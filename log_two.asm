# Joshua Vink and Skyler Burden
.globl log_two
.text
	addi $a0, $0, -5 # x
	
	ble $a0, 0, negative
log_two:
	ble $a0, 1, finish
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	
	sra $a0, $a0, 1
	jal log_two
	addi $v0, $v0, 1
	
	lw $ra, 0($sp)
	addi $sp, $sp, 8
	jr $ra
	

finish:
	addi, $v0, $0, 0
	jr $ra
	
negative:
	addi, $v0, $0, -1
	jr $ra
	
