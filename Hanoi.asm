##############################################################################################
#											     #
#											     #
#		Hanoi Towers								     #
#											     #
#		Guillermo Roldán Gómez , David Pérez Daher			   	     #
#											     #
#											     #
##############################################################################################

.data

#firstPeg: .word 0 0 0 0 0 0 0 0 	  
#auxPeg:   .word 0 0 0 0 0 0 0 0  
#lastPeg:  .word 0 0 0 0 0 0 0 0	  
		

.text

main:
	addi $a1, $zero, 0x10010000		# reserving address for first peg - a1
	addi $a2, $zero, 0x10010020		# reserving address for aux peg - a2
	addi $a3, $zero, 0x10010040		# reserving address for last peg - a3
	
	addi $a0, $zero, 4	# number of discs - a0
	addi $t9, $zero, 1	# loads value 1 for base case comparison in temp reg t9
	add $t0, $a0, $zero	# stores number of discs to temp reg t0

	
		
				
Loop:	#loop to add discs into first peg
	sw $t0, 0($a1)		# stores number of discs to first Peg
	addi $t0, $t0, -1	# number of discs -1
	addi $a1, $a1, 4	# adding 4 for offset in first Peg address
	bne $t0, $zero, Loop	# loops until all discs are loaded
	
	jal hanoi		#jal copies the address of the next instruction into ra, so we need to store it 
	j exit
	
hanoi:

	addi $sp, $sp, -8	# reserves space in stack 
	sw $ra, 0($sp)		# stores return address in stack
	sw $a0, 4($sp)		# stores number of discs in stack
	#beq $t0, $a0, change   
		
	#bne $a0,$t9, basecase	# if number of discs == 1, jump to one
		
#change:
moveDiscs:
	add $a1, $a1, -4	#first peg position
	lw $t4, 0($a1)		#load what is in the first pegin a temp 
	sw $zero, 0($a1)	#remove disc from tower
	sw $t4, 0($a3)		#move disc from first peg to last peg
	add $a3, $a3, 4		# we move to the next space on the last peg
	add $t1, $a2, $zero 	# storing value in aux peg to temp reg
	add $a2, $a3, $zero	# moves discs from last peg to aux peg
	add $a3, $t1, $zero	# brings back value from temp reg(auxPeg) and moves the discs to last peg
	addi $a0,$a0, -1	# number of discs -1
	jal hanoi		# recursive call back to hanoi
	
	

#moveDiscs:

	
	
	#lw $ra, 0($sp)		# loads return address in stack
	#lw $a0, 4($sp)		# loads number of discs in stack
	#lw $a1, 8($sp)		# loads firstpeg in stack
	#lw $a2, 12($sp)		# loads auxpeg in stack
	#lw $a3, 16($sp)		# loads lastpeg in stack
	#addi $sp, $sp, 20	# restores space in stack 

moveAgain:
	
	addi $sp, $sp, -8	# reserves space in stack 
	sw $ra, 0($sp)		# stores return address in stack
	sw $a0, 4($sp)		# stores number of discs in stack
		
	
	add $t2, $a1, $zero	# save firstpeg to temp reg t2
	add $t3, $a2, $zero	# save auxpeg to temp reg t3
	add $a1, $a2, $zero	# move from auxpeg to firstpeg
	add $a2, $t2, $zero	# bring back contents stored in t2(firstpeg) and move to auxpeg
	
	addi $a0, $a0, -1	# number of discs -1
	
	jr $ra			# back to register address
	
basecase:
	j exit

exit:
