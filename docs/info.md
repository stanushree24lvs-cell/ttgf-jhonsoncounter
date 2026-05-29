# 4-Bit Johnson Counter

<!---
This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## Project Overview

This project implements a **4-bit Johnson Counter (Twisted Ring Counter)** using sequential logic flip-flops.

A Johnson counter is a modified ring counter in which the inverted output of the last flip-flop is fed back to the input of the first flip-flop.

The design generates a repeating sequence of unique binary states and is widely used in digital electronics for timing, sequencing, and control applications.

---

## How it works

The counter consists of **4 flip-flops** connected in series.

On each rising clock edge:

- Data shifts from one flip-flop to the next.
- The inverted output of the last flip-flop (`~Q3`) is fed back into the first flip-flop (`Q0`).
- This feedback creates a deterministic sequence of states.

The counter completes a full cycle in **8 clock cycles**.

---

### State Sequence

```text
0000 → 1000 → 1100 → 1110 → 1111 → 0111 → 0011 → 0001 → 0000
