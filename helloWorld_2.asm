# fancy Hello World program
# general information about writting assembly language files

# define data segment
.data
	HelloMsg:		.asciiz	"HELLO\nWORLD\n" #null terminated char array - a string
	PressAnyKey: 	.asciiz "Press any key to continue..." 
	
# define text segment
.text

# assembler directive
.globl  main	# name of main program

# main program
main:
	# display "HELLO WORLD"
 	la $a0, HelloMsg	# string to display
	li $v0, 4	# load print_string code
	syscall		# print the string
	
	#dipslay "Press any key..."
 	la $a0, PressAnyKey	# string to display
	li $v0, 4	# load print_string code
	syscall		# print the string

	# exit when a key is pressed
	li $v0, 12	# load read_char code
	syscall		# read from kb until key pressed
	li $v0, 10	# load exit code
	syscall		# exit

   
    







