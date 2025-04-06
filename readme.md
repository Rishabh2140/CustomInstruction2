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

🪟 **Windows (MSYS2)** 🪟
```bash
pacman -Syu
pacman -S mingw-w64-x86_64-gcc flex bison make
```

🐧 **Linux (Debian/Ubuntu)** 🐧
```bash
sudo apt-get update
sudo apt-get install build-essential flex bison make
```

🔨 **Build Instructions** 🔨
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
🛑 Press **Ctrl+D** (Linux/macOS) or **Ctrl+Z** (Windows) to exit.

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

💡 **Example Output** 💡
**Input:**
```text
R9 r4 h6 compute volume
```
**Output:**
```asm
MUL t0, R9, R9         # R^2
MUL t1, R9, r4         # R*r
MUL t2, r4, r4         # r^2
ADD t3, t0, t1         # R^2 + Rr
ADD t4, t3, t2         # + r^2
MUL t5, t4, h6         # * h
MUL t6, t5, 3.141593   # * pi
DIV volume, t6, 3      # Final Volume

Total Tokens: 5
Computed Volume: 654.498474
```

✍🏻 **Author** ✍🏻
**Rishabh Chandrakar**  
Roll Number - 23115080
Semester- IV
🎓 B.Tech CSE, NIT Raipur

