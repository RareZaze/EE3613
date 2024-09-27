.data
.strA: .asciiz "Please enter your choice to skip numbers (1-4)\n"
Numbers: .byte 100, -7, 11, 25, -66, 99, -1, 34, 12, 22, -2, -7, 100, 11, 4, 67, 2, -90, 22, 2, 56, 3, -89, 12, -10, 21, 10, -25, -6, 9, 111, 34, 12, 22, -2, -17, 100, 111, -4, 7, 14, -19, -2, 29, 36, 31, -79, 2
.error: .asciiz "Invalid input, please try again \n"
.globl main
.text
main: # Your fully commented program starts here.
# Initialize constants
li $t0, 1  # Minimum valid input
li $t1, 4  # Maximum valid input

input:
    # Print the prompt message
    la $a0, .strA
    li $v0, 4
    syscall

    # Read the user's input
    li $v0, 5
    syscall
    li $t2, 0
    add $t2, $t2, $v0  # Store the input in $t2

    # Check if the input is within the valid range
    blt $t2, $t0, invalid
    bgt $t2, $t1, invalid

    # Initialize variables for processing the array
    la $t0, Numbers  # Load base address of Numbers array
    li $t1, 0        # Index
    li $t3, 0        # Sum
    li $t4, 48       # Array size
    li $t6, 0        # Initialize load register

loop:
    # Load the byte at the calculated index and add to sum
    add $t5, $t0, $t1
    lb $t6, 0($t5)
    add $t3, $t3, $t6 

    # Calculate the next index to access based on the user's input
    add $t1, $t1, $t2
    blt $t1, $t4, loop  # If index exceeds array size, exit loop

# Print the sum
li $a0, 0
li $v0, 1
add $a0, $a0, $t3
syscall

# Exit the program
li $v0, 10
syscall

invalid:
    # Handle input that is too low
    li $v0, 4
    la $a0, .error
    syscall
    j input
