	.data
arr: .word 4,5,7,2,1,2,4,5,8,9
text: .asciiz "The number of times : "
	.globl main
	.text
main:
	addi $t0,$zero,0 #counter
	addi $t1,$zero,0 #occuences
	addi $s0,$zero,4 # number
	la $s1, arr
while1: 
	addi $t2,$zero,10 #counter <10
	slt $t2,$t0,$t2
	lw $a0,0($s1)
	bne $a0,$s0,endif
	addi $t1,$t1,1
endif:
	addi $t0,$t0,1 #counter ++
	addi $s1,$s1,4 # arr next element
	bne $t2,$zero,while1
end:
	addi $v0,$zero, 4 # system call code for Print String
	la $a0, text # load address of msg. into $a0
	syscall
	addi $v0,$zero, 1 # system call code for Print String
	add $a0,$t1, $zero # load address of msg. into $a0
	syscall