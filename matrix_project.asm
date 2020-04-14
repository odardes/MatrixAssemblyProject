#######Sena Güventürk#######
#######1601426#######

.data 
	matrix1: .space 40
	matrix2: .space 40
	matrixT: .space 40
	matrixM: .space 40
	
newLine: .asciiz "\n"
FirstMatrix_RowInput: .asciiz "\Enter rows for first matrix: \n"
FirstMatrix_ColumnInput: .asciiz "\Enter columns for first matrix: \n"
SecondMatrix_RowInput: .asciiz "\Enter rows for second matrix: \n"
SecondMatrix_ColumnInput: .asciiz "\Enter columns for second matrix: \n"
Problem_Message: .asciiz "\For multiply transpose matrice first row and second row should be equal. Try again!\n"
EnterFirst: .asciiz "\n Enter the numbers of first matrix: \n"
EnterSecond: .asciiz "\n Enter the numbers of second matrix: \n"
FirstMatrix_Show: .asciiz "\This is first matrix: \n"
SecondMatrix_Show: .asciiz "\This is second matrix: \n"
TransposeMatrix: .asciiz "\n This is transpose of first matrix: \n"
MultiplicateMatrix: .asciiz "\n This is multiplication of transpose of first matrix and second matrix: \n"
space: .asciiz " "
.text 
.globl main

main:
	jal UserInputs
	jal Inner_Product

UserInputs:
	li $v0,4  #Ask for first row
	la $a0, FirstMatrix_RowInput
	syscall
	li $v0,5 #Read the first row
	syscall
	move $t0,$v0 #Store the first row
	li $v0,4 #Ask for first column
	la $a0, FirstMatrix_ColumnInput
	syscall
	li $v0,5 #Read the first column
	syscall
	move $t1,$v0 #Store the first column
	li $v0,4 #Ask for second row
	la $a0, SecondMatrix_RowInput
	syscall
	li $v0,5 #Read the second row
	syscall
	move $t2,$v0 #Store the second row
	li $v0,4 #Ask for second column
	la $a0, SecondMatrix_ColumnInput
	syscall
	li $v0,5 #Read the second column
	syscall
	move $t3,$v0 #Store the second column
jr $ra

Inner_Product:  # If first row and second row is equal then exit loop. Because transpose requires that.
	beq $t0, $t2, ExitInner_Product 
	li $v0,4
	la $a0, Problem_Message # Alert user that multiplication can not be done.
	syscall
	jal UserInputs #Then take inputs again until its correct
	j Inner_Product
ExitInner_Product:
	
################            CREATE FÝRST MATRÝX 	         ################
	
	li $v0,4 #Enter first matrix
	la $a0, EnterFirst
	syscall
	
	mul $t4,$t0,$t1  #how many times do we enter input = r1 x c1
	li $t5,0 #for i
	la $t6, ($zero) #for address matrix 1 
	
EnterMatrix1: #for entering first matrix
	beq $t5,$t4, endloop1 #loops r1 x c1 time
	li $v0,5    #user input
    	syscall
    	add $s0,$v0, $zero #store input to s0
	sb $s0, matrix1($t6) #store input to matrix1
	addi $t6,$t6,4
	addi $t5,$t5,1
	j EnterMatrix1
endloop1:

################            SHOW FÝRST MATRÝX 	         ################

	li $t5,0 #for i
	li $t4,0 #for j
	addi $t6, $zero,0 
	
	li $v0,4 #Show matrix 1
	la $a0, FirstMatrix_Show
	syscall
	
ShowMatrix_1:
	beq $t5,$t0,exitShowMatrix1 #row
Matrix1:
	beq $t4,$t1,exitMatrix1 #column
	addi $t6, $t5, 0        #i + 0
	mul $t6, $t6, $t1       #i * c1(2)
	add $t6, $t6, $t4       #$t6 = (i * 2) + j
	mul $t6, $t6, 4
	li $v0,1 #Print number
	lw $a0, matrix1($t6)
	syscall
	li $v0, 4 #put space
	la $a0, space
	syscall
	div $t6, $t6, 4
	addi $t4, $t4, 1 #increase j
	j Matrix1
exitMatrix1:
	addi $t4, $zero, 0 #set j = 0 again
	addi $t5, $t5, 1 #increase i
	li $v0, 4 #put new line
	la $a0, newLine
	syscall
	j ShowMatrix_1
exitShowMatrix1:

################            CREATE SECOND MATRÝX 	         ################

	li $v0,4 #Enter second matrix
	la $a0, EnterSecond
	syscall
	
	mul $t4,$t2,$t3 #how many times do we enter input = r2 x c2
	li $t5,0 #for i
	la $t7, ($zero) #for address matrix 2

EnterMatrix2: #for entering second matrix
	beq $t5,$t4, endloop2 #loops r2 x c2 time
	li $v0,5    #user input
    	syscall
    	add $s0,$v0, $zero #store input to s0
	sb $s0, matrix2($t7) #store input to matrix2
	addi $t7,$t7,4
	addi $t5,$t5,1
	j EnterMatrix2
endloop2:

################            SHOW SECOND MATRÝX 	         ################

	li $t5,0 #for i
	li $t4,0 #for j
	addi $t7, $zero,0
	
	li $v0,4 #Show matrix 2
	la $a0, SecondMatrix_Show
	syscall
	
ShowMatrix_2:
	beq $t5,$t2,exitShowMatrix2 #row
Matrix2:
	beq $t4,$t3,exitMatrix2 #column
	addi $t7, $t5, 0        #i + 0
	mul $t7, $t7, $t3       #i * c1(2)
	add $t7, $t7, $t4       #$t7 = (i * 2) + j
	mul $t7, $t7, 4
	li $v0,1 #Print number
	lw $a0, matrix2($t7)
	syscall
	li $v0, 4 #Put space
	la $a0, space
	syscall
	div $t7, $t7, 4
	addi $t4, $t4, 1 #increse j
	j Matrix2
exitMatrix2:
	addi $t4, $zero, 0 #set j=0 again
	addi $t5, $t5, 1 #i=i+1
	li $v0, 4 #Put new line
	la $a0, newLine
	syscall
	j ShowMatrix_2
exitShowMatrix2:

################            TRANSPOSE OF FÝRST MATRÝX 	         ################

	li $v0,4  #Transpose of first matrix
	la $a0, TransposeMatrix
	syscall
	
	move $s1, $t1 # column 1
	move $s0 $t0  # row 1
	li $t4,0   # for i
	li $t5,0    # for j
	addi $t6, $zero,0
	addi $t8, $zero,0
	
matrix_transpose:
	beq $t4, $t1, ExitMatrix_transpose  
matrix_transpose2:
	beq $t5, $t0 ExitMatrix_transpose2   
	addi $t6, $t5, 0        #i + 0  
	mul $t6, $t6, $t1      #i * c1(2)   
	add $t6, $t6, $t4       #$t6 = (i * 2) + j   
	mul $t6, $t6, 4     
	li $v0, 1 #Print number
	lw $a0, matrix1($t6)
	syscall
	sw $a0 matrixT($t8)#store input to matrixT
	li $v0, 4 #Put space
	la $a0, space
	syscall
	div $t6, $t6, 4
	addi $t8,$t8,4    
	addi $t5, $t5, 1        
	j matrix_transpose2
ExitMatrix_transpose2:
	addi $t5, $zero, 0       
	addi $t4, $t4, 1     
	li $v0, 4      #Put new line         
	la $a0, newLine    
	syscall
	j matrix_transpose
ExitMatrix_transpose: 

################            MULTÝPLY THE MATRÝCES 	         ################

	li $v0,4  #Multiplication of matrices
	la $a0, MultiplicateMatrix
	syscall
	
	li $t4,0          # for i
	li $s4, 0         # value to be printed
	li $s5, 0           # total print counter    +++++++++++++++
	li $s7, 0           # row print counter
	mul $t6, $t3, 4     # holds incremental value for matrix two  t2 c2 
	mul $s6, $t0, 4     # holds incremental value for matrix one t1 r2 c1 
	mul $t5, $t1, $t3   # store size of matrix 3
	addi $t9, $zero,0 #address matrixM
	addi $t8, $zero,0 #address matrixT
	addi $t7, $zero,0 #address matrix2
	
	
############          LOAD THE MULTÝPLÝED MATRÝX	        ###########

matrixLoad:
	beq $t4, $t0, print_and_reset    
	lw $s0, matrixT($t8)         # load from matrixT
	addi $t8, $t8, 4    	      # move to next index
	lw $s1, matrix2($t7)         # load from matrix two
	add $t7, $t7, $t6            # move to next value
	mul $s3, $s0, $s1            # multiply numbers
	add $s4, $s4, $s3            # add to holder register
	addi $t4, $t4, 1    	     # increment counter
	j matrixLoad
	
print_and_reset:
	move $a0, $s4
	li $v0, 1           # print value
	syscall
	la $a0, space
	li $v0, 4           # print space
        syscall
        
        # MATRIX ONE: reset to start of row
	addi $t8, $zero,0 #address matrixT

	# MATRIX TWO: move to start of next column
	addi $t7, $t7, 4

	addi $s5, $s5, 1    	# ++ print counter
	addi $s7, $s7, 1    	# ++ row counter
	li $t4, 0              # reset counter to 0
	li $s4, 0              # reset holder to 0   
	beq $s5, $t5, EXIT
	beq $s7, $t3, mat1_next_row
	j matrixLoad
	
mat1_next_row:

	# MATRIX ONE: move to start of next row
	add $t8, $t8, $s6

	# MATRIX TWO: reset it to first column
	move $t7, $t7

	li $s7, 0            	# reset counter to 0
	la $a0, newLine
	li $v0, 4            	# print new line
	syscall
	j matrixLoad

EXIT:
