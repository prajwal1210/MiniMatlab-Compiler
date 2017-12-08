	.section	.rodata
.msg0:
	.string	"Enter an integer a:\n"
.msg6:
	.string	"Result of a after a<=(*b)%a : "
.msg4:
	.string	"Result of a after a<=(*b)*a : "
.msg5:
	.string	"Result of a after a<=(*b)/a : "
.msg2:
	.string	"Result of a after a<=*b+a : "
.msg8:
	.string	"Value of (*b) after ++a : "
.msg10:
	.string	"Value of (*b) after --a : "
.msg7:
	.string	"Value of (*b) after a++ : "
.msg9:
	.string	"Value of (*b) after a-- : "
.msg1:
	.string	"We have assigned a pointer b to a\n"
.msg3:
	.string	"\n"
.one:
	.long	0
	.long	1072693248
	.section	.rodata
	.text
	.globl	assign
	.type	assign, @function
assign:
	pushq %rbp
	movq %rsp, %rbp
	subq $0, %rsp
	movq 16(%rbp) ,%rax
	leave
	ret
	.section	.rodata
	.text
	.globl	main
	.type	main, @function
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $216, %rsp
	movq $.msg0 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-20(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -20(%rbp) ,%eax
	movl %eax,-16(%rbp)
	leaq -4(%rbp) ,%rax
	movq %rax,-28(%rbp)
	movq -28(%rbp) ,%rax
	pushq %rax
	movq %rax, %rdi
	call readInt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-32(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -32(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg1 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-36(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -36(%rbp) ,%eax
	movl %eax,-16(%rbp)
	leaq -4(%rbp) ,%rax
	movq %rax,-44(%rbp)
	movq -44(%rbp) ,%rax
	pushq %rax
	call assign
	popq %rbx
	xorq %rbx, %rbx
	movq %rax,-52(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movq -52(%rbp) ,%rax
	movq %rax,-12(%rbp)
	movq $.msg2 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-56(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -56(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq -12(%rbp), %rax
	movl (%rax) ,%edx
	movl %edx,-60(%rbp)
	movl -60(%rbp) ,%eax
	movl -4(%rbp) ,%edx
	addl %edx, %eax
	movl %eax,-64(%rbp)
	movl -64(%rbp) ,%eax
	movl %eax,-4(%rbp)
	movl -4(%rbp) ,%eax
	pushq %rax
	movl %eax, %edi
	call printInt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-68(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -68(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg3 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-72(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -72(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg4 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-76(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -76(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq -12(%rbp), %rax
	movl (%rax) ,%edx
	movl %edx,-80(%rbp)
	movl -80(%rbp) ,%eax
	movl -4(%rbp) ,%edx
	imull %edx, %eax
	movl %eax,-84(%rbp)
	movl -84(%rbp) ,%eax
	movl %eax,-4(%rbp)
	movl -4(%rbp) ,%eax
	pushq %rax
	movl %eax, %edi
	call printInt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-88(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -88(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg3 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-92(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -92(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg5 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-96(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -96(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq -12(%rbp), %rax
	movl (%rax) ,%edx
	movl %edx,-100(%rbp)
	xorq %rax ,%rax
	xorq %rcx ,%rcx
	movl -100(%rbp) ,%eax
	movl -4(%rbp) ,%ecx
	cltd
	idivl %ecx
	movl %eax,-104(%rbp)
	movl -104(%rbp) ,%eax
	movl %eax,-4(%rbp)
	movl -4(%rbp) ,%eax
	pushq %rax
	movl %eax, %edi
	call printInt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-108(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -108(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg3 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-112(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -112(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg6 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-116(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -116(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq -12(%rbp), %rax
	movl (%rax) ,%edx
	movl %edx,-120(%rbp)
	xorq %rax ,%rax
	xorq %rcx ,%rcx
	movl -120(%rbp) ,%eax
	movl -4(%rbp) ,%ecx
	cltd
	idivl %ecx
	movl %edx,-124(%rbp)
	movl -124(%rbp) ,%eax
	movl %eax,-4(%rbp)
	movl -4(%rbp) ,%eax
	pushq %rax
	movl %eax, %edi
	call printInt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-128(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -128(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg3 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-132(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -132(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg7 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-136(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -136(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movl -4(%rbp) ,%eax
	movl %eax,-140(%rbp)
	movl -4(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-4(%rbp)
	movq -12(%rbp), %rax
	movl (%rax) ,%edx
	movl %edx,-144(%rbp)
	movl -144(%rbp) ,%eax
	pushq %rax
	movl %eax, %edi
	call printInt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-148(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -148(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg3 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-152(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -152(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg8 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-156(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -156(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movl -4(%rbp) ,%eax
	movl $1, %edx
	addl %edx, %eax
	movl %eax,-4(%rbp)
	movl -4(%rbp) ,%eax
	movl %eax,-160(%rbp)
	movq -12(%rbp), %rax
	movl (%rax) ,%edx
	movl %edx,-164(%rbp)
	movl -164(%rbp) ,%eax
	pushq %rax
	movl %eax, %edi
	call printInt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-168(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -168(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg3 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-172(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -172(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg9 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-176(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -176(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movl -4(%rbp) ,%eax
	movl %eax,-180(%rbp)
	movl -4(%rbp) ,%eax
	movl $1, %edx
	subl %edx, %eax
	movl %eax,-4(%rbp)
	movq -12(%rbp), %rax
	movl (%rax) ,%edx
	movl %edx,-184(%rbp)
	movl -184(%rbp) ,%eax
	pushq %rax
	movl %eax, %edi
	call printInt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-188(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -188(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg3 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-192(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -192(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg10 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-196(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -196(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movl -4(%rbp) ,%eax
	movl $1, %edx
	subl %edx, %eax
	movl %eax,-4(%rbp)
	movl -4(%rbp) ,%eax
	movl %eax,-200(%rbp)
	movq -12(%rbp), %rax
	movl (%rax) ,%edx
	movl %edx,-204(%rbp)
	movl -204(%rbp) ,%eax
	pushq %rax
	movl %eax, %edi
	call printInt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-208(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -208(%rbp) ,%eax
	movl %eax,-16(%rbp)
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
	movl %eax,-16(%rbp)
	movl $1, -216(%rbp)
	movl -216(%rbp) ,%eax
	leave
	ret
