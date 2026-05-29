# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_johnson_counter(dut):
    dut._log.info("Starting Johnson Counter Test")

    # Create clock (10 ns period = 100 MHz)
    clock = Clock(dut.clk, 10, unit="ns")
    cocotb.start_soon(clock.start())

    # -------------------------
    # RESET PHASE
    # -------------------------
    dut._log.info("Applying reset")

    dut.rst.value = 1
    dut.enable.value = 0
    await ClockCycles(dut.clk, 3)

    dut.rst.value = 0
    dut._log.info("Reset released")

    # -------------------------
    # ENABLE COUNTER
    # -------------------------
    dut.enable.value = 1

    expected_states = [
        0b0000,
        0b1000,
        0b1100,
        0b1110,
        0b1111,
        0b0111,
        0b0011,
        0b0001,
    ]

    dut._log.info("Checking Johnson sequence")

    # Check first 8 states
    for i, expected in enumerate(expected_states):
        await ClockCycles(dut.clk, 1)
        actual = dut.q.value.integer

        assert actual == expected, \
            f"Mismatch at step {i}: expected {bin(expected)}, got {bin(actual)}"

    # -------------------------
    # TEST ENABLE = 0 (HOLD STATE)
    # -------------------------
    dut._log.info("Testing hold behavior")

    dut.enable.value = 0
    hold_value = dut.q.value.integer

    await ClockCycles(dut.clk, 5)

    assert dut.q.value.integer == hold_value, \
        "Counter changed even when enable=0"

    # -------------------------
    # RE-ENABLE TEST
    # -------------------------
    dut._log.info("Re-enabling counter")

    dut.enable.value = 1
    await ClockCycles(dut.clk, 4)

    dut._log.info("Test completed successfully")
