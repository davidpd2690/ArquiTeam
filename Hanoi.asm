##############################################################################################
#											     #
#											     #
#		Hanoi Towers						     		     #
#											     #
#		Guillermo , David P�rez Daher					             #
#											     #
#											     #
##############################################################################################

.data

firstPeg:	  
auxPeg:		  
lastPeg:	  
		

.text

main:
	
	la $a1, firstPeg	# first peg - a1
	la $a2, auxPeg		# aux peg - a2
	la $a3, lastPeg		# last peg - a3
	
	addi $a0, $zero, 6	# number of discs - a0
	
	jal stack
	
stack:
	
	addi $sp, $sp, -20	#save registers in stack
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $a3, 12($sp)
	sw $ra, 16($sp)
	
	sw $a0, 0($a1)
	
	beq $a0, 1, one
	
one:

moveRing:


	

	