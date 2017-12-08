	.section	.rodata
.msg0:
	.string	"Enter an integer \n"
.msg1:
	.string	"Given number is = "
.msg3:
	.string	"Its reverse is  = "
.msg4:
	.string	"Number is a palindrome \n"
.msg5:
	.string	"Number is not a palindrome \n"
.msg2:
	.string	"\n"
.one:
	.long	0
	.long	1072693248
	.section	.rodata
	.text
	.globl	main
	.type	main, @function
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $104, %rsp
	movl $0, -20(%rbp)
	movl -20(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg0 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-28(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -28(%rbp) ,%eax
	movl %eax,-24(%rbp)
	leaq -4(%rbp) ,%rax
	movq %rax,-36(%rbp)
	movq -36(%rbp) ,%rax
	pushq %rax
	movq %rax, %rdi
	call readInt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-40(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -40(%rbp) ,%eax
	movl %eax,-24(%rbp)
	movl -4(%rbp) ,%eax
	movl %eax,-8(%rbp)
.L3:
	movl $0, -44(%rbp)
	movl -44(%rbp) ,%eax
	cmpl %eax, -8(%rbp)
	jg .L0
	jmp .L2
	jmp .L2
.L0:
	movl $10, -48(%rbp)
	xorq %rax ,%rax
	xorq %rcx ,%rcx
	movl -8(%rbp) ,%eax
	movl -48(%rbp) ,%ecx
	cltd
	idivl %ecx
	movl %edx,-52(%rbp)
	movl -52(%rbp) ,%eax
	movl %eax,-12(%rbp)
	movl $10, -56(%rbp)
	movl -16(%rbp) ,%eax
	movl -56(%rbp) ,%edx
	imull %edx, %eax
	movl %eax,-60(%rbp)
	movl -60(%rbp) ,%eax
	movl -12(%rbp) ,%edx
	addl %edx, %eax
	movl %eax,-64(%rbp)
	movl -64(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movl $10, -68(%rbp)
	xorq %rax ,%rax
	xorq %rcx ,%rcx
	movl -8(%rbp) ,%eax
	movl -68(%rbp) ,%ecx
	cltd
	idivl %ecx
	movl %eax,-72(%rbp)
	movl -72(%rbp) ,%eax
	movl %eax,-8(%rbp)
	jmp .L3
.L2:
	movq $.msg1 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-76(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -76(%rbp) ,%eax
	movl %eax,-24(%rbp)
	movl -4(%rbp) ,%eax
	pushq %rax
	movl %eax, %edi
	call printInt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-80(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -80(%rbp) ,%eax
	movl %eax,-24(%rbp)
	movq $.msg2 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-84(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -84(%rbp) ,%eax
	movl %eax,-24(%rbp)
	movq $.msg3 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-88(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -88(%rbp) ,%eax
	movl %eax,-24(%rbp)
	movl -16(%rbp) ,%eax
	pushq %rax
	movl %eax, %edi
	call printInt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-92(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -92(%rbp) ,%eax
	movl %eax,-24(%rbp)
	movq $.msg2 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-96(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -96(%rbp) ,%eax
	movl %eax,-24(%rbp)
	movl -16(%rbp) ,%eax
	cmpl %eax, -4(%rbp)
	je .L4
	jmp .L5
	jmp .L8
.L4:
	movq $.msg4 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-100(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -100(%rbp) ,%eax
	movl %eax,-24(%rbp)
	jmp .L8
.L5:
	movq $.msg5 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-104(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -104(%rbp) ,%eax
	movl %eax,-24(%rbp)
	jmp .L8
.L8:
	leave
	ret
