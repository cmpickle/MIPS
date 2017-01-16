# calculate the area of a rectangle

# registers used
# $v0 system call code
# $a0 value I/O
# $t1 Side-1
# $t2 Side-2
# $t3 Area

# data segment
.data         
  iprompt:  .asciiz "-- Calculate the Area of a Rectangle --\n"
  s1prompt: .asciiz "\nInput Side-1: "
  s2prompt: .asciiz "\nInput Side-2: "
  areaout:  .asciiz "\nArea = "
  eprompt:  .asciiz "\n\nPress any key to exit..."

# text segment
.text
	.globl main   # global label - where the program begins

# main program
main:
# display initial prompt
	li   $v0, 4         # load print_string code (pg. A-49)
	la   $a0, iprompt   # load string to print
	syscall             # print the string

# prompt for and input side 1
	li   $v0, 4         # load print_string code
  	la   $a0, s1prompt  # load string to print
  	syscall             # print the string

  	li   $v0, 5         # load read_int code
  	syscall             # read value from kb until 'Enter' key pressed
  	move $t1, $v0       # move value read to temp register

# prompt for and input side 2
  	li   $v0, 4         # load print_string code
  	la   $a0,s2prompt   # load string to print
  	syscall             # print the string

  	li   $v0, 5         # load read_int code
  	syscall             # read value from kb
  	move $t2, $v0       # move value to temp register

# Calculate the area
  	mul  $t3, $t1, $t2  # s1 * s2

# output the prompt and the area
 	li   $v0, 4         # load print_string code
  	la   $a0, areaout   # load string to print
  	syscall             # print the string

  	li   $v0, 1         # load print_int code
  	move $a0,$t3        # load value to print - $t3 contains area
  	syscall             # print the value

# hold the screen
  	li   $v0, 4         # load print_string code
  	la   $a0, eprompt   # load string to print
  	syscall             # print the string
  	li   $v0, 12        # load read_int code
  	syscall             # read from kb until 'Enter' key pressed

# exit to the operating system.
  	li   $v0, 10        # load exit code
  	syscall             # terminate program

# end program
