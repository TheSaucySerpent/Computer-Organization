.globl wackySum
.text 
	addi $v0, $0, 1337
	addi $a0, $0, 33 # a 
	addi $a1, $0, 42 # b
	addi $a2, $0, 2 # c
wackySum: # callee
	addi $sp, $sp, -12 # decrement stack pointer
	sw $ra, 0($sp) # store ra on the stack
	sw $s2, 4($sp) # store s0 on stack
	sw $s1, 8($sp) # store s1 on stack
	add $s1, $0, $0 # zero out s1
	j loop
	jr $ra
loop: # caller 
	bgt $a0, $a1, return # terminating condition
	
	addi $sp, $sp, -12 # decrement stack pointer
	sw $a0, 8($sp) # store a on the stack
	sw $a1, 4($sp) # store b on the stack
	sw $a2, 0($sp) # store c on the stack
	
	
	add $s0, $a0, $0 # i

	addi $a1, $s0, 1 # i + 1
	sra $a1, $a1, 1 # (i+1) / 2
	
	addi $a2, $s0, 2 # i + 2
	sra $a2, $a2, 1 # (i+2) / 2
	
	addi $a3, $s0, 3# i + 3
	
	jal combineFour # call function
	
	lw $a0, 8($sp) # load a from the stack
	lw $a1, 4($sp) # load b on the stack
	lw $a2, 0($sp) # load c on the stack
	addi $sp, $sp, 12 # increment stack pointer
	
	add $a0, $a0, $a2 # i += c
	add $s1, $s1, $v0 # add returned value to sum 
	
	j loop
	jr $ra
combineFour: # callee
	add $t0, $a0, $a1
	add $t0, $t0, $a2 
	add $t0, $t0, $a3 # sum
	
	add $a0, $0, $t0 # for call to odd_sum 
	
	addi $t1, $0, 2 # for division
	divu $t0, $t1 # sum / 2
	mfhi $t1 # sum % 2
	
	beq $t1, 1, odd_sum # check if sum is odd
	add $v0, $0, $t0 # if sum is even, return sum
	jr $ra
odd_sum: # callee
	sra $t2, $t0, 1 # divide sum by 2
	add $v0, $0, $t2 # if sum is odd, return sum/2
	jr $ra
return: # callee
	add $v0, $0, $s1 # return the sum
	lw $ra, 0($sp) # load ra from the stack
	lw $s0, 4($sp) # restore previous s0
	lw $s1, 8($sp) # restore previous s1
 	addi $sp, $sp, 12 # increment stack pointer
	jr $ra
