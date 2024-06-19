# basic_program_with_all_instructions.asm

.text
.globl main

main:
    # Inicializar contador en $s0
    addi $s0, $zero, 0

    # Inicializar los registros con valores necesarios
    addi $t0, $zero, 5  # num1
    addi $t1, $zero, 3  # num2

    # Array de bytes
    addi $t2, $zero, 1
    addi $t3, $zero, 2
    addi $t4, $zero, 3
    addi $t5, $zero, 4

    # Array de halfwords
    addi $t6, $zero, 0x1234
    addi $t7, $zero, 0x5678

    # Instrucci�n ADD
    add $t2, $t0, $t1
    addi $s0, $s0, 1

    # Instrucci�n ADDU
    addu $t3, $t0, $t1
    addi $s0, $s0, 1

    # Instrucci�n SUB
    sub $t4, $t0, $t1
    addi $s0, $s0, 1

    # Instrucci�n SUBU
    subu $t5, $t0, $t1
    addi $s0, $s0, 1

    # Instrucci�n AND
    and $t6, $t0, $t1
    addi $s0, $s0, 1

    # Instrucci�n OR
    or $t7, $t0, $t1
    addi $s0, $s0, 1

    # Instrucci�n XOR
    xor $t8, $t0, $t1
    addi $s0, $s0, 1

    # Instrucci�n NOR
    nor $t0, $t0, $t1
    addi $s0, $s0, 1

    # Instrucci�n SLT
    slt $t1, $t0, $t1
    addi $s0, $s0, 1

    # Instrucci�n SLTU
    sltu $t2, $t0, $t1
    addi $s0, $s0, 1

    # Instrucci�n SLL
    sll $t3, $t0, 2
    addi $s0, $s0, 1

    # Instrucci�n SRL
    srl $t4, $t0, 1
    addi $s0, $s0, 1

    # Instrucci�n SRA
    sra $t5, $t0, 1
    addi $s0, $s0, 1

    # Instrucci�n SLLV
    sllv $t6, $t0, $t1
    addi $s0, $s0, 1

    # Instrucci�n SRLV
    srlv $t7, $t0, $t1
    addi $s0, $s0, 1

    # Instrucci�n SRAV
    srav $t8, $t0, $t1
    addi $s0, $s0, 1

    # Instrucci�n MULT
    mult $t0, $t1
    mfhi $t2
    mflo $t3
    addi $s0, $s0, 1

    # Instrucci�n MULTU
    multu $t0, $t1
    mfhi $t2
    mflo $t3
    addi $s0, $s0, 1

    # Instrucci�n DIV
    div $t0, $t1
    mfhi $t4
    mflo $t5
    addi $s0, $s0, 1

    # Instrucci�n DIVU
    divu $t0, $t1
    mfhi $t4
    mflo $t5
    addi $s0, $s0, 1
    addi $s0, $s0, 1

    # Instrucci�n ADDI
    addi $t6, $t0, 10
    addi $s0, $s0, 1

    # Instrucci�n ADDIU
    addiu $t7, $t1, 20
    addi $s0, $s0, 1

    # Instrucci�n SLTI
    slti $t8, $t0, 8
    addi $s0, $s0, 1

    # Instrucci�n SLTIU
    sltiu $t9, $t1, 4
    addi $s0, $s0, 1

    # Instrucci�n ANDI
    andi $t2, $t0, 15
    addi $s0, $s0, 1

    # Instrucci�n ORI
    ori $t3, $t1, 10
    addi $s0, $s0, 1

    # Instrucci�n XORI
    xori $t4, $t0, 7
    addi $s0, $s0, 1

    # Instrucci�n LUI
    lui $t5, 0x1234
    addi $s0, $s0, 1

    # Instrucci�n MFHI
    mult $t0, $t1
    mfhi $t2
    addi $s0, $s0, 1

    # Instrucci�n MTHI
    mthi $t0
    addi $s0, $s0, 1

    # Instrucci�n MFLO
    mflo $t3
    addi $s0, $s0, 1

    # Instrucci�n MTLO
    mtlo $t1
    addi $s0, $s0, 1

    # Instrucci�n LB
    sb $t2, 0($sp)  # Guardar en memoria temporal
    lb $t6, 0($sp)
    addi $s0, $s0, 1

    # Instrucci�n LBU
    sb $t2, 0($sp)  # Guardar en memoria temporal
    lbu $t9, 0($sp)
    addi $s0, $s0, 1

    # Instrucci�n LH
    sh $t6, 0($sp)  # Guardar en memoria temporal
    lh $t7, 0($sp)
    addi $s0, $s0, 1

    # Instrucci�n LHU
    sh $t6, 0($sp)  # Guardar en memoria temporal
    lhu $t0, 0($sp)
    addi $s0, $s0, 1

    # Instrucci�n LW
    sw $t0, 0($sp)  # Guardar en memoria temporal
    lw $t8, 0($sp)
    addi $s0, $s0, 1

    # Instrucci�n SB
    sb $t1, 0($sp)
    addi $s0, $s0, 1

    # Instrucci�n SH
    sh $t2, 0($sp)
    addi $s0, $s0, 1

    # Instrucci�n SW
    sw $t3, 0($sp)
    addi $s0, $s0, 1

    # Instrucci�n BEQ
    beq $t0, $t0, equal_label
    nop
equal_label:
    addi $s0, $s0, 1

    # Instrucci�n BNE
    bne $t0, $t1, notequal_label_bne
    nop
notequal_label_bne:
    addi $s0, $s0, 1

    # Instrucci�n BLEZ
    blez $t0, less_or_equal_label
    nop
less_or_equal_label:
    addi $s0, $s0, 1

    # Instrucci�n BGTZ
    bgtz $t0, greater_than_zero_label
    nop
greater_than_zero_label:
    addi $s0, $s0, 1

    # Instrucci�n J
    addi $s0, $s0, 1
    j target

target:
    # Instrucci�n JAL
    addi $s0, $s0, 1
    jal func  # Llamada a funci�n: salto a la etiqueta "func" y guardando la direcci�n de retorno en $ra

    # NOOP considerado previamente, SYS el cual no ha sido implementado
    addi $s0, $s0, 1  # NOOP
    addi $s0, $s0, 1  # SYS

end:
    # Terminar el programa
    j end  # Bucle infinito para evitar el uso de syscall

# Definici�n de la funci�n
func:
    # Sumar $t0 y $t1 dentro de la funci�n, resultado en $v0
    add $v0, $t0, $t1
    addi $s0, $s0, 1
    jr $ra  # Retorno de funci�n usando $ra
