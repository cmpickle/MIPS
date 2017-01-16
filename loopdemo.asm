# demonstrate loops using branch and jump instructions
#   for
#   do...while
#   while

# registers
#	$t1	loop counter, upper limit, keyboard input
#	$t2	lower limit
#	$a0	Syscall output data
#	$v0	syscall codes

# define Data Segment
.data
	crlf:		.asciiz "\n"
	lpFor:		.asciiz "for loop demo"
	lpRepeat:	.asciiz "do...while loop demo"
	lpWhile:	.asciiz "While loop demo"
	execMsg:	.asciiz "executing while loop"
	doneMsg:	.asciiz "while loop finished\n"
	prInput:	.asciiz "Enter an integer (0 to quit): "
	prCont:		.asciiz "Press 'Enter' to continue...\n"

# define text Segment
.text

# assembler directive
	.globl main

# main program
main:
# ********************************************************
# for( i=0; i<10; i++ )
# ********************************************************
	la	$a0, lpFor	# string to display
	li	$v0, 4		# load print_string code
	syscall			# display string

	la	$a0, crlf	# string to display (new line)
	li	$v0, 4		# load print_string code
	syscall			# display string

	# initialize counter
	li	$t1, 1

	# loop test
loop1:	
	bgt $t1, 10, exitF 	# if t1 > 10, exit
	
	# loop body
	move	$a0, $t1	# integer to display (counter)
	li		$v0, 1		# load print_int code
	syscall				# display integer

	la	$a0, crlf	# string to display (new line)
	li	$v0, 4		# load print_string code
	syscall			# display string

	# inc counter
	addi	$t1, $t1, 1		
	
	# repeat loop
	j	loop1

exitF:	jal	wait		# wait till key is pressed

# ********************************************************
# do...while( upper limit >= lower limit )
# ********************************************************
# count down from 20 to 5
	la	$a0, lpRepeat	# string to display
	li	$v0, 4			# load print_string code
	syscall				# display string

	la	$a0, crlf	# string to display (new line)
	li	$v0, 4		# load print_string code
	syscall			# display string

	# initialize limits
	li	$t1, 20		# set upper limit (counter)
	li	$t2, 5		# set lower limit

loop2:	# loop body
	move	$a0, $t1	# integer to display (counter)
	li		$v0, 1		# load print_int code
	syscall				# display counter

	la	$a0, crlf	# string to display (new line)
	li	$v0,4		# load print_string code
	syscall			# display string

	subu	$t1, $t1, 1		# dec counter

	# loop test - repeat if $t1 >= $t2
	bge	$t1, $t2, loop2

	jal	wait		# wait till key is pressed

# ********************************************************
# While( kbInput != 0 )
# ********************************************************
	la	$a0, lpWhile	# string to display
	li	$v0, 4		# load print_string code
	syscall			# display string

	la	$a0, crlf	# string to display (new line)
	li	$v0,4		# load print_string code
	syscall			# display string

loop3:	# get integer from keyboard - store in $t1
	la	$a0, prInput	# string to display
	li	$v0, 4			# load print_string code
	syscall				# display string
	li	$v0, 5			# load read_int code
	syscall				# read keyboard
	move	$t1, $v0	# move integer to temp register

	# loop test
	beq	$t1,$zero,exitW # quit loop if integer == 0

	# loop body
	la	$a0, execMsg	# string to display
	li	$v0, 4			# load print_string code
	syscall				# display string

	la	$a0, crlf	# string to display (new line)
	li	$v0,4		# load print_string code
	syscall			# display string

	# repeat loop
	j	loop3

exitW:	
	la	$a0, doneMsg	# string to display
	li	$v0,	4		# load print_string code
	syscall				# display string

	la	$a0, crlf	# string to display (new line)
	li	$v0,4		# load print_string code
	syscall			# display string

	jal wait		# wait till key is pressed

# exit to Operating System.
	li	$v0, 10  	# load exit code
	syscall			# exit

#------------------------------------
# procedure: wait till key is pressed
#------------------------------------
wait:
	la	$a0, prCont	# string to display
	li	$v0, 4		# load print_string code
	syscall			# display string

	li	$v0, 12		# load read_char code
	syscall			# read keyboard

	jr	$ra
#-----------------------------------

# end of program
