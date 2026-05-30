# 4-Bit Johnson Counter

## Project Overview

This project implements a **4-bit Johnson Counter (Twisted Ring Counter)** using sequential logic.

A Johnson counter is a modified ring counter where the inverted output of the last flip-flop is fed back to the first flip-flop.

This creates a repeating sequence of unique binary states used in timing, sequencing, and digital control applications.

---

## How it works

The counter consists of 4 flip-flops connected in series.

On each rising clock edge:

- Bits shift from one flip-flop to the next
- The inverted output of the last flip-flop (Q3) is fed back into Q0
- This produces a deterministic sequence of states

The counter completes a full cycle in 8 clock cycles.

### State Sequence

```text
0000 → 1000 → 1100 → 1110 → 1111 → 0111 → 0011 → 0001 → 0000
