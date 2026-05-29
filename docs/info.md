# 4-Bit Johnson Counter

## Project Overview
This project implements a **4-bit Johnson Counter (Twisted Ring Counter)** using sequential logic flip-flops.  
A Johnson counter is a modified ring counter in which the inverted output of the last flip-flop is fed back to the input of the first flip-flop.

The design generates a repeating sequence of unique binary states and is widely used in digital electronics for timing, sequencing, and control applications.

---

## How it works
This project implements a **4-bit Johnson (Twisted Ring) Counter** using sequential logic flip-flops.

A Johnson counter shifts data in a circular manner, but with one important modification:
the inverted output of the last flip-flop is fed back into the first flip-flop.

This creates a unique sequence of states:

```text
0000 → 1000 → 1100 → 1110 → 1111 → 0111 → 0011 → 0001 → 0000

