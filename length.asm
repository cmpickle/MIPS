# count the length of a string

# registers
# t0 holds each byte from the string in turn
# t1 contains the count of characters
# t2 points to the string to be used. 

.text
	.globl main

main:
	la $t2,str		# load address of string into t2
	li $t1,0		# initialize count in t1 to zero
nextch:
	lb $t0, ($t2)		# get byte from the string
	beqz $t0, strEnd	# branch when end of string is found
	addi $t1, $t1, 1	# increment count of bytes if not end
	addi $t2, $t2, 1	# increment pointer to string 
	j nextch			# unconditional jump to nextch

strEnd:
	la $a0, str		# load address of ans text to a0
	li $v0, 4		# setup for syscall to output text
	syscall			# system call to output text messages
	
	la $a0, endl	# load address of endl into a0
	li $v0,4		# setup for syscal to output newline
	syscall			# output carriage return line feed

	la $a0, ans		# load address of ans text to a0
	li $v0,4		# setup for syscall to output text
	syscall			# system call to output text message

	move $a0,$t1	# load count into a0
	li $v0,1		# setup for syscall to output count
	syscall			# output the length count

	la $a0, endl	# load address of endl into a0
	li $v0,4		# setup for syscal to output newline
	syscall			# output carriage return line feed

# Hold the screen until a key is pressed
	la	$a0, hold
	li	$v0, 4
	syscall				# output the hold prompt
	li	$v0, 12
	syscall				# hold the screen for input

	li	$v0, 10			#load exit code to v0
	syscall				#exit program return to Op. Sys.

.data
	str:	.asciiz "The lazy brown fox jumped over the log."
	ans:	.asciiz "Length = "
	endl:	.asciiz "\n"
	hold:   .asciiz "Press any key to continue..."

#  end of file
