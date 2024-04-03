.globl wackySum
.text 
	addi $a0, $0, 3 # a 
	addi $a1, $0, 7 # b
	addi $a2, $0, 2 # c
wackySum: # caller
	add $s1, $a0, $0 # set i to a
	add $v0, $0, $0
	
	addi $sp, $sp, -12 # decrement stack pointer
	sw $s1, 8($sp) # store i on the stack
	sw $a1, 4($sp) # store b on the stack
	sw $a2, 0($sp) # store c on the stack
	j loop
	jr $ra
loop: # callee & caller
	lw $t0, 8($sp) # load i from stack
	lw $t1, 4($sp) # load b from stack
	bgt $t0, $t1, return # terminating condition
	
	add $a0, $t0, $0 # i

	addi $a1, $t0, 1 # i + 1
	sra $a1, $a1, 1 # (i+1) / 2
	
	addi $a2, $t0, 2 # i + 2
	sra $a2, $a2, 1 # (i+2) / 2
	
	addi $a3, $t0, 3# i + 3
	
	addi $sp, $sp, -4 # decrement stack pointer
	sw $ra, 0($sp) # store $ra on the stack
	
	jal combineFour # call function
	
	lw $ra, 0($sp) # load $ra from stack
	addi $sp, $sp, 4 # increment stack pointer
	
	lw $t0, 8($sp) # load i from stack
	lw $t1, 0($sp) # load c from stack
	
	add $t2, $t0, $t1 # i += c
	
	sw $t2, 8($sp) # store i on stack
	j loop
	jr $ra
combineFour: # callee & caller
	add $t0, $a0, $a1
	add $t0, $t0, $a2 
	add $t0, $t0, $a3 # sum
	
	add $a0, $0, $t0 # for call to odd_sum 
	
	addi $t1, $0, 2 # for division
	divu $t0, $t1 # sum / 2
	mfhi $t1 # sum % 2
	
	beq $t1, 1, odd_sum # check if sum is odd
	add $v0, $v0, $t0 # if sum is even, simply add to current sum
	jr $ra
odd_sum: # callee
	sra $a0, $a0, 1 # divide sum by 2
	add $v0, $v0, $a0 # if sum is odd, add sum/2 to current sum
	jr $ra
return:
	addi $sp, $sp, 16 # reincrement stack pointer
	jr $ra