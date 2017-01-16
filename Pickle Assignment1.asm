.data
	#The stored strings of the program
	prompt:	.asciiz	"Enter three integers: "
	int1:	.asciiz	"Integer #1: "
	int2:	.asciiz	"Integer #2: "
	int3:	.asciiz	"Integer #3: "
	sum:	.asciiz "The sum of the integers is: "
	small:	.asciiz	"The smallest of the integers is: "
	large:	.asciiz	"The largest of the integers is: "
	return:	.asciiz "\n"

.text
main:
	#Prompt the user to input three integers
	li $v0, 4	#Tells the system you want to print out a string
	la $a0, prompt	#loads the address of the prompt tag
	syscall		#makes the system perform the action

	#Ask for the first integer
	li $v0, 4	
	la $a0, int1	
	syscall 

	#Get user input
	li $v0, 5	#Tells system you want to input an int
	syscall

	#Store the first integer
	move $s0, $v0	#Saves the inputted value in $s0

	#Ask for the second integer
	li $v0, 4	
	la $a0, int2
	syscall 

	#Get user input
	li $v0, 5
	syscall

	#Store the second integer
	move $s1, $v0

	#Ask for the third integer
	li $v0, 4	
	la $a0, int3	
	syscall 

	#Get user input
	li $v0, 5
	syscall

	#Store the third integer
	move $s2, $v0

	#Calculate the sum of the integers
	add $t0, $s0, $s1
	add $t0, $t0, $s2

	#Report the sum of the integers
	li $v0, 4
	la $a0, sum
	syscall
	
	li $v0, 1	#Tells the system you want to output an int
	move $a0, $t0	#Moves the $t0 variable to the input/output variable
	syscall
	
	li $v0, 4
	la $a0, return #Add a new line to the end of he line
	syscall

	#Determine the smallest integer
	slt $t0, $s0, $s1
	bgtz $t0, sm1		#If $s0 is smaller than $s1 go to sm1
	beqz $t0, sm2		#If $s1 is smaller than $s0 go to sm2
sm1:
	slt $t0, $s0, $s2
	beqz $t0, s2sm		#$s2 is the smallest so go to s2sm
	bgtz $t0, s0sm		#$s0 is the smallest so go to s0sm
sm2:	
	slt $t0, $s1, $s2
	beqz $t0, s2sm		#$s2 is the smallest so go to s2sm	
	bgtz $t0, s1sm		#$s1 is the smallest so go to s1sm
s0sm:	
	#Print out $s0 as the smallest int
	li $v0, 4
	la $a0, small
	syscall
	
	li $v0, 1
	la $a0, ($s0)
	syscall
	
	li $v0, 4
	la $a0, return
	syscall
	j smend		#once smallest int is printed skip the rest of this section
s1sm:	
	#Print out $s1 as the smallest int
	li $v0, 4
	la $a0, small
	syscall
	
	li $v0, 1
	la $a0, ($s1)
	syscall
	
	li $v0, 4
	la $a0, return
	syscall
	j smend
s2sm:	
	#Print out $s2 as the smallest int
	li $v0, 4
	la $a0, small
	syscall
	
	li $v0, 1
	la $a0, ($s2)
	syscall
	
	li $v0, 4
	la $a0, return
	syscall
	j smend
	
smend:	

	#Determine the largest integer
	sgt $t0, $s0, $s1
	bgtz $t0, lg1		#If $s0 is larger than $s1 go to sm1
	beqz $t0, lg2		#If $s1 is larger than $s0 go to sm2
lg1:
	sgt $t0, $s0, $s2
	beqz $t0, s2lg		#$s2 is the largest so go to s2sm
	bgtz $t0, s0lg		#$s0 is the largest so go to s0sm
lg2:	
	sgt $t0, $s1, $s2
	beqz $t0, s2lg		#$s2 is the largest so go to s2sm	
	bgtz $t0, s1lg		#$s1 is the largest so go to s1sm
s0lg:	
	#Print out $s0 as the largest int
	li $v0, 4
	la $a0, large
	syscall
	
	li $v0, 1
	la $a0, ($s0)
	syscall
	
	li $v0, 4
	la $a0, return
	syscall
	j lgend		#once largest int is printed skip the rest of this section
s1lg:	
	#Print out $s1 as the largest int
	li $v0, 4
	la $a0, large
	syscall
	
	li $v0, 1
	la $a0, ($s1)
	syscall
	
	li $v0, 4
	la $a0, return
	syscall
	j lgend
s2lg:	
	#Print out $s2 as the largest int
	li $v0, 4
	la $a0, large
	syscall
	
	li $v0, 1
	la $a0, ($s2)
	syscall
	
	li $v0, 4
	la $a0, return
	syscall
	j lgend
	
lgend:	

	#Loop back to begining
	j main
	