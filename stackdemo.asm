# Reverse.a - Reverse the Character
# String "str".

# $t1 - points to the string
# $t0 - hold each byte from the string in turn

	.data 	 		# define data segment
str:		.asciiz "Hello World"
endl:		.asciiz "\n"
prCont:		.asciiz "Press 'Enter' to continue..."

	.text
	.globl main
main:
	la $a0, str		# load address of string into $a0
	li $v0, 4		# load syscall code 4 into $v0
	syscall			# output the string. 

	la $a0, endl		# syscall to print a blank line
	li $v0, 4
	syscall

	la $t1, str
nextch:	lb $t0, ($t1)		# Get a byte from the string
	beqz  $t0, strEnd	# Test for end of string. 
	sub  $sp, $sp, 4		# Sub 4 from stack pointer
	sw  $t0, ($sp)		# Push word onto stack
	add  $t1, $t1,1		# Increment pointer to string character
	j  nextch			# unconditional jump to nextch label

strEnd:
	la  $t1, str		# load address of string into $t1

store:
	lb  $t0, ($t1)		# Get a byte from the string at $t1
	beqz  $t0, done		# Test if done with string
	lw  $t0, ($sp)		# Pop a value from the stack
	add  $sp, $sp, 4	# Add 4 to the stack pointer 
	sb  $t0, ($t1)		# store the char in the string at $t1
	add  $t1, $t1, 1	# increment string pointer by 1
	j store				# unconditional jump to store label loop

done:
	la  $a0, str 		# load address of string into $a0
	li  $v0, 4		# load syscall code 4 into $v0
	syscall			# output the string. 

	la  $a0, endl		# syscall to print a black line
	li  $v0, 4
	syscall

	la $a0, prCont		# string to display
	li $v0, 4		# load print_string code
	syscall			# display string

	li $v0, 5		# load read_int code
	syscall			# read keyboard

	li  $v0, 10		# syscall to exit to op. sys.
	syscall

##
##   end of file to reverse characters. 
