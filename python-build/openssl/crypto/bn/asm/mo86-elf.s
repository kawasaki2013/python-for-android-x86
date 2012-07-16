





	.file	"mo-586.s"
.text
.globl	bn_mul_mont
.type	bn_mul_mont,@function
.align	16
bn_mul_mont:
	pushl	%ebp
	pushl	%ebx
	pushl	%esi
	pushl	%edi

	xorl	%eax,		%eax
	movl	40(%esp),	%edi
	cmpl	$4,		%edi
	jl	.L000just_leave
	leal	20(%esp),	%esi
	leal	24(%esp),	%edx
	movl	%esp,		%ebp
	addl	$2,		%edi
	negl	%edi
	leal	-32(%esp,%edi,4),%esp
	negl	%edi
	movl	%esp,		%eax
	subl	%edx,		%eax
	andl	$2047,		%eax
	subl	%eax,		%esp
	xorl	%esp,		%edx
	andl	$2048,		%edx
	xorl	$2048,		%edx
	subl	%edx,		%esp
	andl	$-64,		%esp
	movl	(%esi),		%eax
	movl	4(%esi),	%ebx
	movl	8(%esi),	%ecx
	movl	12(%esi),	%edx
	movl	16(%esi),	%esi
	movl	(%esi),		%esi
	movl	%eax,		4(%esp)
	movl	%ebx,		8(%esp)
	movl	%ecx,		12(%esp)
	movl	%edx,		16(%esp)
	movl	%esi,		20(%esp)
	leal	-3(%edi),	%ebx
	movl	%ebp,		24(%esp)
	movl	8(%esp),	%esi
	leal	1(%ebx),	%ebp
	movl	12(%esp),	%edi
	xorl	%ecx,		%ecx
	movl	%esi,		%edx
	andl	$1,		%ebp
	subl	%edi,		%edx
	leal	4(%edi,%ebx,4),	%eax
	orl	%edx,		%ebp
	movl	(%edi),		%edi
	jz	.L001bn_sqr_mont
	movl	%eax,		28(%esp)
	movl	(%esi),		%eax
	xorl	%edx,		%edx
.align	16
.L002mull:
	movl	%edx,		%ebp
	mull	%edi
	addl	%eax,		%ebp
	leal	1(%ecx),	%ecx
	adcl	$0,		%edx
	movl	(%esi,%ecx,4),	%eax
	cmpl	%ebx,		%ecx
	movl	%ebp,		28(%esp,%ecx,4)
	jl	.L002mull
	movl	%edx,		%ebp
	mull	%edi
	movl	20(%esp),	%edi
	addl	%ebp,		%eax
	movl	16(%esp),	%esi
	adcl	$0,		%edx
	imull	32(%esp),	%edi
	movl	%eax,		32(%esp,%ebx,4)
	xorl	%ecx,		%ecx
	movl	%edx,		36(%esp,%ebx,4)
	movl	%ecx,		40(%esp,%ebx,4)
	movl	(%esi),		%eax
	mull	%edi
	addl	32(%esp),	%eax
	movl	4(%esi),	%eax
	adcl	$0,		%edx
	incl	%ecx
	jmp	.L0032ndmadd
.align	16
.L0041stmadd:
	movl	%edx,		%ebp
	mull	%edi
	addl	32(%esp,%ecx,4),%ebp
	leal	1(%ecx),	%ecx
	adcl	$0,		%edx
	addl	%eax,		%ebp
	movl	(%esi,%ecx,4),	%eax
	adcl	$0,		%edx
	cmpl	%ebx,		%ecx
	movl	%ebp,		28(%esp,%ecx,4)
	jl	.L0041stmadd
	movl	%edx,		%ebp
	mull	%edi
	addl	32(%esp,%ebx,4),%eax
	movl	20(%esp),	%edi
	adcl	$0,		%edx
	movl	16(%esp),	%esi
	addl	%eax,		%ebp
	adcl	$0,		%edx
	imull	32(%esp),	%edi
	xorl	%ecx,		%ecx
	addl	36(%esp,%ebx,4),%edx
	movl	%ebp,		32(%esp,%ebx,4)
	adcl	$0,		%ecx
	movl	(%esi),		%eax
	movl	%edx,		36(%esp,%ebx,4)
	movl	%ecx,		40(%esp,%ebx,4)
	mull	%edi
	addl	32(%esp),	%eax
	movl	4(%esi),	%eax
	adcl	$0,		%edx
	movl	$1,		%ecx
.align	16
.L0032ndmadd:
	movl	%edx,		%ebp
	mull	%edi
	addl	32(%esp,%ecx,4),%ebp
	leal	1(%ecx),	%ecx
	adcl	$0,		%edx
	addl	%eax,		%ebp
	movl	(%esi,%ecx,4),	%eax
	adcl	$0,		%edx
	cmpl	%ebx,		%ecx
	movl	%ebp,		24(%esp,%ecx,4)
	jl	.L0032ndmadd
	movl	%edx,		%ebp
	mull	%edi
	addl	32(%esp,%ebx,4),%ebp
	adcl	$0,		%edx
	addl	%eax,		%ebp
	adcl	$0,		%edx
	movl	%ebp,		28(%esp,%ebx,4)
	xorl	%eax,		%eax
	movl	12(%esp),	%ecx
	addl	36(%esp,%ebx,4),%edx
	adcl	40(%esp,%ebx,4),%eax
	leal	4(%ecx),	%ecx
	movl	%edx,		32(%esp,%ebx,4)
	cmpl	28(%esp),	%ecx
	movl	%eax,		36(%esp,%ebx,4)
	je	.L005common_tail
	movl	(%ecx),		%edi
	movl	8(%esp),	%esi
	movl	%ecx,		12(%esp)
	xorl	%ecx,		%ecx
	xorl	%edx,		%edx
	movl	(%esi),		%eax
	jmp	.L0041stmadd
.align	16
.L001bn_sqr_mont:
	movl	%ebx,		(%esp)
	movl	%ecx,		12(%esp)
	movl	%edi,		%eax
	mull	%edi
	movl	%eax,		32(%esp)
	movl	%edx,		%ebx
.byte 209
.byte 234	
	andl	$1,		%ebx
	incl	%ecx
.align	16
.L006sqr:
	movl	(%esi,%ecx,4),	%eax
	movl	%edx,		%ebp
	mull	%edi
	addl	%ebp,		%eax
	leal	1(%ecx),	%ecx
	adcl	$0,		%edx
	leal	(%ebx,%eax,2),	%ebp
	shrl	$31,		%eax
	cmpl	(%esp),		%ecx
	movl	%eax,		%ebx
	movl	%ebp,		28(%esp,%ecx,4)
	jl	.L006sqr
	movl	(%esi,%ecx,4),	%eax
	movl	%edx,		%ebp
	mull	%edi
	addl	%ebp,		%eax
	movl	20(%esp),	%edi
	adcl	$0,		%edx
	movl	16(%esp),	%esi
	leal	(%ebx,%eax,2),	%ebp
	imull	32(%esp),	%edi
	shrl	$31,		%eax
	movl	%ebp,		32(%esp,%ecx,4)
	leal	(%eax,%edx,2),	%ebp
	movl	(%esi),		%eax
	shrl	$31,		%edx
	movl	%ebp,		36(%esp,%ecx,4)
	movl	%edx,		40(%esp,%ecx,4)
	mull	%edi
	addl	32(%esp),	%eax
	movl	%ecx,		%ebx
	adcl	$0,		%edx
	movl	4(%esi),	%eax
	movl	$1,		%ecx
.align	16
.L0073rdmadd:
	movl	%edx,		%ebp
	mull	%edi
	addl	32(%esp,%ecx,4),%ebp
	adcl	$0,		%edx
	addl	%eax,		%ebp
	movl	4(%esi,%ecx,4),	%eax
	adcl	$0,		%edx
	movl	%ebp,		28(%esp,%ecx,4)
	movl	%edx,		%ebp
	mull	%edi
	addl	36(%esp,%ecx,4),%ebp
	leal	2(%ecx),	%ecx
	adcl	$0,		%edx
	addl	%eax,		%ebp
	movl	(%esi,%ecx,4),	%eax
	adcl	$0,		%edx
	cmpl	%ebx,		%ecx
	movl	%ebp,		24(%esp,%ecx,4)
	jl	.L0073rdmadd
	movl	%edx,		%ebp
	mull	%edi
	addl	32(%esp,%ebx,4),%ebp
	adcl	$0,		%edx
	addl	%eax,		%ebp
	adcl	$0,		%edx
	movl	%ebp,		28(%esp,%ebx,4)
	movl	12(%esp),	%ecx
	xorl	%eax,		%eax
	movl	8(%esp),	%esi
	addl	36(%esp,%ebx,4),%edx
	adcl	40(%esp,%ebx,4),%eax
	movl	%edx,		32(%esp,%ebx,4)
	cmpl	%ebx,		%ecx
	movl	%eax,		36(%esp,%ebx,4)
	je	.L005common_tail
	movl	4(%esi,%ecx,4),	%edi
	leal	1(%ecx),	%ecx
	movl	%edi,		%eax
	movl	%ecx,		12(%esp)
	mull	%edi
	addl	32(%esp,%ecx,4),%eax
	adcl	$0,		%edx
	movl	%eax,		32(%esp,%ecx,4)
	xorl	%ebp,		%ebp
	cmpl	%ebx,		%ecx
	leal	1(%ecx),	%ecx
	je	.L008sqrlast
	movl	%edx,		%ebx
.byte 209
.byte 234	
	andl	$1,		%ebx
.align	16
.L009sqradd:
	movl	(%esi,%ecx,4),	%eax
	movl	%edx,		%ebp
	mull	%edi
	addl	%ebp,		%eax
	leal	(%eax,%eax),	%ebp
	adcl	$0,		%edx
	shrl	$31,		%eax
	addl	32(%esp,%ecx,4),%ebp
	leal	1(%ecx),	%ecx
	adcl	$0,		%eax
	addl	%ebx,		%ebp
	adcl	$0,		%eax
	cmpl	(%esp),		%ecx
	movl	%ebp,		28(%esp,%ecx,4)
	movl	%eax,		%ebx
	jle	.L009sqradd
	movl	%edx,		%ebp
	leal	(%ebx,%edx,2),	%edx
	shrl	$31,		%ebp
.L008sqrlast:
	movl	20(%esp),	%edi
	movl	16(%esp),	%esi
	imull	32(%esp),	%edi
	addl	32(%esp,%ecx,4),%edx
	movl	(%esi),		%eax
	adcl	$0,		%ebp
	movl	%edx,		32(%esp,%ecx,4)
	movl	%ebp,		36(%esp,%ecx,4)
	mull	%edi
	addl	32(%esp),	%eax
	leal	-1(%ecx),	%ebx
	adcl	$0,		%edx
	movl	$1,		%ecx
	movl	4(%esi),	%eax
	jmp	.L0073rdmadd
.align	16
.L005common_tail:
	movl	16(%esp),	%ebp
	movl	4(%esp),	%edi
	leal	32(%esp),	%esi
	movl	(%esi),		%eax
	movl	%ebx,		%ecx
	xorl	%edx,		%edx
.align	16
.L010sub:
	sbbl	(%ebp,%edx,4),	%eax
	movl	%eax,		(%edi,%edx,4)
	decl	%ecx
	movl	4(%esi,%edx,4),	%eax
	leal	1(%edx),	%edx
	jge	.L010sub
	sbbl	$0,		%eax
	andl	%eax,		%esi
	notl	%eax
	movl	%edi,		%ebp
	andl	%eax,		%ebp
	orl	%ebp,		%esi
.align	16
.L011copy:
	movl	(%esi,%ebx,4),	%eax
	movl	%eax,		(%edi,%ebx,4)
	movl	%ecx,		32(%esp,%ebx,4)
	decl	%ebx
	jge	.L011copy
	movl	24(%esp),	%esp
	movl	$1,		%eax
.L000just_leave:
	popl	%edi
	popl	%esi
	popl	%ebx
	popl	%ebp
	ret
.L_bn_mul_mont_end:
.size	bn_mul_mont,.L_bn_mul_mont_end-bn_mul_mont
.ident	"bn_mul_mont"
	.byte	77,111,110,116,103,111,109,101,114,121,32,77,117,108,116,105
	.byte	112,108,105,99,97,116,105,111,110,32,102,111,114,32,120,56
	.byte	54,44,32,67,82,89,80,84,79,71,65,77,83,32,98,121
	.byte	32,60,97,112,112,114,111,64,111,112,101,110,115,115,108,46
	.byte	111,114,103,62,0
