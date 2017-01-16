# convert celcius temperatures to fahrenheit
# Ftemp = 9/5 * Ctemp + 32
# 
#   Registers used
#	$t0 holds 9 * Celsius Temperature
#	$a0 holds input and output values for Syscall operations
#	$v0 holds syscall codes and input values.

.text	#begin text code segment	
	.globl  main	#program entry point

main:
	la		$a0, prompt		#load prompt
	li		$v0, 4			#syscall code for print string
	syscall					#print string  print prompt.

	li 		$v0, 5			#syscall code to read integer
	syscall					#read integer into $v0
	
	mulo	$t0, $v0, 9		#t0 = V0 * 9
	div 	$t0, $t0, 5		#t0 = t0 / 5
	add		$t0, $t0, 32	#t0 = t0 + 32

	la 		$a0, ans1		#load address for ans1 string to a0
	li 		$v0, 4			#load print string code into v0
	syscall					#print the ans1 string

	move 	$a0, $t0	#(t0) -> a0
	li 		$v0, 1		# load syscall code to print integer
	syscall				# display integer result of conversion
	
	la		$a0, end1	#load address of end1 CR/LF code
	li		$v0,4		#load syscall code for string output
	syscall				#output CR/LF 


# Hold the screen until a key is pressed
	la	$a0, hold
	li	$v0, 4
	syscall				# output the hold prompt
	li	$v0, 12
	syscall				# hold the screen for input

	li	$v0, 10			#load exit code to v0
	syscall				#exit program return to Op. Sys.

.data	#begin data segment
	prompt:	.asciiz	"Enter Temperature in Celsius: "
	ans1:	.asciiz	"The temperature in Fahrenheit is: "
	end1:	.asciiz	"\n"
	hold:   .asciiz "Press any key to continue..."
#end of file
