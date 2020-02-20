    .data

    .balign 4
a: .word 0

    .balign 4
b: .word 0

    .balign 4
msg: .asciz "Enter number : "

    .balign 4
output: .asciz "%d %% %d = %d\n"

    .balign 4
format: .asciz "%d"

    .balign 4
lr_bu: .word 0


    .text

    .global main
    .func main
main:
    LDR R9, addr_lr_bu
    STR LR, [R9]

    LDR R0, addr_msg
    BL printf

    LDR R0, addr_format
    LDR R1, addr_a
    BL scanf

    LDR R0, addr_msg
    BL printf

    LDR R0, addr_format
    LDR R1, addr_b
    BL scanf

    LDR R1, addr_a
    LDR R1, [R1]
    LDR R2, addr_b
    LDR R2, [R2]
loop:
    CMP R1, R2
    BLT end_loop
    SUB R1, R1, R2
    B loop

end_loop:
    MOV R3, R1
    LDR R0, addr_output
    LDR R1, addr_a
    LDR R1, [R1]
    BL printf

end:
    LDR LR, addr_lr_bu
    LDR LR, [LR]
    BX LR

addr_a: .word a
addr_b: .word b
addr_lr_bu: .word lr_bu
addr_msg: .word msg
addr_output: .word output
addr_format: .word format

    .global printf
    .global scanf
