########################################
# Project 2
# Name: Christopher Li
# CS240 MW 6:30-7:45PM
########################################

	.data
prompt: .asciiz "\nPlease Input a value for N = "
result: .asciiz "\nThe sum of the integers from 1 to N is "
truncated: .asciiz "This is a floating point number. Number has been truncated to an integer with value: "
bye: 	.asciiz "\n ****Adios Amigo - Have a good day****"
	
	.globl main
	.text
main:
	li	$v0,4		#Print string system call
	la	$a0,prompt	#load the address of prompt into $a0
	syscall			#Print the prompt message
	
	li	$v0,6		#Read float system call
	syscall			#Reads value N into $v0 register
	
	#Move the FP number into an integer register, no conversion
	mfc1 $t1, $f0 	#$t1 = 1075838976

	blez	$v0,end		#Branch terminates if $v0 <= 0
	
	srl	$t2, $t1, 23 	#$t2 = 128
	#Subtract 127 to get the exponent
	add	$s3, $t2, -127	#Gets the exponent

	#Get the fraction
	sll	$t4, $t1, 9		#Shift out exponent and sign
	srl $t5, $t4, 9		#Shift back to original position
	addi $t6, $t5, 8388608	#add the implied bit
	add	$t7, $s3, 9		#add 9 to the exponent
	sllv $s4, $t6, $t7	#Shifting to the left
	
	#Get the integer
	rol	$t4, $t6, $t7
	#Shift left 31 -exp to zero out
	li	$t5, 31
	sub	$t2, $t5, $s3	#Shift value
	sllv $t5, $t4, $t2	#Zero out
	srlv $s5, $t5, $t2	#reset integer
	
	move $v0, $s5		#move integer  $s5 to $v0
	bgtz $s4,int		#Jump to int if $s4 > 0
int:	
	li	$v0,4		#Print string system call
	la	$a0,truncated	#Load address of truncated into $a0
	syscall			#Print address message

	
	li	$v0,1		#Print integer system call
	move	$a0,$s5		#Move value to be printed from $s5 to $a0
	syscall			#Print integer
	
	li	$t0,0		#Clears $t0 to zero
loop:
	add	$t0,$t0,$s5	#Sum of integers placed in $t0
	addi	$s5,$s5,-1	#Sum of integers in reverse order
	bnez	$s5,loop	#Branch to loop if $v0 is != 0

	li	$v0,4		#Print string system call
	la	$a0,result	#Load address of result into $a0
	syscall			#Print address message

	li	$v0,1		#Print integer system call
	move	$a0,$t0		#Move value to be printed from $t0 to $a0
	syscall			#Print sum of integers
	b 	main		#Branch to main
end:
	li	$v0,4		#Print string system call
	la	$a0,bye		#Load address of bye into $a0
	syscall			#Print bye message
	
	li	$v0,10		#Terminate program and
	syscall			#Return control to system
