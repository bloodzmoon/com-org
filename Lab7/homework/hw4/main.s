
.data
  .balign 4
  a: .word 0
  .balign 4
  b: .word 0
  .balign 4
  gcd: .word 0
  .balign 4
  msg: .asciz "Enter number : "
  .balign 4
  format: .asciz "%d"
  .balign 4
  output: .asciz "GCD of %d and %d is %d"
  .balign 4
  lr_bu: .word 0

.text
  modulo: @(R1, R2) return R1
    loop_modulo:
      CMP R1, R2
      BLT end_modulo
      SUB R1, R1, R2
    B loop_modulo

.global main
main:
  LDR R1, addr_lr_bu
  STR LR, [R1]

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
    CMP R1, #0
    BEQ end
    MOV R3, R1
    MOV R1, R2
    MOV R2, R3
    BL modulo
    end_modulo:
  B loop

end:
  LDR R4, addr_gcd
  STR R2, [R4]

  LDR R0, addr_output
  LDR R1, addr_a
  LDR R1, [R1]
  LDR R2, addr_b
  LDR R2, [R2]
  LDR R3, addr_gcd
  LDR R3, [R3]
  BL printf

  LDR LR, addr_lr_bu
  LDR LR, [LR]
  BX LR

addr_a: .word a
addr_b: .word b
addr_gcd: .word gcd
addr_lr_bu: .word lr_bu
addr_msg: .word msg
addr_format: .word format
addr_output: .word output

.global printf
.global scanf

@ Algorithm by geeksforgeeks
@ func gcd(a, b)
@   if a == 0: return b
@   else: return gcd(b%a, a)
