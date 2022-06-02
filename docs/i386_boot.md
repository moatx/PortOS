# theory

the boot sector is a sector of a persistent data storage device which contains machine code to be loaded into random-access memory (RAM) and then executed by a computer system's built-in firmware (BIOS). 

BIOS doesn't know how to load the OS, so it delegates that task to the boot sector. 
the location for the boot sector will be the first sector of the disk and it will takes 512 bytes.

in the bootsect it enters protected mode and executes the elf loader to load the elf kernel

# boot process

  1. clear interrupts
  2. enable A20 line
  3. load the gdt
  4. switches on the cr0 bit
  5. does a long jump to a 32 bit protected mode labele _start32
  6. setup segment registers and stack for 32 bit protected mode
  7. loads the kernel from disk to memory
  8. jumps to the kernel in memory

# details

  1. clear interrupts:
      bios has interuppts which are being called like the disks motor will turn off or it will reboot

  2. enable A20 line
      the A20 line is physical representation of the 21st bit (number 20, counting from 0) of any memory access. this is because the first PCs 
      with 2 MB of memory would run software that assumed 1 MB.
      we anable the a20 line by using the traditional method and the traditional method for A20 line enabling is to directly probe the keyboard controller. 

  3. load the gdt
      the gdt contains entries telling the CPU about memory segments. the gdt is a flat model meaning that the base of the gdt data segment is 0.

      TODO: 
      details about the gdt:
            the code and data segment in first db will have:
                a base of 0x0 and a limit of 0xffff
                the present bit which is to tell the gdt if the segment is present in memory will be set to 1
                privilige bit that tells the gdt the privilge level will be set to 0 for highest privilege
             code segment will have:
                a descriptor type which is to tell the gdt if the segment is code or data will be set to 1 for code

  4. switch on the cr0 bit
	cr0 is the controll register which controlls whether or not protected mode (32 bits) is enabled or not on the cpu. we need to get into protected mode for 32 bits and so lets switch it on.

  5. do a long jump to _start32
	we need to do a long jump because _start32 is in protected mode with the gdt loaded, and which means to access _start32 we must use gdt protected mode code segment offset to jump to _start32

 6. setup segment registers and stack for 32 bit protected mode
	we need to setup segment registers with gdt data segment and setup stack to be at 9000 under the kernel because the stack grows down.

 7. load the kernel from disk to memory
	we need to load the kernel from disk to memory so we could jump to memory as mentioned in step 8

 8. jump to kernel
	pass control to kernel in kernel space. goodbye bootloader :)
