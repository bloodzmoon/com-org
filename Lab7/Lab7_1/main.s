	.data
	.balign 4 @Request 4 bytes of space
fifteen: .word 15 @fifteen = 15

	.balign 4 @Request 4 bytes of space
thirty: .word 30 @thirty = 30

	.text
	.global main
main:
	LDR R1, addr_fifteen @R1 <- address fifteen
	LDR R1, [R1] @R1 <- mem[R1]
	LDR R2, addr_thirty @R2 <- address thirty
	LDR R2, [R2] @R2 <- mem[R2]
	ADD R0, R1, R2
end:
	MOV R7, #1
	SWI 0

addr_fifteen: .word fifteen
addr_thirty: .word thirty
