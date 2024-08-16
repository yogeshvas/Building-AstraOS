.set MAGIC, 0x1badb002
.set FLAGS, (1 << 0 | 1 << 1)
.set CHECKSUM, -(MAGIC + FLAGS)

.section .multiboot
    .long MAGIC
    .long FLAGS  # Corrected typo from 'GlAGS' to 'FLAGS'
    .long CHECKSUM

.section .text
.extern kernelMain
.global loader

loader:
    mov $kernel_stack, %esp
    push %eax
    push %ebx
    call kernelMain

_stop:
    cli
    hlt
    jmp _stop

.section .bss
kernel_stack:         # The label should come before .space
    .space 2*1024*1024  # 2 MiB
