########################################
# Project 1
# Name: Christopher Li
# CS240 MW 6:30-7:45PM
########################################

	.data
prompt: .asciiz "\n Please Input a value for N = "
result: .asciiz " The sum of the integers from 1 to N is "
bye: 	.asciiz "\n ****Adios Amigo - Have a good day****"
	
	.globl main
	.text
main:
	li	$v0,4		#Print string system call
	la	$a0,prompt	#load the address of prompt into $a0
	syscall			#Print the prompt message
	
	li	$v0,5		#Read integer system call
	syscall			#Reads value N into $v0 register

	blez	$v0,end		#Branch terminates if $v0 <= 0
	li	$t0,0		#Clears $t0 to zero
loop:
	add	$t0,$t0,$v0	#Sum of integers placed in $t0
	addi	$v0,$v0,-1	#Sum of integers in reverse order
	bnez	$v0,loop	#Branch to loop if $v0 is != 0

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
