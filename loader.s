.set MAGIC, 0x1badb002
.set FLAGS, (1 << 0 | 1 << 1)
.set CHECKSUM, -(MAGIC + FLAGS)

.section .multiboot
    .long MAGIC
    .long FLAGS
    .long CHECKSUM

.section .text
    .global loader
    .extern kernelMain

loader:
    movl $kernel_stack, %esp
    pushl %eax
    pushl %ebx
    call kernelMain

_stop:
    cli
    hlt
    jmp _stop

.section .bss
    .lcomm kernel_stack, 2*1024*1024  # 2 MiB
