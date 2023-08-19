.data
buffer_for_input_string: .space 100
buffer_for_processed_string: .space 100
prompt_for_input: .asciiz "Please enter your string:\n"
prompt_for_output: .asciiz "Your processed string is as follows:\n"

.text
main:
# prompting the user with a message for a string input:
li $v0, 4
la $a0, prompt_for_input
syscall

# reading the input string and putting it in the memory:
# the starting address of the string is accessible as buffer_for_input_string
# 100 is the hard-coded maximum length of the null-terminated string that is
# going to be read from the input. So effectively, up to 99 ascii characters.
li $v0, 8
la $a0, buffer_for_input_string
li $a1, 100
syscall

# >>>> MAKE YOUR CHANGES BELOW HERE:

# Looping over characters of the string:
la $t0, buffer_for_input_string
la $t1, buffer_for_processed_string

LOOP:
lb $t4, 0($t0) 
blt $t4, 'A', START
bgt $t4, 'z', START

ble $t4, 'Z', CAPITAL
bge $t4, 'a', LOWER
j START

CAPITAL:
addi $t4, $t4, 32
j START

LOWER:
addi $t4, $t4, -32
j START

START:
sb $t4, 0($t1)
addi $t0, $t0, 1
addi $t1, $t1, 1
bne $t4, $zero, LOOP

# <<<< MAKE YOUR CHANGES ABOVE HERE

# prompting the user with a message for the processed output:
li $v0, 4
la $a0, prompt_for_output
syscall

# printing the processed output
# note that v0 already holds 4, the syscall code for printing a string.
la $a0, buffer_for_processed_string
syscall

# Finish the programme:
li $v0, 10      # syscall code for exit
syscall         # exit