#------- Data Segment ----------
.data
# Define the string messages and the matrix
EnterNumberMsg1: 	.asciiz "MatrixA["
EnterNumberMsg2: 	.asciiz "]: "
EnterNumberMsg3: 	.asciiz "MatrixB["
EnterNumberMsg4: 	.asciiz "]: "
msg1:           .asciiz "The original matrix A is\n"
msg2:           .asciiz "\nThe original matrix B is\n"
msg3:		.asciiz "\nThe multiplied output matrix is\n"
space:		.asciiz " "
newline:	.asciiz "\n" 
                     
originMatrixA:    .word 0:4
originMatrixB:    .word 0:4
outputMatrix: .word 0:4
size:			.word 4
col:			.word 2
row:			.word 2

#------- Text Segment ----------
.text
.globl main
main:
	la $s0,originMatrixA  #$s0 holds the starting address of originMatrixA
	la $s1, originMatrixB #$s1 holds the starting address of originMatrixB
	la $s2,size           
	lw $s2,($s2)          #$s2 holds the number of elements in the matrices
	la $s4, col
	lw $s4,($s4)          #$s4 holds the column number of the matrices
	la $s5,row
	lw $s5,($s5)         #$s5 holds the row number of the matrices
	la $s3, outputMatrix #$s3 holds the starting address of outputMatrix

	
	add $t1,$s2,$zero #$t1 holds number of times we need to get input elements for matrix A
	
	matrixA_input:
	
	beq  $t1,$zero, getMatrixB #all elements got for matrix A, go to get elements for matrix B
	
	# print part1
	la $a0, EnterNumberMsg1
	addi $v0, $zero, 4
	syscall
	
	# print index
	sub $t2, $s2,$t1
	add $a0,$t2,$zero
	addi $v0, $zero, 1
	syscall
	
	# print part2
	la $a0, EnterNumberMsg2
	addi $v0, $zero, 4
	syscall
	
	# take user input and store in memory
	addi $v0, $zero, 5
	syscall
	sll $t3,$t2,2
	add $t3,$t3,$s0
	sw $v0, 0($t3)
	
	addi $t1,$t1,-1
	j matrixA_input
	
	getMatrixB: #get Matrix B elements
	add $t1,$s2,$zero #$t1 holds number of times we need to get input elements for matrix A
	matrixB_input:

	beq  $t1,$zero, outputMatrices #all elements got for matrix B, output matrices A and B to the screen
	
	# print part1
	la $a0, EnterNumberMsg3
	addi $v0, $zero, 4
	syscall
	
	# print index
	sub $t2, $s2,$t1
	add $a0,$t2,$zero
	addi $v0, $zero, 1
	syscall
	
	# print part2
	la $a0, EnterNumberMsg4
	addi $v0, $zero, 4
	syscall
	
	# take user input and store in memory
	addi $v0, $zero, 5
	syscall
	sll $t3,$t2,2
	add $t3,$t3,$s1
	sw $v0, 0($t3)
	
	addi $t1,$t1,-1
	
	j matrixB_input
	
	outputMatrices:
	# print msg1	
	la 	$a0, msg1
	li 	$v0, 4
	syscall	

                 #passing arguments to print
	add  $a1,$s2,$zero # number of elements
	add  $a2,$s4,$zero # number of columns
	add  $a3,$s0,$zero # starting address of array originMatrixA[]
	# Print the original matrix A
	jal print


	# print msg2	
	la 	$a0, msg2
	li 	$v0, 4
	syscall	
	
                 #passing arguments to print
	add  $a1,$s2,$zero # number of elements
	add  $a2,$s4,$zero # number of columns
	add  $a3,$s1,$zero # starting address of array originMatrixB[]
	# Print the original matrix B
 	jal 	print

                 # passing parameters to matrixMultiply
	# $a0 the starting address of originMatrixA
	add $a0,$s0,$zero
	# $a1 the starting address of originMatrixB
	add $a1,$s1,$zero
	# $a3 the starting address of outputMatrix
	add $a2,$s3,$zero
	# Multiply matrix	
	jal 	matrixMultiply
	
                 #output "The multiplied output matrix is"	
	la 	$a0, msg3
	li 	$v0, 4
	syscall
	
	# Print the multiply matrix
	                 #passing arguments to print
	add  $a1,$s2,$zero # number of elements
	add  $a2,$s4,$zero # number of columns
	add  $a3,$s3,$zero # starting address of array outputMatrix[]
	
	# Print the multiplied matrix C
	jal 	print
	
	# Terminate the program
	li 	$v0, 10 
	syscall




# Multiply the originMatrixA and originMatrixB
# you can use the given multiply function given below at "multiply:"
# the multiply function will take the *two positive integers* and multiple them
# the two positive integers are in $a0, $a1, the result of $a0*$a1 is in $v0
# preserve registers to the stack as needed
# $a0 the starting address of originMatrixA
# $a1 the starting address of originMatrixB
# $a2 the starting address of outputMatrix

matrixMultiply:
# TODO below: 
	addi 	$sp, $sp, -4
	sw 	$ra, 0($sp)	
	
# output[0]
        addi  $t1, $zero, 0
	sll   $t2, $t1, 2
	add   $t2, $t2, $a0
	#backup $a0,$a1
	addi $sp,$sp,-8
	sw $a0,0($sp)
	sw $a1,4($sp)
	
	lw    $a0, 0($t2) # $a0<-matrixA[i]
	addi  $t3, $zero, 0
	sll   $t4, $t3, 2
	add   $t4, $t4, $a1
	lw    $a1, 0($t4) # $a1<-matrixB[i]
	

	
	jal   multiply   
	
	#restore $a0,$a1
	lw $a0,0($sp)
	lw $a1,4($sp)
	addi $sp,$sp,8
	
	add   $s6, $zero, $v0
	
	addi  $t1, $zero, 1
	sll   $t2, $t1, 2
	add   $t2, $t2, $a0
	
	#backup $a0,$a1
	addi $sp,$sp,-8
	sw $a0,0($sp)
	sw $a1,4($sp)
	
	lw    $a0, 0($t2) # $a0<-matrixA[i]
	addi  $t3, $zero, 2
	sll   $t4, $t3, 2
	add   $t4, $t4, $a1
	lw    $a1, 0($t4) # $a1<-matrixB[i]
	jal   multiply   
	
	#restore $a0,$a1
	lw $a0,0($sp)
	lw $a1,4($sp)
	addi $sp,$sp,8
	
	add   $s6, $s6, $v0
	
	addi   $t5, $zero, 0
	sll    $t6, $t5, 2
	add    $t6, $t6, $a2       
	sw     $s6, 0($t6)
	
	
	
# output[1]
        addi  $t1, $zero, 0
	sll   $t2, $t1, 2
	add   $t2, $t2, $a0
	
	#backup $a0,$a1
	addi $sp,$sp,-8
	sw $a0,0($sp)
	sw $a1,4($sp)
	
	lw    $a0, 0($t2) # $a0<-matrixA[i]
	addi  $t3, $zero, 1
	sll   $t4, $t3, 2
	add   $t4, $t4, $a1
	lw    $a1, 0($t4) # $a1<-matrixB[i]
	jal   multiply   
	
	#restore $a0,$a1
	lw $a0,0($sp)
	lw $a1,4($sp)
	addi $sp,$sp,8
	
	add   $s6, $zero, $v0 #accumulate temp result to $s6

	#backup $a0,$a1
	addi $sp,$sp,-8
	sw $a0,0($sp)
	sw $a1,4($sp)	
	
	addi  $t1, $zero, 1
	sll   $t2, $t1, 2
	add   $t2, $t2, $a0
	lw    $a0, 0($t2) # $a0<-matrixA[i]
	addi  $t3, $zero, 3
	sll   $t4, $t3, 2
	add   $t4, $t4, $a1
	lw    $a1, 0($t4) # $a1<-matrixB[i]
	jal   multiply 

	#restore $a0,$a1
	lw $a0,0($sp)
	lw $a1,4($sp)
	addi $sp,$sp,8
	  
	add   $s6, $s6, $v0
	
	addi   $t5, $zero, 1
	sll    $t6, $t5, 2
	add    $t6, $t6, $a2       
	sw     $s6, 0($t6)

# output[2]
        addi  $t1, $zero, 2
	sll   $t2, $t1, 2
	add   $t2, $t2, $s0
	#backup $a0,$a1
	addi $sp,$sp,-8
	sw $a0,0($sp)
	sw $a1,4($sp)
	
	lw    $a0, 0($t2) # $a0<-matrixA[i]
	addi  $t3, $zero, 0
	sll   $t4, $t3, 2
	add   $t4, $t4, $a1
	lw    $a1, 0($t4) # $a1<-matrixB[i]
	jal   multiply   

	#restore $a0,$a1
	lw $a0,0($sp)
	lw $a1,4($sp)
	addi $sp,$sp,8
	
	add   $s6, $zero, $v0
	
	addi  $t1, $zero, 3
	sll   $t2, $t1, 2
	add   $t2, $t2, $a0
	
	#backup $a0,$a1
	addi $sp,$sp,-8
	sw $a0,0($sp)
	sw $a1,4($sp)
	
	lw    $a0, 0($t2) # $a0<-matrixA[i]
	addi  $t3, $zero, 2
	sll   $t4, $t3, 2
	add   $t4, $t4, $a1
	lw    $a1, 0($t4) # $a1<-matrixB[i]
	jal   multiply  
	
	#restore $a0,$a1
	lw $a0,0($sp)
	lw $a1,4($sp)
	addi $sp,$sp,8
	 
	add   $s6, $s6, $v0
	
	addi   $t5, $zero, 2
	sll    $t6, $t5, 2
	add    $t6, $t6, $a2       
	sw     $s6, 0($t6)

	
# output[3]
        addi  $t1, $zero, 2
	sll   $t2, $t1, 2
	add   $t2, $t2, $s0
	#backup $a0,$a1
	addi $sp,$sp,-8
	sw $a0,0($sp)
	sw $a1,4($sp)
	
	lw    $a0, 0($t2) # $a0<-matrixA[i]
	addi  $t3, $zero, 1
	sll   $t4, $t3, 2
	add   $t4, $t4, $a1
	lw    $a1, 0($t4) # $a1<-matrixB[i]
	jal   multiply   
	
	#restore $a0,$a1
	lw $a0,0($sp)
	lw $a1,4($sp)
	addi $sp,$sp,8
		
	add   $s6, $zero, $v0
	
	addi  $t1, $zero, 3
	sll   $t2, $t1, 2
	add   $t2, $t2, $a0
	
	#backup $a0,$a1
	addi $sp,$sp,-8
	sw $a0,0($sp)
	sw $a1,4($sp)
	
	lw    $a0, 0($t2) # $a0<-matrixA[i]
	addi  $t3, $zero, 3
	sll   $t4, $t3, 2
	add   $t4, $t4, $a1
	lw    $a1, 0($t4) # $a1<-matrixB[i]
	jal   multiply   
	add   $s6, $s6, $v0
	
	#restore $a0,$a1
	lw $a0,0($sp)
	lw $a1,4($sp)
	addi $sp,$sp,8	
	
	addi   $t5, $zero, 3
	sll    $t6, $t5, 2
	add    $t6, $t6, $a2       
	sw     $s6, 0($t6)

returnMatrix:
	lw 	$ra, 0($sp)
	addi 	$sp, $sp, 4
	jr 	$ra 
# TODO above


# inputs $a0, $a1
# the multiply result saved in $v0
# the multiply function will take the *two positive integers* and multiple them
# the two positive integers are in $a0, $a1, the result of $a0*$a1 is in $v0
multiply:
	addi    $v0, $zero,  0
	beq     $a0,$zero,return
	beq     $a1,$zero,return

Loop:
        add    $v0, $v0, $a0    
        addi   $a1, $a1, -1
        beq    $a1, $zero, return
        j Loop    
        
return:
        jr 	$ra



# print matrx 
# $a1 total number of elements 
# $a2 number of columns in each row
# $a3 starting address of the matrix  

print:
	addi 	$sp, $sp, -4
	sw 	$ra, 0($sp)
	
        jal 	printmain
        
        lw 	$ra, 0($sp)
        addi 	$sp, $sp, 4
        jr 	$ra

# print matrx 
# $s1 total number of elements 
# $a2 number of columns in each row
# $a3 starting address of the matrix  
printmain:
	addi 	$sp, $sp, -4
	sw 	$ra, 0($sp)

	#Print a new line
	#la 	$a0, newline
	#li 	$v0, 4
	#syscall
	
        addi	$t1, $zero, 0  			# $t1 is the index for printing originMatrix[i]
        addi	$t8, $zero, 0                   # $t8 is record the counter for recording number printed on each line
printloop:
	slt  	$t0, $t1, $a1     		#check to see if $t1 (i) is still within the correct range (max value == $a1-1)       
        beq  	$t0, $zero, endprintloop 	#if i>=20 end print numbers
        
	slt	$t0, $t8, $a2                   # check to see if $t8 is still within the correct range (max value == $a2-1)
	beq	$t0, $zero, next_line           # if $t8 == $a2 - 1, then enter next_line
	j	go_on
next_line:
	#Print a new line
	la 	$a0, newline
	li 	$v0, 4
	syscall
	
	# reset $t8
	addi $t8, $zero, 0
	        
go_on:
	sll  	$t2, $t1, 2       		#$t1*4 to get the byte offset
	add  	$t3, $a3, $t2     		#base+byte offset to get the address of originMatrix[i]
	# print originMatrix[i]
	lw   	$a0, 0($t3)                
	li   	$v0, 1
	syscall
	
	#Print a space to separate the numbers
	la 	$a0, space
	li 	$v0, 4
	syscall
	
        #i=i+1 and start another iteration of the loop		
	addi 	$t1,$t1,1     
	# renew $t8
	addi	$t8, $t8, 1 
	j 	printloop 

endprintloop:	
#Print a new line
	la 	$a0, newline
	li 	$v0, 4
	syscall
	lw 	$ra, 0($sp)
        addi 	$sp, $sp, 4
        jr 	$ra
