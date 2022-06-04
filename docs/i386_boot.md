# theory

* Real mode is a simplistic 16-bit mode.

* Protected mode is a 32-bit mode that allows the system to enforce strict memory and hardware I/O protection, thus the name "protected mode".

* BIOS initializes the CPU in real mode for compatibility purposes.

* BIOS _doesn't_ know how to load the kernel, and so it delegates that task to the boot-loader which is in the **boot sector**. 

* The **boot sector** is a _sector_ of a persistent data storage device which contains machine code to be loaded into random-access **memory** (RAM) and then executed by a computer system's built-in firmware (BIOS). 

* The location for the boot sector will be the first sector of the disk and it will takes **512** bytes.

* The boot-loader's job is to bring the kernel (and all the kernel needs to bootstrap) into memory, then provide the kernel with the information it needs to work correctly, and then switch to an environment that the kernel will like, and then transfer control to the kernel.


# boot process

1. Clear interrupts

2. Enable A20 line

3. Load the kernel from disk to memory

4. Load the GDT

5. Switch on the cr0 bit

6. Do a long jump to a 32 bit protected mode label called _start32

7. Setup segment registers and stack for 32 bit protected mode

8. Jump to the kernel in memory

# details

1. clear interrupts
	* Bios _will_ sometimes annoy us with interrupts like disk motors randomly turning on or off or the computer randomly rebooting, and so to not be annoyed the boot-loader **has** to clear interrupts.

2. enable A20 line
	* The A20 line is physical representation of the 21st bit (number 20, counting from 0) of any memory access. 
	* This is because the first PCs with 2 MB of memory would run software that assumed 1 MB.
	* We enable the a20 line by using the traditional method and the traditional method for A20 line enabling is to directly probe the keyboard controller. 

7. load the kernel from disk to memory
	* The boot-loader **needs** to load the kernel from disk to memory so we could jump to memory as mentioned in step 8

3. load the gdt
	* The gdt contains entries telling the CPU about memory segments. the gdt is a flat model meaning that the base of the gdt data segment is 0.

     TODO: 
     details about the gdt:
           the code and data segment in first db will have:
               a base of 0x0 and a limit of 0xffff
               the present bit which is to tell the gdt if the segment is present in memory will be set to 1
               privilege bit that tells the gdt the privilege level will be set to 0 for highest privilege
            code segment will have:
               a descriptor type which is to tell the gdt if the segment is code or data will be set to 1 for code

4. switch on the cr0 bit
	* Cr0 is the control register which controls whether or not protected mode (32 bits) is enabled or not on the CPU. The boot-loader wants to get to protected mode for 32 bits and so it switches it on.

5. do a long jump to _start32
	* The boot-loader needs to do a long jump because _start32 is in protected mode with the gdt loaded, and which means to access _start32 the boot-loader **must** use gdt protected mode code segment offset to jump to _start32.

6. setup segment registers and stack for 32 bit protected mode
	* The boot-loader needs to setup segment registers with gdt data segment and setup stack to be at 9000 under the kernel because the stack grows down.

8. jump to kernel
	* Pass control to kernel in kernel space. goodbye boot-loader :)
