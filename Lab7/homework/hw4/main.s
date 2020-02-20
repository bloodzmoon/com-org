
    .data

    .balign 4
a: .word 0

    .balign 4
b: .word 0

    .balign 4
gcd: .word 0

    .balign 4
tmp: .word 0

    .balign 4
tmp_2: .word 0

    .balign 4
factor: .word 1

    .balign 4
factor_2: .word 1

    .balign 4
format: .asciz "%d"

    .balign 4
msg: .asciz "Enter number : "

    .balign 4
output: .asciz "GCD of %d and %d is %d"

    .balign 4
lr_bu: .word 0

    .balign 4
lr_bu_2: .word 0


    .text

modulo:
    LDR R10, addr_lr_bu_2
    STR LR, [R10]

    @ prepare data A(R0) and B(R1)
    LDR R3, addr_tmp
    STR R1, [R3] @ tmp is equal to B now

    @ compare A and B
    CMP R0, R1
    BLT case_1 @ A < B
    BGE case_2 @ A >= B

case_1:
    B end_2 @ return R0

case_2:
    LDR R2, addr_factor_2
    LDR R2, [R2]

    @ B(tmp) = B x factor
    MUL R4, R1, R2

    @ compare A & B(tmp)
    CMP R0, R4
    BLT rem @ A <= B

    @ if false increase factor_2 by 1, store tmp and loop case_2
    ADD R2, R2, #1
    LDR R5, addr_factor_2
    STR R2, [R5]
    LDR R5, addr_tmp
    STR R4, [R5]
    B case_2

rem: @ A - B(tmp) = remaining
    LDR R3, addr_tmp
    LDR R3, [R3]
    SUB R0, R0, R3
    B end_2

end_2:
    LDR LR, addr_lr_bu_2
    LDR LR, [LR]
    BX LR

    .global main
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

loop:
    LDR R0, addr_a
    LDR R0, [R0]
    LDR R1, addr_b
    LDR R1, [R1]
    LDR R2, addr_factor
    LDR R2, [R2]

    @ compare (factor > A) or (factor > B)
    CMP R2, R0
    BGT result @ factor > A
    CMP R2, R1
    BGT result @ factor > B

    @ if false check GCD
    LDR R4, addr_factor_2
    MOV R5, #1
    STR R5, [R4]
    LDR R0, addr_a
    LDR R0, [R0]
    LDR R1, addr_factor
    LDR R1, [R1]
    BL modulo @ A % factor
    CMP R0, #0
    BNE result @ A % factor != 0

    LDR R4, addr_factor_2
    MOV R5, #1
    STR R5, [R4]
    LDR R0, addr_b
    LDR R0, [R0]
    LDR R1, addr_factor
    LDR R1, [R1]
    BL modulo @ B % factor
    CMP R0, #0
    BNE result @ B % factor != 0

    @ if (A % factor == 0) and (B % factor == 0) store GCD, increase factor and loop
    LDR R4, addr_gcd
    STR R2, [R4] @ GCD == factor
    ADD R2, R2, #1 @ factor++
    LDR R4, addr_factor
    STR R2, [R4]
    B loop

result:
    LDR R0, addr_output
    LDR R1, addr_a
    LDR R1, [R1]
    LDR R2, addr_b
    LDR R2, [R2]
    LDR R3, addr_gcd
    LDR R3, [R3]
    BL printf

end:
    LDR LR, addr_lr_bu
    LDR LR, [LR]
    BX LR

addr_a: .word a
addr_b: .word b
addr_gcd: .word gcd
addr_factor: .word factor
addr_factor_2: .word factor_2
addr_tmp: .word tmp
addr_tmp_2: .word tmp_2
addr_lr_bu: .word lr_bu
addr_lr_bu_2: .word lr_bu_2
addr_format: .word format
addr_msg: .word msg
addr_output: .word output

    .global printf
    .global scanf
