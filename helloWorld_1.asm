 # classic Hello World program

.data
    #  Define a greeting message.
    Message:  .asciiz   "Hello World!\n"
    Message2: .asciiz   "This is my new string!"

.text
    #  Print the greeting message.
	li		$v0, 4
	la		$a0, Message2
	syscall
	
	
    #  Return to the operating system.
	li		$v0, 10
	syscall