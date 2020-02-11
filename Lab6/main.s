    .data
    .balign 4

donut: .word 1
    .text
    .global main

main:
    MOV R1, #2
    LDR R2, than
    STR R1, [R2]
    LDR R0, [R2]
    BX LR


than: .word donut
