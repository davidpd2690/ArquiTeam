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

	addi $a1, $zero, 0x10010000		# reserving address for first peg - a1
	addi $a2, $zero, 0x10010020		# reserving address for aux peg - a2
	addi $a3, $zero, 0x10010040		# reserving address for last peg - a3
	
	addi $a0, $zero, 8	# number of discs - a0
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
		
	beq $a0,$t9, baseCase	# if number of discs == 1, jump to base case
		
				
	addi $a0, $a0, -1	# number of discs -1
	add $t1, $a2, $zero 	# storing value in aux peg to temp reg
	add $a2, $a3, $zero	# moves discs from last peg to aux peg
	add $a3, $t1, $zero	# brings back value from temp reg(auxPeg) and moves the discs to last peg
		
	jal hanoi		# recursive call back to hanoi
	
	add $t8, $t8, $t9	# recursion indicator
	
	add $t1, $a2, $zero	# storing value in auxpeg to tempreg 
	add $a2, $a3, $zero	# moving discs from lastpeg to auxpeg
	add $a3, $t1, $zero 	# bring back value stored in tempreg, moves it to lastpeg
	

baseCase:


	addi $a1, $a1, -4	# firstPeg -= 4
	lw $t3,0($a1)		# store value of first location of firstpeg address in tempreg	
	sw $zero, 0($a1)	# set value of first location of firstpeg address to 0
	sw $t3, 0($a3)		# 
	addi $a3, $a3, 4	# firstpeg += 4
	#bnez  $t8, nonRec 	# if recursion indicator is not 0, move to nonRec label
	bne $t8, $zero, nonRec	# if recursion indicator is not 0, move to nonRec label
	
	# load stuff back from stack
	lw $ra, 0($sp)
	addi $sp, $sp, 8	# give space back to stack
	
	jr $ra			# back to register address
nonRec:
	
	add $t8, $zero, $zero	# set recursion indicator to zero
	lw $a0, 4($sp)		# load disc value 
	addi $a0, $a0, -1	# number of discs -1
	add $t1, $a1, $zero	# stores value of firstpeg to tempreg
	add $a1, $a2, $zero	# moves from auxpeg to firstpeg
	add $a2, $t1, $zero 	# brings bck value in tempreg and places it in auxpeg 
		
	jal hanoi		# back to hanoi again
	
	lw $ra, 0($sp)
	add $t2, $a1, $zero	# save firstpeg to temp reg t2
	add $a1, $a2, $zero	# move from auxpeg to firstpeg
	add $a2, $t2, $zero	# bring back contents stored in t2(firstpeg) and move to auxpeg
	
	addi $sp, $sp, 8	# give space back to stack
	
	jr $ra			# back to register address

exit:
	
#end
	
