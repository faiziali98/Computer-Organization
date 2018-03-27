	.data
out1: .asciiz "\n Enter a Number : "
out2: .asciiz "\n Not Prime. "
out3: .asciiz "\n Prime number. "
	.text
	.globl main

main:
	addi $t0,$zero,0 #number
	addi $t1,$zero,0 #c

	la $a0,out1 # prints enter number
	addi $v0,$zero,4
	syscall

	addi $v0,$zero,5
	syscall
	add $a1,$zero,$v0 #input argument in #a1 as $a0 is used for printing

	jal prime

	addi $v0,$zero,10
	syscall	

prime:
	addi $t1,$zero,2 #intializing dividing factor

for1:
	rem $s2,$a1,$t1
	beq $s2,$zero,break1
	
	add $t1,$t1,1 #c++
	slt $s1,$t1,$a1 #comparing
	bne $s1,$zero,for1 			

break1:
	bne $t1,$a1,not_p

	la $a0,out3 
	addi $v0,$zero,4 #cout is prime
	syscall

	jr $ra

not_p:

	la $a0,out2
	addi $v0,$zero,4 #cout not prime
	syscall
	
	jr $ra


