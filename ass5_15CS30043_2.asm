	.section	.rodata
.msg13:
	.string	"Difference of the two doubles :\n"
.msg4:
	.string	"Difference of the two integers :\n"
.msg15:
	.string	"Division of the two doubles :\n"
.msg10:
	.string	"Enter an double X:\n"
.msg11:
	.string	"Enter an double Y:\n"
.msg0:
	.string	"Enter an integer M:\n"
.msg1:
	.string	"Enter an integer n:\n"
.msg8:
	.string	"Factorial of M :\n"
.msg9:
	.string	"Factorial of N :\n"
.msg14:
	.string	"Product of the two doubles :\n"
.msg5:
	.string	"Product of the two integers :\n"
.msg6:
	.string	"Quotient of the two integers :\n"
.msg7:
	.string	"Remainder of the two integers :\n"
.msg12:
	.string	"Sum of the two doubles :\n"
.msg2:
	.string	"Sum of the two integers :\n"
.msg3:
	.string	"\n"
.one:
	.long	0
	.long	1072693248
	.section	.rodata
	.text
	.globl	fact
	.type	fact, @function
fact:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
	movl $1, -4(%rbp)
	movl -4(%rbp) ,%eax
	cmpl %eax, 16(%rbp)
	je .L0
	jmp .L1
	jmp .L4
.L0:
	movl $1, -8(%rbp)
	movl -8(%rbp) ,%eax
	leave
	ret
	jmp .L4
.L1:
	movl $1, -12(%rbp)
	movl 16(%rbp) ,%eax
	movl -12(%rbp) ,%edx
	subl %edx, %eax
	movl %eax,-16(%rbp)
	movl -16(%rbp) ,%eax
	pushq %rax
	call fact
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-20(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl 16(%rbp) ,%eax
	movl -20(%rbp) ,%edx
	imull %edx, %eax
	movl %eax,-24(%rbp)
	movl -24(%rbp) ,%eax
	leave
	ret
	jmp .L4
.L4:
	.section	.rodata
	.text
	.globl	sum
	.type	sum, @function
sum:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	movl 16(%rbp) ,%eax
	movl 24(%rbp) ,%edx
	addl %edx, %eax
	movl %eax,-8(%rbp)
	movl -8(%rbp) ,%eax
	movl %eax,-4(%rbp)
	movl -4(%rbp) ,%eax
	leave
	ret
	.section	.rodata
	.text
	.globl	sumchar
	.type	sumchar, @function
sumchar:
	pushq %rbp
	movq %rsp, %rbp
	subq $2, %rsp
	movzbq 16(%rbp) ,%rax
	movzbq 24(%rbp) ,%rdx
	addq %rdx, %rax
	movb %al,-2(%rbp)
	movzbq -2(%rbp) ,%rax
	movb %al,-1(%rbp)
	movzbq -1(%rbp) ,%rax
	leave
	ret
	.section	.rodata
	.text
	.globl	main
	.type	main, @function
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $302, %rsp
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
	leaq -8(%rbp) ,%rax
	movq %rax,-44(%rbp)
	movq -44(%rbp) ,%rax
	pushq %rax
	movq %rax, %rdi
	call readInt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-48(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -48(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movl -4(%rbp) ,%eax
	pushq %rax
	movl -8(%rbp) ,%eax
	pushq %rax
	call sum
	popq %rbx
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-52(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -52(%rbp) ,%eax
	movl %eax,-12(%rbp)
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
	movl -12(%rbp) ,%eax
	pushq %rax
	movl %eax, %edi
	call printInt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-60(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -60(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg3 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-64(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -64(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg4 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-68(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -68(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movl -4(%rbp) ,%eax
	movl -8(%rbp) ,%edx
	subl %edx, %eax
	movl %eax,-72(%rbp)
	movl -72(%rbp) ,%eax
	movl %eax,-12(%rbp)
	movl -12(%rbp) ,%eax
	pushq %rax
	movl %eax, %edi
	call printInt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-76(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -76(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg3 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-80(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -80(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg5 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-84(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -84(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movl -4(%rbp) ,%eax
	movl -8(%rbp) ,%edx
	imull %edx, %eax
	movl %eax,-88(%rbp)
	movl -88(%rbp) ,%eax
	movl %eax,-12(%rbp)
	movl -12(%rbp) ,%eax
	pushq %rax
	movl %eax, %edi
	call printInt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-92(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -92(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg3 ,%rax
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
	movq $.msg6 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-100(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -100(%rbp) ,%eax
	movl %eax,-16(%rbp)
	xorq %rax ,%rax
	xorq %rcx ,%rcx
	movl -4(%rbp) ,%eax
	movl -8(%rbp) ,%ecx
	cltd
	idivl %ecx
	movl %eax,-104(%rbp)
	movl -104(%rbp) ,%eax
	movl %eax,-12(%rbp)
	movl -12(%rbp) ,%eax
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
	movq $.msg7 ,%rax
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
	xorq %rax ,%rax
	xorq %rcx ,%rcx
	movl -4(%rbp) ,%eax
	movl -8(%rbp) ,%ecx
	cltd
	idivl %ecx
	movl %edx,-120(%rbp)
	movl -120(%rbp) ,%eax
	movl %eax,-12(%rbp)
	movl -12(%rbp) ,%eax
	pushq %rax
	movl %eax, %edi
	call printInt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-124(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -124(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg3 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-128(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -128(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg8 ,%rax
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
	movl -4(%rbp) ,%eax
	pushq %rax
	call fact
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-136(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -136(%rbp) ,%eax
	movl %eax,-12(%rbp)
	movl -12(%rbp) ,%eax
	pushq %rax
	movl %eax, %edi
	call printInt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-140(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -140(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg3 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-144(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -144(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg9 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-148(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -148(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movl -8(%rbp) ,%eax
	pushq %rax
	call fact
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-152(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -152(%rbp) ,%eax
	movl %eax,-12(%rbp)
	movl -12(%rbp) ,%eax
	pushq %rax
	movl %eax, %edi
	call printInt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-156(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -156(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg3 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-160(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -160(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movb $97, -162(%rbp)
	movzbq -162(%rbp) ,%rax
	movb %al,-161(%rbp)
	movb $98, -164(%rbp)
	movzbq -164(%rbp) ,%rax
	movb %al,-163(%rbp)
	movzbq -163(%rbp) ,%rax
	pushq %rax
	movzbq -161(%rbp) ,%rax
	pushq %rax
	call sumchar
	popq %rbx
	popq %rbx
	xorq %rbx, %rbx
	movb %al,-166(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movzbq -166(%rbp) ,%rax
	movb %al,-165(%rbp)
	movq $.msg10 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-194(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -194(%rbp) ,%eax
	movl %eax,-16(%rbp)
	leaq -174(%rbp) ,%rax
	movq %rax,-202(%rbp)
	movq -202(%rbp) ,%rax
	pushq %rax
	movq %rax, %rdi
	call readFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-206(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -206(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg11 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-210(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -210(%rbp) ,%eax
	movl %eax,-16(%rbp)
	leaq -182(%rbp) ,%rax
	movq %rax,-218(%rbp)
	movq -218(%rbp) ,%rax
	pushq %rax
	movq %rax, %rdi
	call readFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-222(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -222(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg12 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-226(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -226(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movsd -174(%rbp) ,%xmm0
	movsd -182(%rbp) ,%xmm1
	addsd %xmm1, %xmm0
	movsd %xmm0,-234(%rbp)
	movsd -234(%rbp) ,%xmm0
	movsd %xmm0,-190(%rbp)
	xorpd %xmm0,%xmm0
	movsd -190(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	call printFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-238(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -238(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg3 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-242(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -242(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg13 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-246(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -246(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movsd -174(%rbp) ,%xmm0
	movsd -182(%rbp) ,%xmm1
	subsd %xmm1, %xmm0
	movsd %xmm0,-254(%rbp)
	movsd -254(%rbp) ,%xmm0
	movsd %xmm0,-190(%rbp)
	xorpd %xmm0,%xmm0
	movsd -190(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	call printFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-258(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -258(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg3 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-262(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -262(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg14 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-266(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -266(%rbp) ,%eax
	movl %eax,-16(%rbp)
	xorpd %xmm0, %xmm0
	xorpd %xmm1, %xmm1
	movsd -174(%rbp) ,%xmm0
	movsd -182(%rbp) ,%xmm1
	mulsd %xmm1, %xmm0
	movsd %xmm0,-274(%rbp)
	xorpd %xmm0, %xmm0
	xorpd %xmm1, %xmm1
	movsd -274(%rbp) ,%xmm0
	movsd %xmm0,-190(%rbp)
	xorpd %xmm0,%xmm0
	movsd -190(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	call printFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-278(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -278(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg3 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-282(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -282(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg15 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-286(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -286(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movsd -174(%rbp) ,%xmm0
	movsd -182(%rbp) ,%xmm1
	divsd %xmm1, %xmm0
	movsd %xmm0,-294(%rbp)
	movsd -294(%rbp) ,%xmm0
	movsd %xmm0,-190(%rbp)
	xorpd %xmm0,%xmm0
	movsd -190(%rbp) ,%xmm0
	subq $8, %rsp
	movsd %xmm0, (%rsp) 
	call printFlt
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-298(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -298(%rbp) ,%eax
	movl %eax,-16(%rbp)
	movq $.msg3 ,%rax
	pushq %rax
	movq %rax, %rdi
	call printStr
	popq %rbx
	xorq %rbx, %rbx
	movl %eax,-302(%rbp)
	xorpd %xmm0, %xmm0
	xorq %rax, %rax
	movl -302(%rbp) ,%eax
	movl %eax,-16(%rbp)
	leave
	ret
