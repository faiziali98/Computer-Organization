	.data
arr: .word 7,-2,15,-3,-2,3,-16,12,9,-1
text: .asciiz "Sum is : "
	.globl main
	.text
main:
	addi $t0, $zero, 0 # sum
	addi $t1, $zero, 0 # i
	la $s0,arr #array
for1:
	lw $s1,0($s0)
	slt $t2,$s1,$zero
	beq $t2,$zero,dont
	sub $s1,$zero,$s1 #getting absolute value
dont:
	add $t2,$zero,$s1
	add $t0,$t0,$t2
	addi $t1,$t1,1 #i++
	addi $s0,$s0,4 #array next element
	addi $t2,$zero,10 
	slt $t2,$t1,$t2
	bne $t2,$zero,for1
end:
	addi $v0,$zero, 4 # system call code for Print String
	la $a0, text # load address of msg. into $a0
	syscall
	addi $v0,$zero, 1 # system call code for Print String
	add $a0,$t0, $zero # load address of msg. into $a0
	syscall