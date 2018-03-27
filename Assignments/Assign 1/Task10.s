	.data
arr1:	.space 20
out1: .asciiz "\n Enter the size of the arrays: "
out2: .asciiz "\n Enter the elements: "
out3:	.asciiz "\n Sorted elements : "
	.text
	.globl main

main:

size_array: #getting size of array
	li $v0,4
	la $a0,out1
	syscall
	li $v0,5
	syscall

	add $t0,$zero,$v0 #orignal length
	add $a2,$zero,$t0 #making copy of orignal length

Input_Elements: #to input elements
	la $s0,arr1
In1:

	li $v0,4
	la $a0,out2
	syscall

	li $v0,5
	syscall

	sw $v0,0($s0)
	add $s0,$s0,4
	add $t0,$t0,-1
	bne $t0,$zero,In1


	add $sp,$sp,-4
	sw $a2,0($sp)
	addi $a2,$a2,-1	#push length-1

Call_quicksort:
	la $a0,arr1
	li $a1,0
	jal quicksort
	lw $a2,0($sp)
	add $sp,$sp,4

output_result: #to output result
	la $a0,out3
	li $v0,4
	syscall	
	li $t0,0
	add $t0,$t0,$a2
	la $s0,arr1
output:
	lw $a0,0($s0)	#cout the values
	li $v0,1
	syscall
	add $s0,$s0,4
	add $t0,$t0,-1
	bne $t0,$zero,output
End:
	li $v0,10
	syscall

quicksort:
	li $t5,4
	
	blt $a1,$a2,if1
	beq $0,$0,ifexit1
if1: #selecting pivot
	move $t1,$a1	
	move $t2,$a2	
	li $t3,0	
	move $t4,$a1	

while1: #main loop
	slt $s0,$t4,$t2
	beq $s0,$zero,exit1

	while2: #finding place
		mult $t5,$t4
		mflo $s0			
		add $s0,$s0,$a0 
		lw $s1,0($s0)  
		
		mult $t5,$t1
		mflo $s0			
		add $s0,$s0,$a0 
		lw $s2,0($s0)   
		
		slt $s0,$s2,$s1
		bne $s0,$zero,while3
		slt $s0,$t4,$a2
		beq $s0,$zero,while3
		
		add $t4,$t4,1
		
		b while2
	while3: #inserting at sorted place
		mult $t5,$t2
		mflo $s0			
		add $s0,$s0,$a0 
		lw $s1,0($s0)   
		
		mult $t5,$t1
		mflo $s0			
		add $s0,$s0,$a0
		lw $s2,0($s0)  

		slt $s0,$s2,$s1
		beq $s0,$zero,exit2		
		
		add $t2,$t2,-1
		
		b while3
	exit2:

		blt $t4,$t2,if2
		b ifexit2
	if2:
		mult $t5,$t4
		mflo $s0			
		add $s0,$s0,$a0
		lw $s1,0($s0)  

		move $t3,$s1 

		mult $t5,$t2
		mflo $s3			
		add $s3,$s3,$a0 
		lw $s1,0($s3) 
	
		sw $s1,0($s0)	
		sw $t3,0($s3)		


	ifexit2:

	beq $zero,$zero, while1
exit1:
	
		mult $t5,$t1
		mflo $s0			
		add $s0,$s0,$a0 
		lw $s1,0($s0)   

		move $t3,$s1 	

		mult $t5,$t2
		mflo $s3			
		add $s3,$s3,$a0 
		lw $s1,0($s3)   
	
		sw $s1,0($s0)	
		sw $t3,0($s3)			
	
inserting_into_stack: #Insertong values in stack
		#inserting $ra,$a2,$t2
		addi $sp,$sp,-4
		sw $ra,0($sp)
		addi $sp,$sp,-4
		sw $a2,0($sp)
		addi $sp,$sp,-4
		sw $t2,0($sp)
		addi $a2,$t2,-1		
		jal quicksort

getting_from_stack:
		#getting $ra,$a2,$t2
		lw $t2,0($sp)
		addi $sp,$sp,4
		lw $a2,0($sp)
		addi $sp,$sp,4
		addi $a1,$t2,1
		jal quicksort
Basecase: #getting address of last callee functions
		lw $ra,0($sp)
		addi $sp,$sp,4

ifexit1:
	jr $ra