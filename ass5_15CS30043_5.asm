	.section	.rodata
.msg0:
	.string	" "
.msg1:
	.string	"The given matrix is :\n"
.msg3:
	.string	"The matrix printed in spiral form is:\n"
.msg4:
	.string	"The transposed matrix is :\n"
.msg5:
	.string	"The transposed matrix printed in spiral form is:\n"
.msg2:
	.string	"\n"
.one:
	.long	0
	.long	1072693248
	.section	.rodata
	.text
	.globl	spiralPrint
	.type	spiralPrint, @function
spiralPrint:
	pushq %rbp
	movq %rsp, %rbp
	subq $176, %rsp
	movl $4, 32(%rbp)
	movl $3, 36(%rbp)
	movl $4, -4(%rbp)
	movl $3, -8(%rbp)
	movl $0, -24(%rbp)
	movl -24(%rbp) ,%eax
	movl %eax,-20(%rbp)
	movl $0, -32(%rbp)
	movl -32(%rbp) ,%eax
	movl %eax,-28(%rbp)
.L33:
	movl 16(%rbp) ,%eax
	cmpl %eax, -20(%rbp)
	jl .L0
	jmp .L4
.L0:
	movl 24(%rbp) ,%eax
	cmpl %eax, -28(%rbp)
	jl .L2
	jmp .L4
	jmp .L4
.L2:
	movl -28(%rbp) ,%eax
	movl %eax,-16(%rbp)
.L8:
	movl 24(%rbp) ,%eax
	cmpl %eax, -16(%rbp)
	jl .L5
	jmp .L7
	jmp .L7
.L9:
	movl -16(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-16(%rbp)
	movl -16(%rbp) ,%eax
	movl %eax,-36(%rbp)
	jmp .L8
.L5:
	xorq %rax ,%rax
	movl $4, %eax
	movl 32(%rbp,%rax,1) ,%edx
	movl %edx,-40(%rbp)
	movl -20(%rbp) ,%eax
	movl -40(%rbp) ,%edx
	imull %edx, %eax
	movl %eax,-40(%rbp)
	movl -40(%rbp) ,%eax
	movl -16(%rbp) ,%edx
	addl %edx, %eax
	movl %eax,-40(%rbp)
	movl -40(%rbp) ,%eax
	movl $8 ,%edx
	imull %edx, %eax
	movl %eax,-40(%rbp)
	movl -40(%rbp) ,%eax
	movl $8, %edx
	addl %edx, %eax
	movl %eax,-40(%rbp)
	xorq %rax ,%rax
	movl -40(%rbp) ,%eax
	movsd 32(%rbp,%rax,1) ,%xmm0
	movsd %xmm0,-48(%rbp)
	xorpd %xmm0,%xmm0
	movsd -48(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	call printFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-52(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -52(%rbp) ,%eax
	movl %eax,-12(%rbp)
	movq $.msg0 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-56(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -56(%rbp) ,%eax
	movl %eax,-12(%rbp)
	jmp .L9
.L7:
	movl -20(%rbp) ,%eax
	movl %eax,-60(%rbp)
	movl -20(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-20(%rbp)
	movl -20(%rbp) ,%eax
	movl %eax,-16(%rbp)
.L13:
	movl 16(%rbp) ,%eax
	cmpl %eax, -16(%rbp)
	jl .L10
	jmp .L12
	jmp .L12
.L14:
	movl -16(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-16(%rbp)
	movl -16(%rbp) ,%eax
	movl %eax,-64(%rbp)
	jmp .L13
.L10:
	movl $1, -68(%rbp)
	movl 24(%rbp) ,%eax
	movl -68(%rbp) ,%edx
	subl %edx, %eax
	movl %eax,-72(%rbp)
	xorq %rax ,%rax
	movl $4, %eax
	movl 32(%rbp,%rax,1) ,%edx
	movl %edx,-76(%rbp)
	movl -16(%rbp) ,%eax
	movl -76(%rbp) ,%edx
	imull %edx, %eax
	movl %eax,-76(%rbp)
	movl -76(%rbp) ,%eax
	movl -72(%rbp) ,%edx
	addl %edx, %eax
	movl %eax,-76(%rbp)
	movl -76(%rbp) ,%eax
	movl $8 ,%edx
	imull %edx, %eax
	movl %eax,-76(%rbp)
	movl -76(%rbp) ,%eax
	movl $8, %edx
	addl %edx, %eax
	movl %eax,-76(%rbp)
	xorq %rax ,%rax
	movl -76(%rbp) ,%eax
	movsd 32(%rbp,%rax,1) ,%xmm0
	movsd %xmm0,-84(%rbp)
	xorpd %xmm0,%xmm0
	movsd -84(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	call printFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-88(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -88(%rbp) ,%eax
	movl %eax,-12(%rbp)
	movq $.msg0 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-92(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -92(%rbp) ,%eax
	movl %eax,-12(%rbp)
	jmp .L14
.L12:
	movl 24(%rbp) ,%eax
	movl %eax,-96(%rbp)
	movl 24(%rbp) ,%eax
	movl $1, %edx
	subl %edx, %eax
	movl %eax,24(%rbp)
	movl 16(%rbp) ,%eax
	cmpl %eax, -20(%rbp)
	jl .L15
	jmp .L23
	jmp .L23
.L15:
	movl $1, -100(%rbp)
	movl 24(%rbp) ,%eax
	movl -100(%rbp) ,%edx
	subl %edx, %eax
	movl %eax,-104(%rbp)
	movl -104(%rbp) ,%eax
	movl %eax,-16(%rbp)
.L21:
	movl -28(%rbp) ,%eax
	cmpl %eax, -16(%rbp)
	jge .L18
	jmp .L20
	jmp .L20
.L22:
	movl -16(%rbp) ,%eax
	movl $1, %edx
	subl %edx, %eax
	movl %eax,-16(%rbp)
	movl -16(%rbp) ,%eax
	movl %eax,-108(%rbp)
	jmp .L21
.L18:
	movl $1, -112(%rbp)
	movl 16(%rbp) ,%eax
	movl -112(%rbp) ,%edx
	subl %edx, %eax
	movl %eax,-116(%rbp)
	xorq %rax ,%rax
	movl $4, %eax
	movl 32(%rbp,%rax,1) ,%edx
	movl %edx,-120(%rbp)
	movl -116(%rbp) ,%eax
	movl -120(%rbp) ,%edx
	imull %edx, %eax
	movl %eax,-120(%rbp)
	movl -120(%rbp) ,%eax
	movl -16(%rbp) ,%edx
	addl %edx, %eax
	movl %eax,-120(%rbp)
	movl -120(%rbp) ,%eax
	movl $8 ,%edx
	imull %edx, %eax
	movl %eax,-120(%rbp)
	movl -120(%rbp) ,%eax
	movl $8, %edx
	addl %edx, %eax
	movl %eax,-120(%rbp)
	xorq %rax ,%rax
	movl -120(%rbp) ,%eax
	movsd 32(%rbp,%rax,1) ,%xmm0
	movsd %xmm0,-128(%rbp)
	xorpd %xmm0,%xmm0
	movsd -128(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	call printFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-132(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -132(%rbp) ,%eax
	movl %eax,-12(%rbp)
	movq $.msg0 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-136(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -136(%rbp) ,%eax
	movl %eax,-12(%rbp)
	jmp .L22
.L20:
	movl 16(%rbp) ,%eax
	movl %eax,-140(%rbp)
	movl 16(%rbp) ,%eax
	movl $1, %edx
	subl %edx, %eax
	movl %eax,16(%rbp)
	jmp .L23
.L23:
	movl 24(%rbp) ,%eax
	cmpl %eax, -28(%rbp)
	jl .L24
	jmp .L33
	jmp .L26
.L24:
	movl $1, -144(%rbp)
	movl 16(%rbp) ,%eax
	movl -144(%rbp) ,%edx
	subl %edx, %eax
	movl %eax,-148(%rbp)
	movl -148(%rbp) ,%eax
	movl %eax,-16(%rbp)
.L30:
	movl -20(%rbp) ,%eax
	cmpl %eax, -16(%rbp)
	jge .L27
	jmp .L29
	jmp .L29
.L31:
	movl -16(%rbp) ,%eax
	movl $1, %edx
	subl %edx, %eax
	movl %eax,-16(%rbp)
	movl -16(%rbp) ,%eax
	movl %eax,-152(%rbp)
	jmp .L30
.L27:
	xorq %rax ,%rax
	movl $4, %eax
	movl 32(%rbp,%rax,1) ,%edx
	movl %edx,-156(%rbp)
	movl -16(%rbp) ,%eax
	movl -156(%rbp) ,%edx
	imull %edx, %eax
	movl %eax,-156(%rbp)
	movl -156(%rbp) ,%eax
	movl -28(%rbp) ,%edx
	addl %edx, %eax
	movl %eax,-156(%rbp)
	movl -156(%rbp) ,%eax
	movl $8 ,%edx
	imull %edx, %eax
	movl %eax,-156(%rbp)
	movl -156(%rbp) ,%eax
	movl $8, %edx
	addl %edx, %eax
	movl %eax,-156(%rbp)
	xorq %rax ,%rax
	movl -156(%rbp) ,%eax
	movsd 32(%rbp,%rax,1) ,%xmm0
	movsd %xmm0,-164(%rbp)
	xorpd %xmm0,%xmm0
	movsd -164(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	call printFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-168(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -168(%rbp) ,%eax
	movl %eax,-12(%rbp)
	movq $.msg0 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-172(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -172(%rbp) ,%eax
	movl %eax,-12(%rbp)
	jmp .L31
.L29:
	movl -28(%rbp) ,%eax
	movl %eax,-176(%rbp)
	movl -28(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-28(%rbp)
	jmp .L33
.L26:
	jmp .L33
.L4:
	leave
	ret
	.section	.rodata
	.text
	.globl	spiralPrintTrans
	.type	spiralPrintTrans, @function
spiralPrintTrans:
	pushq %rbp
	movq %rsp, %rbp
	subq $176, %rsp
	movl $3, 32(%rbp)
	movl $4, 36(%rbp)
	movl $3, -4(%rbp)
	movl $4, -8(%rbp)
	movl $0, -24(%rbp)
	movl -24(%rbp) ,%eax
	movl %eax,-20(%rbp)
	movl $0, -32(%rbp)
	movl -32(%rbp) ,%eax
	movl %eax,-28(%rbp)
.L67:
	movl 16(%rbp) ,%eax
	cmpl %eax, -20(%rbp)
	jl .L34
	jmp .L38
.L34:
	movl 24(%rbp) ,%eax
	cmpl %eax, -28(%rbp)
	jl .L36
	jmp .L38
	jmp .L38
.L36:
	movl -28(%rbp) ,%eax
	movl %eax,-16(%rbp)
.L42:
	movl 24(%rbp) ,%eax
	cmpl %eax, -16(%rbp)
	jl .L39
	jmp .L41
	jmp .L41
.L43:
	movl -16(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-16(%rbp)
	movl -16(%rbp) ,%eax
	movl %eax,-36(%rbp)
	jmp .L42
.L39:
	xorq %rax ,%rax
	movl $4, %eax
	movl 32(%rbp,%rax,1) ,%edx
	movl %edx,-40(%rbp)
	movl -20(%rbp) ,%eax
	movl -40(%rbp) ,%edx
	imull %edx, %eax
	movl %eax,-40(%rbp)
	movl -40(%rbp) ,%eax
	movl -16(%rbp) ,%edx
	addl %edx, %eax
	movl %eax,-40(%rbp)
	movl -40(%rbp) ,%eax
	movl $8 ,%edx
	imull %edx, %eax
	movl %eax,-40(%rbp)
	movl -40(%rbp) ,%eax
	movl $8, %edx
	addl %edx, %eax
	movl %eax,-40(%rbp)
	xorq %rax ,%rax
	movl -40(%rbp) ,%eax
	movsd 32(%rbp,%rax,1) ,%xmm0
	movsd %xmm0,-48(%rbp)
	xorpd %xmm0,%xmm0
	movsd -48(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	call printFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-52(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -52(%rbp) ,%eax
	movl %eax,-12(%rbp)
	movq $.msg0 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-56(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -56(%rbp) ,%eax
	movl %eax,-12(%rbp)
	jmp .L43
.L41:
	movl -20(%rbp) ,%eax
	movl %eax,-60(%rbp)
	movl -20(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-20(%rbp)
	movl -20(%rbp) ,%eax
	movl %eax,-16(%rbp)
.L47:
	movl 16(%rbp) ,%eax
	cmpl %eax, -16(%rbp)
	jl .L44
	jmp .L46
	jmp .L46
.L48:
	movl -16(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-16(%rbp)
	movl -16(%rbp) ,%eax
	movl %eax,-64(%rbp)
	jmp .L47
.L44:
	movl $1, -68(%rbp)
	movl 24(%rbp) ,%eax
	movl -68(%rbp) ,%edx
	subl %edx, %eax
	movl %eax,-72(%rbp)
	xorq %rax ,%rax
	movl $4, %eax
	movl 32(%rbp,%rax,1) ,%edx
	movl %edx,-76(%rbp)
	movl -16(%rbp) ,%eax
	movl -76(%rbp) ,%edx
	imull %edx, %eax
	movl %eax,-76(%rbp)
	movl -76(%rbp) ,%eax
	movl -72(%rbp) ,%edx
	addl %edx, %eax
	movl %eax,-76(%rbp)
	movl -76(%rbp) ,%eax
	movl $8 ,%edx
	imull %edx, %eax
	movl %eax,-76(%rbp)
	movl -76(%rbp) ,%eax
	movl $8, %edx
	addl %edx, %eax
	movl %eax,-76(%rbp)
	xorq %rax ,%rax
	movl -76(%rbp) ,%eax
	movsd 32(%rbp,%rax,1) ,%xmm0
	movsd %xmm0,-84(%rbp)
	xorpd %xmm0,%xmm0
	movsd -84(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	call printFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-88(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -88(%rbp) ,%eax
	movl %eax,-12(%rbp)
	movq $.msg0 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-92(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -92(%rbp) ,%eax
	movl %eax,-12(%rbp)
	jmp .L48
.L46:
	movl 24(%rbp) ,%eax
	movl %eax,-96(%rbp)
	movl 24(%rbp) ,%eax
	movl $1, %edx
	subl %edx, %eax
	movl %eax,24(%rbp)
	movl 16(%rbp) ,%eax
	cmpl %eax, -20(%rbp)
	jl .L49
	jmp .L57
	jmp .L57
.L49:
	movl $1, -100(%rbp)
	movl 24(%rbp) ,%eax
	movl -100(%rbp) ,%edx
	subl %edx, %eax
	movl %eax,-104(%rbp)
	movl -104(%rbp) ,%eax
	movl %eax,-16(%rbp)
.L55:
	movl -28(%rbp) ,%eax
	cmpl %eax, -16(%rbp)
	jge .L52
	jmp .L54
	jmp .L54
.L56:
	movl -16(%rbp) ,%eax
	movl $1, %edx
	subl %edx, %eax
	movl %eax,-16(%rbp)
	movl -16(%rbp) ,%eax
	movl %eax,-108(%rbp)
	jmp .L55
.L52:
	movl $1, -112(%rbp)
	movl 16(%rbp) ,%eax
	movl -112(%rbp) ,%edx
	subl %edx, %eax
	movl %eax,-116(%rbp)
	xorq %rax ,%rax
	movl $4, %eax
	movl 32(%rbp,%rax,1) ,%edx
	movl %edx,-120(%rbp)
	movl -116(%rbp) ,%eax
	movl -120(%rbp) ,%edx
	imull %edx, %eax
	movl %eax,-120(%rbp)
	movl -120(%rbp) ,%eax
	movl -16(%rbp) ,%edx
	addl %edx, %eax
	movl %eax,-120(%rbp)
	movl -120(%rbp) ,%eax
	movl $8 ,%edx
	imull %edx, %eax
	movl %eax,-120(%rbp)
	movl -120(%rbp) ,%eax
	movl $8, %edx
	addl %edx, %eax
	movl %eax,-120(%rbp)
	xorq %rax ,%rax
	movl -120(%rbp) ,%eax
	movsd 32(%rbp,%rax,1) ,%xmm0
	movsd %xmm0,-128(%rbp)
	xorpd %xmm0,%xmm0
	movsd -128(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	call printFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-132(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -132(%rbp) ,%eax
	movl %eax,-12(%rbp)
	movq $.msg0 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-136(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -136(%rbp) ,%eax
	movl %eax,-12(%rbp)
	jmp .L56
.L54:
	movl 16(%rbp) ,%eax
	movl %eax,-140(%rbp)
	movl 16(%rbp) ,%eax
	movl $1, %edx
	subl %edx, %eax
	movl %eax,16(%rbp)
	jmp .L57
.L57:
	movl 24(%rbp) ,%eax
	cmpl %eax, -28(%rbp)
	jl .L58
	jmp .L67
	jmp .L60
.L58:
	movl $1, -144(%rbp)
	movl 16(%rbp) ,%eax
	movl -144(%rbp) ,%edx
	subl %edx, %eax
	movl %eax,-148(%rbp)
	movl -148(%rbp) ,%eax
	movl %eax,-16(%rbp)
.L64:
	movl -20(%rbp) ,%eax
	cmpl %eax, -16(%rbp)
	jge .L61
	jmp .L63
	jmp .L63
.L65:
	movl -16(%rbp) ,%eax
	movl $1, %edx
	subl %edx, %eax
	movl %eax,-16(%rbp)
	movl -16(%rbp) ,%eax
	movl %eax,-152(%rbp)
	jmp .L64
.L61:
	xorq %rax ,%rax
	movl $4, %eax
	movl 32(%rbp,%rax,1) ,%edx
	movl %edx,-156(%rbp)
	movl -16(%rbp) ,%eax
	movl -156(%rbp) ,%edx
	imull %edx, %eax
	movl %eax,-156(%rbp)
	movl -156(%rbp) ,%eax
	movl -28(%rbp) ,%edx
	addl %edx, %eax
	movl %eax,-156(%rbp)
	movl -156(%rbp) ,%eax
	movl $8 ,%edx
	imull %edx, %eax
	movl %eax,-156(%rbp)
	movl -156(%rbp) ,%eax
	movl $8, %edx
	addl %edx, %eax
	movl %eax,-156(%rbp)
	xorq %rax ,%rax
	movl -156(%rbp) ,%eax
	movsd 32(%rbp,%rax,1) ,%xmm0
	movsd %xmm0,-164(%rbp)
	xorpd %xmm0,%xmm0
	movsd -164(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	call printFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-168(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -168(%rbp) ,%eax
	movl %eax,-12(%rbp)
	movq $.msg0 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-172(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -172(%rbp) ,%eax
	movl %eax,-12(%rbp)
	jmp .L65
.L63:
	movl -28(%rbp) ,%eax
	movl %eax,-176(%rbp)
	movl -28(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-28(%rbp)
	jmp .L67
.L60:
	jmp .L67
.L38:
	leave
	ret
	.section	.rodata
t74:
	.long	0
	.long	1072693248
t75:
	.long	0
	.long	1073741824
t76:
	.long	0
	.long	1074266112
t77:
	.long	0
	.long	1074790400
t78:
	.long	0
	.long	1075052544
t79:
	.long	0
	.long	1075314688
t80:
	.long	0
	.long	1075576832
t81:
	.long	0
	.long	1075838976
t82:
	.long	0
	.long	1075970048
t83:
	.long	0
	.long	1076101120
t84:
	.long	0
	.long	1076232192
t85:
	.long	0
	.long	1076363264
	.text
	.globl	main
	.type	main, @function
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $580, %rsp
	movl $4, -116(%rbp)
	movl $3, -112(%rbp)
	movl $3, -396(%rbp)
	movl $4, -392(%rbp)
	movl $3, -500(%rbp)
	movl $4, -496(%rbp)
	movl $4, -8(%rbp)
	movl $3, -12(%rbp)
	movsd t74, %xmm0
	movsd %xmm0,-124(%rbp)
	movsd t75, %xmm0
	movsd %xmm0,-132(%rbp)
	movsd t76, %xmm0
	movsd %xmm0,-140(%rbp)
	movsd t77, %xmm0
	movsd %xmm0,-148(%rbp)
	movsd t78, %xmm0
	movsd %xmm0,-156(%rbp)
	movsd t79, %xmm0
	movsd %xmm0,-164(%rbp)
	movsd t80, %xmm0
	movsd %xmm0,-172(%rbp)
	movsd t81, %xmm0
	movsd %xmm0,-180(%rbp)
	movsd t82, %xmm0
	movsd %xmm0,-188(%rbp)
	movsd t83, %xmm0
	movsd %xmm0,-196(%rbp)
	movsd t84, %xmm0
	movsd %xmm0,-204(%rbp)
	movsd t85, %xmm0
	movsd %xmm0,-212(%rbp)
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
	xorq %rax ,%rax
	movl $80, %eax
	movsd -196(%rbp) ,%xmm0
	movsd %xmm0,-116(%rbp,%rax,1)
	xorq %rax ,%rax
	movl $88, %eax
	movsd -204(%rbp) ,%xmm0
	movsd %xmm0,-116(%rbp,%rax,1)
	xorq %rax ,%rax
	movl $96, %eax
	movsd -212(%rbp) ,%xmm0
	movsd %xmm0,-116(%rbp,%rax,1)
	movq $.msg1 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-224(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -224(%rbp) ,%eax
	movl %eax,-4(%rbp)
	movl $0, -228(%rbp)
	movl -228(%rbp) ,%eax
	movl %eax,-216(%rbp)
.L71:
	movl $4, -232(%rbp)
	movl -232(%rbp) ,%eax
	cmpl %eax, -216(%rbp)
	jl .L68
	jmp .L70
	jmp .L70
.L77:
	movl -216(%rbp) ,%eax
	movl %eax,-236(%rbp)
	movl -216(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-216(%rbp)
	jmp .L71
.L68:
	movl $0, -240(%rbp)
	movl -240(%rbp) ,%eax
	movl %eax,-220(%rbp)
.L75:
	movl $3, -244(%rbp)
	movl -244(%rbp) ,%eax
	cmpl %eax, -220(%rbp)
	jl .L72
	jmp .L74
	jmp .L74
.L76:
	movl -220(%rbp) ,%eax
	movl %eax,-248(%rbp)
	movl -220(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-220(%rbp)
	jmp .L75
.L72:
	xorq %rax ,%rax
	movl $4, %eax
	movl -116(%rbp,%rax,1) ,%edx
	movl %edx,-252(%rbp)
	movl -216(%rbp) ,%eax
	movl -252(%rbp) ,%edx
	imull %edx, %eax
	movl %eax,-252(%rbp)
	movl -252(%rbp) ,%eax
	movl -220(%rbp) ,%edx
	addl %edx, %eax
	movl %eax,-252(%rbp)
	movl -252(%rbp) ,%eax
	movl $8 ,%edx
	imull %edx, %eax
	movl %eax,-252(%rbp)
	movl -252(%rbp) ,%eax
	movl $8, %edx
	addl %edx, %eax
	movl %eax,-252(%rbp)
	xorq %rax ,%rax
	movl -252(%rbp) ,%eax
	movsd -116(%rbp,%rax,1) ,%xmm0
	movsd %xmm0,-260(%rbp)
	xorpd %xmm0,%xmm0
	movsd -260(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	call printFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-264(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -264(%rbp) ,%eax
	movl %eax,-4(%rbp)
	movq $.msg0 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-268(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -268(%rbp) ,%eax
	movl %eax,-4(%rbp)
	jmp .L76
.L74:
	movq $.msg2 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-272(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -272(%rbp) ,%eax
	movl %eax,-4(%rbp)
	jmp .L77
.L70:
	movq $.msg3 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-276(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -276(%rbp) ,%eax
	movl %eax,-4(%rbp)
	movl $4, -280(%rbp)
	movl $3, -284(%rbp)
	movsd -20(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -28(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -36(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -44(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -52(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -60(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -68(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -76(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -84(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -92(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -100(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -108(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	subq $8, %rsp
	movl -284(%rbp) ,%eax
	pushq %rax
	movl -280(%rbp) ,%eax
	pushq %rax
	call spiralPrint
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
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
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl $3, -288(%rbp)
	movl $4, -292(%rbp)
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
	jmp .LoopL88
.LoopL88:
	cmpl %r8d, %r10d
	jge .LoopL88899091
	movl $0, %r11d
	jmp .LoopL8889
.LoopL8889:
	cmpl %r9d, %r11d
	jge .LoopL888990
	movl %r11d, %r12d
	imull %r8d, %r12d
	addl %r10d, %r12d
	imull $8, %r12d
	movl %r10d, %r13d
	imull %r9d, %r13d
	addl %r11d, %r13d
	imull $8, %r13d
	movq -108(%rbp,%r13,1), %xmm0
	movq %xmm0, -492(%rbp,%r12,1)
	addl $1, %r11d
	jmp .LoopL8889
.LoopL888990:
	addl $1, %r10d
	jmp .LoopL88
.LoopL88899091:
	movsd -492(%rbp) ,%xmm0
	movsd %xmm0,-388(%rbp)
	movsd -484(%rbp) ,%xmm0
	movsd %xmm0,-380(%rbp)
	movsd -476(%rbp) ,%xmm0
	movsd %xmm0,-372(%rbp)
	movsd -468(%rbp) ,%xmm0
	movsd %xmm0,-364(%rbp)
	movsd -460(%rbp) ,%xmm0
	movsd %xmm0,-356(%rbp)
	movsd -452(%rbp) ,%xmm0
	movsd %xmm0,-348(%rbp)
	movsd -444(%rbp) ,%xmm0
	movsd %xmm0,-340(%rbp)
	movsd -436(%rbp) ,%xmm0
	movsd %xmm0,-332(%rbp)
	movsd -428(%rbp) ,%xmm0
	movsd %xmm0,-324(%rbp)
	movsd -420(%rbp) ,%xmm0
	movsd %xmm0,-316(%rbp)
	movsd -412(%rbp) ,%xmm0
	movsd %xmm0,-308(%rbp)
	movsd -404(%rbp) ,%xmm0
	movsd %xmm0,-300(%rbp)
	movq $.msg2 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-504(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -504(%rbp) ,%eax
	movl %eax,-4(%rbp)
	movq $.msg2 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-508(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -508(%rbp) ,%eax
	movl %eax,-4(%rbp)
	movq $.msg4 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-512(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -512(%rbp) ,%eax
	movl %eax,-4(%rbp)
	movl $0, -516(%rbp)
	movl -516(%rbp) ,%eax
	movl %eax,-216(%rbp)
.L81:
	movl $3, -520(%rbp)
	movl -520(%rbp) ,%eax
	cmpl %eax, -216(%rbp)
	jl .L78
	jmp .L80
	jmp .L80
.L87:
	movl -216(%rbp) ,%eax
	movl %eax,-524(%rbp)
	movl -216(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-216(%rbp)
	jmp .L81
.L78:
	movl $0, -528(%rbp)
	movl -528(%rbp) ,%eax
	movl %eax,-220(%rbp)
.L85:
	movl $4, -532(%rbp)
	movl -532(%rbp) ,%eax
	cmpl %eax, -220(%rbp)
	jl .L82
	jmp .L84
	jmp .L84
.L86:
	movl -220(%rbp) ,%eax
	movl %eax,-536(%rbp)
	movl -220(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-220(%rbp)
	jmp .L85
.L82:
	xorq %rax ,%rax
	movl $4, %eax
	movl -396(%rbp,%rax,1) ,%edx
	movl %edx,-540(%rbp)
	movl -216(%rbp) ,%eax
	movl -540(%rbp) ,%edx
	imull %edx, %eax
	movl %eax,-540(%rbp)
	movl -540(%rbp) ,%eax
	movl -220(%rbp) ,%edx
	addl %edx, %eax
	movl %eax,-540(%rbp)
	movl -540(%rbp) ,%eax
	movl $8 ,%edx
	imull %edx, %eax
	movl %eax,-540(%rbp)
	movl -540(%rbp) ,%eax
	movl $8, %edx
	addl %edx, %eax
	movl %eax,-540(%rbp)
	xorq %rax ,%rax
	movl -540(%rbp) ,%eax
	movsd -396(%rbp,%rax,1) ,%xmm0
	movsd %xmm0,-548(%rbp)
	xorpd %xmm0,%xmm0
	movsd -548(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	call printFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-552(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -552(%rbp) ,%eax
	movl %eax,-4(%rbp)
	movq $.msg0 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-556(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -556(%rbp) ,%eax
	movl %eax,-4(%rbp)
	jmp .L86
.L84:
	movq $.msg2 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-560(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -560(%rbp) ,%eax
	movl %eax,-4(%rbp)
	jmp .L87
.L80:
	movq $.msg5 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-564(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -564(%rbp) ,%eax
	movl %eax,-4(%rbp)
	movl $3, -568(%rbp)
	movl $4, -572(%rbp)
	movsd -300(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -308(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -316(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -324(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -332(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -340(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -348(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -356(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -364(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -372(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -380(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	movsd -388(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	subq $8, %rsp
	movl -572(%rbp) ,%eax
	pushq %rax
	movl -568(%rbp) ,%eax
	pushq %rax
	call spiralPrintTrans
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
	popq %rbx
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
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movq $.msg2 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-576(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -576(%rbp) ,%eax
	movl %eax,-4(%rbp)
	movl $0, -580(%rbp)
	movl -580(%rbp) ,%eax
	leave
	ret
