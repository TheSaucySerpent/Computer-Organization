	.globl monkeyTrouble sleepIn posNeg
	.text

# You can use these lines to run your program directly in MARS for
# troubleshooting. Change the values of $a0 and $a1 to try out your
# function with different arguments.
# As the code is written now, it will run all three functions. You can
# comment out a `jal` call if you do not want the function to run.
# ----------------------------------------------------------------------------
	addi $a0, $0, 0		# $a0 and $a1 are used to store function arguments
	addi $a1, $0, 1
	jal monkeyTrouble	# functions are called using `jal`

	addi $a0, $0, 1
	addi $a1, $0, 1
	jal sleepIn

	addi $a0, $0, 1
	addi $a1, $0, -1
	addi $a2, $0, 1
	jal posNeg

	addi $v0, $0, 10	# syscall calls the operating system to perform various tasks
	syscall			# It looks in $v0 to determine what to do
				# In the case of $v0 == 10, syscall exits the program
				# Without this, MARS would keep running with the next line
				# of code
# ----------------------------------------------------------------------------
#
# Lines below here are where you will write your functions.
#
monkeyTrouble:
	li $t0, 1
	xor $t1, $a0, $a1
	xor $v0, $t0, $t1 
	jr $ra
sleepIn:
	not $a0, $a0
	andi $a0, $a0, 1
	or $v0, $a0, $a1
	jr $ra

posNeg:
	slti $t0, $a0, 0
	slti $t1, $a1, 0
	and $t2, $t0, $t1
	and $t3, $t2, $a2
	not $a2, $a2
	andi $a2, 1
	xor $t4, $t0, $t1
	and $v0, $a2, $t4
	or $v0, $v0, $t3
	jr $ra
