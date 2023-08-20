.data
prompt_for_input: .asciiz "Please enter your numbers, pressing enter after each, (0 to terminate):\n"
prompt_for_output: .asciiz "Your quantity of interest is equal to: "

.text
main:
# prompting the user with a message for a string input:
li $v0, 4
la $a0, prompt_for_input
syscall

li $t6, 1
li $t7, 4
li $t4, 0
li $t5, 0    # acts as a counter

START:
li $v0, 5
syscall

beq $v0, $zero, END

addu $a0, $zero, $v0

addu $t2, $a0, $zero
slt $t3, $t2, $zero
beq $t3, $t6, LESS   # checks divisibility if inputted number is less than zero
beq $t3, $zero, MORE   # checks divisibility if inputted number is more than zero

LESS:         # checks if negative number is divisible by 4
beq $t2, $zero , START
slt $t3, $t2, $zero
beq $t3, $zero, ANSWER
addu $t2, $t7, $zero
j LESS

MORE:         # checks if the positive number is divisible by 4
beq $t2, $zero , START
slt $t3, $t2, $zero
beq $t3, $t6, ANSWER
subu $t2, $t2, $t7
j MORE

ANSWER:
addu $t5, $t5, $t6      # COUNTER
beq $t5, $t6, FIRST
bne $t5, $t6, ELSE
j START

FIRST:
addu $t4, $zero, $a0
j START

ELSE:
slt $t3, $a0, $t4
beq $t3, $t6, RETAIN
beq $t3, $zero, FIRST
j START

RETAIN:
addu $t4, $t4, $zero
j START

# prompting the user with a message for the processed output:
END:
li $v0, 4
la $a0, prompt_for_output
syscall

# printing the output
addiu  $v0, $zero, 1
addu $a0, $zero, $t4
syscall

# Finish the programme:
li $v0, 10      # syscall code for exit
syscall         # exit
