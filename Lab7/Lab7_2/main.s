	.data
	.balign 4 @Request 4 bytes of space
fifteen: .word 0 @fifteen = 0

	.balign 4 @Request 4 bytes of space
thirty: .word 0 @thirty = 0

	.text
	.global main
main:
	LDR R1, addr_fifteen @R1 <- address fifteen
	MOV R3, #15
	STR R3, [R1] @Mem[R1] <- R3
	LDR R2, addr_thirty
	MOV R3, #30
	STR R3, [R2]

	LDR R1, addr_fifteen @Load address
	LDR R1, [R1]
	LDR R2, addr_thirty
	LDR R2, [R2]
	ADD R0, R1, R2


end:
	MOV R7, #1
	SWI 0

@ Lebles for addresses in the data section
addr_fifteen: .word fifteen
addr_thirty: .word thirty
