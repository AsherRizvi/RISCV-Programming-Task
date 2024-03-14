# Begin code section

.text
.align 2

main:
    # Load address of 'num' into t1
    la t1, num
    # Load the value of 'num' into a1
    lw a1, 0(t1)
    # Load address of 'result' into s1
    la s1, result
    # Call the 'factorial' function
    call factorial
    # Store the calculated factorial in 'result'
    sw a0, 0(s1)
    # Jump to 'write_tohost'
    j write_tohost

# Recursive factorial function
factorial:
    # Reserve space on the stack
    addi sp, sp, -8
    # Preserve the return address
    sw ra, 0(sp)
    # Check if a1 <= 1, if so, return 1
    li t0, 1
    ble a1, t0, return_1
    # Push 'a1' onto the stack
    sw a1, 4(sp)
    # Compute a1-1 for the next recursive call
    addi a1, a1, -1
    # Recursive call to 'factorial' with a1-1
    call factorial
    # Compute a1 factorial (a1-1)!
    lw t0, 4(sp)
    mul a0, t0, a0 
    # Jump to 'done'
    j done

return_1:
    # If a1 is 0 or 1, return 1
    li a0, 1

done:
    # Restore the return address from the stack
    lw ra, 0(sp)
    # Free the reserved stack space
    addi sp, sp, 8
    # Return to the caller
    ret

# End code section

# Function to write the result to the tohost register
write_tohost:
    li x1, 1
    sw x1, tohost, t5
    j write_tohost

# Begin data section
.data
.align 2

# Define the input 'num'
num: .word 8
# Define the variable to store the result
result: .word 0
# End data section

.align 12

.section ".tohost", "aw", @progbits;

.align 4
.global tohost
tohost: .dword 0

.align 4
.global fromhost
fromhost: .dword 0

