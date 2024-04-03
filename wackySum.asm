.globl wackySum
.text 
	addi $a0, $0, 3 # a 
	addi $a1, $0, 7 # b
	addi $a2, $0, 2 # c
wackySum:
	add $s0, $0, $0 # initialize sum to 0
	add $s1, $a0, $0 # set i to a
	
	addi $sp, $sp -12 # decrement stack pointer
	sw $ra, 8($sp) # save ra on the stack
	sw $a1, 4($sp) # store b on the stack
	sw $a2, 0($sp) # store c on the stack
	j loop
	jr $ra
loop:
	lw $t0, 4($sp) # load b from stack
	bgt $s1, $t0, return # check if i > b (terminating condition)
	
	add $a0, $s1, $0 # i
	
	addi $a1, $a0, 1 # i + 1
	sra $a1, $a1, 1 # (i+1) / 2
	
	addi $a2, $a0, 2 # i + 2
	sra $a2, $a2, 1 # (i+2) / 2
	
	addi $a3, $a0, 3# i + 3
	
	jal combineFour
	lw $t1, 0($sp) # load c from stack
	add $s1, $s1, $t1 # i += c
	j loop
combineFour:
	add $t0, $a0, $a1 # a + b
	add $t1, $a2, $a3 # c + d
	add $t2, $t0, $t1 # a + b + c + d
	
	addi $t3, $0 2
	divu $t2, $t3
	mfhi $t3 # t3 = sum % 2
	
	beq $t3, 1, odd_sum # check if sum is odd
	add $s0, $s0, $t2 # otherwise, it is even so return the sum as is
	jr $ra
odd_sum:
	sra $t2, $t2, 1
	add $s0, $s0, $t2
	jr $ra
return:
	add $v0, $s0, $0 # set return value to sum
	lw $ra, 8($sp)
	addi $sp, $sp 12 # increment stack pointer
	jr $ra # return
	
