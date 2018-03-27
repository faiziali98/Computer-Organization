	.data
arr1:	.space 20
out1: .asciiz "\n Enter the size of the array: "
out2: .asciiz "\n Enter elements: "
out3: .asciiz "\n Enter the index after which you wish to insert the element: "
out4:	.asciiz "\n Enter the value to insert: "
out5:	.asciiz "\n Resultant array is : "
	.text
	.globl main

main:
	la $a1,arr1

	la $a0,out1
	addi $v0,$zero,4
	syscall	

	addi $v0,$zero,5 
	syscall

	add $a2,$zero,$v0		#size of the array
	add $s0,$zero,$a2		#making copy of orignal size
	j Input1

insert:
	add $a1,$a1,-4

	lw $s2,0($a1)
	add $a1,$a1,4
	sw $s2,0($a1)
	add $a1,$a1,-4

	add $t0,$t0,-1
	bne $t0,$zero,insert	
	
	sw $t1,0($a1)
	jr $ra	

Input1:

	la $a0,out2
	addi $v0,$zero,4
	syscall

	addi $v0,$zero,5 #enter element by element
	syscall

	sw $v0,0($a1)
	add $a1,$a1,4 #save element by element

	add $a2,$a2,-1
	bne $a2,$zero,Input1
	add $a2,$zero,$s0 #getting iterator back to orignal length

get_index: # to get index to insert
	la $a0,out3
	addi $v0,$zero,4 
	syscall

	addi $v0,$zero,5
	syscall
	add $t0,$zero,$v0	

get_number: # to get number to insert
	la $a0,out4
	addi $v0,$zero,4
	syscall

	addi $v0,$zero,5
	syscall
	add $t1,$zero,$v0

insert_element: #to insert element
	jal insert

print_result: #to print result
	la $a0,out5
	addi $v0,$zero,4
	syscall

	add $a2,$zero,$s0
	la $a1,arr1

output:
	lw $a0,0($a1)
	addi $v0,$zero,1
	syscall

	add $a1,$a1,4

	add $a2,$a2,-1
	bne $a2,$zero,output
End: #ending program
	addi $v0,$zero,10
	syscall	

