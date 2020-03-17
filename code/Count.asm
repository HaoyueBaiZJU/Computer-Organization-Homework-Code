# Your name:
# Your student id:
# Your email address:
# Homework 2 Question 1

.data
# define the strings for any output messages
initMsg: .asciiz "Please enter an integer from 0 to 99 into the array A[] one by one:\n"
EnterNumberMsg1: 	.asciiz "A["
EnterNumberMsg2: 	.asciiz "]: "
OrignalMsg: 	.asciiz "\nOriginal array:"
CountMsg:	.asciiz "\nBin count output:"
OutputCountMsg1:        .asciiz"\nThe count of "
OutputCountMsg2:        .asciiz" in A[] is: "
#array A[] has 10 elements, each element is of the size of one word, 32 bits.
A: .word 0:10
#array A_count[] has 100 elements, each element is of the size of one word, 32 bits.
A_count: .word 0:100
#size indicates the number of elements in array A[]
size: .word 10
#max_range indicates the upper bound of the array A[] elements, all the element must be bigger than or equal to 0 and less than max_range (=100)
max_range: .word 99
space: .asciiz " "

.text
.globl main

main:
# Your code starts here
	# load the starting address of array to $s0
	# array A size is saved in $s1
	# load the starting address of A_count to $s2
	# max_range is saved in $s3
	la $s0,A        #$s0 base address of array A[]
	la $s1,size
	lw $s1,0($s1)   #$s1 is the size of array A[]
	la $s2,A_count  #$s2 is the base address of array A_count[]
	la $s3,max_range
	lw $s3,0($s3)   #$s3 is the upperbound of user enter value 100, the values user can enter is 0,...,99 (100 is not included)
	
	add $t1,$s1,$zero
	
	#prompt the user for inputs
	la $a0, initMsg
	addi $v0, $zero, 4
	syscall

	#keep coming back to array_input for 10 times to get the 10 inputs
	
	array_input:
	beq  $t1,$zero, passpara # $t1 is the remaining number of integer inputs to be entered by the user
	
	# print the message on the screen and wait for user input
	# print part1
	la $a0, EnterNumberMsg1
	addi $v0, $zero, 4
	syscall
	
	# print index
	sub $t2, $s1,$t1 #$s1-$t1 is the index of the current user input integer in array A[]
	add $a0,$t2,$zero #print this index calculated and stored in $t2
	addi $v0, $zero, 1
	syscall
	
	# print part2
	la $a0, EnterNumberMsg2
	addi $v0, $zero, 4
	syscall
	
	# take user input and store in A[i]
	addi $v0, $zero, 5
	syscall
	#$t2 is holding i, A[i]=base of A+i*4
	sll $t3,$t2,2   #multiple i by 4
	add $t3,$t3,$s0 #$t3=i*4 + base of A in $s0 
	sw $v0, 0($t3)  #store user inputted integer to A[i] in the memory
	
	addi $t1,$t1,-1 #decrease $t1 by 1, $t1 is initially 10, after one integer has entered by the user $t1=10-1=9
	
	j array_input   #go back to get another user inputted integer
	
	passpara:
	# copying parameters to $s0,$a1,$a2 before calling bin_count
	add $a0,$s2,$zero #$a0 is base address of A_count[]
	add $a1,$s0,$zero #$a1 is the base address of A[]
	add $a2,$s1,$zero #$a2 is the size of the A[]
	
	jal bin_count
	
	#print on screen
	la $a0, OrignalMsg
	addi $v0, $zero, 4
	syscall
	
	add $a0,$s0,$zero # parameter passing for arrayPrint
	add $a1,$s1,$zero
	jal arrayPrint
	
	la $a0, CountMsg
	addi $v0, $zero, 4
	syscall
	
	add $a0,$s2,$zero # parameter passing for arrayPrint
	add $a1,$s3,$zero
	add $a1,$a1,1
	jal countPrint
	
	exit:
	addi $v0, $zero, 10 
	syscall
	
# This function counts the frequencies of each integer in A[]
# the results are stored in A_count[]. 
# after running the function, A_count[i] is supposed to be holding the frequency integer i in the array A[]
# Assume the following :
# base address of A_count[] is in $a0
# the base address of   A[] is in $a1
# the size of           A[] is in $a2
# preserve the $s0,...$s7 registers if you use them below
bin_count:
#TODO below

	
		









#TODO Above			
jr    $ra     # return from bin_count()



# This function prints array content on the screen
arrayPrint:
	addi $t1,$zero,0
	add $t3,$a0,$zero  
	
	Loop2:
	slt $t2,$t1,$a1
	beq $t2,$zero,L3
	
	sll $t2,$t1,2
	add $t2,$t2,$t3
	lw $t2,0($t2) # $t2<-array[i]
	
	add $a0,$t2,$zero
	addi $v0, $zero, 1
	syscall
	
	# Print a space to separate numbers
	la $a0,space
	addi $v0, $zero, 4
	syscall 
	
	addi $t1,$t1,1	
	j Loop2
	
	L3:	        
	jr    $ra			# return

	
# This function prints count results on the screen
# $a0 holding the base address of
countPrint:
	addi $t1,$zero,0
	add $t3,$a0,$zero  
	
	Loop3:
	slt $t2,$t1,$a1
	beq $t2,$zero,L4
	
	sll $t2,$t1,2
	add $t2,$t2,$t3
	lw $t2,0($t2) # $t2<-array[i]
	
	
	beq $t2,$zero,L5
	
	
	# print part1
	la $a0, OutputCountMsg1
	addi $v0, $zero, 4
	syscall
	# print index	
	add $a0,$t1,$zero
	addi $v0, $zero, 1
	syscall
	# print part2
	la $a0, OutputCountMsg2
	addi $v0, $zero, 4
	syscall
	
	add $a0,$t2,$zero
	addi $v0, $zero, 1
	syscall
	
	# Print a space to separate numbers
	la $a0,space
	addi $v0, $zero, 4
	syscall 
	
	L5:

	addi $t1,$t1,1	
	j Loop3
	
	L4:	        
	jr    $ra			# return
	
	
	
	
