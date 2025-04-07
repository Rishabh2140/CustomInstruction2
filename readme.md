# 🏗️ Frustum Volume Compiler 🏗️

📌 **Frustum Volume Compiler** is a basic compiler-like application built using **Flex (Lex)** and **Bison (Yacc)** in **C** to parse a custom instruction for computing the volume of a frustum of a cone.

✨ **Features** ✨

- ✅ Parses user-friendly input like:
  ```
  R9 r4 h6 compute volume
  ```
- ✅ Generates **Three-Address Code (TAC)**
- ✅ Displays optimized custom instructions
- ✅ Shows final computed volume
- ✅ Outputs pseudo assembly–style code

📂 **Project Structure** 📂

```
├── lexar.l       # Flex lexical analyzer rules
├── parser.y      # Bison grammar rules
├── Makefile      # Build automation
└── README.md     # Documentation
```

⚙️ **Requirements** ⚙️

- 🔹 **gcc** – C compiler
- 🔹 **flex** – Lexical analysis (v2.6+)
- 🔹 **bison** – Syntax parsing (v3.0+)
- 🔹 **make** – Build tool

🪺 **Windows (MSYS2)** 🪺

```bash
pacman -Syu
pacman -S mingw-w64-x86_64-gcc flex bison make
```

🐧 **Linux (Debian/Ubuntu)** 🐧

```bash
sudo apt-get update
sudo apt-get install build-essential flex bison make
```

🛠️ **Build Instructions** 🛠️

```bash
make
```

This will:
1️⃣ Use **Flex** to generate `lex.yy.c`
2️⃣ Use **Bison** to generate parser files
3️⃣ Compile all source files
4️⃣ Produce executable: `frustum.exe` (Windows) or `frustum` (Linux/macOS)

🚀 **How to Use** 🚀

```bash
./frustum.exe
```

Then enter instructions like:

```
R9 r4 h6 compute volume
```

🚩 Press **Ctrl+D** (Linux/macOS) or **Ctrl+Z** (Windows) to exit.

🧮 **Frustum Volume Formula** 🧮

```math
V = \frac{\pi \times h \times (R^2 + R\,r + r^2)}{3}
```

Where:

- 🔹 **R** = radius of the bottom base
- 🔹 **r** = radius of the top base
- 🔹 **h** = height of the frustum

🧹 **Cleaning the Build** 🧹

```bash
make clean
```

📜 **License** 📜
This project is released under the **MIT License**.

🔎 **Example Output** 🔎
**Input:**

```text
R9 r4 h6 compute volume
```

**Generated Assembly Code (output.s):**

```asm
.section .data
R_const:    .double 5.000000
r_const:    .double 3.000000
h_const:    .double 10.000000
pi_const:   .double 3.141593
three_const:.double 3.0
fmt:        .asciz "Computed Volume: %f\n"

.section .bss
    .lcomm t0,8
    .lcomm t1,8
    .lcomm t2,8
    .lcomm t3,8
    .lcomm t4,8
    .lcomm t5,8
    .lcomm t6,8
    .lcomm t7,8
    .lcomm volume,8

.intel_syntax noprefix
.global main
.section .text
main:
    push rbp
    mov rbp, rsp

    movsd xmm0, qword PTR [R_const]
    mulsd xmm0, xmm0          # t0 = R^2
    movsd qword PTR [t0], xmm0

    movsd xmm1, qword PTR [R_const]
    mulsd xmm1, qword PTR [r_const]  # t1 = R*r
    movsd qword PTR [t1], xmm1

    movsd xmm2, qword PTR [r_const]
    mulsd xmm2, xmm2          # t2 = r^2
    movsd qword PTR [t2], xmm2

    movsd xmm3, qword PTR [t0]
    addsd xmm3, qword PTR [t1]
    addsd xmm3, qword PTR [t2]  # t3 = R^2 + Rr + r^2
    movsd qword PTR [t3], xmm3

    movsd xmm4, qword PTR [t3]
    mulsd xmm4, qword PTR [h_const]  # t4 = t3 * h
    movsd qword PTR [t4], xmm4

    movsd xmm5, qword PTR [t4]
    mulsd xmm5, qword PTR [pi_const] # t5 = t4 * π
    movsd qword PTR [t5], xmm5

    movsd xmm6, qword PTR [t5]
    divsd xmm6, qword PTR [three_const] # volume = t5 / 3
    movsd qword PTR [volume], xmm6

    lea rdi, [rel fmt]
    movsd xmm0, qword PTR [volume]
    xor eax, eax
    call printf

    mov eax, 0
    pop rbp
    ret

```

**Console Output:**

```text
Total Tokens: 5
Computed Volume: 654.498474
```

✍️ **Author** ✍️
**Rishabh Chandrakar**\
Roll Number - 23115080\
Semester- IV\
🎓 B.Tech CSE, NIT Raipur

