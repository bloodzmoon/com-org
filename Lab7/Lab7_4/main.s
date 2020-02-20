
    .data
    .balign 4
question: .asciz "What is your fav num?"

    .balign 4
message: .asciz "%d is a great num!\n"

    .balign 4
pattern: .asciz "%d"

    .balign 4
number: .word 0

    .balign 4
lr_bu: .word 0

    .text

    @ used by compiler to tell lib c where main is located
    .global main
    .func main

main:
    @ keep the value link inside register
    LDR R1, addr_lr_bu
    STR lr, [R1] @Mem[R1] <- LR

    @ load R0, addr_question
    LDR R0, addr_pattern
    BL printf

    @define pattern for scanf and where to store it
    LDR R0, addr_message
    LDR R1, addr_number
    BL scanf

    @ display the msg together with num
    LDR R0, addr_message
    LDR R1, addr_message
    LDR R1, [R1]
    BL printf

    @ restore the  saved value to link register
    LDR lr, addr_lr_bu
    LDR lr, [lr] @ LR <- Mem[addr_lr_bu]
    BX lr @ return to main func

    @define addr
    addr_question: .word question
    addr_message: .word message
    addr_pattern: .word pattern
    addr_number: .word number
    addr_lr_bu: .word lr_bu

    @declare printf scanf
    .global printf
    .global scanf
