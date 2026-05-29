# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_johnson_counter(dut):
    dut._log.info("Starting Johnson Counter Test")

    # -------------------------
    # CLOCK (100 MHz)
    # -------------------------
    clock = Clock(dut.clk, 10, unit="ns")
    cocotb.start_soon(clock.start())

    # -------------------------
    # INITIALIZE SIGNALS
    # -------------------------
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0

    await ClockCycles(dut.clk, 5)

    # Release reset
    dut.rst_n.value = 1
    dut._log.info("Reset released")

    # -------------------------
    # EXPECTED JOHNSON SEQUENCE
    # -------------------------
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

    for i, expected in enumerate(expected_states):
        await ClockCycles(dut.clk, 1)

        actual = dut.uo_out.value.integer & 0x0F  # lower 4 bits

        assert actual == expected, \
            f"Mismatch at step {i}: expected {bin(expected)}, got {bin(actual)}"

    # -------------------------
    # TEST HOLD (ena = 0)
    # -------------------------
    dut._log.info("Testing hold state")

    dut.ena.value = 0
    hold_value = dut.uo_out.value.integer & 0x0F

    await ClockCycles(dut.clk, 5)

    assert (dut.uo_out.value.integer & 0x0F) == hold_value, \
        "Counter changed even when ena=0"

    # -------------------------
    # RE-ENABLE TEST
    # -------------------------
    dut._log.info("Re-enabling counter")

    dut.ena.value = 1
    await ClockCycles(dut.clk, 4)

    dut._log.info("Test completed successfully")
