#------- Data Segment ----------
.data

mesg1: .asciiz "Please enter the bit number(range:1~4) of Gray Code: "
newline: .asciiz "\n"
msg2:		.asciiz "The Gray Code output is\n"
space: .asciiz " "
array1: 		.word 0,1
array2: 		.word 0,0,0,0
array3: 		.word 0,0,0,0,0,0,0,0
array4: 		.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0



#------- Text Segment ----------
.text 
.globl main
main:

	# Print starting message to ask for row number input
	la 	$a0 mesg1						
	li 	$v0 4
	syscall					

	# $t0 stores number of lines to print
	li 	$v0, 5
	syscall					
	addi 	$t0, $v0, 0			

	la      $s1, array1
	la      $s2, array2
	la      $s3, array3
	la      $s4, array4

						
# output 1-bit Gray Code in array1
        add    $a1, $zero, $s1
        addi   $a2, $zero, 1
        beq 	$t0, 1, endPrint # user entered 1

# generate 2-bit Gray Code based on 1-bit Gray Code
        # parameter passing
        add     $a0, $zero, $s1 #$a0 is the base address of array1
        add     $a1, $zero, $s2 #$a1 is the base address of array2
        addi    $a2, $zero, 2   #$a2 is the length of array holding the (n-1)-bit Gray code (i.e. length of the array1 holding the 1-bit Gray code)
        jal     mirror         
        jal     addOneToLeft
        beq     $t0, 2, endPrint #user entered 2

# generate 3-bit Gray Code based on 2-bit Gray Code
        # parameter passing
        add     $a0, $zero, $s2  #$a0 is the base address of array2
        add     $a1, $zero, $s3  #$a1 is the base address of array3
        addi    $a2, $zero, 4    #$a2 is the length of the array holding the 2-bit Gray code
        jal     mirror         
        jal     addOneToLeft
        beq     $t0, 3, endPrint #user entered 3

# generate 4-bit Gray Code based on 3-bit Gray Code
        # parameter passing
        add     $a0, $zero, $s3  #$a0 is the base address of array3
        add     $a1, $zero, $s4  #$a1 is the base address of array4
        addi    $a2, $zero, 8    #$a2 is the length of the array holding the 3-bit Gray code
        jal     mirror        
        jal     addOneToLeft
        beq     $t0, 4, endPrint #user entered 4

#print the message "The Gray Code output is"
#then print the corresponding Gray code according to user entered value
endPrint:	
        la 	$a0, msg2
	li 	$v0, 4
	syscall	
		
	jal printGrayCode			
					
	# Terminate the program
	li 	$v0, 10 
	syscall			
	

# arguments are in $a0, $a1 and $a2
# $a0 (n-1)-bit Gray Code array address, this is the "int smallArray[]" argument in the C++ code
# $a1 n-bit Gray Code array address, this is the "int bigArray[]" argument in the C++ code
# $a2 length of (n-1)-bit Gray Code array, this is the "int n" argument in the C++ code
# preserve the $s0,...$s7 registers if you use them below
mirror:
#TODO1 Below



















#TODO1 Above
jr    $ra			# return from mirror()
	
	
# arguments are in $a1 and $a2
# a1 n-bit Gray Code array address, this is the "int array[]" argument in the C++ code
# a2 length of (n-1)-bit Gray Code array, this is the "int n" argument in the C++ code
# preserve the $s0,...$s7 registers if you use them below
addOneToLeft:
#TODO2 Below

















#TODO2 Above
jr    $ra			# return from addOneToLeft()

printGrayCode:
# a1 n-bit Gray Code array address
# a2 length of (n-1)-bit Gray Code array
	addi $t1, $zero, 0
	add  $t3, $a1, $zero  
	
	Loop3:
	add  $a3, $a2, $a2 # a3 length of n-bit Gray Code array
	slt  $t2, $t1, $a3 # if t1 < a3
	beq  $t2, $zero, L3
	
	sll  $t2, $t1, 2
	add  $t2, $t2, $t3
	lw   $t2, 0($t2) # $t4<-array[i]
	
	addi $t4, $zero, 0 # j = 0
	addi $a3, $zero, 1 # '1000' -> '0100' -> '0010' -> '0001'	
	add $t6, $zero, $t0
	Loop4:
	slt  $t5, $t4, $t0
	beq  $t5, $zero, L4
	
	addi $t6, $t6, -1
	sllv $a1, $a3, $t6
	
	add  $t5, $zero, $a1
	and  $t7, $t2, $t5
	slt  $t7, $zero, $t7
	
	add  $a0, $t7, $zero 
	addi $v0, $zero, 1
	syscall
	
	addi $t4, $t4, 1	
	j Loop4
	
	L4:

	la   $a0, space
	addi $v0, $zero, 4
	syscall 
	
	
	addi $t1, $t1, 1	
	j Loop3
	
	L3:	        
	jr    $ra			# return




				


