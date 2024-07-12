j salto_incondicional
salto_incondicional: addi $t0, $zero, 10         # $t0 = 10
    addi $t1, $zero, 10         # $t1 = 10
    beq $t0, $t1, beq_true      # Salta a beq_true si $t0 == $t1 (10 == 10)
beq_false: addi $t0, $zero, 10         # $t0 = 10
    addi $t1, $zero, 20         # $t1 = 20
    bne $t0, $t1, bne_true      # Salta a bne_true si $t0 != $t1 (10 != 20)
bne_false: addi $t0, $zero, -5         # $t0 = -5
    blez $t0, blez_true         # Salta a blez_true si $t0 <= 0 (-5 <= 0)
blez_false: addi $t0, $zero, 15         # $t0 = 15
    bgtz $t0, bgtz_true         # Salta a bgtz_true si $t0 > 0 (15 > 0)
bgtz_false: addi $t0, $zero, -10        # $t0 = -10
    bltz $t0, bltz_true         # Salta a bltz_true si $t0 < 0 (-10 < 0)
bltz_false: addi $t0, $zero, 0          # $t0 = 0
    bgez $t0, bgez_true         # Salta a bgez_true si $t0 >= 0 (0 >= 0)
bgez_false: jal subroutine              # Salta a subroutine y guarda la dirección de retorno en $ra
retorno_subrutina: j retorno_subrutina         # Salta a retorno_subrutina, creando un loop infinito
subroutine: jr $ra                      # Salta a la dirección guardada en $ra (retorna a la instrucción siguiente de donde se llamó jal)
beq_true: j beq_false                 # Salta a beq_false
bne_true: j bne_false                 # Salta a bne_false
blez_true: j blez_false                # Salta a blez_false
bgtz_true: j bgtz_false                # Salta a bgtz_false
bltz_true: j bltz_false                # Salta a bltz_false
bgez_true: j bgez_false                # Salta a bgez_false