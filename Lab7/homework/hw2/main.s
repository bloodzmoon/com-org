    .data

    .balign 4
a: .word 0

    .balign 4
b: .word 0

    .balign 4
tmp: .word 0

    .balign 4
factor: .word 1

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

    @ prepare data
    LDR R0, addr_a
    LDR R0, [R0]
    LDR R1, addr_b
    LDR R1, [R1]
    LDR R4, addr_tmp
    STR R1, [R4] @ tmp is equal to B now

    @ compare A and B
    CMP R0, R1
    BLT case_1 @ A < B
    BGE case_2 @ A >= B

case_1:
    LDR R0, addr_output
    LDR R1, addr_a
    LDR R1, [R1]
    LDR R2, addr_b
    LDR R2, [R2]
    LDR R3, addr_a
    LDR R3, [R3]
    BL printf
    B end

case_2:
    LDR R0, addr_a
    LDR R0, [R0]
    LDR R1, addr_b
    LDR R1, [R1]
    LDR R2, addr_factor
    LDR R2, [R2]

    @ B = B x factor
    MUL R1, R1, R2

    @ compare A & B
    CMP R0, R1
    BLT result @ A < B

    @ if false increase factor by 1, store tmp and loop case_2
    ADD R2, R2, #1
    LDR R4, addr_factor
    STR R2, [R4]
    LDR R4, addr_tmp
    STR R1, [R4]
    B case_2

result: @ A - B(tmp) = remaining
    LDR R4, addr_tmp
    LDR R4, [R4]
    SUB R3, R0, R4
    LDR R0, addr_output
    LDR R1, addr_a
    LDR R1, [R1]
    LDR R2, addr_b
    LDR R2, [R2]
    BL printf
    B end

end:
    LDR LR, addr_lr_bu
    LDR LR, [LR]
    BX LR

addr_a: .word a
addr_b: .word b
addr_factor: .word factor
addr_tmp: .word tmp
addr_lr_bu: .word lr_bu
addr_msg: .word msg
addr_output: .word output
addr_format: .word format

    .global printf
    .global scanf
