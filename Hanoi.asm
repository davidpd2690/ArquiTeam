##############################################################################################
#											     #
#											     #
#		Hanoi Towers						     		     #
#											     #
#		Guillermo , David Pérez Daher					             #
#											     #
#											     #
##############################################################################################

.data

firstPeg: .word 8 7 6 5 4 3 2 1	  
auxPeg:   .word 0 0 0 0 0 0 0 0  
lastPeg:  .word 0 0 0 0 0 0 0 0	  
		

.text

main:
	lw $a1, firstPeg	# first peg - a1
	lw $a2, auxPeg		# aux peg - a2
	lw $a3, lastPeg		# last peg - a3
	
	addi $a0, $zero, 6	# number of discs - a0
	
	jal hanoi		#jal copies the address of the next instruction into ra, so we need to store it	
	
hanoi:

	add $t0, $a0, $zero	# save number of discs(a0) to t0
	addi $t1,$zero, 1	# store value one in temp register for comparison
	bne $a0,$t1, moveDiscs	# if number of discs is not equal to one, jump to moveDiscs
	

moveDiscs:

	addi $sp, $sp, -20	# save registers in stack
	sw $a0, 0($sp)		# number of discs
	sw $a1, 4($sp)		# firstPeg
	sw $a2, 8($sp)		# auxPeg
	sw $a3, 12($sp)		# lastPeg
	sw $ra, 16($sp)		
	
	#void hanoi(int n,int com, int aux, int fin)
	add $t2, $a2, $zero	# copy auxPeg to temp register
	add $a2, $a3, $zero	# auxPeg = lastPeg
	add $a3,$a2, $zero	# lastPeg = auxPeg
	addi $a0, $a0, -1	# n-1
	
	jal hanoi
	
