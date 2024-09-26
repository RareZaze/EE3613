.data
strA: .asciiz “Original Array:\n “
strB: .asciiz “Second Array:\n: “
newline: .asciiz “\n”
space : .asciiz “ “
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