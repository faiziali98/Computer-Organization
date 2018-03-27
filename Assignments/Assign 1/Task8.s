	.data
arr1: .space 40
arr2: .space 40

out1: .asciiz "\n Enter the size of the arrays: "
out2: .asciiz "\n Enter elements of first array number by number: \n"
out3: .asciiz "\n Enter elements of second array number by number: \n"
out4: .asciiz "\n The elements of first array are : "
out5: .asciiz "\n The elements of second array are : "

	.text
	.globl main
main:
	la $s0,arr1
	la $s3,arr2

	la $a0,out1
	addi $v0,$zero,4
	syscall	

	addi $v0,$zero,5 #cin size of the array
	syscall

	add $s2,$zero,$v0	
	add $s1,$zero,$s2 #making copy of orignal length to run loop


	la $a0,out2
	addi $v0,$zero,4
	syscall
	add $a1,$zero,$s0
	jal Input1 #void input (arr1)
	add $s0,$zero,$a1

	la $a0,out3
	addi $v0,$zero,4
	syscall
	add $a1,$zero,$s3
	jal Input1 #void input (arr2)
	add $s3,$zero,$a1
	jal while_not_head 
	j while1

Input1: #taking inputs in array 1 
	addi $v0,$zero,5 #taking input
	syscall

	sw $v0,0($a1) #saving input
	add $a1,$a1,4

	add $s2,$s2,-1
	bne $s2,$zero,Input1
	
	add $s2,$zero,$s1 #getting iterator back to orignal length
	jr $ra

while_not_head: #to get to the first element of the array
	add $s0,$s0,-4 #getting to the head of array 1
	add $s3,$s3,-4 #getting to the head of array 2

	add $s2,$s2,-1
	bne $s2,$zero,while_not_head
	add $s2,$zero,$s1 #getting iterator back to orignal length
	jr $ra

while1: #starting Swap

	lw $t0,0($s0) #elements of arr1
	lw $t1,0($s3) #elements of arr2
	
	sw $t1,0($s0) #putting arr2[i] at arr1[i]
	sw $t0,0($s3) #putting arr1[i] at arr2[i]
	add $s2,$s2,-1 #i-- (i=length of the array)

	beq $s2,$zero,end_swap #checking if loop has ended
	add $s0,$s0,4
	add $s3,$s3,4	

	b while1 
		
end_swap:
	add $s2,$zero,$s1
	jal while_not_head #get to the head
	add $s0,$s0,4
	add $s3,$s3,4

cout_arr1: #printing values of arr1
	la $a0,out4
	addi $v0,$zero,4
	syscall	
while2:
	
	lw $a0,0($s0)
	addi $v0,$zero,1 
	syscall	

	add $s0,$s0,4
	add $s2,$s2,-1
	bne $s2,$zero,while2

	add $s2,$zero,$s1 #getting iterator back to orignal length

cout_arr2: #printing values of arr2
	la $a0,out5
	addi $v0,$zero,4
	syscall	

while3:
	
	lw $a0,0($s3)
	addi $v0,$zero,1
	syscall	

	add $s3,$s3,4
	add $s2,$s2,-1
	bne $s2,$zero,while3
End: #ending the program
	addi $v0,$zero,10
	syscall