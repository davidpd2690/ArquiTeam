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
	
	addi $a0, $zero, 6	# number of discs - a0
	addi $t9, $zero, 1	# loads value 1 for base case comparison
	add $t0, $a0, $zero	# stores number of discs to temp reg t0
	
Loop:	#loop to add discs into first peg
	sw $t0, 0($a1)		# stores number of discs to first Peg
	addi $t0, $t0, -1	# number of discs -1
	addi $a1, $a1, 4	# adding 4 for offset in first Peg address
	bne $t0, $zero, Loop	# loops until all discs are loaded
	
	jal hanoi		#jal copies the address of the next instruction into ra, so we need to store it	
	j exit
	
hanoi:
########################################################
# void hanoi(int n,int com, int aux, int fin){
#
#	if(n==1){
#		printf("%c->%c",com,fin);
#	}
#	else{
#		hanoi(n-1,com,fin,aux);
#		printf("\n%c->%c\n",com,fin);
#		hanoi(n-1,aux,com,fin);
#	}
#######################################################
	add $sp, $sp, -8	# reserves space in stack for two regs
	sw $a0, 0($sp)		# stores number of discs in stack
	sw $ra, 4($sp)		# stores return address in stack
	
	beq $a0,$t9, one	# if number of discs == 1, jump to one	
	

moveDiscs:
	#hanoi(n-1,com,fin,aux);
	addi $a0,$a0, -1	# number of discs -1
	add $t1, $a2, $zero 	# storing value in aux peg to temp reg
	add $a2, $a3, $zero	# moves discs from last peg to aux peg
	add $a3, $t1, $zero	# brings back value from temp reg(auxPeg) and moves the discs to last peg
	jal hanoi		# recursive call back to hanoi

one:


exit:
	

	
