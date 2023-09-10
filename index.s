	.file	"index.c"
 # GNU C17 (Rev7, Built by MSYS2 project) version 13.1.0 (x86_64-w64-mingw32)
 #	compiled by GNU C version 13.1.0, GMP version 6.2.1, MPFR version 4.2.0-p9, MPC version 1.3.1, isl version isl-0.26-GMP

 # GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
 # options passed: -mtune=generic -march=nocona -g -O2
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.file 0 "C:/Users/Kyouma/reyuki/explore-c" "index.c"
	.section .rdata,"dr"
.LC0:
	.ascii "hello, world!\12\0"
	.text
	.p2align 4
	.def	printf.constprop.0;	.scl	3;	.type	32;	.endef
	.seh_proc	printf.constprop.0
printf.constprop.0:
.LVL0:
.LFB31:
	.file 1 "C:/msys64/mingw64/include/stdio.h"
	.loc 1 371 5 view -0
	.cfi_startproc
	.loc 1 371 5 is_stmt 0 view .LVU1
	pushq	%rbx	 #
	.seh_pushreg	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$48, %rsp	 #,
	.seh_stackalloc	48
	.cfi_def_cfa_offset 64
	.seh_endprologue
.LVL1:
	.loc 1 373 3 is_stmt 1 view .LVU2
	.loc 1 374 3 view .LVU3
	.loc 1 374 35 view .LVU4
 # C:/msys64/mingw64/include/stdio.h:375:   __retval = __mingw_vfprintf( stdout, __format, __local_argv );
	.loc 1 375 14 is_stmt 0 view .LVU5
	movl	$1, %ecx	 #,
.LVL2:
 # C:/msys64/mingw64/include/stdio.h:374:   __builtin_va_list __local_argv; __builtin_va_start( __local_argv, __format );
	.loc 1 374 35 view .LVU6
	leaq	72(%rsp), %rbx	 #, tmp86
 # C:/msys64/mingw64/include/stdio.h:371: int printf (const char *__format, ...)
	.loc 1 371 5 view .LVU7
	movq	%rdx, 72(%rsp)	 #,
	movq	%r8, 80(%rsp)	 #,
	movq	%r9, 88(%rsp)	 #,
 # C:/msys64/mingw64/include/stdio.h:374:   __builtin_va_list __local_argv; __builtin_va_start( __local_argv, __format );
	.loc 1 374 35 view .LVU8
	movq	%rbx, 40(%rsp)	 # tmp86, MEM[(char * *)&__local_argv]
	.loc 1 375 3 is_stmt 1 view .LVU9
 # C:/msys64/mingw64/include/stdio.h:375:   __retval = __mingw_vfprintf( stdout, __format, __local_argv );
	.loc 1 375 14 is_stmt 0 view .LVU10
	call	*__imp___acrt_iob_func(%rip)	 #
.LVL3:
 # C:/msys64/mingw64/include/stdio.h:375:   __retval = __mingw_vfprintf( stdout, __format, __local_argv );
	.loc 1 375 14 discriminator 1 view .LVU11
	movq	%rbx, %r8	 # tmp86,
	leaq	.LC0(%rip), %rdx	 #, tmp88
 # C:/msys64/mingw64/include/stdio.h:375:   __retval = __mingw_vfprintf( stdout, __format, __local_argv );
	.loc 1 375 14 view .LVU12
	movq	%rax, %rcx	 # tmp90, _2
 # C:/msys64/mingw64/include/stdio.h:375:   __retval = __mingw_vfprintf( stdout, __format, __local_argv );
	.loc 1 375 14 discriminator 1 view .LVU13
	call	__mingw_vfprintf	 #
.LVL4:
	.loc 1 376 3 is_stmt 1 view .LVU14
	.loc 1 377 3 view .LVU15
 # C:/msys64/mingw64/include/stdio.h:378: }
	.loc 1 378 1 is_stmt 0 view .LVU16
	addq	$48, %rsp	 #,
	.cfi_def_cfa_offset 16
	popq	%rbx	 #
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE31:
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section	.text.startup,"x"
	.p2align 4
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
.LFB30:
	.file 2 "index.c"
	.loc 2 3 12 is_stmt 1 view -0
	.cfi_startproc
	subq	$40, %rsp	 #,
	.seh_stackalloc	40
	.cfi_def_cfa_offset 48
	.seh_endprologue
 # index.c:3: int main() {
	.loc 2 3 12 is_stmt 0 view .LVU18
	call	__main	 #
.LVL5:
	.loc 2 4 5 is_stmt 1 view .LVU19
	leaq	.LC0(%rip), %rcx	 #, tmp83
	call	printf.constprop.0	 #
.LVL6:
	.loc 2 5 5 view .LVU20
 # index.c:6: }
	.loc 2 6 1 is_stmt 0 view .LVU21
	xorl	%eax, %eax	 #
	addq	$40, %rsp	 #,
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE30:
	.seh_endproc
	.text
.Letext0:
	.file 3 "C:/msys64/mingw64/include/vadefs.h"
	.section	.debug_info,"dr"
.Ldebug_info0:
	.long	0x358
	.word	0x5
	.byte	0x1
	.byte	0x8
	.secrel32	.Ldebug_abbrev0
	.uleb128 0xc
	.ascii "GNU C17 13.1.0 -mtune=generic -march=nocona -g -O2\0"
	.byte	0x1d
	.secrel32	.LASF0
	.secrel32	.LASF1
	.secrel32	.LLRL2
	.quad	0
	.secrel32	.Ldebug_line0
	.uleb128 0x5
	.ascii "__gnuc_va_list\0"
	.byte	0x3
	.byte	0x18
	.byte	0x1d
	.long	0x70
	.uleb128 0xd
	.byte	0x8
	.ascii "__builtin_va_list\0"
	.long	0x88
	.uleb128 0x1
	.byte	0x1
	.byte	0x6
	.ascii "char\0"
	.uleb128 0xe
	.long	0x88
	.uleb128 0x5
	.ascii "va_list\0"
	.byte	0x3
	.byte	0x1f
	.byte	0x1a
	.long	0x59
	.uleb128 0x1
	.byte	0x8
	.byte	0x7
	.ascii "long long unsigned int\0"
	.uleb128 0x1
	.byte	0x8
	.byte	0x5
	.ascii "long long int\0"
	.uleb128 0x1
	.byte	0x2
	.byte	0x7
	.ascii "short unsigned int\0"
	.uleb128 0x1
	.byte	0x4
	.byte	0x5
	.ascii "int\0"
	.uleb128 0x1
	.byte	0x4
	.byte	0x5
	.ascii "long int\0"
	.uleb128 0x6
	.long	0x88
	.uleb128 0x1
	.byte	0x4
	.byte	0x7
	.ascii "unsigned int\0"
	.uleb128 0x1
	.byte	0x4
	.byte	0x7
	.ascii "long unsigned int\0"
	.uleb128 0x1
	.byte	0x1
	.byte	0x8
	.ascii "unsigned char\0"
	.uleb128 0xf
	.ascii "_iobuf\0"
	.byte	0x30
	.byte	0x1
	.byte	0x21
	.byte	0xa
	.long	0x1bc
	.uleb128 0x2
	.ascii "_ptr\0"
	.byte	0x25
	.byte	0xb
	.long	0xf9
	.byte	0
	.uleb128 0x2
	.ascii "_cnt\0"
	.byte	0x26
	.byte	0x9
	.long	0xe6
	.byte	0x8
	.uleb128 0x2
	.ascii "_base\0"
	.byte	0x27
	.byte	0xb
	.long	0xf9
	.byte	0x10
	.uleb128 0x2
	.ascii "_flag\0"
	.byte	0x28
	.byte	0x9
	.long	0xe6
	.byte	0x18
	.uleb128 0x2
	.ascii "_file\0"
	.byte	0x29
	.byte	0x9
	.long	0xe6
	.byte	0x1c
	.uleb128 0x2
	.ascii "_charbuf\0"
	.byte	0x2a
	.byte	0x9
	.long	0xe6
	.byte	0x20
	.uleb128 0x2
	.ascii "_bufsiz\0"
	.byte	0x2b
	.byte	0x9
	.long	0xe6
	.byte	0x24
	.uleb128 0x2
	.ascii "_tmpfname\0"
	.byte	0x2c
	.byte	0xb
	.long	0xf9
	.byte	0x28
	.byte	0
	.uleb128 0x5
	.ascii "FILE\0"
	.byte	0x1
	.byte	0x2f
	.byte	0x19
	.long	0x134
	.uleb128 0x7
	.ascii "__mingw_vfprintf\0"
	.byte	0xc4
	.byte	0xf
	.long	0xe6
	.long	0x1f5
	.uleb128 0x3
	.long	0x1fa
	.uleb128 0x3
	.long	0x204
	.uleb128 0x3
	.long	0x95
	.byte	0
	.uleb128 0x6
	.long	0x1bc
	.uleb128 0x8
	.long	0x1f5
	.uleb128 0x6
	.long	0x90
	.uleb128 0x8
	.long	0x1ff
	.uleb128 0x7
	.ascii "__acrt_iob_func\0"
	.byte	0x5d
	.byte	0x17
	.long	0x1f5
	.long	0x22a
	.uleb128 0x3
	.long	0xfe
	.byte	0
	.uleb128 0x10
	.ascii "main\0"
	.byte	0x2
	.byte	0x3
	.byte	0x5
	.long	0xe6
	.quad	.LFB30
	.quad	.LFE30-.LFB30
	.uleb128 0x1
	.byte	0x9c
	.long	0x276
	.uleb128 0x11
	.quad	.LVL5
	.long	0x34c
	.uleb128 0x9
	.quad	.LVL6
	.long	0x2c5
	.uleb128 0x4
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x9
	.byte	0x3
	.quad	.LC0
	.byte	0
	.byte	0
	.uleb128 0x12
	.ascii "printf\0"
	.byte	0x1
	.word	0x173
	.byte	0x5
	.long	0xe6
	.byte	0x3
	.long	0x2c5
	.uleb128 0x13
	.ascii "__format\0"
	.byte	0x1
	.word	0x173
	.byte	0x19
	.long	0x1ff
	.uleb128 0xa
	.uleb128 0xb
	.ascii "__retval\0"
	.word	0x175
	.byte	0x7
	.long	0xe6
	.uleb128 0xb
	.ascii "__local_argv\0"
	.word	0x176
	.byte	0x15
	.long	0x70
	.byte	0
	.uleb128 0x14
	.long	0x276
	.quad	.LFB31
	.quad	.LFE31-.LFB31
	.uleb128 0x1
	.byte	0x9c
	.long	0x34c
	.uleb128 0x15
	.long	0x28b
	.secrel32	.LLST0
	.secrel32	.LVUS0
	.uleb128 0xa
	.uleb128 0x16
	.long	0x29e
	.secrel32	.LLST1
	.secrel32	.LVUS1
	.uleb128 0x17
	.long	0x2af
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x18
	.long	0x28b
	.uleb128 0xa
	.byte	0x3
	.quad	.LC0
	.byte	0x9f
	.uleb128 0x19
	.quad	.LVL3
	.long	0x209
	.long	0x32a
	.uleb128 0x4
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x1
	.byte	0x31
	.byte	0
	.uleb128 0x9
	.quad	.LVL4
	.long	0x1c9
	.uleb128 0x4
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x9
	.byte	0x3
	.quad	.LC0
	.uleb128 0x4
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.byte	0
	.uleb128 0x1a
	.ascii "__main\0"
	.ascii "__main\0"
	.byte	0
	.section	.debug_abbrev,"dr"
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x49
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x7e
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x37
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x48
	.byte	0x1
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0x8
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x48
	.byte	0
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x48
	.byte	0x1
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0x8
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loclists,"dr"
	.long	.Ldebug_loc3-.Ldebug_loc2
.Ldebug_loc2:
	.word	0x5
	.byte	0x8
	.byte	0
	.long	0
.Ldebug_loc0:
.LVUS0:
	.uleb128 0
	.uleb128 .LVU6
	.uleb128 .LVU6
	.uleb128 0
.LLST0:
	.byte	0x6
	.quad	.LVL0
	.byte	0x4
	.uleb128 .LVL0-.LVL0
	.uleb128 .LVL2-.LVL0
	.uleb128 0x1
	.byte	0x52
	.byte	0x4
	.uleb128 .LVL2-.LVL0
	.uleb128 .LFE31-.LVL0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.byte	0
.LVUS1:
	.uleb128 .LVU14
	.uleb128 0
.LLST1:
	.byte	0x8
	.quad	.LVL4
	.uleb128 .LFE31-.LVL4
	.uleb128 0x1
	.byte	0x50
	.byte	0
.Ldebug_loc3:
	.section	.debug_aranges,"dr"
	.long	0x3c
	.word	0x2
	.secrel32	.Ldebug_info0
	.byte	0x8
	.byte	0
	.word	0
	.word	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	.LFB30
	.quad	.LFE30-.LFB30
	.quad	0
	.quad	0
	.section	.debug_rnglists,"dr"
.Ldebug_ranges0:
	.long	.Ldebug_ranges3-.Ldebug_ranges2
.Ldebug_ranges2:
	.word	0x5
	.byte	0x8
	.byte	0
	.long	0
.LLRL2:
	.byte	0x7
	.quad	.Ltext0
	.uleb128 .Letext0-.Ltext0
	.byte	0x7
	.quad	.LFB30
	.uleb128 .LFE30-.LFB30
	.byte	0
.Ldebug_ranges3:
	.section	.debug_line,"dr"
.Ldebug_line0:
	.section	.debug_str,"dr"
	.section	.debug_line_str,"dr"
.LASF1:
	.ascii "C:\\Users\\Kyouma\\reyuki\\explore-c\0"
.LASF0:
	.ascii "index.c\0"
	.ident	"GCC: (Rev7, Built by MSYS2 project) 13.1.0"
	.def	__mingw_vfprintf;	.scl	2;	.type	32;	.endef
