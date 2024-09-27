.data
strA: .asciiz "Please enter the nth Fibonacci number to be displayed: \n"  # Prompt message
comma_space: .asciiz ", "  # Comma and space for separating Fibonacci numbers
error: .asciiz "Invalid input \n"  # Error message for invalid input

.globl main
.text

main:
    li $t0, 0  # Initialize $t0 to 0
    li $t1, 1  # Initialize $t1 to 1
    li $t2, 2  # Initialize $t2 to 2

input:
    li $v0, 4  # Load syscall code for print string
    la $a0, strA  # Load address of prompt message
    syscall  # Print the prompt message

    li $v0, 5  # Load syscall code for read integer
    syscall  # Read integer input from user
    add $t0, $t0, $v0  # Store the input in $t0

    blt $t0, $t1, invalid  # If input < 1, jump to invalid
    beq $t0, $t1, zero  # If input == 1, jump to zero
    beq $t0, $t2, one  # If input == 2, jump to one

    li $t1, 0  # Initialize $t1 to 0 for Fibonacci calculation
    li $t2, 1  # Initialize $t2 to 1 for Fibonacci calculation

    li $v0, 1  # Load syscall code for print integer
    li $a0, 0  # Load 0 into $a0
    syscall  # Print 0

    li $v0, 4  # Load syscall code for print string
    la $a0, comma_space  # Load address of comma and space
    syscall  # Print comma and space

    li $a0, 0  # Load 0 into $a0
    li $v0, 1  # Load syscall code for print integer
    add $a0, $a0, $t2  # Load 1 into $a0
    syscall  # Print 1

    li $t3, 1  # Initialize $t3 to 1 for Fibonacci calculation
    li $t4, 2  # Initialize $t4 to 2 for loop counter

loop:
    li $v0, 4  # Load syscall code for print string
    la $a0, comma_space  # Load address of comma and space
    syscall  # Print comma and space

    li $t1, 0  # Reset $t1 to 0
    add $t1, $t1, $t2  # $t1 = $t2
    li $t2, 0  # Reset $t2 to 0
    add $t2, $t2, $t3  # $t2 = $t3

    add $t3, $t1, $t2  # $t3 = $t1 + $t2

    li $a0, 0  # Load 0 into $a0
    li $v0, 1  # Load syscall code for print integer
    add $a0, $a0, $t3  # Load $t3 into $a0
    syscall  # Print $t3

    addi $t4, $t4, 1  # Increment loop counter
    blt $t4, $t0, loop  # If loop counter < input, repeat loop

    li $v0, 10  # Load syscall code for exit
    syscall  # Exit program

zero:
    li $v0, 1  # Load syscall code for print integer
    li $a0, 0  # Load 0 into $a0
    syscall  # Print 0

    li $v0, 10  # Load syscall code for exit
    syscall  # Exit program

one:
    li $v0, 1  # Load syscall code for print integer
    li $a0, 0  # Load 0 into $a0
    syscall  # Print 0

    li $v0, 4  # Load syscall code for print string
    la $a0, comma_space  # Load address of comma and space
    syscall  # Print comma and space

    li $a0, 0  # Load 0 into $a0
    li $v0, 1  # Load syscall code for print integer
    add $a0, $a0, $t2  # Load 1 into $a0
    syscall  # Print 1

    li $v0, 10  # Load syscall code for exit
    syscall  # Exit program

invalid:
    li $v0, 4  # Load syscall code for print string
    la $a0, error  # Load address of error message
    syscall  # Print error message
    j input  # Jump back to input
