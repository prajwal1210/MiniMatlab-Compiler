	.section	.rodata
.msg1:
	.string	" "
.msg10:
	.string	"Calling SumDiff:\n"
.msg5:
	.string	"Enter 9 values for the matrix : \n"
.msg3:
	.string	"The matrix from which the input will be subtracted : \n"
.msg0:
	.string	"The matrix to be added : \n"
.msg4:
	.string	"The negated matrix is: \n"
.msg8:
	.string	"The sum of all elements in the addition of the two matrices: "
.msg11:
	.string	"The sum of all elements in the subtraction of the two matrices: "
.msg2:
	.string	"\n"
.msg12:
	.string	"\nCalling Negate to negate the input matrix:\n"
.msg13:
	.string	"\nCalling Sum with the negated matrix:\n"
.msg7:
	.string	"\nCalling Sum:\n"
.msg6:
	.string	"\nInput Matrix:\n"
.msg9:
	.string	"\n\n"
.one:
	.long	0
	.long	1072693248
	.section	.rodata
t6:
	.long	2576980378
	.long	1072798105
t7:
	.long	2576980378
	.long	1073846681
t8:
	.long	1717986918
	.long	1074423398
t9:
	.long	0
	.long	1074921472
t10:
	.long	1717986918
	.long	1075209830
t11:
	.long	3435973837
	.long	1075498188
t12:
	.long	858993459
	.long	1075000115
t13:
	.long	2576980378
	.long	1075550617
t14:
	.long	3435973837
	.long	1075236044
	.text
	.globl	sum
	.type	sum, @function
sum:
	pushq %rbp
	movq %rsp, %rbp
	subq $464, %rsp
	movl $3, 16(%rbp)
	movl $3, 20(%rbp)
	movl $3, -116(%rbp)
	movl $3, -112(%rbp)
	movl $3, -280(%rbp)
	movl $3, -276(%rbp)
	movl $3, -412(%rbp)
	movl $3, -408(%rbp)
	movl $3, -4(%rbp)
	movl $3, -8(%rbp)
	movl $0, -20(%rbp)
	movsd -28(%rbp) ,%xmm0
	movsd %xmm0,-16(%rbp)
	movl $3, -32(%rbp)
	movl $3, -36(%rbp)
	movsd t6, %xmm0
	movsd %xmm0,-124(%rbp)
	movsd t7, %xmm0
	movsd %xmm0,-132(%rbp)
	movsd t8, %xmm0
	movsd %xmm0,-140(%rbp)
	movsd t9, %xmm0
	movsd %xmm0,-148(%rbp)
	movsd t10, %xmm0
	movsd %xmm0,-156(%rbp)
	movsd t11, %xmm0
	movsd %xmm0,-164(%rbp)
	movsd t12, %xmm0
	movsd %xmm0,-172(%rbp)
	movsd t13, %xmm0
	movsd %xmm0,-180(%rbp)
	movsd t14, %xmm0
	movsd %xmm0,-188(%rbp)
	xorq %rax ,%rax
	movl $8, %eax
	movsd -124(%rbp) ,%xmm0
	movsd %xmm0,-116(%rbp,%rax,1)
	xorq %rax ,%rax
	movl $16, %eax
	movsd -132(%rbp) ,%xmm0
	movsd %xmm0,-116(%rbp,%rax,1)
	xorq %rax ,%rax
	movl $24, %eax
	movsd -140(%rbp) ,%xmm0
	movsd %xmm0,-116(%rbp,%rax,1)
	xorq %rax ,%rax
	movl $32, %eax
	movsd -148(%rbp) ,%xmm0
	movsd %xmm0,-116(%rbp,%rax,1)
	xorq %rax ,%rax
	movl $40, %eax
	movsd -156(%rbp) ,%xmm0
	movsd %xmm0,-116(%rbp,%rax,1)
	xorq %rax ,%rax
	movl $48, %eax
	movsd -164(%rbp) ,%xmm0
	movsd %xmm0,-116(%rbp,%rax,1)
	xorq %rax ,%rax
	movl $56, %eax
	movsd -172(%rbp) ,%xmm0
	movsd %xmm0,-116(%rbp,%rax,1)
	xorq %rax ,%rax
	movl $64, %eax
	movsd -180(%rbp) ,%xmm0
	movsd %xmm0,-116(%rbp,%rax,1)
	xorq %rax ,%rax
	movl $72, %eax
	movsd -188(%rbp) ,%xmm0
	movsd %xmm0,-116(%rbp,%rax,1)
	xorq %r8, %r8
	xorq %r9, %r9
	xorq %r10, %r10
	xorq %r11, %r11
	xorq %r12, %r12
	xorq %r13, %r13
	movl -116(%rbp), %r8d
	movl -112(%rbp), %r9d
	movl $0, %r10d
	movl $0, %r11d
	jmp .LoopL70
.LoopL70:
	cmpl %r8d, %r10d
	jge .LoopL70717273
	movl $0, %r11d
	jmp .LoopL7071
.LoopL7071:
	cmpl %r9d, %r11d
	jge .LoopL707172
	movl %r11d, %r12d
	imull %r8d, %r12d
	addl %r10d, %r12d
	imull $8, %r12d
	movl %r10d, %r13d
	imull %r9d, %r13d
	addl %r11d, %r13d
	imull $8, %r13d
	movq -108(%rbp,%r13,1), %xmm0
	movq %xmm0, -272(%rbp,%r12,1)
	addl $1, %r11d
	jmp .LoopL7071
.LoopL707172:
	addl $1, %r10d
	jmp .LoopL70
.LoopL70717273:
	movsd -272(%rbp) ,%xmm0
	movsd %xmm0,-108(%rbp)
	movsd -264(%rbp) ,%xmm0
	movsd %xmm0,-100(%rbp)
	movsd -256(%rbp) ,%xmm0
	movsd %xmm0,-92(%rbp)
	movsd -248(%rbp) ,%xmm0
	movsd %xmm0,-84(%rbp)
	movsd -240(%rbp) ,%xmm0
	movsd %xmm0,-76(%rbp)
	movsd -232(%rbp) ,%xmm0
	movsd %xmm0,-68(%rbp)
	movsd -224(%rbp) ,%xmm0
	movsd %xmm0,-60(%rbp)
	movsd -216(%rbp) ,%xmm0
	movsd %xmm0,-52(%rbp)
	movsd -208(%rbp) ,%xmm0
	movsd %xmm0,-44(%rbp)
	movq $.msg0 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-284(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -284(%rbp) ,%eax
	movl %eax,-200(%rbp)
	movl $0, -288(%rbp)
	movl -288(%rbp) ,%eax
	movl %eax,-192(%rbp)
.L3:
	movl $3, -292(%rbp)
	movl -292(%rbp) ,%eax
	cmpl %eax, -192(%rbp)
	jl .L0
	jmp .L2
	jmp .L2
.L9:
	movl -192(%rbp) ,%eax
	movl %eax,-296(%rbp)
	movl -192(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-192(%rbp)
	jmp .L3
.L0:
	movl $0, -300(%rbp)
	movl -300(%rbp) ,%eax
	movl %eax,-196(%rbp)
.L7:
	movl $3, -304(%rbp)
	movl -304(%rbp) ,%eax
	cmpl %eax, -196(%rbp)
	jl .L4
	jmp .L6
	jmp .L6
.L8:
	movl -196(%rbp) ,%eax
	movl %eax,-308(%rbp)
	movl -196(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-196(%rbp)
	jmp .L7
.L4:
	xorq %rax ,%rax
	movl $4, %eax
	movl -116(%rbp,%rax,1) ,%edx
	movl %edx,-312(%rbp)
	movl -192(%rbp) ,%eax
	movl -312(%rbp) ,%edx
	imull %edx, %eax
	movl %eax,-312(%rbp)
	movl -312(%rbp) ,%eax
	movl -196(%rbp) ,%edx
	addl %edx, %eax
	movl %eax,-312(%rbp)
	movl -312(%rbp) ,%eax
	movl $8 ,%edx
	imull %edx, %eax
	movl %eax,-312(%rbp)
	movl -312(%rbp) ,%eax
	movl $8, %edx
	addl %edx, %eax
	movl %eax,-312(%rbp)
	xorq %rax ,%rax
	movl -312(%rbp) ,%eax
	movsd -116(%rbp,%rax,1) ,%xmm0
	movsd %xmm0,-320(%rbp)
	xorpd %xmm0,%xmm0
	movsd -320(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	call printFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-324(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -324(%rbp) ,%eax
	movl %eax,-200(%rbp)
	movq $.msg1 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-328(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -328(%rbp) ,%eax
	movl %eax,-200(%rbp)
	jmp .L8
.L6:
	movq $.msg2 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-332(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -332(%rbp) ,%eax
	movl %eax,-200(%rbp)
	jmp .L9
.L2:
	movsd -108(%rbp) ,%xmm0
	movsd 24(%rbp) ,%xmm1
	addsd %xmm1,%xmm0
	movsd %xmm0,-404(%rbp)
	movsd -100(%rbp) ,%xmm0
	movsd 32(%rbp) ,%xmm1
	addsd %xmm1,%xmm0
	movsd %xmm0,-396(%rbp)
	movsd -92(%rbp) ,%xmm0
	movsd 40(%rbp) ,%xmm1
	addsd %xmm1,%xmm0
	movsd %xmm0,-388(%rbp)
	movsd -84(%rbp) ,%xmm0
	movsd 48(%rbp) ,%xmm1
	addsd %xmm1,%xmm0
	movsd %xmm0,-380(%rbp)
	movsd -76(%rbp) ,%xmm0
	movsd 56(%rbp) ,%xmm1
	addsd %xmm1,%xmm0
	movsd %xmm0,-372(%rbp)
	movsd -68(%rbp) ,%xmm0
	movsd 64(%rbp) ,%xmm1
	addsd %xmm1,%xmm0
	movsd %xmm0,-364(%rbp)
	movsd -60(%rbp) ,%xmm0
	movsd 72(%rbp) ,%xmm1
	addsd %xmm1,%xmm0
	movsd %xmm0,-356(%rbp)
	movsd -52(%rbp) ,%xmm0
	movsd 80(%rbp) ,%xmm1
	addsd %xmm1,%xmm0
	movsd %xmm0,-348(%rbp)
	movsd -44(%rbp) ,%xmm0
	movsd 88(%rbp) ,%xmm1
	addsd %xmm1,%xmm0
	movsd %xmm0,-340(%rbp)
	movsd -404(%rbp) ,%xmm0
	movsd %xmm0,-108(%rbp)
	movsd -396(%rbp) ,%xmm0
	movsd %xmm0,-100(%rbp)
	movsd -388(%rbp) ,%xmm0
	movsd %xmm0,-92(%rbp)
	movsd -380(%rbp) ,%xmm0
	movsd %xmm0,-84(%rbp)
	movsd -372(%rbp) ,%xmm0
	movsd %xmm0,-76(%rbp)
	movsd -364(%rbp) ,%xmm0
	movsd %xmm0,-68(%rbp)
	movsd -356(%rbp) ,%xmm0
	movsd %xmm0,-60(%rbp)
	movsd -348(%rbp) ,%xmm0
	movsd %xmm0,-52(%rbp)
	movsd -340(%rbp) ,%xmm0
	movsd %xmm0,-44(%rbp)
	movl $0, -424(%rbp)
	movl -424(%rbp) ,%eax
	movl %eax,-416(%rbp)
.L13:
	movl $3, -428(%rbp)
	movl -428(%rbp) ,%eax
	cmpl %eax, -416(%rbp)
	jl .L10
	jmp .L12
	jmp .L12
.L19:
	movl -416(%rbp) ,%eax
	movl %eax,-432(%rbp)
	movl -416(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-416(%rbp)
	jmp .L13
.L10:
	movl $0, -436(%rbp)
	movl -436(%rbp) ,%eax
	movl %eax,-420(%rbp)
.L17:
	movl $3, -440(%rbp)
	movl -440(%rbp) ,%eax
	cmpl %eax, -420(%rbp)
	jl .L14
	jmp .L19
	jmp .L16
.L18:
	movl -420(%rbp) ,%eax
	movl %eax,-444(%rbp)
	movl -420(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-420(%rbp)
	jmp .L17
.L14:
	xorq %rax ,%rax
	movl $4, %eax
	movl -116(%rbp,%rax,1) ,%edx
	movl %edx,-448(%rbp)
	movl -416(%rbp) ,%eax
	movl -448(%rbp) ,%edx
	imull %edx, %eax
	movl %eax,-448(%rbp)
	movl -448(%rbp) ,%eax
	movl -420(%rbp) ,%edx
	addl %edx, %eax
	movl %eax,-448(%rbp)
	movl -448(%rbp) ,%eax
	movl $8 ,%edx
	imull %edx, %eax
	movl %eax,-448(%rbp)
	movl -448(%rbp) ,%eax
	movl $8, %edx
	addl %edx, %eax
	movl %eax,-448(%rbp)
	xorq %rax ,%rax
	movl -448(%rbp) ,%eax
	movsd -116(%rbp,%rax,1) ,%xmm0
	movsd %xmm0,-456(%rbp)
	movsd -16(%rbp) ,%xmm0
	movsd -456(%rbp) ,%xmm1
	addsd %xmm1, %xmm0
	movsd %xmm0,-464(%rbp)
	movsd -464(%rbp) ,%xmm0
	movsd %xmm0,-16(%rbp)
	jmp .L18
.L16:
	jmp .L19
.L12:
	movsd -16(%rbp) ,%xmm0
	leave
	ret
	.section	.rodata
t44:
	.long	2576980378
	.long	1072798105
t45:
	.long	2576980378
	.long	1073846681
t46:
	.long	1717986918
	.long	1074423398
t47:
	.long	0
	.long	1074921472
t48:
	.long	1717986918
	.long	1075209830
t49:
	.long	3435973837
	.long	1075498188
t50:
	.long	858993459
	.long	1075000115
t51:
	.long	2576980378
	.long	1075550617
t52:
	.long	3435973837
	.long	1075236044
	.text
	.globl	diffsum
	.type	diffsum, @function
diffsum:
	pushq %rbp
	movq %rsp, %rbp
	subq $384, %rsp
	movl $3, 16(%rbp)
	movl $3, 20(%rbp)
	movl $3, -116(%rbp)
	movl $3, -112(%rbp)
	movl $3, -340(%rbp)
	movl $3, -336(%rbp)
	movl $3, -4(%rbp)
	movl $3, -8(%rbp)
	movl $0, -20(%rbp)
	movsd -28(%rbp) ,%xmm0
	movsd %xmm0,-16(%rbp)
	movl $3, -32(%rbp)
	movl $3, -36(%rbp)
	movsd t44, %xmm0
	movsd %xmm0,-124(%rbp)
	movsd t45, %xmm0
	movsd %xmm0,-132(%rbp)
	movsd t46, %xmm0
	movsd %xmm0,-140(%rbp)
	movsd t47, %xmm0
	movsd %xmm0,-148(%rbp)
	movsd t48, %xmm0
	movsd %xmm0,-156(%rbp)
	movsd t49, %xmm0
	movsd %xmm0,-164(%rbp)
	movsd t50, %xmm0
	movsd %xmm0,-172(%rbp)
	movsd t51, %xmm0
	movsd %xmm0,-180(%rbp)
	movsd t52, %xmm0
	movsd %xmm0,-188(%rbp)
	xorq %rax ,%rax
	movl $8, %eax
	movsd -124(%rbp) ,%xmm0
	movsd %xmm0,-116(%rbp,%rax,1)
	xorq %rax ,%rax
	movl $16, %eax
	movsd -132(%rbp) ,%xmm0
	movsd %xmm0,-116(%rbp,%rax,1)
	xorq %rax ,%rax
	movl $24, %eax
	movsd -140(%rbp) ,%xmm0
	movsd %xmm0,-116(%rbp,%rax,1)
	xorq %rax ,%rax
	movl $32, %eax
	movsd -148(%rbp) ,%xmm0
	movsd %xmm0,-116(%rbp,%rax,1)
	xorq %rax ,%rax
	movl $40, %eax
	movsd -156(%rbp) ,%xmm0
	movsd %xmm0,-116(%rbp,%rax,1)
	xorq %rax ,%rax
	movl $48, %eax
	movsd -164(%rbp) ,%xmm0
	movsd %xmm0,-116(%rbp,%rax,1)
	xorq %rax ,%rax
	movl $56, %eax
	movsd -172(%rbp) ,%xmm0
	movsd %xmm0,-116(%rbp,%rax,1)
	xorq %rax ,%rax
	movl $64, %eax
	movsd -180(%rbp) ,%xmm0
	movsd %xmm0,-116(%rbp,%rax,1)
	xorq %rax ,%rax
	movl $72, %eax
	movsd -188(%rbp) ,%xmm0
	movsd %xmm0,-116(%rbp,%rax,1)
	movq $.msg3 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-212(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -212(%rbp) ,%eax
	movl %eax,-208(%rbp)
	movl $0, -216(%rbp)
	movl -216(%rbp) ,%eax
	movl %eax,-200(%rbp)
.L23:
	movl $3, -220(%rbp)
	movl -220(%rbp) ,%eax
	cmpl %eax, -200(%rbp)
	jl .L20
	jmp .L22
	jmp .L22
.L29:
	movl -200(%rbp) ,%eax
	movl %eax,-224(%rbp)
	movl -200(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-200(%rbp)
	jmp .L23
.L20:
	movl $0, -228(%rbp)
	movl -228(%rbp) ,%eax
	movl %eax,-204(%rbp)
.L27:
	movl $3, -232(%rbp)
	movl -232(%rbp) ,%eax
	cmpl %eax, -204(%rbp)
	jl .L24
	jmp .L26
	jmp .L26
.L28:
	movl -204(%rbp) ,%eax
	movl %eax,-236(%rbp)
	movl -204(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-204(%rbp)
	jmp .L27
.L24:
	xorq %rax ,%rax
	movl $4, %eax
	movl -116(%rbp,%rax,1) ,%edx
	movl %edx,-240(%rbp)
	movl -200(%rbp) ,%eax
	movl -240(%rbp) ,%edx
	imull %edx, %eax
	movl %eax,-240(%rbp)
	movl -240(%rbp) ,%eax
	movl -204(%rbp) ,%edx
	addl %edx, %eax
	movl %eax,-240(%rbp)
	movl -240(%rbp) ,%eax
	movl $8 ,%edx
	imull %edx, %eax
	movl %eax,-240(%rbp)
	movl -240(%rbp) ,%eax
	movl $8, %edx
	addl %edx, %eax
	movl %eax,-240(%rbp)
	xorq %rax ,%rax
	movl -240(%rbp) ,%eax
	movsd -116(%rbp,%rax,1) ,%xmm0
	movsd %xmm0,-248(%rbp)
	xorpd %xmm0,%xmm0
	movsd -248(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	call printFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-252(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -252(%rbp) ,%eax
	movl %eax,-208(%rbp)
	movq $.msg1 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-256(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -256(%rbp) ,%eax
	movl %eax,-208(%rbp)
	jmp .L28
.L26:
	movq $.msg2 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-260(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -260(%rbp) ,%eax
	movl %eax,-208(%rbp)
	jmp .L29
.L22:
	movsd -108(%rbp) ,%xmm0
	movsd 24(%rbp) ,%xmm1
	subsd %xmm1,%xmm0
	movsd %xmm0,-332(%rbp)
	movsd -100(%rbp) ,%xmm0
	movsd 32(%rbp) ,%xmm1
	subsd %xmm1,%xmm0
	movsd %xmm0,-324(%rbp)
	movsd -92(%rbp) ,%xmm0
	movsd 40(%rbp) ,%xmm1
	subsd %xmm1,%xmm0
	movsd %xmm0,-316(%rbp)
	movsd -84(%rbp) ,%xmm0
	movsd 48(%rbp) ,%xmm1
	subsd %xmm1,%xmm0
	movsd %xmm0,-308(%rbp)
	movsd -76(%rbp) ,%xmm0
	movsd 56(%rbp) ,%xmm1
	subsd %xmm1,%xmm0
	movsd %xmm0,-300(%rbp)
	movsd -68(%rbp) ,%xmm0
	movsd 64(%rbp) ,%xmm1
	subsd %xmm1,%xmm0
	movsd %xmm0,-292(%rbp)
	movsd -60(%rbp) ,%xmm0
	movsd 72(%rbp) ,%xmm1
	subsd %xmm1,%xmm0
	movsd %xmm0,-284(%rbp)
	movsd -52(%rbp) ,%xmm0
	movsd 80(%rbp) ,%xmm1
	subsd %xmm1,%xmm0
	movsd %xmm0,-276(%rbp)
	movsd -44(%rbp) ,%xmm0
	movsd 88(%rbp) ,%xmm1
	subsd %xmm1,%xmm0
	movsd %xmm0,-268(%rbp)
	movsd -332(%rbp) ,%xmm0
	movsd %xmm0,-108(%rbp)
	movsd -324(%rbp) ,%xmm0
	movsd %xmm0,-100(%rbp)
	movsd -316(%rbp) ,%xmm0
	movsd %xmm0,-92(%rbp)
	movsd -308(%rbp) ,%xmm0
	movsd %xmm0,-84(%rbp)
	movsd -300(%rbp) ,%xmm0
	movsd %xmm0,-76(%rbp)
	movsd -292(%rbp) ,%xmm0
	movsd %xmm0,-68(%rbp)
	movsd -284(%rbp) ,%xmm0
	movsd %xmm0,-60(%rbp)
	movsd -276(%rbp) ,%xmm0
	movsd %xmm0,-52(%rbp)
	movsd -268(%rbp) ,%xmm0
	movsd %xmm0,-44(%rbp)
	movl $0, -344(%rbp)
	movl -344(%rbp) ,%eax
	movl %eax,-192(%rbp)
.L33:
	movl $3, -348(%rbp)
	movl -348(%rbp) ,%eax
	cmpl %eax, -192(%rbp)
	jl .L30
	jmp .L32
	jmp .L32
.L39:
	movl -192(%rbp) ,%eax
	movl %eax,-352(%rbp)
	movl -192(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-192(%rbp)
	jmp .L33
.L30:
	movl $0, -356(%rbp)
	movl -356(%rbp) ,%eax
	movl %eax,-196(%rbp)
.L37:
	movl $3, -360(%rbp)
	movl -360(%rbp) ,%eax
	cmpl %eax, -196(%rbp)
	jl .L34
	jmp .L39
	jmp .L36
.L38:
	movl -196(%rbp) ,%eax
	movl %eax,-364(%rbp)
	movl -196(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-196(%rbp)
	jmp .L37
.L34:
	xorq %rax ,%rax
	movl $4, %eax
	movl -116(%rbp,%rax,1) ,%edx
	movl %edx,-368(%rbp)
	movl -192(%rbp) ,%eax
	movl -368(%rbp) ,%edx
	imull %edx, %eax
	movl %eax,-368(%rbp)
	movl -368(%rbp) ,%eax
	movl -196(%rbp) ,%edx
	addl %edx, %eax
	movl %eax,-368(%rbp)
	movl -368(%rbp) ,%eax
	movl $8 ,%edx
	imull %edx, %eax
	movl %eax,-368(%rbp)
	movl -368(%rbp) ,%eax
	movl $8, %edx
	addl %edx, %eax
	movl %eax,-368(%rbp)
	xorq %rax ,%rax
	movl -368(%rbp) ,%eax
	movsd -116(%rbp,%rax,1) ,%xmm0
	movsd %xmm0,-376(%rbp)
	movsd -16(%rbp) ,%xmm0
	movsd -376(%rbp) ,%xmm1
	addsd %xmm1, %xmm0
	movsd %xmm0,-384(%rbp)
	movsd -384(%rbp) ,%xmm0
	movsd %xmm0,-16(%rbp)
	jmp .L38
.L36:
	jmp .L39
.L32:
	movsd -16(%rbp) ,%xmm0
	leave
	ret
	.section	.rodata
	.text
	.globl	negate
	.type	negate, @function
negate:
	pushq %rbp
	movq %rsp, %rbp
	subq $240, %rsp
	movl $3, 16(%rbp)
	movl $3, 20(%rbp)
	movl $3, -96(%rbp)
	movl $3, -92(%rbp)
	movl $3, -188(%rbp)
	movl $3, -184(%rbp)
	movl $3, -4(%rbp)
	movl $3, -8(%rbp)
	movl $3, -12(%rbp)
	movl $3, -16(%rbp)
	movsd 24(%rbp) ,%xmm0
	xorpd %xmm1, %xmm1
	subsd %xmm0, %xmm1
	movsd %xmm1, -180(%rbp)
	movsd 32(%rbp) ,%xmm0
	xorpd %xmm1, %xmm1
	subsd %xmm0, %xmm1
	movsd %xmm1, -172(%rbp)
	movsd 40(%rbp) ,%xmm0
	xorpd %xmm1, %xmm1
	subsd %xmm0, %xmm1
	movsd %xmm1, -164(%rbp)
	movsd 48(%rbp) ,%xmm0
	xorpd %xmm1, %xmm1
	subsd %xmm0, %xmm1
	movsd %xmm1, -156(%rbp)
	movsd 56(%rbp) ,%xmm0
	xorpd %xmm1, %xmm1
	subsd %xmm0, %xmm1
	movsd %xmm1, -148(%rbp)
	movsd 64(%rbp) ,%xmm0
	xorpd %xmm1, %xmm1
	subsd %xmm0, %xmm1
	movsd %xmm1, -140(%rbp)
	movsd 72(%rbp) ,%xmm0
	xorpd %xmm1, %xmm1
	subsd %xmm0, %xmm1
	movsd %xmm1, -132(%rbp)
	movsd 80(%rbp) ,%xmm0
	xorpd %xmm1, %xmm1
	subsd %xmm0, %xmm1
	movsd %xmm1, -124(%rbp)
	movsd 88(%rbp) ,%xmm0
	xorpd %xmm1, %xmm1
	subsd %xmm0, %xmm1
	movsd %xmm1, -116(%rbp)
	movsd -180(%rbp) ,%xmm0
	movsd %xmm0,-88(%rbp)
	movsd -172(%rbp) ,%xmm0
	movsd %xmm0,-80(%rbp)
	movsd -164(%rbp) ,%xmm0
	movsd %xmm0,-72(%rbp)
	movsd -156(%rbp) ,%xmm0
	movsd %xmm0,-64(%rbp)
	movsd -148(%rbp) ,%xmm0
	movsd %xmm0,-56(%rbp)
	movsd -140(%rbp) ,%xmm0
	movsd %xmm0,-48(%rbp)
	movsd -132(%rbp) ,%xmm0
	movsd %xmm0,-40(%rbp)
	movsd -124(%rbp) ,%xmm0
	movsd %xmm0,-32(%rbp)
	movsd -116(%rbp) ,%xmm0
	movsd %xmm0,-24(%rbp)
	movq $.msg4 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-192(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -192(%rbp) ,%eax
	movl %eax,-108(%rbp)
	movl $0, -196(%rbp)
	movl -196(%rbp) ,%eax
	movl %eax,-100(%rbp)
.L43:
	movl $3, -200(%rbp)
	movl -200(%rbp) ,%eax
	cmpl %eax, -100(%rbp)
	jl .L40
	jmp .L42
	jmp .L42
.L49:
	movl -100(%rbp) ,%eax
	movl %eax,-204(%rbp)
	movl -100(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-100(%rbp)
	jmp .L43
.L40:
	movl $0, -208(%rbp)
	movl -208(%rbp) ,%eax
	movl %eax,-104(%rbp)
.L47:
	movl $3, -212(%rbp)
	movl -212(%rbp) ,%eax
	cmpl %eax, -104(%rbp)
	jl .L44
	jmp .L46
	jmp .L46
.L48:
	movl -104(%rbp) ,%eax
	movl %eax,-216(%rbp)
	movl -104(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-104(%rbp)
	jmp .L47
.L44:
	xorq %rax ,%rax
	movl $4, %eax
	movl -96(%rbp,%rax,1) ,%edx
	movl %edx,-220(%rbp)
	movl -100(%rbp) ,%eax
	movl -220(%rbp) ,%edx
	imull %edx, %eax
	movl %eax,-220(%rbp)
	movl -220(%rbp) ,%eax
	movl -104(%rbp) ,%edx
	addl %edx, %eax
	movl %eax,-220(%rbp)
	movl -220(%rbp) ,%eax
	movl $8 ,%edx
	imull %edx, %eax
	movl %eax,-220(%rbp)
	movl -220(%rbp) ,%eax
	movl $8, %edx
	addl %edx, %eax
	movl %eax,-220(%rbp)
	xorq %rax ,%rax
	movl -220(%rbp) ,%eax
	movsd -96(%rbp,%rax,1) ,%xmm0
	movsd %xmm0,-228(%rbp)
	xorpd %xmm0,%xmm0
	movsd -228(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	call printFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-232(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -232(%rbp) ,%eax
	movl %eax,-108(%rbp)
	movq $.msg1 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-236(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -236(%rbp) ,%eax
	movl %eax,-108(%rbp)
	jmp .L48
.L46:
	movq $.msg2 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-240(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -240(%rbp) ,%eax
	movl %eax,-108(%rbp)
	jmp .L49
.L42:
	leaq -96(%rbp) ,%rax
	leave
	ret
	.section	.rodata
	.text
	.globl	main
	.type	main, @function
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $396, %rsp
	movl $3, -88(%rbp)
	movl $3, -84(%rbp)
	movl $3, -364(%rbp)
	movl $3, -360(%rbp)
	movl $3, -4(%rbp)
	movl $3, -8(%rbp)
	movq $.msg5 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-124(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -124(%rbp) ,%eax
	movl %eax,-92(%rbp)
	movl $0, -128(%rbp)
	movl -128(%rbp) ,%eax
	movl %eax,-104(%rbp)
.L53:
	movl $3, -132(%rbp)
	movl -132(%rbp) ,%eax
	cmpl %eax, -104(%rbp)
	jl .L50
	jmp .L52
	jmp .L52
.L59:
	movl -104(%rbp) ,%eax
	movl %eax,-136(%rbp)
	movl -104(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-104(%rbp)
	jmp .L53
.L50:
	movl $0, -140(%rbp)
	movl -140(%rbp) ,%eax
	movl %eax,-108(%rbp)
.L57:
	movl $3, -144(%rbp)
	movl -144(%rbp) ,%eax
	cmpl %eax, -108(%rbp)
	jl .L54
	jmp .L59
	jmp .L56
.L58:
	movl -108(%rbp) ,%eax
	movl %eax,-148(%rbp)
	movl -108(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-108(%rbp)
	jmp .L57
.L54:
	xorq %rax ,%rax
	movl $4, %eax
	movl -88(%rbp,%rax,1) ,%edx
	movl %edx,-152(%rbp)
	movl -104(%rbp) ,%eax
	movl -152(%rbp) ,%edx
	imull %edx, %eax
	movl %eax,-152(%rbp)
	movl -152(%rbp) ,%eax
	movl -108(%rbp) ,%edx
	addl %edx, %eax
	movl %eax,-152(%rbp)
	movl -152(%rbp) ,%eax
	movl $8 ,%edx
	imull %edx, %eax
	movl %eax,-152(%rbp)
	movl -152(%rbp) ,%eax
	movl $8, %edx
	addl %edx, %eax
	movl %eax,-152(%rbp)
	leaq -88(%rbp) ,%rax
	movq %rax,-160(%rbp)
	movq -160(%rbp) ,%rax
	xorq %rdx, %rdx
	movl -152(%rbp) ,%edx
	addq %rdx, %rax
	movq %rax,-160(%rbp)
	movq -160(%rbp) ,%rax
	pushq %rax
	movq %rax, %rdi
	call readFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-164(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -164(%rbp) ,%eax
	movl %eax,-92(%rbp)
	jmp .L58
.L56:
	jmp .L59
.L52:
	movq $.msg6 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-168(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -168(%rbp) ,%eax
	movl %eax,-92(%rbp)
	movl $0, -172(%rbp)
	movl -172(%rbp) ,%eax
	movl %eax,-104(%rbp)
.L63:
	movl $3, -176(%rbp)
	movl -176(%rbp) ,%eax
	cmpl %eax, -104(%rbp)
	jl .L60
	jmp .L62
	jmp .L62
.L69:
	movl -104(%rbp) ,%eax
	movl %eax,-180(%rbp)
	movl -104(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-104(%rbp)
	jmp .L63
.L60:
	movl $0, -184(%rbp)
	movl -184(%rbp) ,%eax
	movl %eax,-108(%rbp)
.L67:
	movl $3, -188(%rbp)
	movl -188(%rbp) ,%eax
	cmpl %eax, -108(%rbp)
	jl .L64
	jmp .L66
	jmp .L66
.L68:
	movl -108(%rbp) ,%eax
	movl %eax,-192(%rbp)
	movl -108(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-108(%rbp)
	jmp .L67
.L64:
	xorq %rax ,%rax
	movl $4, %eax
	movl -88(%rbp,%rax,1) ,%edx
	movl %edx,-196(%rbp)
	movl -104(%rbp) ,%eax
	movl -196(%rbp) ,%edx
	imull %edx, %eax
	movl %eax,-196(%rbp)
	movl -196(%rbp) ,%eax
	movl -108(%rbp) ,%edx
	addl %edx, %eax
	movl %eax,-196(%rbp)
	movl -196(%rbp) ,%eax
	movl $8 ,%edx
	imull %edx, %eax
	movl %eax,-196(%rbp)
	movl -196(%rbp) ,%eax
	movl $8, %edx
	addl %edx, %eax
	movl %eax,-196(%rbp)
	xorq %rax ,%rax
	movl -196(%rbp) ,%eax
	movsd -88(%rbp,%rax,1) ,%xmm0
	movsd %xmm0,-204(%rbp)
	xorpd %xmm0,%xmm0
	movsd -204(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	call printFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-208(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -208(%rbp) ,%eax
	movl %eax,-92(%rbp)
	movq $.msg1 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-212(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -212(%rbp) ,%eax
	movl %eax,-92(%rbp)
	jmp .L68
.L66:
	movq $.msg2 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-216(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -216(%rbp) ,%eax
	movl %eax,-92(%rbp)
	jmp .L69
.L62:
	movl $10, -220(%rbp)
	movl -220(%rbp) ,%eax
	movl %eax,-96(%rbp)
	movl $9, -224(%rbp)
	movl -224(%rbp) ,%eax
	movl %eax,-100(%rbp)
	movq $.msg7 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-236(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -236(%rbp) ,%eax
	movl %eax,-92(%rbp)
	movsd -16(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -24(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -32(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -40(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -48(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -56(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -64(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -72(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -80(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	subq $8, %rsp
	call sum
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	xorq %rbx, %rbx
	movsd %xmm0, -244(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movsd -244(%rbp) ,%xmm0
	movsd %xmm0,-232(%rbp)
	movq $.msg8 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-248(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -248(%rbp) ,%eax
	movl %eax,-92(%rbp)
	xorpd %xmm0,%xmm0
	movsd -232(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	call printFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-252(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -252(%rbp) ,%eax
	movl %eax,-92(%rbp)
	movq $.msg9 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-256(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -256(%rbp) ,%eax
	movl %eax,-92(%rbp)
	movq $.msg10 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-260(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -260(%rbp) ,%eax
	movl %eax,-92(%rbp)
	movsd -16(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -24(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -32(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -40(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -48(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -56(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -64(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -72(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -80(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	subq $8, %rsp
	call diffsum
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	xorq %rbx, %rbx
	movsd %xmm0, -268(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movsd -268(%rbp) ,%xmm0
	movsd %xmm0,-232(%rbp)
	movq $.msg11 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-272(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -272(%rbp) ,%eax
	movl %eax,-92(%rbp)
	xorpd %xmm0,%xmm0
	movsd -232(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	call printFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-276(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -276(%rbp) ,%eax
	movl %eax,-92(%rbp)
	movq $.msg9 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-280(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -280(%rbp) ,%eax
	movl %eax,-92(%rbp)
	movq $.msg12 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-284(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -284(%rbp) ,%eax
	movl %eax,-92(%rbp)
	movsd -16(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -24(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -32(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -40(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -48(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -56(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -64(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -72(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -80(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	subq $8, %rsp
	call negate
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	xorq %rbx, %rbx
	movsd 8(%rax),%xmm0
	movsd %xmm0, -356(%rbp)
	movsd 16(%rax),%xmm0
	movsd %xmm0, -348(%rbp)
	movsd 24(%rax),%xmm0
	movsd %xmm0, -340(%rbp)
	movsd 32(%rax),%xmm0
	movsd %xmm0, -332(%rbp)
	movsd 40(%rax),%xmm0
	movsd %xmm0, -324(%rbp)
	movsd 48(%rax),%xmm0
	movsd %xmm0, -316(%rbp)
	movsd 56(%rax),%xmm0
	movsd %xmm0, -308(%rbp)
	movsd 64(%rax),%xmm0
	movsd %xmm0, -300(%rbp)
	movsd 72(%rax),%xmm0
	movsd %xmm0, -292(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movsd -356(%rbp) ,%xmm0
	movsd %xmm0,-80(%rbp)
	movsd -348(%rbp) ,%xmm0
	movsd %xmm0,-72(%rbp)
	movsd -340(%rbp) ,%xmm0
	movsd %xmm0,-64(%rbp)
	movsd -332(%rbp) ,%xmm0
	movsd %xmm0,-56(%rbp)
	movsd -324(%rbp) ,%xmm0
	movsd %xmm0,-48(%rbp)
	movsd -316(%rbp) ,%xmm0
	movsd %xmm0,-40(%rbp)
	movsd -308(%rbp) ,%xmm0
	movsd %xmm0,-32(%rbp)
	movsd -300(%rbp) ,%xmm0
	movsd %xmm0,-24(%rbp)
	movsd -292(%rbp) ,%xmm0
	movsd %xmm0,-16(%rbp)
	movq $.msg2 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-368(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -368(%rbp) ,%eax
	movl %eax,-92(%rbp)
	movq $.msg13 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-372(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -372(%rbp) ,%eax
	movl %eax,-92(%rbp)
	movsd -16(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -24(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -32(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -40(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -48(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -56(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -64(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -72(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -80(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	subq $8, %rsp
	call sum
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	xorq %rbx, %rbx
	movsd %xmm0, -380(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movsd -380(%rbp) ,%xmm0
	movsd %xmm0,-232(%rbp)
	movq $.msg8 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-384(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -384(%rbp) ,%eax
	movl %eax,-92(%rbp)
	xorpd %xmm0,%xmm0
	movsd -232(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	call printFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-388(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -388(%rbp) ,%eax
	movl %eax,-92(%rbp)
	movq $.msg2 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-392(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -392(%rbp) ,%eax
	movl %eax,-92(%rbp)
	movl $0, -396(%rbp)
	movl -396(%rbp) ,%eax
	leave
	ret
