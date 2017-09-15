##############################################################################################
#											     #
#											     #
#		Hanoi Towers						     		     #
#											     #
#		Guillermo Roldán Gómez, David Pérez Daher			             #
#											     #
#											     #
##############################################################################################

.data
	#added 0s to be able to see how the towers are filled 
firstPeg: .word 0 0 0 0 0 0 0 0	  
auxPeg:   .word 0 0 0 0 0 0 0 0  
lastPeg:  .word 0 0 0 0 0 0 0 0
		

.text
	#moved this values out of the main because this are only needed at the beggining
	la $a1, firstPeg	# first peg - a1
	la $a2, auxPeg		# aux peg - a2
	la $a3, lastPeg		# last peg - a3
	
	addi $a0, $zero, 6	# number of discs - a0
main:
	
	addi $sp, $sp, -20	#save registers in stack
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $a3, 12($sp)
	sw $ra, 16($sp)		#ask what is ra used for
	
	sw $a0, 0($a1)
	
	beq $a0, 1, one		#compare if the number of disks is not 1, if not jump to one:
	
	
	
	
stack:
	
	
	
one:

moveRing: