<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## 🔷 How it works

This project implements a **4-bit Johnson (Twisted Ring) Counter** using sequential logic flip-flops.

A Johnson counter shifts data in a circular manner, but with a key modification:  
the inverted output of the last flip-flop is fed back into the first flip-flop.

This creates a unique sequence of states:
