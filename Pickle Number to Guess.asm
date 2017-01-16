.data
	#Number that is to be guessed
	numToGuess:	.word	42
	guessMax:	.word	5
	guessCount:	.word	0
	
	#Strings
	#equalNum:	.asciiz	"good guess"
	smallerNum:	.asciiz	"Your guess was too low.\n"
	higherNum:	.asciiz	"Your guess was too high.\n"
	congrats:	.asciiz	"Congratulations! you guessed the number!"
	#guessesUsed:	.asciiz	"You had your five guesses"
	prompt:		.asciiz	"I have picked an integer between 1 and 100. You have five guesses to figure it out. Good luck!\n"
	int1:		.asciiz	"Input your guess: "
	limMessage:	.asciiz	"You have already had your five guesses."
	
.text
main:	
	#Give instructions for the program
	li $v0, 4	#Tells the system you want to print out a string
	la $a0, prompt	#loads the address of the prompt tag
	syscall	
	
guess:
	#Check the guessCount to see if user has more guesses
	lw $t1, guessCount
	lw $t2, guessMax
	sge $t0, $t1, $t2
	beq $t0, 1, guessLim 
		
	#Ask for an integer
	li $v0, 4	
	la $a0, int1	
	syscall 
	
	#Get user input
	li $v0, 5	#Tells system you want to input an int
	syscall
	
	#Store the first integer
	move $s0, $v0	#Saves the inputted value in $s0
	
	#Make comparisons on inputted integer and numToGuess
	jal compare
	
	#Incrament the guess count
	lw $t0, guessCount
	addi $t0, $t0, 1
	sw $t0, guessCount
	
	
	#Start new iteration of guess
	j guess
	
compare:
	#Check if the input is equal to the number to guess
	lw $t0, numToGuess 
	seq $t1, $s0, $t0	#Returns 1 for a "good guess" and 0 for a "too low" or "too high" guess
	bnez $t1, win
	
	#Check if the input is greater than the number to guess
	lw $t0, numToGuess
	sgt $t1, $s0, $t0
	bnez $t1, higher
	
	#Check if the input is less than the number to guess
	lw $t0, numToGuess
	slt $t1, $s0, $t0
	bnez $t1, lower
	
lower:
	li $v0, 4
	la $a0, smallerNum
	syscall
	
	jr $ra
	
higher:
	#prints out message that the users guess was larger than the numToGuess 
	li $v0, 4
	la $a0, higherNum
	syscall
	
	jr $ra
	
guessLim:
	#Output that the guess limit has been reached
	li $v0, 4	
	la $a0, limMessage	
	syscall 
	
	#Exit the program
	li $v0, 10
	syscall
	
win:
	#Congratulates the user and exits the program
	li $v0, 4
	la $a0, congrats
	syscall
	
	#Exit the program
	li $v0, 10
	syscall