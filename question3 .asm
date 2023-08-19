.data
prompt_for_input: .asciiz "Please enter your numbers, pressing enter after each, (0 to terminate):\n"
prompt_for_output: .asciiz "Your quantity of interest is equal to: "

.text
main:
li $t4, 0
li $t2, 1
li $a0, 1
li $t6, 1

# prompting the user with a message for a string input:
li $v0, 4
la $a0, prompt_for_input
syscall

LOOP:
li $v0, 5
syscall

addu $a0, $v0, $zero

slt $t3, $a0, $zero
beq $t3, $t2, POSITIVE   # if the entered number is less than zero it is first made positive

START:
beq $a0, $zero, END

addu $t4, $t6, $t4     # acts as a counter

# if counter is at 1 then another register gets the inputted value:
beq $t4, $t6, IF
bne $t4, $t6, ELSE

IF:
beq $a0, $zero , END
addu $t1, $a0, $zero
j LOOP

ELSE:
beq $a0, $zero, END
slt $t5, $a0, $t1
beq $t5, $t2, RETAIN
beq $t5, $zero, CHANGE
j LOOP

RETAIN:
beq $a0, $zero, END 
addiu $t1, $t1, 0
j LOOP

CHANGE:
beq $a0, $zero, END
# if entered value is more than previous value then printng value is changed to that:
addiu $t1, $a0, 0  
j LOOP

POSITIVE:
subu $a0, $zero, $a0  # negative number is converted to its positive counter-part
j START

END:
# prompting the user with a message for the processed output:
li $v0, 4
la $a0, prompt_for_output
syscall

addiu $v0, $zero, 1
addu $a0, $t1, $zero
syscall

# Finish the programme:
li $v0, 10      # syscall code for exit
syscall         # exit