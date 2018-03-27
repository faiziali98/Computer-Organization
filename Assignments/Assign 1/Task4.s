	.data
out1:	.asciiz "\n I will come up with a magic number between 0 and 9 and ask you to guess it. \n"
out2:	.asciiz "\n Enter your guess : "
out3:	.asciiz "\n Too big! Guess again ...\n"
out4:	.asciiz "\n Too small! Guess again...\n"
out5:	.asciiz "\n You are RIGHT!"
	.globl main
	.text
main:
	addi $t0,$zero,0 #magic
	addi $t1,$zero,0 #guess

	addi $v0,$zero,4 #Output I will come up with a magic number between 0 and 9 and ask you to guess it.
	la $a0,out1
	syscall

	addi $v0,$zero,5 #get magic number
	syscall
	add $t0,$t0,$v0

	addi $v0,$zero,4 #Output Enter your guess :
	la $a0,out2
	syscall
		
	addi $v0,$zero,5 #input guess
	syscall
	add $t1,$t1,$v0

while1:
	slt $s0,$t0,$t1
	bne $s0,$zero,else1
if1:	
	addi $v0,$zero,4 #if guess is small
	la $a0,out4
	syscall		
	beq $zero,$zero,Endif
else1:
	addi $v0,$zero,4 #if group is big
	la $a0,out3
	syscall
Endif:
	addi $v0,$zero,5 #the rest of the loop
	syscall
	add $t1,$zero,$v0
	
	bne $t0,$t1,while1
EndCode:
	addi $v0,$zero,4
	la $a0,out5
	syscall

	addi $v0,$zero,10
	syscall
