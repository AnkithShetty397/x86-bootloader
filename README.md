# x86-Bootloader
This project contains code for building a simple x86 bootloader written in assembly language. The bootloader is designed for learning purposes in operating system development. Below, you'll find instructions on how to build the bootloader and create a bootable floppy disk image.
## File structure
The project has the following file structure:
<pre>
.
├── build
│   ├── bootloader.bin
│   ├── main.bin
│   └── main_floppy.img
├── Makefile
└── src
    ├── bootloader
    │   └── boot.asm
    ├── kernel
    │   └── main.asm
    └── structure.asm
</pre>
* `build/`: contains the output of the binaries and disk image.
* `src/`: contains the source code for the bootloader and for the kernel.
  * `bootloader/`: contains the bootloader assembly code.
  * `kernel/`: placeholder for kernel development.
* `Makefile`: contains build instructions.

## Building and Running
### Prerequisites
* An x86 compatible computer or virtual machine
* nasm assembler
### Building 
1. Clone the repository:
<pre>
  git clone https://github.com/AnkithShetty397/x86-bootloader.git
</pre>
2. Navigate to the project directory:
<pre>
  cd x86-bootloader
</pre>
3. Build the bootloader:
<pre>
  make bootloader
</pre>
### Creating bootable floppy image
1. Build the bootable floppy image:
<pre>
  make floppy_image
</pre>
### Running
1. Run the bootloader using QEMU:
<pre>
  qemu-system-x86_64 -fda build/main_floppy.img
</pre>

## Understanding the code
- **Bootloader code(`src/bootloader.boot.asm`):** This file contains the assembly code for the bootloader. It initializes the system, interacts with the user, and prepares to load the kernel.
- **Bootloader Structure (`src/structure.asm`)**: The `structure.asm` file outlines the basic structure of the bootloader code, including the entry point, main function, and essential components. It serves as a reference for understanding the overall organization of the bootloader code.
## Disclaimer
This code is provided for educational purposes only. Use it at your own risk.
