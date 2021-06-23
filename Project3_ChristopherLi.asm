########################################
# Project 3
# Name: Christopher Li
# CS240 MW 6:30-7:45PM
########################################

	.data
string1: .space 5	#must allocate extra byte
str2: .asciiz "\n The output string is: "
string2: .space 5	#must allocate extra byte
str1: .ascii "\n Enter the string: "
	.text
	
main:
	la $a0,str1		#load the address of prompt into $a0
	li $v0,4		#Print string system call
	syscall			#Print the prompt message
	
	li $v0,8		#Read string call
	li $a1,5		#Set the maximum number of characters to read
	la $a0,string1	#load the address of string1 into $a0
	syscall
	
	lb $t0,0($a0)	#Load byte from 0($a0) into $t0
	lb $t1,1($a0)	#Load byte from 1($a0) into $t1
	lb $t2,2($a0)	#Load byte from 2($a0) into $t2
	lb $t3,3($a0)	#Load byte from 3($a0) into $t3
	add $sp,$sp,-4	#Allocate 4 bytes for stack
	
	sb $t0,0($sp)	#Store byte from $t0 into 0($sp)
	sb $t1,1($sp)	#Store byte from $t1 into 1($sp)
	sb $t2,2($sp)	#Store byte from $t2 into 2($sp)
	sb $t3,3($sp)	#Store byte from $t3 into 3($sp)
	
	lb $s0,0($sp)	#Load byte from 0($sp) into $s0
	lb $s1,1($sp)	#Load byte from 1($sp) into $s1
	lb $s2,2($sp)	#Load byte from 2($sp) into $s2
	lb $s3,3($sp)	#Load byte from 3($sp) into $s3
	add $sp,$sp,4	#Deallocate 4 bytes from stack
	
	la $t5,string2	#load the address of string2 into $t5
	
	sb $s3,0($t5)	#Store byte from $s3 into 0($t5)
	sb $s2,1($t5)	#Store byte from $s2 into 1($t5)
	sb $s1,2($t5)	#Store byte from $s1 into 2($t5)
	sb $s0,3($t5)	#Store byte from $s0 into 3($t5)
	
	la $a0,str2		#load the address of prompt into $a0
	li $v0,4		#Print string system call
	syscall			#Print the prompt message
	
	la $a0,string2	#load the address of string2 into $a0
	li $v0,4		#Print string system call
	syscall			#Print the prompt message
	
	li $v0,10 		#end program
	syscall			#Return control to system
	
