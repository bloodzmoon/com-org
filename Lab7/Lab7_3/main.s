
@    .data
@primes:
@    .word 2
@    .word 3
@    .word 5
@    .word 7
@
@    .text
@    .global main
@main:
@    LDR R3, =primes @ Load addr for data in R3
@    LDR R0, [R3, #4] @ Get the next item in list
@end:
@    MOV R7, #1
@    SWI 0


    .data
numbers: .byte 1, 2, 3, 4, 5

    .text
    .global main
main:
    LDR R3, =numbers
    LDRB R0, [R3, #2]
end:
    MOV R7, #1
    SWI 0
