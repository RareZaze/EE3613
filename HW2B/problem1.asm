.data
strA: .asciiz "Original Array:\n: "
strB: .asciiz "Second Array:\n: "
newline: .asciiz "\n"
space : .asciiz " "
# This is the start of the original array.
Original: .word 200, 270, 250, 100
.word 205, 230, 105, 235
.word 190, 95, 90, 205
.word 80, 205, 110, 215
# The next statement allocates room for the other array.
# The array takes up 4*16=64 bytes.
#
Second: .space 64
.align 2
.globl main
.text
main: # Your fully commented program starts here

la $t0, Original # load the address of the original array into $t0
la $t1, Second   # load the address of the second array into $t1
li $t2, 4        # load the array size into $t2

# Initialize row and column counters
li $t3, 0        # row counter
li $t4, 0        # column counter

transpose_loop:
    # Calculate the source index: row * 4 + column
    mul $t5, $t3, $t2
    add $t5, $t5, $t4
    sll $t5, $t5, 2  # multiply by 4 (word size)
    add $t6, $t0, $t5
    lw $t7, 0($t6)   # load the word from the original array

    # Calculate the destination index: column * 4 + row
    mul $t5, $t4, $t2
    add $t5, $t5, $t3
    sll $t5, $t5, 2  # multiply by 4 (word size)
    add $t6, $t1, $t5
    sw $t7, 0($t6)   # store the word into the second array

    # Update column counter
    addi $t4, $t4, 1
    bne $t4, $t2, transpose_loop

    # Reset column counter and update row counter
    li $t4, 0
    addi $t3, $t3, 1
    bne $t3, $t2, transpose_loop

#Print the original array

# Initialize row and column counters
li $t3, 0        # row counter
li $t4, 0        # column counter

la $a0, strA
li $v0, 4
syscall


print_original:
    # Calculate the source index: row * 4 + column
    mul $t5, $t3, $t2
    add $t5, $t5, $t4
    sll $t5, $t5, 2  # multiply by 4 (word size)
    add $t6, $t0, $t5
    lw $a0, 0($t6)   # load the word from the original array
    li $v0, 1        # Prepare to print integer
    syscall          # Print integer

    # Print space
    li $v0, 4
    la $a0, space
    syscall

    # Update column counter
    addi $t4, $t4, 1
    bne $t4, $t2, print_original

    # Print newline
    la $a0, newline
    syscall

    # Print space for aligment
    la $a0, space
    syscall

    # Print space for aligment
    la $a0, space
    syscall

    # Reset column counter and update row counter
    li $t4, 0
    addi $t3, $t3, 1
    bne $t3, $t2, print_original

la $a0, newline
syscall

#Print the second array

la $a0, strB
syscall

# Initialize row and column counters
li $t3, 0        # row counter
li $t4, 0        # column counter

print_second:
    # Calculate the source index: row * 4 + column
    mul $t5, $t3, $t2
    add $t5, $t5, $t4
    sll $t5, $t5, 2  # multiply by 4 (word size)
    add $t6, $t1, $t5
    lw $a0, 0($t6)   # load the word from the second array
    li $v0, 1        # Prepare to print integer
    syscall          # Print integer

    # Print space
    li $v0, 4
    la $a0, space
    syscall

    # Update column counter
    addi $t4, $t4, 1
    bne $t4, $t2, print_second

    # Print newline
    la $a0, newline
    syscall

    # Print space for aligment
    la $a0, space
    syscall

    # Print space for aligment
    la $a0, space
    syscall

    # Reset column counter and update row counter
    li $t4, 0
    addi $t3, $t3, 1
    bne $t3, $t2, print_second

# Exit the program
li $v0, 10
syscall
