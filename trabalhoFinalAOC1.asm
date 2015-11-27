.data
	lot: .word 0 # numero de veiculos estacionados
	string1: .space 48
	Splaca: .space 8
	bem_vindo: .asciiz "   **** Bem-vindo ao Sistema de Estacionamento ****\n"
	nada:      .asciiz "   ************************************************\n"
	menu:      .asciiz "   ***************** MENU *************************\n"
	op1:       .asciiz "   1 - Estacionar um Veiculo\n"
	op2:       .asciiz "   2 - Desocupar uma Vaga\n"
	op3:       .asciiz "   3 - Listar Veiculos estacionados\n"
	op4:       .asciiz "   4 - Buscar uma vaga Disponivel\n"
	op5:       .asciiz "   5 - Cadastrar/Atualizar valor de cobrança por hora\n"
	op6:       .asciiz "   6 - Sair do Sistema\n"
	op:        .asciiz "   Digite a Opção desejada: "
	sairr:     .asciiz "   Tem certeza que deseja Sair? (1- SIM // 0- NÃO):  "
	ate_mais:  .asciiz "   Até mais, Volte sempre!!!!\n"
	vc_esc:    .asciiz " Você escolheu a opção: "
	propriet:  .asciiz "\n  Proprietário:  "
	placa:     .asciiz "\n  Placa:  "
	vaga:      .asciiz "\n  Vaga:  "
	## System Time ????????
	
.text
	lui $t0, 0x1001
	addi $t0, $t0, 608
	
	la $t1, lot
	sw $zero, 0($t1)
	
volta:	la $a0, bem_vindo
	li $v0, 4
	syscall
	la $a0, nada
	li $v0, 4
	syscall
	la $a0, menu
	li $v0, 4
	syscall
	la $a0, op1
	li $v0, 4
	syscall
	la $a0, op2
	li $v0, 4
	syscall
	la $a0, op3
	li $v0, 4
	syscall
	la $a0, op4
	li $v0, 4
	syscall
	la $a0, op5
	li $v0, 4
	syscall
	la $a0, op6
	li $v0, 4
	syscall
	la $a0, op
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	
	beq $v0, 1, estacionar
	nop
	beq $v0, 2, desocupar
	nop
	beq $v0, 3, listar
	nop
	beq $v0, 4, buscar
	nop
	beq $v0, 5, cad_atualiz
	nop
	beq $v0, 6, sair
	nop

estacionar: la $a0, vc_esc
	    li $v0, 4
	    syscall
	    la $a0, op1
	    li $v0, 4
	    syscall
	    la $a0, propriet
	    li $v0, 4
	    syscall
	    la $a0, string1
	    la $a1, 48
	    li $v0, 8
	    syscall
	    
	    la $a0, placa
	    li $v0, 4
	    syscall
	    la $a0, Splaca
	    la $a1, 8
	    li $v0, 8
	    syscall
	    
	    la $a0, vaga
	    li $v0, 4
	    syscall
	    li $v0, 5
	    syscall
	    la $a2, Splaca 	# a2 = placa
	    la $a1, string1	# a1 = proprietario
	    move $a3, $v0      # a3 = vaga
	    jal s_estacionar
	    nop
	    j volta
	    nop
	    
desocupar:  la $a0, vc_esc
	    li $v0, 4
	    syscall
	    la $a0, op2
	    li $v0, 4
	    syscall
	    j volta
	    nop
	    
listar:     la $a0, vc_esc
	    li $v0, 4
	    syscall
	    li $v0, 4
	    la $a0, op3
	    syscall 
	    li $v0, 1
	    la $a0, lot
	    syscall
	    
	    j volta
	    nop
buscar: j volta
	    nop
cad_atualiz: j volta
	    nop

sair:   jal out
	nop
	li $v0, 10
	syscall
	
out:    la $a0, sairr
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	beq $v0, 0, volta
	nop
	la $a0, ate_mais
	li $v0, 4
	syscall
	jr $ra
	nop
	
### Salva proprietário
s_estacionar: 	move $t1, $t0
loop_s_e_p:	lb $t2, 0($a1)
		beq $t2, $zero, fim_salva_prop
		nop
		beq $t2, 10, fim_salva_prop
		nop
		sb $t2, 0($t1)
		addi $a1, $a1, 1
		addi $t1, $t1, 1
		j loop_s_e_p
		nop
fim_salva_prop:	li $t2, 0
		sb $t2, 0($t1)
	       	addi $t0, $t0, 48
	
### Salva placa      	
	   	move $t1, $t0
loop_s_e_pl:	lb $t2, 0($a2)
		beq $t2, $zero, fim_salva_pl
		nop
		sb $t2, 0($t1)
		addi $a2, $a2, 1
		addi $t1, $t1, 1
		j loop_s_e_pl
		nop
fim_salva_pl:	li $t2, 0
		sb $t2, 0($t1)
	       	addi $t0, $t0, 8
	       	
	       sw $a3, 0($t0)
	       addi $t0, $t0, 4
	       la $t5, lot
	       lw $t4, 0($t5)
	       addi $t4, $t4, 1
	       sw $t4, 0($t5)
	       jr $ra
	       nop
