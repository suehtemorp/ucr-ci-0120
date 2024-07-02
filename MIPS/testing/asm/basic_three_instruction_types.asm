# Tipo R: add, Tipo I: addi, Tipo J: j
.data
.text
main:  
addi $t0, $zero, 1
addi $t1, $t1, 2
sub $t1, $t1, $t0
j main
end:
nop
