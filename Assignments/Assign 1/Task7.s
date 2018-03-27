	.data
out1: .asciiz "\n Enter the number to be checked: "
out2: .asciiz "\n The entered number is an Armstrong Number."
out3: .asciiz "\n The entered number is not an Armstrong Number "
	.text
	.globl main

main:
	addi $t0,$zero,0 #number
	addi $t1,$zero,0 #sum 
	addi $t2,$zero,0 #temp
	addi $t3,$zero,0 #remainder

	la $a0,out1 # prints Enter the number to be checked:
	addi $v0,$zero,4
	syscall

	addi $v0,$zero,5 # gets the number to be checked:
	syscall
	add $t0,$t0,$v0

	add $t2,$t2,$t0 #making copy of orignal number

while1:
	rem $t3,$t2,10 #geting remainder

	mult $t3,$t3 
	mflo $s0 #remainder*remainder
	mult $s0,$t3 
	mflo $t3 #remainder*remainder*remainder

	add $t1,$t1,$t3 #sum=sum+Remainder^3

	div $t2,$t2,10 #temp=temp/10

	bne $t2,$zero,while1 #if temp is not zero, repeat

	beq $t0,$t1,else1

if1: #not amstrong
	la $a0,out3
	addi $v0,$zero,4
	syscall
	beq $zero,$zero,end

else1: #is amstrong
	la $a0,out2
	addi $v0,$zero,4
	syscall

end:
	addi $v0,$zero,10
	syscall		