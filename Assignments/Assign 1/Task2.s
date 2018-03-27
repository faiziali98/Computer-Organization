	.data
Prompt: .asciiz "\n Please Input a value for N =  "
Result: .asciiz "\n Result is  "
Bye: 	.asciiz "\n **** Allah Hafiz – Have a good day****"
new: 	.asciiz ", "
	.globl main
	.text
main:	
	jal Get
	move $t0,$v0
	jal Get
	move $t1, $v0
	jal Get
	move $a1,$v0
	addi $a1,-2
	li $s1,1
	li $v0,1
	move $a0,$t0
	syscall
	li $v0,4
	la $a0,new
	syscall
	li $v0,1
	move $a0,$t1
	syscall
	li $v0,4
	la $a0,new
	syscall
	jal Fact1
	b End 
#write proper code here:
Get:
	li $v0, 4 # system call code for print string
	la $a0, Prompt # load address of prompt into $a0
	syscall   # print the prompt message
	li $v0, 5 # system call code for Read Integer
	syscall
	jr $ra

Fact1:
	slt $s0,$a1,$zero
	beq $s0, $s1, basecase
	beq $a1, $zero, basecase
	add $t2, $t1,$t0
	add $t0,$t1,$zero
	add $t1,$t2,$zero
	addi $a1,$a1,-1
	li $v0,1
	move $a0,$t2
	syscall
	li $v0,4
	la $a0,new
	syscall
	b Fact1
basecase:
	jr $ra

End: 
	li $v0, 4 # system call code for Print String
	la $a0, Bye # load address of msg. into $a0
	syscall # print the string
	li $v0, 10 # terminate program run and
	syscall # return control to systemA