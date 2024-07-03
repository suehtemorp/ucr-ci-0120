.text
.globl main

main:
    # Inicializar contador en $s0
    addi $s0, $zero, 0          # $s0 = 0

    # Inicializar los registros con valores necesarios
    addi $t0, $zero, 5          # $t0 = 5
    addi $t1, $zero, 3          # $t1 = 3

    # Array de bytes
    addi $t2, $zero, 1          # $t2 = 1
    addi $t3, $zero, 2          # $t3 = 2
    addi $t4, $zero, 3          # $t4 = 3
    addi $t5, $zero, 4          # $t5 = 4

    # Array de halfwords
    addi $t6, $zero, 0x1234     # $t6 = 0x1234
    addi $t7, $zero, 0x5678     # $t7 = 0x5678

    # Instrucci�n ADD
    add $t2, $t0, $t1           # $t2 = $t0 + $t1 = 5 + 3 = 8
    addi $s0, $s0, 1            #1 $s0 = 1 (0x01)

    # Instrucci�n ADDU
    addu $t3, $t0, $t1          # $t3 = $t0 + $t1 = 5 + 3 = 8
    addi $s0, $s0, 1            #2 $s0 = 2 (0x02)

    # Instrucci�n SUB
    sub $t4, $t0, $t1           # $t4 = $t0 - $t1 = 5 - 3 = 2
    addi $s0, $s0, 1            #3 $s0 = 3 (0x03)

    # Instrucci�n SUBU
    subu $t5, $t0, $t1          # $t5 = $t0 - $t1 = 5 - 3 = 2
    addi $s0, $s0, 1            #4 $s0 = 4 (0x04)

    # Instrucci�n AND
    and $t6, $t0, $t1           # $t6 = $t0 & $t1 = 5 & 3 = 1
    addi $s0, $s0, 1            #5 $s0 = 5 (0x05)

    # Instrucci�n OR
    or $t7, $t0, $t1            # $t7 = $t0 | $t1 = 5 | 3 = 7
    addi $s0, $s0, 1            #6 $s0 = 6 (0x06)

    # Instrucci�n XOR
    xor $t8, $t0, $t1           # $t8 = $t0 ^ $t1 = 5 ^ 3 = 6
    addi $s0, $s0, 1            #7 $s0 = 7 (0x07)

    # Instrucci�n NOR
    nor $t9, $t0, $t1           # $t9 = ~($t0 | $t1) = ~(5 | 3) = -8 (0xf8)
    addi $s0, $s0, 1            #8 $s0 = 8 (0x08)

    # Instrucci�n SLT
    slt $t1, $t1, $t0           # $t1 = ($t1 < $t0) ? 1 : 0 = (3 < 5) ? 1 : 0 = 1 
    addi $s0, $s0, 1            #9 $s0 = 9 (0x09)

    # Instrucci�n SLTU
    sltu $t2, $t0, $t1          # $t2 = ($t0 < $t1) ? 1 : 0 = (5 < 0) ? 1 : 0 = 0
    addi $s0, $s0, 1            #10 $s0 = 10 (0x0A)

    # Instrucci�n SLL
    sll $t3, $t0, 2             # $t3 = $t0 << 2 = 5 << 2 = 20 (0x014)
    addi $s0, $s0, 1            #11 $s0 = 11 (0x0B)

    # Instrucci�n SRL
    srl $t4, $t0, 2             # $t4 = $t0 >> 1 = 5 >> 2 = 1 (0x01)
    addi $s0, $s0, 1            #12 $s0 = 12 (0x0C)

    # Instrucci�n SRA
    sra $t5, $t0, 2             # $t5 = $t0 >> 2 = 5 >> 2 = 1 (0x01)
    addi $s0, $s0, 1            #13 $s0 = 13 (0x0D)

    # Instrucci�n SLLV
    sllv $t6, $t0, $t1          # $t6 = $t0 << $t1 = 5 << 1 = 10 (0x0a)
    addi $s0, $s0, 1            #14 $s0 = 14 (0x0E)

    # Instrucci�n SRLV
    srlv $t7, $t0, $t1          # $t7 = $t0 >> $t1 = 5 >> 1 = 2 (0x02)
    addi $s0, $s0, 1            #15 $s0 = 15 (0x0F)

    # Instrucci�n SRAV
    srav $t8, $t0, $t1          # $t8 = $t0 >> $t1 = 5 >> 1 = 2 (0x02)
    addi $s0, $s0, 1            #16 $s0 = 16 (0x10)

    # Instrucci�n MULT
    mult $t0, $t1               # HI = 5 * 1 >> 32 = 0, LO = 5 * 1 = 5
    mfhi $t2                    # $t2 = HI = 0
    mflo $t3                    # $t3 = LO = 5
    addi $s0, $s0, 1            #17 $s0 = 17 (0x11)

    # Instrucci�n MULTU
    multu $t0, $t3              # HI = 5 * 5 >> 32 = 0, LO = 5 * 5 = 25 (0x19)
    mfhi $t2                    # $t2 = HI = 0
    mflo $t3                    # $t3 = LO = 25 (0x19)
    addi $s0, $s0, 1            #17 $s0 = 18 (0x12)

    # Instrucci�n DIV
    div $t0, $t1                # LO = 5 / 1 = 5, HI = 5 / 1 = 5
    mfhi $t4                    # $t4 = HI = 0
    mflo $t5                    # $t5 = LO = 5
    addi $s0, $s0, 1            #19 $s0 = 19 (0x13)

    # Instrucci�n DIVU
    divu $t0, $t3               # LO = $t0 / $t3 = 5 / 25 = 0, HI = $t0 % $t3 = 5 % 25 = 5
    mfhi $t4                    # $t4 = HI = 5
    mflo $t5                    # $t5 = LO = 0
    addi $s0, $s0, 1            #20 $s0 = 20 (0x14)
    addi $s0, $s0, 1            #21 $s0 = 21 (0x15)
 
    # Instrucci�n ADDI
    addi $t6, $t0, 10           # $t6 = $t0 + 10 = 5 + 10 = 15 (0x0f)
    addi $s0, $s0, 1            #22 $s0 = 22 (0x16)

    # Instrucci�n ADDIU
    addiu $t7, $t1, 20          # $t7 = $t1 + 20 = 5 + 20 = 25 (0x15)
    addi $s0, $s0, 1            #23 $s0 = 23 (0x17)

    # Instrucci�n SLTI
    slti $t8, $t0, 8            # $t8 = ($t0 < 8) ? 1 : 0 = (5 < 8) ? 1 : 0 = 1
    addi $s0, $s0, 1            #24 $s0 = 24 (0x18)

    # Instrucci�n SLTIU
    sltiu $t9, $t1, 4           # $t9 = ($t1 < 4) ? 1 : 0 = (1 < 4) ? 1 : 0 = 1
    addi $s0, $s0, 1            #25 $s0 = 25 (0x19)

    # Instrucci�n ANDI
    andi $t2, $t0, 15           # $t2 = $t0 & 15 = 5 & 15 = 5 (0x05)
    addi $s0, $s0, 1            #26 $s0 = 26 (0x1A)

    # Instrucci�n ORI
    ori $t3, $t1, 10            # $t3 = $t1 | 10 = 1 | 10 = 11 (0x0b)
    addi $s0, $s0, 1            #27 $s0 = 27 (0x1B)

    # Instrucci�n XORI
    xori $t4, $t0, 7            # $t4 = $t0 ^ 7 = 5 ^ 7 = 2 (0x02)
    addi $s0, $s0, 1            #28 $s0 = 28 (0x1C)

    # Instrucci�n LUI
    lui $t5, 0x1234             # $t5 = 0x1234 << 16 = 0x12340000
    addi $s0, $s0, 1            #29 $s0 = 29 (0x1D)

    # Instrucci�n MFHI
    mult $t0, $t1               # HI = 5 * 1 >> 32 = 0, LO = 5 * 1 = 5
    mfhi $t2                    # $t2 = HI = 0
    addi $s0, $s0, 1            #30 $s0 = 30 (0x1E)

    # Instrucci�n MTHI
    mthi $t0                    # HI = $t0 = 5
    addi $s0, $s0, 1            #31 $s0 = 31 (0x1F)

    # Instrucci�n MFLO
    mflo $t3                    # $t3 = LO = 5
    addi $s0, $s0, 1            #32 $s0 = 32 (0x20)

    # Instrucci�n MTLO
    mtlo $t1                    # LO = $t1 = 1
    addi $s0, $s0, 1            #33 $s0 = 33 (0x21)
    
    ## S�per hasta aqu� por ahora

    # Instrucci�n LB
    sb $t2, 0($sp)              # Mem[$sp] = $t2 = 0
    lb $t6, 0($sp)              # $t6 = Mem[$sp] = 0
    addi $s0, $s0, 1            #34 $s0 = 34 (0x22)

    # Instrucci�n LBU
    sb $t2, 0($sp)              # Mem[$sp] = $t2 = 0
    lbu $t9, 0($sp)             # $t9 = Mem[$sp] = 0
    addi $s0, $s0, 1            #35 $s0 = 35 (0x23)

    # Instrucci�n LH
    sh $t6, 0($sp)              # Mem[$sp] = $t6 = 0
    lh $t7, 0($sp)              # $t7 = Mem[$sp] = 0
    addi $s0, $s0, 1            #36 $s0 = 36 (0x24)

    # Instrucci�n LHU
    sh $t6, 0($sp)              # Mem[$sp] = $t6 = 0
    lhu $t0, 0($sp)             # $t0 = Mem[$sp] = 0
    addi $s0, $s0, 1            #37 $s0 = 37 (0x25)

    # Instrucci�n LW
    sw $t0, 0($sp)              # Mem[$sp] = $t0 = 0
    lw $t8, 0($sp)              # $t8 = Mem[$sp] = 0
    addi $s0, $s0, 1            #38 $s0 = 38 (0x26)

    # Instrucci�n SB
    sb $t1, 0($sp)              # Mem[$sp] = $t1 = 1
    addi $s0, $s0, 1            #39 $s0 = 39 (0x27)

    # Instrucci�n SH
    sh $t2, 0($sp)              # Mem[$sp] = $t2 = 0
    addi $s0, $s0, 1            #40 $s0 = 40 (0x28)

    # Instrucci�n SW
    sw $t3, 0($sp)              # Mem[$sp] = $t3 = -8
    addi $s0, $s0, 1            #41 $s0 = 41 (0x29)

    # Instrucci�n BEQ
    beq $t0, $t0, equal_label   # Branch taken
    nop
equal_label:
    addi $s0, $s0, 1            #42 $s0 = 42 (0x2A)

    # Instrucci�n BNE
    bne $t0, $t1, notequal_label_bne  # Branch taken
    nop
notequal_label_bne:
    addi $s0, $s0, 1            #43 $s0 = 43 (0x2B)

    # Instrucci�n BLEZ
    blez $t0, less_or_equal_label  # Branch taken
    nop
less_or_equal_label:
    addi $s0, $s0, 1            #44 $s0 = 44 (0x2C)
 
    # Instrucci�n BGTZ
    bgtz $t0, greater_than_zero_label  # Branch not taken
    nop
greater_than_zero_label:
    addi $s0, $s0, 1            #45 $s0 = 45 (0x2D)

    # Instrucci�n J
    addi $s0, $s0, 1            #46 $s0 = 46 (0x2E)
    j target

target:
    # Instrucci�n JAL
    addi $s0, $s0, 1            #47 $s0 = 47 (0x2F)
    jal func                    # $ra = PC + 4

    # NOOP considerado previamente, SYS el cual no ha sido implementado
    addi $s0, $s0, 1            # NOOP #49 $s0 = 49 (0x31)
    addi $s0, $s0, 1            # SYS #50 $s0 = 50 (0x32)

end:
    # Terminar el programa
    j end                       # Bucle infinito para evitar el uso de syscall

# Definici�n de la funci�n
func:
    # Sumar $t0 y $t1 dentro de la funci�n, resultado en $v0
    add $v0, $t0, $t1           # $v0 = $t0 + $t1 = -8 + 1 = -7
    addi $s0, $s0, 1            #48 $s0 = 48 (0x30)
    jr $ra                      # Retorno de funci�n usando $ra
