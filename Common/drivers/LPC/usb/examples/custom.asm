
custom.elf:     file format elf32-littlearm

Disassembly of section .text:

00000000 <_startup>:
       0:	e59ff018 	ldr	pc, [pc, #24]	; 20 <Reset_Addr>
       4:	e59ff018 	ldr	pc, [pc, #24]	; 24 <Undef_Addr>
       8:	e59ff018 	ldr	pc, [pc, #24]	; 28 <SWI_Addr>
       c:	e59ff018 	ldr	pc, [pc, #24]	; 2c <PAbt_Addr>
      10:	e59ff018 	ldr	pc, [pc, #24]	; 30 <DAbt_Addr>
      14:	e1a00000 	nop			(mov r0,r0)
      18:	e51ff120 	ldr	pc, [pc, #-288]	; ffffff00 <_stack_end+0xbfff8024>
      1c:	e59ff014 	ldr	pc, [pc, #20]	; 38 <FIQ_Addr>

00000020 <Reset_Addr>:
      20:	00000040 	andeq	r0, r0, r0, asr #32

00000024 <Undef_Addr>:
      24:	000000e4 	andeq	r0, r0, r4, ror #1

00000028 <SWI_Addr>:
      28:	000000e0 	andeq	r0, r0, r0, ror #1

0000002c <PAbt_Addr>:
      2c:	000000e4 	andeq	r0, r0, r4, ror #1

00000030 <DAbt_Addr>:
      30:	000000e4 	andeq	r0, r0, r4, ror #1

00000034 <IRQ_Addr>:
      34:	000000d8 	ldreqd	r0, [r0], -r8

00000038 <FIQ_Addr>:
      38:	000000dc 	ldreqd	r0, [r0], -ip
      3c:	00000000 	andeq	r0, r0, r0

00000040 <Reset_Handler>:
      40:	e59f0078 	ldr	r0, [pc, #120]	; c0 <.text+0xc0>
      44:	e321f0db 	msr	CPSR_c, #219	; 0xdb
      48:	e1a0d000 	mov	sp, r0
      4c:	e2400040 	sub	r0, r0, #64	; 0x40
      50:	e321f0d7 	msr	CPSR_c, #215	; 0xd7
      54:	e1a0d000 	mov	sp, r0
      58:	e2400040 	sub	r0, r0, #64	; 0x40
      5c:	e321f0d1 	msr	CPSR_c, #209	; 0xd1
      60:	e1a0d000 	mov	sp, r0
      64:	e2400040 	sub	r0, r0, #64	; 0x40
      68:	e321f0d2 	msr	CPSR_c, #210	; 0xd2
      6c:	e1a0d000 	mov	sp, r0
      70:	e2400c01 	sub	r0, r0, #256	; 0x100
      74:	e321f0d3 	msr	CPSR_c, #211	; 0xd3
      78:	e1a0d000 	mov	sp, r0
      7c:	e2400b01 	sub	r0, r0, #1024	; 0x400
      80:	e321f0df 	msr	CPSR_c, #223	; 0xdf
      84:	e1a0d000 	mov	sp, r0
      88:	e59f1034 	ldr	r1, [pc, #52]	; c4 <.text+0xc4>
      8c:	e59f2034 	ldr	r2, [pc, #52]	; c8 <.text+0xc8>
      90:	e59f3034 	ldr	r3, [pc, #52]	; cc <.text+0xcc>
      94:	e1520003 	cmp	r2, r3
      98:	34910004 	ldrcc	r0, [r1], #4
      9c:	34820004 	strcc	r0, [r2], #4
      a0:	3afffffb 	bcc	94 <I_BIT+0x14>
      a4:	e3a00000 	mov	r0, #0	; 0x0
      a8:	e59f1020 	ldr	r1, [pc, #32]	; d0 <.text+0xd0>
      ac:	e59f2020 	ldr	r2, [pc, #32]	; d4 <.text+0xd4>
      b0:	e1510002 	cmp	r1, r2
      b4:	34810004 	strcc	r0, [r1], #4
      b8:	3afffffc 	bcc	b0 <I_BIT+0x30>
      bc:	ea0001a6 	b	75c <main>
      c0:	40007edc 	ldrmid	r7, [r0], -ip
      c4:	00001ef8 	streqd	r1, [r0], -r8
      c8:	40000200 	andmi	r0, r0, r0, lsl #4
      cc:	40000200 	andmi	r0, r0, r0, lsl #4
      d0:	40000200 	andmi	r0, r0, r0, lsl #4
      d4:	400002a0 	andmi	r0, r0, r0, lsr #5

000000d8 <IRQ_Routine>:
      d8:	eafffffe 	b	d8 <IRQ_Routine>

000000dc <FIQ_Routine>:
      dc:	eafffffe 	b	dc <FIQ_Routine>

000000e0 <SWI_Routine>:
      e0:	eafffffe 	b	e0 <SWI_Routine>

000000e4 <UNDEF_Routine>:
      e4:	eafffffe 	b	e4 <UNDEF_Routine>

000000e8 <HalSysPinSelect>:
      e8:	e20020ff 	and	r2, r0, #255	; 0xff
      ec:	e352000f 	cmp	r2, #15	; 0xf
      f0:	e201c0ff 	and	ip, r1, #255	; 0xff
      f4:	8a000007 	bhi	118 <IRQ_STACK_SIZE+0x18>
      f8:	e59f0040 	ldr	r0, [pc, #64]	; 140 <.text+0x140>
      fc:	e5903000 	ldr	r3, [r0]
     100:	e1a01082 	mov	r1, r2, lsl #1
     104:	e3a02003 	mov	r2, #3	; 0x3
     108:	e1c33112 	bic	r3, r3, r2, lsl r1
     10c:	e183311c 	orr	r3, r3, ip, lsl r1
     110:	e5803000 	str	r3, [r0]
     114:	e12fff1e 	bx	lr
     118:	e59f0020 	ldr	r0, [pc, #32]	; 140 <.text+0x140>
     11c:	e2422010 	sub	r2, r2, #16	; 0x10
     120:	e5903004 	ldr	r3, [r0, #4]
     124:	e20220ff 	and	r2, r2, #255	; 0xff
     128:	e1a02082 	mov	r2, r2, lsl #1
     12c:	e3a01003 	mov	r1, #3	; 0x3
     130:	e1c33211 	bic	r3, r3, r1, lsl r2
     134:	e183321c 	orr	r3, r3, ip, lsl r2
     138:	e5803004 	str	r3, [r0, #4]
     13c:	e12fff1e 	bx	lr
     140:	e002c000 	and	ip, r2, r0

00000144 <HalSysGetCCLK>:
     144:	e59f0000 	ldr	r0, [pc, #0]	; 14c <.text+0x14c>
     148:	e12fff1e 	bx	lr
     14c:	03938700 	orreqs	r8, r3, #0	; 0x0

00000150 <HalSysGetPCLK>:
     150:	e59f0000 	ldr	r0, [pc, #0]	; 158 <.text+0x158>
     154:	e12fff1e 	bx	lr
     158:	03938700 	orreqs	r8, r3, #0	; 0x0

0000015c <HalPinSelect>:
     15c:	e20020ff 	and	r2, r0, #255	; 0xff
     160:	e352000f 	cmp	r2, #15	; 0xf
     164:	e201c0ff 	and	ip, r1, #255	; 0xff
     168:	8a000007 	bhi	18c <HalPinSelect+0x30>
     16c:	e59f0040 	ldr	r0, [pc, #64]	; 1b4 <.text+0x1b4>
     170:	e5903000 	ldr	r3, [r0]
     174:	e1a01082 	mov	r1, r2, lsl #1
     178:	e3a02003 	mov	r2, #3	; 0x3
     17c:	e1c33112 	bic	r3, r3, r2, lsl r1
     180:	e183311c 	orr	r3, r3, ip, lsl r1
     184:	e5803000 	str	r3, [r0]
     188:	e12fff1e 	bx	lr
     18c:	e59f0020 	ldr	r0, [pc, #32]	; 1b4 <.text+0x1b4>
     190:	e2422010 	sub	r2, r2, #16	; 0x10
     194:	e5903004 	ldr	r3, [r0, #4]
     198:	e20220ff 	and	r2, r2, #255	; 0xff
     19c:	e1a02082 	mov	r2, r2, lsl #1
     1a0:	e3a01003 	mov	r1, #3	; 0x3
     1a4:	e1c33211 	bic	r3, r3, r1, lsl r2
     1a8:	e183321c 	orr	r3, r3, ip, lsl r2
     1ac:	e5803004 	str	r3, [r0, #4]
     1b0:	e12fff1e 	bx	lr
     1b4:	e002c000 	and	ip, r2, r0

000001b8 <HalSysInit>:
     1b8:	e59f3064 	ldr	r3, [pc, #100]	; 224 <.text+0x224>
     1bc:	e3a02024 	mov	r2, #36	; 0x24
     1c0:	e5832084 	str	r2, [r3, #132]
     1c4:	e3a010aa 	mov	r1, #170	; 0xaa
     1c8:	e3a00055 	mov	r0, #85	; 0x55
     1cc:	e3a02001 	mov	r2, #1	; 0x1
     1d0:	e583108c 	str	r1, [r3, #140]
     1d4:	e583008c 	str	r0, [r3, #140]
     1d8:	e5832080 	str	r2, [r3, #128]
     1dc:	e583108c 	str	r1, [r3, #140]
     1e0:	e583008c 	str	r0, [r3, #140]
     1e4:	e1a01003 	mov	r1, r3
     1e8:	e5913088 	ldr	r3, [r1, #136]
     1ec:	e3130b01 	tst	r3, #1024	; 0x400
     1f0:	0afffffc 	beq	1e8 <HalSysInit+0x30>
     1f4:	e3a02003 	mov	r2, #3	; 0x3
     1f8:	e3a030aa 	mov	r3, #170	; 0xaa
     1fc:	e5812080 	str	r2, [r1, #128]
     200:	e581308c 	str	r3, [r1, #140]
     204:	e3a03055 	mov	r3, #85	; 0x55
     208:	e581308c 	str	r3, [r1, #140]
     20c:	e3a03002 	mov	r3, #2	; 0x2
     210:	e5812004 	str	r2, [r1, #4]
     214:	e5813000 	str	r3, [r1]
     218:	e3a03001 	mov	r3, #1	; 0x1
     21c:	e5813100 	str	r3, [r1, #256]
     220:	e12fff1e 	bx	lr
     224:	e01fc000 	ands	ip, pc, r0

00000228 <printchar>:
     228:	e3500000 	cmp	r0, #0	; 0x0
     22c:	0a000005 	beq	248 <printchar+0x20>
     230:	e5903000 	ldr	r3, [r0]
     234:	e5c31000 	strb	r1, [r3]
     238:	e5903000 	ldr	r3, [r0]
     23c:	e2833001 	add	r3, r3, #1	; 0x1
     240:	e5803000 	str	r3, [r0]
     244:	e12fff1e 	bx	lr
     248:	e1a00001 	mov	r0, r1
     24c:	ea00011f 	b	6d0 <putchar>

00000250 <prints>:
     250:	e92d41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
     254:	e2524000 	subs	r4, r2, #0	; 0x0
     258:	e1a07000 	mov	r7, r0
     25c:	e1a05001 	mov	r5, r1
     260:	c3a02000 	movgt	r2, #0	; 0x0
     264:	ca000001 	bgt	270 <prints+0x20>
     268:	ea000009 	b	294 <prints+0x44>
     26c:	e2822001 	add	r2, r2, #1	; 0x1
     270:	e7d21005 	ldrb	r1, [r2, r5]
     274:	e3510000 	cmp	r1, #0	; 0x0
     278:	1afffffb 	bne	26c <prints+0x1c>
     27c:	e1520004 	cmp	r2, r4
     280:	a1a04001 	movge	r4, r1
     284:	b0624004 	rsblt	r4, r2, r4
     288:	e3130002 	tst	r3, #2	; 0x2
     28c:	13a08030 	movne	r8, #48	; 0x30
     290:	1a000000 	bne	298 <prints+0x48>
     294:	e3a08020 	mov	r8, #32	; 0x20
     298:	e2130001 	ands	r0, r3, #1	; 0x1
     29c:	13a06000 	movne	r6, #0	; 0x0
     2a0:	01a06000 	moveq	r6, r0
     2a4:	0a000003 	beq	2b8 <prints+0x68>
     2a8:	ea000009 	b	2d4 <prints+0x84>
     2ac:	ebffffdd 	bl	228 <printchar>
     2b0:	e2866001 	add	r6, r6, #1	; 0x1
     2b4:	e2444001 	sub	r4, r4, #1	; 0x1
     2b8:	e3540000 	cmp	r4, #0	; 0x0
     2bc:	e1a00007 	mov	r0, r7
     2c0:	e1a01008 	mov	r1, r8
     2c4:	cafffff8 	bgt	2ac <prints+0x5c>
     2c8:	ea000001 	b	2d4 <prints+0x84>
     2cc:	ebffffd5 	bl	228 <printchar>
     2d0:	e2866001 	add	r6, r6, #1	; 0x1
     2d4:	e5d53000 	ldrb	r3, [r5]
     2d8:	e2531000 	subs	r1, r3, #0	; 0x0
     2dc:	e1a00007 	mov	r0, r7
     2e0:	e2855001 	add	r5, r5, #1	; 0x1
     2e4:	1afffff8 	bne	2cc <prints+0x7c>
     2e8:	ea000001 	b	2f4 <prints+0xa4>
     2ec:	ebffffcd 	bl	228 <printchar>
     2f0:	e2866001 	add	r6, r6, #1	; 0x1
     2f4:	e3540000 	cmp	r4, #0	; 0x0
     2f8:	e1a00007 	mov	r0, r7
     2fc:	e1a01008 	mov	r1, r8
     300:	e2444001 	sub	r4, r4, #1	; 0x1
     304:	cafffff8 	bgt	2ec <prints+0x9c>
     308:	e1a00006 	mov	r0, r6
     30c:	e8bd81f0 	ldmia	sp!, {r4, r5, r6, r7, r8, pc}

00000310 <printi>:
     310:	e92d4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
     314:	e2514000 	subs	r4, r1, #0	; 0x0
     318:	e24dd00c 	sub	sp, sp, #12	; 0xc
     31c:	e1a06002 	mov	r6, r2
     320:	e1a0b000 	mov	fp, r0
     324:	e28d7030 	add	r7, sp, #48	; 0x30
     328:	e8970280 	ldmia	r7, {r7, r9}
     32c:	1a000007 	bne	350 <printi+0x40>
     330:	e3a0c030 	mov	ip, #48	; 0x30
     334:	e1a02007 	mov	r2, r7
     338:	e1a03009 	mov	r3, r9
     33c:	e1a0100d 	mov	r1, sp
     340:	e5cdc000 	strb	ip, [sp]
     344:	e5cd4001 	strb	r4, [sp, #1]
     348:	ebffffc0 	bl	250 <prints>
     34c:	ea000037 	b	430 <SVC_STACK_SIZE+0x30>
     350:	e2533000 	subs	r3, r3, #0	; 0x0
     354:	13a03001 	movne	r3, #1	; 0x1
     358:	e352000a 	cmp	r2, #10	; 0xa
     35c:	13a03000 	movne	r3, #0	; 0x0
     360:	e3530000 	cmp	r3, #0	; 0x0
     364:	0a000003 	beq	378 <printi+0x68>
     368:	e3540000 	cmp	r4, #0	; 0x0
     36c:	b2644000 	rsblt	r4, r4, #0	; 0x0
     370:	b3a08001 	movlt	r8, #1	; 0x1
     374:	ba000000 	blt	37c <printi+0x6c>
     378:	e3a08000 	mov	r8, #0	; 0x0
     37c:	e59d3038 	ldr	r3, [sp, #56]
     380:	e28d200b 	add	r2, sp, #11	; 0xb
     384:	e243a03a 	sub	sl, r3, #58	; 0x3a
     388:	e3a03000 	mov	r3, #0	; 0x0
     38c:	e5cd300b 	strb	r3, [sp, #11]
     390:	ea00000a 	b	3c0 <printi+0xb0>
     394:	eb0005c3 	bl	1aa8 <__umodsi3>
     398:	e1a03000 	mov	r3, r0
     39c:	e3530009 	cmp	r3, #9	; 0x9
     3a0:	c083300a 	addgt	r3, r3, sl
     3a4:	e2833030 	add	r3, r3, #48	; 0x30
     3a8:	e1a00004 	mov	r0, r4
     3ac:	e5653001 	strb	r3, [r5, #-1]!
     3b0:	e1a01006 	mov	r1, r6
     3b4:	eb000577 	bl	1998 <__aeabi_uidiv>
     3b8:	e1a02005 	mov	r2, r5
     3bc:	e1a04000 	mov	r4, r0
     3c0:	e3540000 	cmp	r4, #0	; 0x0
     3c4:	e1a00004 	mov	r0, r4
     3c8:	e1a01006 	mov	r1, r6
     3cc:	e1a05002 	mov	r5, r2
     3d0:	1affffef 	bne	394 <printi+0x84>
     3d4:	e3580000 	cmp	r8, #0	; 0x0
     3d8:	01a04008 	moveq	r4, r8
     3dc:	0a00000d 	beq	418 <SVC_STACK_SIZE+0x18>
     3e0:	e3570000 	cmp	r7, #0	; 0x0
     3e4:	0a000007 	beq	408 <SVC_STACK_SIZE+0x8>
     3e8:	e3190002 	tst	r9, #2	; 0x2
     3ec:	0a000005 	beq	408 <SVC_STACK_SIZE+0x8>
     3f0:	e1a0000b 	mov	r0, fp
     3f4:	e3a0102d 	mov	r1, #45	; 0x2d
     3f8:	ebffff8a 	bl	228 <printchar>
     3fc:	e2477001 	sub	r7, r7, #1	; 0x1
     400:	e3a04001 	mov	r4, #1	; 0x1
     404:	ea000003 	b	418 <SVC_STACK_SIZE+0x18>
     408:	e3a0302d 	mov	r3, #45	; 0x2d
     40c:	e5423001 	strb	r3, [r2, #-1]
     410:	e2425001 	sub	r5, r2, #1	; 0x1
     414:	e3a04000 	mov	r4, #0	; 0x0
     418:	e1a0000b 	mov	r0, fp
     41c:	e1a01005 	mov	r1, r5
     420:	e1a02007 	mov	r2, r7
     424:	e1a03009 	mov	r3, r9
     428:	ebffff88 	bl	250 <prints>
     42c:	e0800004 	add	r0, r0, r4
     430:	e28dd00c 	add	sp, sp, #12	; 0xc
     434:	e8bd8ff0 	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}

00000438 <print>:
     438:	e92d4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
     43c:	e3a05000 	mov	r5, #0	; 0x0
     440:	e24dd014 	sub	sp, sp, #20	; 0x14
     444:	e1a06000 	mov	r6, r0
     448:	e1a04001 	mov	r4, r1
     44c:	e1a07005 	mov	r7, r5
     450:	e3a0a00a 	mov	sl, #10	; 0xa
     454:	e28db012 	add	fp, sp, #18	; 0x12
     458:	e3a08061 	mov	r8, #97	; 0x61
     45c:	e3a09041 	mov	r9, #65	; 0x41
     460:	e58d200c 	str	r2, [sp, #12]
     464:	ea000060 	b	5ec <print+0x1b4>
     468:	e3530025 	cmp	r3, #37	; 0x25
     46c:	1a000059 	bne	5d8 <print+0x1a0>
     470:	e5f43001 	ldrb	r3, [r4, #1]!
     474:	e3530000 	cmp	r3, #0	; 0x0
     478:	0a00005e 	beq	5f8 <print+0x1c0>
     47c:	e3530025 	cmp	r3, #37	; 0x25
     480:	0a000054 	beq	5d8 <print+0x1a0>
     484:	e353002d 	cmp	r3, #45	; 0x2d
     488:	11a00007 	movne	r0, r7
     48c:	02844001 	addeq	r4, r4, #1	; 0x1
     490:	03a00001 	moveq	r0, #1	; 0x1
     494:	ea000001 	b	4a0 <print+0x68>
     498:	e2844001 	add	r4, r4, #1	; 0x1
     49c:	e3800002 	orr	r0, r0, #2	; 0x2
     4a0:	e5d43000 	ldrb	r3, [r4]
     4a4:	e3530030 	cmp	r3, #48	; 0x30
     4a8:	0afffffa 	beq	498 <print+0x60>
     4ac:	e1a02007 	mov	r2, r7
     4b0:	ea000001 	b	4bc <print+0x84>
     4b4:	e022c29a 	mla	r2, sl, r2, ip
     4b8:	e2844001 	add	r4, r4, #1	; 0x1
     4bc:	e5d41000 	ldrb	r1, [r4]
     4c0:	e241c030 	sub	ip, r1, #48	; 0x30
     4c4:	e20c30ff 	and	r3, ip, #255	; 0xff
     4c8:	e3530009 	cmp	r3, #9	; 0x9
     4cc:	9afffff8 	bls	4b4 <print+0x7c>
     4d0:	e3510073 	cmp	r1, #115	; 0x73
     4d4:	1a000008 	bne	4fc <print+0xc4>
     4d8:	e59dc00c 	ldr	ip, [sp, #12]
     4dc:	e49c1004 	ldr	r1, [ip], #4
     4e0:	e59f312c 	ldr	r3, [pc, #300]	; 614 <.text+0x614>
     4e4:	e3510000 	cmp	r1, #0	; 0x0
     4e8:	01a01003 	moveq	r1, r3
     4ec:	e1a03000 	mov	r3, r0
     4f0:	e1a00006 	mov	r0, r6
     4f4:	e58dc00c 	str	ip, [sp, #12]
     4f8:	ea000034 	b	5d0 <print+0x198>
     4fc:	e3510064 	cmp	r1, #100	; 0x64
     500:	1a00000c 	bne	538 <print+0x100>
     504:	e58d2000 	str	r2, [sp]
     508:	e58d0004 	str	r0, [sp, #4]
     50c:	e59dc00c 	ldr	ip, [sp, #12]
     510:	e58d8008 	str	r8, [sp, #8]
     514:	e1a00006 	mov	r0, r6
     518:	e59c1000 	ldr	r1, [ip]
     51c:	e1a0200a 	mov	r2, sl
     520:	e28cc004 	add	ip, ip, #4	; 0x4
     524:	e3a03001 	mov	r3, #1	; 0x1
     528:	e58dc00c 	str	ip, [sp, #12]
     52c:	ebffff77 	bl	310 <printi>
     530:	e0855000 	add	r5, r5, r0
     534:	ea00002b 	b	5e8 <print+0x1b0>
     538:	e3510078 	cmp	r1, #120	; 0x78
     53c:	058d2000 	streq	r2, [sp]
     540:	058d0004 	streq	r0, [sp, #4]
     544:	058d8008 	streq	r8, [sp, #8]
     548:	0a000003 	beq	55c <print+0x124>
     54c:	e3510058 	cmp	r1, #88	; 0x58
     550:	1a000007 	bne	574 <print+0x13c>
     554:	e58d2000 	str	r2, [sp]
     558:	e98d0201 	stmib	sp, {r0, r9}
     55c:	e59dc00c 	ldr	ip, [sp, #12]
     560:	e59c1000 	ldr	r1, [ip]
     564:	e1a00006 	mov	r0, r6
     568:	e28cc004 	add	ip, ip, #4	; 0x4
     56c:	e3a02010 	mov	r2, #16	; 0x10
     570:	ea000009 	b	59c <print+0x164>
     574:	e3510075 	cmp	r1, #117	; 0x75
     578:	1a000009 	bne	5a4 <print+0x16c>
     57c:	e58d2000 	str	r2, [sp]
     580:	e58d0004 	str	r0, [sp, #4]
     584:	e59dc00c 	ldr	ip, [sp, #12]
     588:	e58d8008 	str	r8, [sp, #8]
     58c:	e1a00006 	mov	r0, r6
     590:	e59c1000 	ldr	r1, [ip]
     594:	e1a0200a 	mov	r2, sl
     598:	e28cc004 	add	ip, ip, #4	; 0x4
     59c:	e1a03007 	mov	r3, r7
     5a0:	eaffffe0 	b	528 <print+0xf0>
     5a4:	e3510063 	cmp	r1, #99	; 0x63
     5a8:	1a00000e 	bne	5e8 <print+0x1b0>
     5ac:	e59dc00c 	ldr	ip, [sp, #12]
     5b0:	e59ce000 	ldr	lr, [ip]
     5b4:	e28cc004 	add	ip, ip, #4	; 0x4
     5b8:	e58dc00c 	str	ip, [sp, #12]
     5bc:	e5cde012 	strb	lr, [sp, #18]
     5c0:	e5cd7013 	strb	r7, [sp, #19]
     5c4:	e1a03000 	mov	r3, r0
     5c8:	e1a0100b 	mov	r1, fp
     5cc:	e1a00006 	mov	r0, r6
     5d0:	ebffff1e 	bl	250 <prints>
     5d4:	eaffffd5 	b	530 <print+0xf8>
     5d8:	e1a00006 	mov	r0, r6
     5dc:	e5d41000 	ldrb	r1, [r4]
     5e0:	ebffff10 	bl	228 <printchar>
     5e4:	e2855001 	add	r5, r5, #1	; 0x1
     5e8:	e2844001 	add	r4, r4, #1	; 0x1
     5ec:	e5d43000 	ldrb	r3, [r4]
     5f0:	e3530000 	cmp	r3, #0	; 0x0
     5f4:	1affff9b 	bne	468 <print+0x30>
     5f8:	e3560000 	cmp	r6, #0	; 0x0
     5fc:	15962000 	ldrne	r2, [r6]
     600:	13a03000 	movne	r3, #0	; 0x0
     604:	e1a00005 	mov	r0, r5
     608:	15c23000 	strneb	r3, [r2]
     60c:	e28dd014 	add	sp, sp, #20	; 0x14
     610:	e8bd8ff0 	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
     614:	00001c68 	andeq	r1, r0, r8, ror #24

00000618 <sprintf>:
     618:	e92d000e 	stmdb	sp!, {r1, r2, r3}
     61c:	e52de004 	str	lr, [sp, #-4]!
     620:	e24dd008 	sub	sp, sp, #8	; 0x8
     624:	e28d3010 	add	r3, sp, #16	; 0x10
     628:	e58d0000 	str	r0, [sp]
     62c:	e1a02003 	mov	r2, r3
     630:	e1a0000d 	mov	r0, sp
     634:	e59d100c 	ldr	r1, [sp, #12]
     638:	e58d3004 	str	r3, [sp, #4]
     63c:	ebffff7d 	bl	438 <print>
     640:	e28dd008 	add	sp, sp, #8	; 0x8
     644:	e49de004 	ldr	lr, [sp], #4
     648:	e28dd00c 	add	sp, sp, #12	; 0xc
     64c:	e12fff1e 	bx	lr

00000650 <printf>:
     650:	e92d000f 	stmdb	sp!, {r0, r1, r2, r3}
     654:	e52de004 	str	lr, [sp, #-4]!
     658:	e24dd004 	sub	sp, sp, #4	; 0x4
     65c:	e28d300c 	add	r3, sp, #12	; 0xc
     660:	e1a02003 	mov	r2, r3
     664:	e59d1008 	ldr	r1, [sp, #8]
     668:	e3a00000 	mov	r0, #0	; 0x0
     66c:	e58d3000 	str	r3, [sp]
     670:	ebffff70 	bl	438 <print>
     674:	e28dd004 	add	sp, sp, #4	; 0x4
     678:	e49de004 	ldr	lr, [sp], #4
     67c:	e28dd010 	add	sp, sp, #16	; 0x10
     680:	e12fff1e 	bx	lr

00000684 <ConsoleInit>:
     684:	e59f103c 	ldr	r1, [pc, #60]	; 6c8 <.text+0x6c8>
     688:	e5913000 	ldr	r3, [r1]
     68c:	e3c3300f 	bic	r3, r3, #15	; 0xf
     690:	e59f2034 	ldr	r2, [pc, #52]	; 6cc <.text+0x6cc>
     694:	e3833005 	orr	r3, r3, #5	; 0x5
     698:	e5813000 	str	r3, [r1]
     69c:	e3a03083 	mov	r3, #131	; 0x83
     6a0:	e582300c 	str	r3, [r2, #12]
     6a4:	e1a0c440 	mov	ip, r0, asr #8
     6a8:	e3a03003 	mov	r3, #3	; 0x3
     6ac:	e20000ff 	and	r0, r0, #255	; 0xff
     6b0:	e5820000 	str	r0, [r2]
     6b4:	e582c004 	str	ip, [r2, #4]
     6b8:	e582300c 	str	r3, [r2, #12]
     6bc:	e3a03001 	mov	r3, #1	; 0x1
     6c0:	e5823008 	str	r3, [r2, #8]
     6c4:	e12fff1e 	bx	lr
     6c8:	e002c000 	and	ip, r2, r0
     6cc:	e000c000 	and	ip, r0, r0

000006d0 <putchar>:
     6d0:	e350000a 	cmp	r0, #10	; 0xa
     6d4:	1a000005 	bne	6f0 <putchar+0x20>
     6d8:	e59f2028 	ldr	r2, [pc, #40]	; 708 <.text+0x708>
     6dc:	e5923014 	ldr	r3, [r2, #20]
     6e0:	e3130020 	tst	r3, #32	; 0x20
     6e4:	0afffffc 	beq	6dc <putchar+0xc>
     6e8:	e3a0300d 	mov	r3, #13	; 0xd
     6ec:	e5823000 	str	r3, [r2]
     6f0:	e59f2010 	ldr	r2, [pc, #16]	; 708 <.text+0x708>
     6f4:	e5923014 	ldr	r3, [r2, #20]
     6f8:	e3130020 	tst	r3, #32	; 0x20
     6fc:	0afffffc 	beq	6f4 <putchar+0x24>
     700:	e5820000 	str	r0, [r2]
     704:	e12fff1e 	bx	lr
     708:	e000c000 	and	ip, r0, r0

0000070c <getchar>:
     70c:	e59f0010 	ldr	r0, [pc, #16]	; 724 <.text+0x724>
     710:	e5903014 	ldr	r3, [r0, #20]
     714:	e3130001 	tst	r3, #1	; 0x1
     718:	0afffffc 	beq	710 <getchar+0x4>
     71c:	e5900000 	ldr	r0, [r0]
     720:	e12fff1e 	bx	lr
     724:	e000c000 	and	ip, r0, r0

00000728 <puts>:
     728:	e92d4010 	stmdb	sp!, {r4, lr}
     72c:	e1a04000 	mov	r4, r0
     730:	ea000000 	b	738 <puts+0x10>
     734:	ebffffe5 	bl	6d0 <putchar>
     738:	e5d43000 	ldrb	r3, [r4]
     73c:	e3530000 	cmp	r3, #0	; 0x0
     740:	e1a00003 	mov	r0, r3
     744:	e2844001 	add	r4, r4, #1	; 0x1
     748:	1afffff9 	bne	734 <puts+0xc>
     74c:	e3a0000a 	mov	r0, #10	; 0xa
     750:	ebffffde 	bl	6d0 <putchar>
     754:	e3a00001 	mov	r0, #1	; 0x1
     758:	e8bd8010 	ldmia	sp!, {r4, pc}

0000075c <main>:
     75c:	e52de004 	str	lr, [sp, #-4]!
     760:	ebfffe94 	bl	1b8 <HalSysInit>
     764:	e3a00027 	mov	r0, #39	; 0x27
     768:	ebffffc5 	bl	684 <ConsoleInit>
     76c:	e59f004c 	ldr	r0, [pc, #76]	; 7c0 <.text+0x7c0>
     770:	ebffffec 	bl	728 <puts>
     774:	eb000467 	bl	1918 <USBInit>
     778:	e59f0044 	ldr	r0, [pc, #68]	; 7c4 <.text+0x7c4>
     77c:	eb00035b 	bl	14f0 <USBRegisterDescriptors>
     780:	e59f2040 	ldr	r2, [pc, #64]	; 7c8 <.text+0x7c8>
     784:	e3a00002 	mov	r0, #2	; 0x2
     788:	e59f103c 	ldr	r1, [pc, #60]	; 7cc <.text+0x7cc>
     78c:	eb000283 	bl	11a0 <USBRegisterRequestHandler>
     790:	e3a00082 	mov	r0, #130	; 0x82
     794:	e59f1034 	ldr	r1, [pc, #52]	; 7d0 <.text+0x7d0>
     798:	eb000258 	bl	1100 <USBHwRegisterEPIntHandler>
     79c:	e3a00005 	mov	r0, #5	; 0x5
     7a0:	e59f102c 	ldr	r1, [pc, #44]	; 7d4 <.text+0x7d4>
     7a4:	eb000255 	bl	1100 <USBHwRegisterEPIntHandler>
     7a8:	e59f0028 	ldr	r0, [pc, #40]	; 7d8 <.text+0x7d8>
     7ac:	ebffffdd 	bl	728 <puts>
     7b0:	e3a00001 	mov	r0, #1	; 0x1
     7b4:	eb0000a7 	bl	a58 <USBHwConnect>
     7b8:	eb00013c 	bl	cb0 <USBHwISR>
     7bc:	eafffffd 	b	7b8 <main+0x5c>
     7c0:	00001c70 	andeq	r1, r0, r0, ror ip
     7c4:	00001b78 	andeq	r1, r0, r8, ror fp
     7c8:	40000208 	andmi	r0, r0, r8, lsl #4
     7cc:	00000888 	andeq	r0, r0, r8, lsl #17
     7d0:	00000820 	andeq	r0, r0, r0, lsr #16
     7d4:	000007dc 	ldreqd	r0, [r0], -ip
     7d8:	00001c88 	andeq	r1, r0, r8, lsl #25

000007dc <_HandleBulkOut>:
     7dc:	e3a01000 	mov	r1, #0	; 0x0
     7e0:	e1a02001 	mov	r2, r1
     7e4:	e52de004 	str	lr, [sp, #-4]!
     7e8:	e20000ff 	and	r0, r0, #255	; 0xff
     7ec:	eb0000db 	bl	b60 <USBHwEPRead>
     7f0:	e59f2020 	ldr	r2, [pc, #32]	; 818 <.text+0x818>
     7f4:	e892000a 	ldmia	r2, {r1, r3}
     7f8:	e0603003 	rsb	r3, r0, r3
     7fc:	e3530000 	cmp	r3, #0	; 0x0
     800:	e0800001 	add	r0, r0, r1
     804:	e8820009 	stmia	r2, {r0, r3}
     808:	149df004 	ldrne	pc, [sp], #4
     80c:	e59f0008 	ldr	r0, [pc, #8]	; 81c <.text+0x81c>
     810:	e49de004 	ldr	lr, [sp], #4
     814:	eaffffc3 	b	728 <puts>
     818:	40000200 	andmi	r0, r0, r0, lsl #4
     81c:	00001ca4 	andeq	r1, r0, r4, lsr #25

00000820 <_HandleBulkIn>:
     820:	e92d4030 	stmdb	sp!, {r4, r5, lr}
     824:	e59f5054 	ldr	r5, [pc, #84]	; 880 <.text+0x880>
     828:	e5953004 	ldr	r3, [r5, #4]
     82c:	e3530040 	cmp	r3, #64	; 0x40
     830:	31a04003 	movcc	r4, r3
     834:	23a04040 	movcs	r4, #64	; 0x40
     838:	e3540000 	cmp	r4, #0	; 0x0
     83c:	e20000ff 	and	r0, r0, #255	; 0xff
     840:	1a000002 	bne	850 <_HandleBulkIn+0x30>
     844:	e59f0038 	ldr	r0, [pc, #56]	; 884 <.text+0x884>
     848:	e8bd4030 	ldmia	sp!, {r4, r5, lr}
     84c:	eaffffb5 	b	728 <puts>
     850:	e1a02004 	mov	r2, r4
     854:	e5951000 	ldr	r1, [r5]
     858:	eb00009d 	bl	ad4 <USBHwEPWrite>
     85c:	e5953000 	ldr	r3, [r5]
     860:	e5952004 	ldr	r2, [r5, #4]
     864:	e0843003 	add	r3, r4, r3
     868:	e3c334ff 	bic	r3, r3, #-16777216	; 0xff000000
     86c:	e0642002 	rsb	r2, r4, r2
     870:	e3c3373e 	bic	r3, r3, #16252928	; 0xf80000
     874:	e5853000 	str	r3, [r5]
     878:	e5852004 	str	r2, [r5, #4]
     87c:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
     880:	40000200 	andmi	r0, r0, r0, lsl #4
     884:	00001ca4 	andeq	r1, r0, r4, lsr #25

00000888 <HandleVendorRequest>:
     888:	e92d4030 	stmdb	sp!, {r4, r5, lr}
     88c:	e5d04001 	ldrb	r4, [r0, #1]
     890:	e3540001 	cmp	r4, #1	; 0x1
     894:	e1a05001 	mov	r5, r1
     898:	e5922000 	ldr	r2, [r2]
     89c:	0a000002 	beq	8ac <HandleVendorRequest+0x24>
     8a0:	e3540002 	cmp	r4, #2	; 0x2
     8a4:	1a000017 	bne	908 <HandleVendorRequest+0x80>
     8a8:	ea00000b 	b	8dc <HandleVendorRequest+0x54>
     8ac:	e8925000 	ldmia	r2, {ip, lr}
     8b0:	e59f3064 	ldr	r3, [pc, #100]	; 91c <.text+0x91c>
     8b4:	e1a0100c 	mov	r1, ip
     8b8:	e1a0200e 	mov	r2, lr
     8bc:	e8835000 	stmia	r3, {ip, lr}
     8c0:	e59f0058 	ldr	r0, [pc, #88]	; 920 <.text+0x920>
     8c4:	ebffff61 	bl	650 <printf>
     8c8:	e3a00082 	mov	r0, #130	; 0x82
     8cc:	e3a01000 	mov	r1, #0	; 0x0
     8d0:	ebffffd2 	bl	820 <_HandleBulkIn>
     8d4:	e1a00004 	mov	r0, r4
     8d8:	ea000007 	b	8fc <HandleVendorRequest+0x74>
     8dc:	e8925000 	ldmia	r2, {ip, lr}
     8e0:	e59f3034 	ldr	r3, [pc, #52]	; 91c <.text+0x91c>
     8e4:	e1a0100c 	mov	r1, ip
     8e8:	e1a0200e 	mov	r2, lr
     8ec:	e59f0030 	ldr	r0, [pc, #48]	; 924 <.text+0x924>
     8f0:	e8835000 	stmia	r3, {ip, lr}
     8f4:	ebffff55 	bl	650 <printf>
     8f8:	e3a00001 	mov	r0, #1	; 0x1
     8fc:	e3a03000 	mov	r3, #0	; 0x0
     900:	e5853000 	str	r3, [r5]
     904:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
     908:	e1a01004 	mov	r1, r4
     90c:	e59f0014 	ldr	r0, [pc, #20]	; 928 <.text+0x928>
     910:	ebffff4e 	bl	650 <printf>
     914:	e3a00000 	mov	r0, #0	; 0x0
     918:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
     91c:	40000200 	andmi	r0, r0, r0, lsl #4
     920:	00001cac 	andeq	r1, r0, ip, lsr #25
     924:	00001cc4 	andeq	r1, r0, r4, asr #25
     928:	00001cdc 	ldreqd	r1, [r0], -ip

0000092c <USBHwCmd>:
     92c:	e1a00800 	mov	r0, r0, lsl #16
     930:	e59f2028 	ldr	r2, [pc, #40]	; 960 <.text+0x960>
     934:	e20008ff 	and	r0, r0, #16711680	; 0xff0000
     938:	e3800c05 	orr	r0, r0, #1280	; 0x500
     93c:	e3a03030 	mov	r3, #48	; 0x30
     940:	e5023df7 	str	r3, [r2, #-3575]
     944:	e5020def 	str	r0, [r2, #-3567]
     948:	e5123dff 	ldr	r3, [r2, #-3583]
     94c:	e2033010 	and	r3, r3, #16	; 0x10
     950:	e3530010 	cmp	r3, #16	; 0x10
     954:	1afffffb 	bne	948 <USBHwCmd+0x1c>
     958:	e5023df7 	str	r3, [r2, #-3575]
     95c:	e12fff1e 	bx	lr
     960:	ffe0cfff 	undefined instruction 0xffe0cfff

00000964 <USBHwCmdWrite>:
     964:	e92d4010 	stmdb	sp!, {r4, lr}
     968:	e1a04801 	mov	r4, r1, lsl #16
     96c:	e20000ff 	and	r0, r0, #255	; 0xff
     970:	e1a04824 	mov	r4, r4, lsr #16
     974:	ebffffec 	bl	92c <USBHwCmd>
     978:	e1a04804 	mov	r4, r4, lsl #16
     97c:	e59f3020 	ldr	r3, [pc, #32]	; 9a4 <.text+0x9a4>
     980:	e3844c01 	orr	r4, r4, #256	; 0x100
     984:	e5034def 	str	r4, [r3, #-3567]
     988:	e1a02003 	mov	r2, r3
     98c:	e5123dff 	ldr	r3, [r2, #-3583]
     990:	e2033010 	and	r3, r3, #16	; 0x10
     994:	e3530010 	cmp	r3, #16	; 0x10
     998:	1afffffb 	bne	98c <USBHwCmdWrite+0x28>
     99c:	e5023df7 	str	r3, [r2, #-3575]
     9a0:	e8bd8010 	ldmia	sp!, {r4, pc}
     9a4:	ffe0cfff 	undefined instruction 0xffe0cfff

000009a8 <USBHwCmdRead>:
     9a8:	e92d4010 	stmdb	sp!, {r4, lr}
     9ac:	e20040ff 	and	r4, r0, #255	; 0xff
     9b0:	e1a00004 	mov	r0, r4
     9b4:	ebffffdc 	bl	92c <USBHwCmd>
     9b8:	e1a04804 	mov	r4, r4, lsl #16
     9bc:	e59f3028 	ldr	r3, [pc, #40]	; 9ec <.text+0x9ec>
     9c0:	e3844c02 	orr	r4, r4, #512	; 0x200
     9c4:	e5034def 	str	r4, [r3, #-3567]
     9c8:	e1a02003 	mov	r2, r3
     9cc:	e5123dff 	ldr	r3, [r2, #-3583]
     9d0:	e2033020 	and	r3, r3, #32	; 0x20
     9d4:	e3530020 	cmp	r3, #32	; 0x20
     9d8:	1afffffb 	bne	9cc <USBHwCmdRead+0x24>
     9dc:	e5023df7 	str	r3, [r2, #-3575]
     9e0:	e5120deb 	ldr	r0, [r2, #-3563]
     9e4:	e20000ff 	and	r0, r0, #255	; 0xff
     9e8:	e8bd8010 	ldmia	sp!, {r4, pc}
     9ec:	ffe0cfff 	undefined instruction 0xffe0cfff

000009f0 <USBHwEPConfig>:
     9f0:	e59fc04c 	ldr	ip, [pc, #76]	; a44 <.text+0xa44>
     9f4:	e200300f 	and	r3, r0, #15	; 0xf
     9f8:	e51c2dbb 	ldr	r2, [ip, #-3515]
     9fc:	e1a03083 	mov	r3, r3, lsl #1
     a00:	e2000080 	and	r0, r0, #128	; 0x80
     a04:	e18303a0 	orr	r0, r3, r0, lsr #7
     a08:	e3a03001 	mov	r3, #1	; 0x1
     a0c:	e1822013 	orr	r2, r2, r3, lsl r0
     a10:	e1a01801 	mov	r1, r1, lsl #16
     a14:	e1a01821 	mov	r1, r1, lsr #16
     a18:	e50c2dbb 	str	r2, [ip, #-3515]
     a1c:	e50c0db7 	str	r0, [ip, #-3511]
     a20:	e50c1db3 	str	r1, [ip, #-3507]
     a24:	e51c3dff 	ldr	r3, [ip, #-3583]
     a28:	e2033c01 	and	r3, r3, #256	; 0x100
     a2c:	e3530c01 	cmp	r3, #256	; 0x100
     a30:	1afffffb 	bne	a24 <USBHwEPConfig+0x34>
     a34:	e3800040 	orr	r0, r0, #64	; 0x40
     a38:	e3a01000 	mov	r1, #0	; 0x0
     a3c:	e50c3df7 	str	r3, [ip, #-3575]
     a40:	eaffffc7 	b	964 <USBHwCmdWrite>
     a44:	ffe0cfff 	undefined instruction 0xffe0cfff

00000a48 <USBHwSetAddress>:
     a48:	e200107f 	and	r1, r0, #127	; 0x7f
     a4c:	e3811080 	orr	r1, r1, #128	; 0x80
     a50:	e3a000d0 	mov	r0, #208	; 0xd0
     a54:	eaffffc2 	b	964 <USBHwCmdWrite>

00000a58 <USBHwConnect>:
     a58:	e3500000 	cmp	r0, #0	; 0x0
     a5c:	159f3020 	ldrne	r3, [pc, #32]	; a84 <.text+0xa84>
     a60:	059f301c 	ldreq	r3, [pc, #28]	; a84 <.text+0xa84>
     a64:	13a02901 	movne	r2, #16384	; 0x4000
     a68:	03a02901 	moveq	r2, #16384	; 0x4000
     a6c:	15032fe3 	strne	r2, [r3, #-4067]
     a70:	05032fe7 	streq	r2, [r3, #-4071]
     a74:	e2501000 	subs	r1, r0, #0	; 0x0
     a78:	13a01001 	movne	r1, #1	; 0x1
     a7c:	e3a000fe 	mov	r0, #254	; 0xfe
     a80:	eaffffb7 	b	964 <USBHwCmdWrite>
     a84:	3fffcfff 	svccc	0x00ffcfff

00000a88 <USBHwNakIntEnable>:
     a88:	e20010ff 	and	r1, r0, #255	; 0xff
     a8c:	e3a000f3 	mov	r0, #243	; 0xf3
     a90:	eaffffb3 	b	964 <USBHwCmdWrite>

00000a94 <USBHwEPGetStatus>:
     a94:	e1a03000 	mov	r3, r0
     a98:	e200000f 	and	r0, r0, #15	; 0xf
     a9c:	e2033080 	and	r3, r3, #128	; 0x80
     aa0:	e1a00080 	mov	r0, r0, lsl #1
     aa4:	e52de004 	str	lr, [sp, #-4]!
     aa8:	e18003a3 	orr	r0, r0, r3, lsr #7
     aac:	ebffffbd 	bl	9a8 <USBHwCmdRead>
     ab0:	e49df004 	ldr	pc, [sp], #4

00000ab4 <USBHwEPStall>:
     ab4:	e200300f 	and	r3, r0, #15	; 0xf
     ab8:	e1a03083 	mov	r3, r3, lsl #1
     abc:	e2000080 	and	r0, r0, #128	; 0x80
     ac0:	e18333a0 	orr	r3, r3, r0, lsr #7
     ac4:	e2511000 	subs	r1, r1, #0	; 0x0
     ac8:	13a01001 	movne	r1, #1	; 0x1
     acc:	e3830040 	orr	r0, r3, #64	; 0x40
     ad0:	eaffffa3 	b	964 <USBHwCmdWrite>

00000ad4 <USBHwEPWrite>:
     ad4:	e92d40f0 	stmdb	sp!, {r4, r5, r6, r7, lr}
     ad8:	e59fc07c 	ldr	ip, [pc, #124]	; b5c <.text+0xb5c>
     adc:	e200500f 	and	r5, r0, #15	; 0xf
     ae0:	e1a03105 	mov	r3, r5, lsl #2
     ae4:	e3833002 	orr	r3, r3, #2	; 0x2
     ae8:	e1a06002 	mov	r6, r2
     aec:	e1a0e001 	mov	lr, r1
     af0:	e1a0400c 	mov	r4, ip
     af4:	e20070ff 	and	r7, r0, #255	; 0xff
     af8:	e50c3dd7 	str	r3, [ip, #-3543]
     afc:	e50c2ddb 	str	r2, [ip, #-3547]
     b00:	ea000008 	b	b28 <USBHwEPWrite+0x54>
     b04:	e55e3002 	ldrb	r3, [lr, #-2]
     b08:	e55e2001 	ldrb	r2, [lr, #-1]
     b0c:	e55e1004 	ldrb	r1, [lr, #-4]
     b10:	e1a03803 	mov	r3, r3, lsl #16
     b14:	e1833c02 	orr	r3, r3, r2, lsl #24
     b18:	e55e2003 	ldrb	r2, [lr, #-3]
     b1c:	e1833001 	orr	r3, r3, r1
     b20:	e1833402 	orr	r3, r3, r2, lsl #8
     b24:	e5003de3 	str	r3, [r0, #-3555]
     b28:	e5143dd7 	ldr	r3, [r4, #-3543]
     b2c:	e2133002 	ands	r3, r3, #2	; 0x2
     b30:	e28ee004 	add	lr, lr, #4	; 0x4
     b34:	e1a00004 	mov	r0, r4
     b38:	1afffff1 	bne	b04 <USBHwEPWrite+0x30>
     b3c:	e1a00085 	mov	r0, r5, lsl #1
     b40:	e18003a7 	orr	r0, r0, r7, lsr #7
     b44:	e5043dd7 	str	r3, [r4, #-3543]
     b48:	ebffff77 	bl	92c <USBHwCmd>
     b4c:	e3a000fa 	mov	r0, #250	; 0xfa
     b50:	ebffff75 	bl	92c <USBHwCmd>
     b54:	e1a00006 	mov	r0, r6
     b58:	e8bd80f0 	ldmia	sp!, {r4, r5, r6, r7, pc}
     b5c:	ffe0cfff 	undefined instruction 0xffe0cfff

00000b60 <USBHwEPRead>:
     b60:	e92d4030 	stmdb	sp!, {r4, r5, lr}
     b64:	e200e00f 	and	lr, r0, #15	; 0xf
     b68:	e59fc088 	ldr	ip, [pc, #136]	; bf8 <.text+0xbf8>
     b6c:	e1a0310e 	mov	r3, lr, lsl #2
     b70:	e3833001 	orr	r3, r3, #1	; 0x1
     b74:	e50c3dd7 	str	r3, [ip, #-3543]
     b78:	e20050ff 	and	r5, r0, #255	; 0xff
     b7c:	e51c3ddf 	ldr	r3, [ip, #-3551]
     b80:	e3130b02 	tst	r3, #2048	; 0x800
     b84:	0afffffc 	beq	b7c <USBHwEPRead+0x1c>
     b88:	e3130b01 	tst	r3, #1024	; 0x400
     b8c:	03e04000 	mvneq	r4, #0	; 0x0
     b90:	0a000016 	beq	bf0 <USBHwEPRead+0x90>
     b94:	e1a03b03 	mov	r3, r3, lsl #22
     b98:	e3a04000 	mov	r4, #0	; 0x0
     b9c:	e59fc054 	ldr	ip, [pc, #84]	; bf8 <.text+0xbf8>
     ba0:	e1a03b23 	mov	r3, r3, lsr #22
     ba4:	e1a00004 	mov	r0, r4
     ba8:	ea000006 	b	bc8 <USBHwEPRead+0x68>
     bac:	e3140003 	tst	r4, #3	; 0x3
     bb0:	051c0de7 	ldreq	r0, [ip, #-3559]
     bb4:	e3510000 	cmp	r1, #0	; 0x0
     bb8:	11540002 	cmpne	r4, r2
     bbc:	b7c40001 	strltb	r0, [r4, r1]
     bc0:	e2844001 	add	r4, r4, #1	; 0x1
     bc4:	e1a00420 	mov	r0, r0, lsr #8
     bc8:	e1540003 	cmp	r4, r3
     bcc:	1afffff6 	bne	bac <USBHwEPRead+0x4c>
     bd0:	e59f3020 	ldr	r3, [pc, #32]	; bf8 <.text+0xbf8>
     bd4:	e1a0008e 	mov	r0, lr, lsl #1
     bd8:	e3a02000 	mov	r2, #0	; 0x0
     bdc:	e18003a5 	orr	r0, r0, r5, lsr #7
     be0:	e5032dd7 	str	r2, [r3, #-3543]
     be4:	ebffff50 	bl	92c <USBHwCmd>
     be8:	e3a000f2 	mov	r0, #242	; 0xf2
     bec:	ebffff4e 	bl	92c <USBHwCmd>
     bf0:	e1a00004 	mov	r0, r4
     bf4:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
     bf8:	ffe0cfff 	undefined instruction 0xffe0cfff

00000bfc <USBHwISOCEPRead>:
     bfc:	e92d4030 	stmdb	sp!, {r4, r5, lr}
     c00:	e200e00f 	and	lr, r0, #15	; 0xf
     c04:	e1a0310e 	mov	r3, lr, lsl #2
     c08:	e59fc08c 	ldr	ip, [pc, #140]	; c9c <.text+0xc9c>
     c0c:	e3833001 	orr	r3, r3, #1	; 0x1
     c10:	e50c3dd7 	str	r3, [ip, #-3543]
     c14:	e20050ff 	and	r5, r0, #255	; 0xff
     c18:	e1a00000 	nop			(mov r0,r0)
     c1c:	e51c3ddf 	ldr	r3, [ip, #-3551]
     c20:	e2130b02 	ands	r0, r3, #2048	; 0x800
     c24:	0a000001 	beq	c30 <USBHwISOCEPRead+0x34>
     c28:	e2130b01 	ands	r0, r3, #1024	; 0x400
     c2c:	1a000002 	bne	c3c <USBHwISOCEPRead+0x40>
     c30:	e3e04000 	mvn	r4, #0	; 0x0
     c34:	e50c0dd7 	str	r0, [ip, #-3543]
     c38:	ea000015 	b	c94 <USBHwISOCEPRead+0x98>
     c3c:	e1a03b03 	mov	r3, r3, lsl #22
     c40:	e3a04000 	mov	r4, #0	; 0x0
     c44:	e1a03b23 	mov	r3, r3, lsr #22
     c48:	e1a00004 	mov	r0, r4
     c4c:	ea000006 	b	c6c <USBHwISOCEPRead+0x70>
     c50:	e3140003 	tst	r4, #3	; 0x3
     c54:	051c0de7 	ldreq	r0, [ip, #-3559]
     c58:	e3510000 	cmp	r1, #0	; 0x0
     c5c:	11540002 	cmpne	r4, r2
     c60:	b7c40001 	strltb	r0, [r4, r1]
     c64:	e2844001 	add	r4, r4, #1	; 0x1
     c68:	e1a00420 	mov	r0, r0, lsr #8
     c6c:	e1540003 	cmp	r4, r3
     c70:	1afffff6 	bne	c50 <USBHwISOCEPRead+0x54>
     c74:	e59f3020 	ldr	r3, [pc, #32]	; c9c <.text+0xc9c>
     c78:	e1a0008e 	mov	r0, lr, lsl #1
     c7c:	e3a02000 	mov	r2, #0	; 0x0
     c80:	e18003a5 	orr	r0, r0, r5, lsr #7
     c84:	e5032dd7 	str	r2, [r3, #-3543]
     c88:	ebffff27 	bl	92c <USBHwCmd>
     c8c:	e3a000f2 	mov	r0, #242	; 0xf2
     c90:	ebffff25 	bl	92c <USBHwCmd>
     c94:	e1a00004 	mov	r0, r4
     c98:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
     c9c:	ffe0cfff 	undefined instruction 0xffe0cfff

00000ca0 <USBHwConfigDevice>:
     ca0:	e2501000 	subs	r1, r0, #0	; 0x0
     ca4:	13a01001 	movne	r1, #1	; 0x1
     ca8:	e3a000d8 	mov	r0, #216	; 0xd8
     cac:	eaffff2c 	b	964 <USBHwCmdWrite>

00000cb0 <USBHwISR>:
     cb0:	e59f3144 	ldr	r3, [pc, #324]	; dfc <.text+0xdfc>
     cb4:	e3a02002 	mov	r2, #2	; 0x2
     cb8:	e5032fa7 	str	r2, [r3, #-4007]
     cbc:	e59f213c 	ldr	r2, [pc, #316]	; e00 <.text+0xe00>
     cc0:	e92d45f0 	stmdb	sp!, {r4, r5, r6, r7, r8, sl, lr}
     cc4:	e5126dff 	ldr	r6, [r2, #-3583]
     cc8:	e3160001 	tst	r6, #1	; 0x1
     ccc:	0a00000b 	beq	d00 <USBHwISR+0x50>
     cd0:	e59f312c 	ldr	r3, [pc, #300]	; e04 <.text+0xe04>
     cd4:	e5934000 	ldr	r4, [r3]
     cd8:	e3a03001 	mov	r3, #1	; 0x1
     cdc:	e3540000 	cmp	r4, #0	; 0x0
     ce0:	e5023df7 	str	r3, [r2, #-3575]
     ce4:	0a000005 	beq	d00 <USBHwISR+0x50>
     ce8:	e3a000f5 	mov	r0, #245	; 0xf5
     cec:	ebffff2d 	bl	9a8 <USBHwCmdRead>
     cf0:	e1a00800 	mov	r0, r0, lsl #16
     cf4:	e1a00820 	mov	r0, r0, lsr #16
     cf8:	e1a0e00f 	mov	lr, pc
     cfc:	e12fff14 	bx	r4
     d00:	e3160008 	tst	r6, #8	; 0x8
     d04:	0a000011 	beq	d50 <USBHwISR+0xa0>
     d08:	e59f30f0 	ldr	r3, [pc, #240]	; e00 <.text+0xe00>
     d0c:	e3a02008 	mov	r2, #8	; 0x8
     d10:	e3a000fe 	mov	r0, #254	; 0xfe
     d14:	e5032df7 	str	r2, [r3, #-3575]
     d18:	ebffff22 	bl	9a8 <USBHwCmdRead>
     d1c:	e310001a 	tst	r0, #26	; 0x1a
     d20:	0a00000a 	beq	d50 <USBHwISR+0xa0>
     d24:	e59f30dc 	ldr	r3, [pc, #220]	; e08 <.text+0xe08>
     d28:	e5933000 	ldr	r3, [r3]
     d2c:	e3530000 	cmp	r3, #0	; 0x0
     d30:	0a000006 	beq	d50 <USBHwISR+0xa0>
     d34:	e59f50c0 	ldr	r5, [pc, #192]	; dfc <.text+0xdfc>
     d38:	e3a04001 	mov	r4, #1	; 0x1
     d3c:	e5054fa7 	str	r4, [r5, #-4007]
     d40:	e2000015 	and	r0, r0, #21	; 0x15
     d44:	e1a0e00f 	mov	lr, pc
     d48:	e12fff13 	bx	r3
     d4c:	e5054fa3 	str	r4, [r5, #-4003]
     d50:	e3160004 	tst	r6, #4	; 0x4
     d54:	0a000024 	beq	dec <USBHwISR+0x13c>
     d58:	e59f30a0 	ldr	r3, [pc, #160]	; e00 <.text+0xe00>
     d5c:	e3a02004 	mov	r2, #4	; 0x4
     d60:	e5032df7 	str	r2, [r3, #-3575]
     d64:	e59fa0a0 	ldr	sl, [pc, #160]	; e0c <.text+0xe0c>
     d68:	e59f708c 	ldr	r7, [pc, #140]	; dfc <.text+0xdfc>
     d6c:	e1a05003 	mov	r5, r3
     d70:	e1a06002 	mov	r6, r2
     d74:	e3a04000 	mov	r4, #0	; 0x0
     d78:	e3a08001 	mov	r8, #1	; 0x1
     d7c:	e1a02418 	mov	r2, r8, lsl r4
     d80:	e5153dcf 	ldr	r3, [r5, #-3535]
     d84:	e1120003 	tst	r2, r3
     d88:	0a000014 	beq	de0 <USBHwISR+0x130>
     d8c:	e5052dc7 	str	r2, [r5, #-3527]
     d90:	e5153dff 	ldr	r3, [r5, #-3583]
     d94:	e2032020 	and	r2, r3, #32	; 0x20
     d98:	e3520020 	cmp	r2, #32	; 0x20
     d9c:	1afffffb 	bne	d90 <USBHwISR+0xe0>
     da0:	e0843fa4 	add	r3, r4, r4, lsr #31
     da4:	e1a030c3 	mov	r3, r3, asr #1
     da8:	e79a3103 	ldr	r3, [sl, r3, lsl #2]
     dac:	e5052df7 	str	r2, [r5, #-3575]
     db0:	e3530000 	cmp	r3, #0	; 0x0
     db4:	e5151deb 	ldr	r1, [r5, #-3563]
     db8:	0a000008 	beq	de0 <USBHwISR+0x130>
     dbc:	e1a000c4 	mov	r0, r4, asr #1
     dc0:	e200000f 	and	r0, r0, #15	; 0xf
     dc4:	e1800384 	orr	r0, r0, r4, lsl #7
     dc8:	e5076fa7 	str	r6, [r7, #-4007]
     dcc:	e200008f 	and	r0, r0, #143	; 0x8f
     dd0:	e201101f 	and	r1, r1, #31	; 0x1f
     dd4:	e1a0e00f 	mov	lr, pc
     dd8:	e12fff13 	bx	r3
     ddc:	e5076fa3 	str	r6, [r7, #-4003]
     de0:	e2844001 	add	r4, r4, #1	; 0x1
     de4:	e3540020 	cmp	r4, #32	; 0x20
     de8:	1affffe3 	bne	d7c <USBHwISR+0xcc>
     dec:	e59f3008 	ldr	r3, [pc, #8]	; dfc <.text+0xdfc>
     df0:	e3a02002 	mov	r2, #2	; 0x2
     df4:	e5032fa3 	str	r2, [r3, #-4003]
     df8:	e8bd85f0 	ldmia	sp!, {r4, r5, r6, r7, r8, sl, pc}
     dfc:	3fffcfff 	svccc	0x00ffcfff
     e00:	ffe0cfff 	undefined instruction 0xffe0cfff
     e04:	40000210 	andmi	r0, r0, r0, lsl r2
     e08:	40000214 	andmi	r0, r0, r4, lsl r2
     e0c:	40000218 	andmi	r0, r0, r8, lsl r2

00000e10 <USBHwInit>:
     e10:	e59f2124 	ldr	r2, [pc, #292]	; f3c <.text+0xf3c>
     e14:	e5923004 	ldr	r3, [r2, #4]
     e18:	e3c33103 	bic	r3, r3, #-1073741824	; 0xc0000000
     e1c:	e3833101 	orr	r3, r3, #1073741824	; 0x40000000
     e20:	e5823004 	str	r3, [r2, #4]
     e24:	e592300c 	ldr	r3, [r2, #12]
     e28:	e3c33203 	bic	r3, r3, #805306368	; 0x30000000
     e2c:	e3833202 	orr	r3, r3, #536870912	; 0x20000000
     e30:	e582300c 	str	r3, [r2, #12]
     e34:	e5923000 	ldr	r3, [r2]
     e38:	e3c3330f 	bic	r3, r3, #1006632960	; 0x3c000000
     e3c:	e3833301 	orr	r3, r3, #67108864	; 0x4000000
     e40:	e5823000 	str	r3, [r2]
     e44:	e59f20f4 	ldr	r2, [pc, #244]	; f40 <.text+0xf40>
     e48:	e5123fff 	ldr	r3, [r2, #-4095]
     e4c:	e3833901 	orr	r3, r3, #16384	; 0x4000
     e50:	e5023fff 	str	r3, [r2, #-4095]
     e54:	e3a03901 	mov	r3, #16384	; 0x4000
     e58:	e5023fe7 	str	r3, [r2, #-4071]
     e5c:	e59f20e0 	ldr	r2, [pc, #224]	; f44 <.text+0xf44>
     e60:	e59230c4 	ldr	r3, [r2, #196]
     e64:	e92d4010 	stmdb	sp!, {r4, lr}
     e68:	e3833102 	orr	r3, r3, #-2147483648	; 0x80000000
     e6c:	e58230c4 	str	r3, [r2, #196]
     e70:	e59f10d0 	ldr	r1, [pc, #208]	; f48 <.text+0xf48>
     e74:	e3a03005 	mov	r3, #5	; 0x5
     e78:	e5823108 	str	r3, [r2, #264]
     e7c:	e2833015 	add	r3, r3, #21	; 0x15
     e80:	e501300b 	str	r3, [r1, #-11]
     e84:	e5113007 	ldr	r3, [r1, #-7]
     e88:	e313001a 	tst	r3, #26	; 0x1a
     e8c:	0afffffc 	beq	e84 <USBHwInit+0x74>
     e90:	e3a04000 	mov	r4, #0	; 0x0
     e94:	e3e02000 	mvn	r2, #0	; 0x0
     e98:	e3a03003 	mov	r3, #3	; 0x3
     e9c:	e5013eef 	str	r3, [r1, #-3823]
     ea0:	e1a00004 	mov	r0, r4
     ea4:	e5014dfb 	str	r4, [r1, #-3579]
     ea8:	e5012df7 	str	r2, [r1, #-3575]
     eac:	e5014dd3 	str	r4, [r1, #-3539]
     eb0:	e5014dcb 	str	r4, [r1, #-3531]
     eb4:	e5012dc7 	str	r2, [r1, #-3527]
     eb8:	e5014dbf 	str	r4, [r1, #-3519]
     ebc:	ebfffef1 	bl	a88 <USBHwNakIntEnable>
     ec0:	e59f107c 	ldr	r1, [pc, #124]	; f44 <.text+0xf44>
     ec4:	e59131a0 	ldr	r3, [r1, #416]
     ec8:	e59fc06c 	ldr	ip, [pc, #108]	; f3c <.text+0xf3c>
     ecc:	e3833001 	orr	r3, r3, #1	; 0x1
     ed0:	e58131a0 	str	r3, [r1, #416]
     ed4:	e59f2064 	ldr	r2, [pc, #100]	; f40 <.text+0xf40>
     ed8:	e58c4028 	str	r4, [ip, #40]
     edc:	e5123fbf 	ldr	r3, [r2, #-4031]
     ee0:	e3a00001 	mov	r0, #1	; 0x1
     ee4:	e3833001 	orr	r3, r3, #1	; 0x1
     ee8:	e5023fbf 	str	r3, [r2, #-4031]
     eec:	e5020fa3 	str	r0, [r2, #-4003]
     ef0:	e59131a0 	ldr	r3, [r1, #416]
     ef4:	e1833000 	orr	r3, r3, r0
     ef8:	e58131a0 	str	r3, [r1, #416]
     efc:	e58c4028 	str	r4, [ip, #40]
     f00:	e5123fbf 	ldr	r3, [r2, #-4031]
     f04:	e3833002 	orr	r3, r3, #2	; 0x2
     f08:	e5023fbf 	str	r3, [r2, #-4031]
     f0c:	e3a03002 	mov	r3, #2	; 0x2
     f10:	e5023fa3 	str	r3, [r2, #-4003]
     f14:	e59131a0 	ldr	r3, [r1, #416]
     f18:	e1833000 	orr	r3, r3, r0
     f1c:	e58131a0 	str	r3, [r1, #416]
     f20:	e58c4028 	str	r4, [ip, #40]
     f24:	e5123fbf 	ldr	r3, [r2, #-4031]
     f28:	e3833004 	orr	r3, r3, #4	; 0x4
     f2c:	e5023fbf 	str	r3, [r2, #-4031]
     f30:	e3a03004 	mov	r3, #4	; 0x4
     f34:	e5023fa3 	str	r3, [r2, #-4003]
     f38:	e8bd8010 	ldmia	sp!, {r4, pc}
     f3c:	e002c000 	and	ip, r2, r0
     f40:	3fffcfff 	svccc	0x00ffcfff
     f44:	e01fc000 	ands	ip, pc, r0
     f48:	ffe0cfff 	undefined instruction 0xffe0cfff

00000f4c <USBSetupDMADescriptor>:
     f4c:	e52de004 	str	lr, [sp, #-4]!
     f50:	e3a0e000 	mov	lr, #0	; 0x0
     f54:	e580e004 	str	lr, [r0, #4]
     f58:	e5801000 	str	r1, [r0]
     f5c:	e1a0c001 	mov	ip, r1
     f60:	e1a03b03 	mov	r3, r3, lsl #22
     f64:	e5901004 	ldr	r1, [r0, #4]
     f68:	e1a03b23 	mov	r3, r3, lsr #22
     f6c:	e1811283 	orr	r1, r1, r3, lsl #5
     f70:	e5801004 	str	r1, [r0, #4]
     f74:	e1dd10b4 	ldrh	r1, [sp, #4]
     f78:	e5903004 	ldr	r3, [r0, #4]
     f7c:	e1833801 	orr	r3, r3, r1, lsl #16
     f80:	e5803004 	str	r3, [r0, #4]
     f84:	e21220ff 	ands	r2, r2, #255	; 0xff
     f88:	15903004 	ldrne	r3, [r0, #4]
     f8c:	13833010 	orrne	r3, r3, #16	; 0x10
     f90:	15803004 	strne	r3, [r0, #4]
     f94:	e35c0000 	cmp	ip, #0	; 0x0
     f98:	15903004 	ldrne	r3, [r0, #4]
     f9c:	e59d100c 	ldr	r1, [sp, #12]
     fa0:	13833004 	orrne	r3, r3, #4	; 0x4
     fa4:	15803004 	strne	r3, [r0, #4]
     fa8:	e59d3008 	ldr	r3, [sp, #8]
     fac:	e3520000 	cmp	r2, #0	; 0x0
     fb0:	13510000 	cmpne	r1, #0	; 0x0
     fb4:	e5803008 	str	r3, [r0, #8]
     fb8:	15801010 	strne	r1, [r0, #16]
     fbc:	e580e00c 	str	lr, [r0, #12]
     fc0:	e49df004 	ldr	pc, [sp], #4

00000fc4 <USBDisableDMAForEndpoint>:
     fc4:	e200200f 	and	r2, r0, #15	; 0xf
     fc8:	e1a02082 	mov	r2, r2, lsl #1
     fcc:	e2000080 	and	r0, r0, #128	; 0x80
     fd0:	e18223a0 	orr	r2, r2, r0, lsr #7
     fd4:	e3a03001 	mov	r3, #1	; 0x1
     fd8:	e1a03213 	mov	r3, r3, lsl r2
     fdc:	e59f2004 	ldr	r2, [pc, #4]	; fe8 <.text+0xfe8>
     fe0:	e5023d73 	str	r3, [r2, #-3443]
     fe4:	e12fff1e 	bx	lr
     fe8:	ffe0cfff 	undefined instruction 0xffe0cfff

00000fec <USBEnableDMAForEndpoint>:
     fec:	e200200f 	and	r2, r0, #15	; 0xf
     ff0:	e1a02082 	mov	r2, r2, lsl #1
     ff4:	e2000080 	and	r0, r0, #128	; 0x80
     ff8:	e18223a0 	orr	r2, r2, r0, lsr #7
     ffc:	e3a03001 	mov	r3, #1	; 0x1
    1000:	e1a03213 	mov	r3, r3, lsl r2
    1004:	e59f2004 	ldr	r2, [pc, #4]	; 1010 <.text+0x1010>
    1008:	e5023d77 	str	r3, [r2, #-3447]
    100c:	e12fff1e 	bx	lr
    1010:	ffe0cfff 	undefined instruction 0xffe0cfff

00001014 <USBInitializeISOCFrameArray>:
    1014:	e92d4030 	stmdb	sp!, {r4, r5, lr}
    1018:	e1a03b03 	mov	r3, r3, lsl #22
    101c:	e1a02802 	mov	r2, r2, lsl #16
    1020:	e1a03b23 	mov	r3, r3, lsr #22
    1024:	e1a05000 	mov	r5, r0
    1028:	e1a04001 	mov	r4, r1
    102c:	e1a0c822 	mov	ip, r2, lsr #16
    1030:	e3830902 	orr	r0, r3, #32768	; 0x8000
    1034:	e3a0e000 	mov	lr, #0	; 0x0
    1038:	ea000000 	b	1040 <USBInitializeISOCFrameArray+0x2c>
    103c:	e7851102 	str	r1, [r5, r2, lsl #2]
    1040:	e1a0280e 	mov	r2, lr, lsl #16
    1044:	e28c3001 	add	r3, ip, #1	; 0x1
    1048:	e1a02822 	mov	r2, r2, lsr #16
    104c:	e1a03803 	mov	r3, r3, lsl #16
    1050:	e1520004 	cmp	r2, r4
    1054:	e180180c 	orr	r1, r0, ip, lsl #16
    1058:	e28ee001 	add	lr, lr, #1	; 0x1
    105c:	e1a0c823 	mov	ip, r3, lsr #16
    1060:	3afffff5 	bcc	103c <USBInitializeISOCFrameArray+0x28>
    1064:	e8bd8030 	ldmia	sp!, {r4, r5, pc}

00001068 <USBSetHeadDDForDMA>:
    1068:	e200300f 	and	r3, r0, #15	; 0xf
    106c:	e1a03083 	mov	r3, r3, lsl #1
    1070:	e2000080 	and	r0, r0, #128	; 0x80
    1074:	e18333a0 	orr	r3, r3, r0, lsr #7
    1078:	e7812103 	str	r2, [r1, r3, lsl #2]
    107c:	e12fff1e 	bx	lr

00001080 <USBInitializeUSBDMA>:
    1080:	e3a03000 	mov	r3, #0	; 0x0
    1084:	e1a02003 	mov	r2, r3
    1088:	e7832000 	str	r2, [r3, r0]
    108c:	e2833004 	add	r3, r3, #4	; 0x4
    1090:	e3530080 	cmp	r3, #128	; 0x80
    1094:	1afffffb 	bne	1088 <USBInitializeUSBDMA+0x8>
    1098:	e59f3004 	ldr	r3, [pc, #4]	; 10a4 <.text+0x10a4>
    109c:	e5030d7f 	str	r0, [r3, #-3455]
    10a0:	e12fff1e 	bx	lr
    10a4:	ffe0cfff 	undefined instruction 0xffe0cfff

000010a8 <USBHwRegisterFrameHandler>:
    10a8:	e59f1018 	ldr	r1, [pc, #24]	; 10c8 <.text+0x10c8>
    10ac:	e59f3018 	ldr	r3, [pc, #24]	; 10cc <.text+0x10cc>
    10b0:	e5112dfb 	ldr	r2, [r1, #-3579]
    10b4:	e5830000 	str	r0, [r3]
    10b8:	e59f0010 	ldr	r0, [pc, #16]	; 10d0 <.text+0x10d0>
    10bc:	e3822001 	orr	r2, r2, #1	; 0x1
    10c0:	e5012dfb 	str	r2, [r1, #-3579]
    10c4:	eafffd97 	b	728 <puts>
    10c8:	ffe0cfff 	undefined instruction 0xffe0cfff
    10cc:	40000210 	andmi	r0, r0, r0, lsl r2
    10d0:	00001cf0 	streqd	r1, [r0], -r0

000010d4 <USBHwRegisterDevIntHandler>:
    10d4:	e59f1018 	ldr	r1, [pc, #24]	; 10f4 <.text+0x10f4>
    10d8:	e59f3018 	ldr	r3, [pc, #24]	; 10f8 <.text+0x10f8>
    10dc:	e5112dfb 	ldr	r2, [r1, #-3579]
    10e0:	e5830000 	str	r0, [r3]
    10e4:	e59f0010 	ldr	r0, [pc, #16]	; 10fc <.text+0x10fc>
    10e8:	e3822008 	orr	r2, r2, #8	; 0x8
    10ec:	e5012dfb 	str	r2, [r1, #-3579]
    10f0:	eafffd8c 	b	728 <puts>
    10f4:	ffe0cfff 	undefined instruction 0xffe0cfff
    10f8:	40000214 	andmi	r0, r0, r4, lsl r2
    10fc:	00001d10 	andeq	r1, r0, r0, lsl sp

00001100 <USBHwRegisterEPIntHandler>:
    1100:	e92d4010 	stmdb	sp!, {r4, lr}
    1104:	e200300f 	and	r3, r0, #15	; 0xf
    1108:	e1a03083 	mov	r3, r3, lsl #1
    110c:	e2002080 	and	r2, r0, #128	; 0x80
    1110:	e183e3a2 	orr	lr, r3, r2, lsr #7
    1114:	e35e001f 	cmp	lr, #31	; 0x1f
    1118:	e1a04001 	mov	r4, r1
    111c:	e24dd004 	sub	sp, sp, #4	; 0x4
    1120:	e20010ff 	and	r1, r0, #255	; 0xff
    1124:	da000007 	ble	1148 <USBHwRegisterEPIntHandler+0x48>
    1128:	e3a0c0d2 	mov	ip, #210	; 0xd2
    112c:	e59f0050 	ldr	r0, [pc, #80]	; 1184 <.text+0x1184>
    1130:	e59f1050 	ldr	r1, [pc, #80]	; 1188 <.text+0x1188>
    1134:	e59f2050 	ldr	r2, [pc, #80]	; 118c <.text+0x118c>
    1138:	e59f3050 	ldr	r3, [pc, #80]	; 1190 <.text+0x1190>
    113c:	e58dc000 	str	ip, [sp]
    1140:	ebfffd42 	bl	650 <printf>
    1144:	eafffffe 	b	1144 <USBHwRegisterEPIntHandler+0x44>
    1148:	e59fc044 	ldr	ip, [pc, #68]	; 1194 <.text+0x1194>
    114c:	e51c3dcb 	ldr	r3, [ip, #-3531]
    1150:	e3a02001 	mov	r2, #1	; 0x1
    1154:	e1833e12 	orr	r3, r3, r2, lsl lr
    1158:	e50c3dcb 	str	r3, [ip, #-3531]
    115c:	e51c2dfb 	ldr	r2, [ip, #-3579]
    1160:	e59f3030 	ldr	r3, [pc, #48]	; 1198 <.text+0x1198>
    1164:	e59f0030 	ldr	r0, [pc, #48]	; 119c <.text+0x119c>
    1168:	e3822004 	orr	r2, r2, #4	; 0x4
    116c:	e1a0e0ae 	mov	lr, lr, lsr #1
    1170:	e783410e 	str	r4, [r3, lr, lsl #2]
    1174:	e50c2dfb 	str	r2, [ip, #-3579]
    1178:	e28dd004 	add	sp, sp, #4	; 0x4
    117c:	e8bd4010 	ldmia	sp!, {r4, lr}
    1180:	eafffd32 	b	650 <printf>
    1184:	00001d38 	andeq	r1, r0, r8, lsr sp
    1188:	00001d60 	andeq	r1, r0, r0, ror #26
    118c:	00001d68 	andeq	r1, r0, r8, ror #26
    1190:	00001bec 	andeq	r1, r0, ip, ror #23
    1194:	ffe0cfff 	undefined instruction 0xffe0cfff
    1198:	40000218 	andmi	r0, r0, r8, lsl r2
    119c:	00001d74 	andeq	r1, r0, r4, ror sp

000011a0 <USBRegisterRequestHandler>:
    11a0:	e52de004 	str	lr, [sp, #-4]!
    11a4:	e3500000 	cmp	r0, #0	; 0x0
    11a8:	e24dd004 	sub	sp, sp, #4	; 0x4
    11ac:	aa000007 	bge	11d0 <USBRegisterRequestHandler+0x30>
    11b0:	e3a0c0e2 	mov	ip, #226	; 0xe2
    11b4:	e59f0054 	ldr	r0, [pc, #84]	; 1210 <.text+0x1210>
    11b8:	e59f1054 	ldr	r1, [pc, #84]	; 1214 <.text+0x1214>
    11bc:	e59f2054 	ldr	r2, [pc, #84]	; 1218 <.text+0x1218>
    11c0:	e59f3054 	ldr	r3, [pc, #84]	; 121c <.text+0x121c>
    11c4:	e58dc000 	str	ip, [sp]
    11c8:	ebfffd20 	bl	650 <printf>
    11cc:	eafffffe 	b	11cc <USBRegisterRequestHandler+0x2c>
    11d0:	e3500003 	cmp	r0, #3	; 0x3
    11d4:	da000007 	ble	11f8 <USBRegisterRequestHandler+0x58>
    11d8:	e3a0c0e3 	mov	ip, #227	; 0xe3
    11dc:	e59f002c 	ldr	r0, [pc, #44]	; 1210 <.text+0x1210>
    11e0:	e59f1038 	ldr	r1, [pc, #56]	; 1220 <.text+0x1220>
    11e4:	e59f202c 	ldr	r2, [pc, #44]	; 1218 <.text+0x1218>
    11e8:	e59f302c 	ldr	r3, [pc, #44]	; 121c <.text+0x121c>
    11ec:	e58dc000 	str	ip, [sp]
    11f0:	ebfffd16 	bl	650 <printf>
    11f4:	eafffffe 	b	11f4 <USBRegisterRequestHandler+0x54>
    11f8:	e59f3024 	ldr	r3, [pc, #36]	; 1224 <.text+0x1224>
    11fc:	e7832100 	str	r2, [r3, r0, lsl #2]
    1200:	e59f3020 	ldr	r3, [pc, #32]	; 1228 <.text+0x1228>
    1204:	e7831100 	str	r1, [r3, r0, lsl #2]
    1208:	e28dd004 	add	sp, sp, #4	; 0x4
    120c:	e8bd8000 	ldmia	sp!, {pc}
    1210:	00001d38 	andeq	r1, r0, r8, lsr sp
    1214:	00001d94 	muleq	r0, r4, sp
    1218:	00001da0 	andeq	r1, r0, r0, lsr #27
    121c:	00001c08 	andeq	r1, r0, r8, lsl #24
    1220:	00001db0 	streqh	r1, [r0], -r0
    1224:	40000268 	andmi	r0, r0, r8, ror #4
    1228:	40000258 	andmi	r0, r0, r8, asr r2

0000122c <_HandleRequest>:
    122c:	e92d4010 	stmdb	sp!, {r4, lr}
    1230:	e5d03000 	ldrb	r3, [r0]
    1234:	e1a032a3 	mov	r3, r3, lsr #5
    1238:	e203c003 	and	ip, r3, #3	; 0x3
    123c:	e59f3028 	ldr	r3, [pc, #40]	; 126c <.text+0x126c>
    1240:	e793410c 	ldr	r4, [r3, ip, lsl #2]
    1244:	e3540000 	cmp	r4, #0	; 0x0
    1248:	1a000004 	bne	1260 <_HandleRequest+0x34>
    124c:	e1a0100c 	mov	r1, ip
    1250:	e59f0018 	ldr	r0, [pc, #24]	; 1270 <.text+0x1270>
    1254:	ebfffcfd 	bl	650 <printf>
    1258:	e1a00004 	mov	r0, r4
    125c:	e8bd8010 	ldmia	sp!, {r4, pc}
    1260:	e1a0e00f 	mov	lr, pc
    1264:	e12fff14 	bx	r4
    1268:	e8bd8010 	ldmia	sp!, {r4, pc}
    126c:	40000258 	andmi	r0, r0, r8, asr r2
    1270:	00001dbc 	streqh	r1, [r0], -ip

00001274 <StallControlPipe>:
    1274:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
    1278:	e1a03000 	mov	r3, r0
    127c:	e3a01001 	mov	r1, #1	; 0x1
    1280:	e3a00080 	mov	r0, #128	; 0x80
    1284:	e20350ff 	and	r5, r3, #255	; 0xff
    1288:	ebfffe09 	bl	ab4 <USBHwEPStall>
    128c:	e59f0030 	ldr	r0, [pc, #48]	; 12c4 <.text+0x12c4>
    1290:	ebfffcee 	bl	650 <printf>
    1294:	e59f602c 	ldr	r6, [pc, #44]	; 12c8 <.text+0x12c8>
    1298:	e3a04000 	mov	r4, #0	; 0x0
    129c:	e7d41006 	ldrb	r1, [r4, r6]
    12a0:	e59f0024 	ldr	r0, [pc, #36]	; 12cc <.text+0x12cc>
    12a4:	e2844001 	add	r4, r4, #1	; 0x1
    12a8:	ebfffce8 	bl	650 <printf>
    12ac:	e3540008 	cmp	r4, #8	; 0x8
    12b0:	1afffff9 	bne	129c <StallControlPipe+0x28>
    12b4:	e59f0014 	ldr	r0, [pc, #20]	; 12d0 <.text+0x12d0>
    12b8:	e1a01005 	mov	r1, r5
    12bc:	e8bd4070 	ldmia	sp!, {r4, r5, r6, lr}
    12c0:	eafffce2 	b	650 <printf>
    12c4:	00001dd8 	ldreqd	r1, [r0], -r8
    12c8:	40000278 	andmi	r0, r0, r8, ror r2
    12cc:	00001de4 	andeq	r1, r0, r4, ror #27
    12d0:	00001dec 	andeq	r1, r0, ip, ror #27

000012d4 <DataIn>:
    12d4:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
    12d8:	e59f6038 	ldr	r6, [pc, #56]	; 1318 <.text+0x1318>
    12dc:	e5964000 	ldr	r4, [r6]
    12e0:	e59f5034 	ldr	r5, [pc, #52]	; 131c <.text+0x131c>
    12e4:	e3540040 	cmp	r4, #64	; 0x40
    12e8:	a3a04040 	movge	r4, #64	; 0x40
    12ec:	e1a02004 	mov	r2, r4
    12f0:	e3a00080 	mov	r0, #128	; 0x80
    12f4:	e5951000 	ldr	r1, [r5]
    12f8:	ebfffdf5 	bl	ad4 <USBHwEPWrite>
    12fc:	e5953000 	ldr	r3, [r5]
    1300:	e5962000 	ldr	r2, [r6]
    1304:	e0833004 	add	r3, r3, r4
    1308:	e0642002 	rsb	r2, r4, r2
    130c:	e5853000 	str	r3, [r5]
    1310:	e5862000 	str	r2, [r6]
    1314:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
    1318:	40000284 	andmi	r0, r0, r4, lsl #5
    131c:	40000280 	andmi	r0, r0, r0, lsl #5

00001320 <USBHandleControlTransfer>:
    1320:	e92d40f0 	stmdb	sp!, {r4, r5, r6, r7, lr}
    1324:	e21000ff 	ands	r0, r0, #255	; 0xff
    1328:	e24dd004 	sub	sp, sp, #4	; 0x4
    132c:	e20170ff 	and	r7, r1, #255	; 0xff
    1330:	1a000051 	bne	147c <USBHandleControlTransfer+0x15c>
    1334:	e3110004 	tst	r1, #4	; 0x4
    1338:	e59f6178 	ldr	r6, [pc, #376]	; 14b8 <.text+0x14b8>
    133c:	0a000021 	beq	13c8 <USBHandleControlTransfer+0xa8>
    1340:	e59f5174 	ldr	r5, [pc, #372]	; 14bc <.text+0x14bc>
    1344:	e3a02008 	mov	r2, #8	; 0x8
    1348:	e1a01005 	mov	r1, r5
    134c:	ebfffe03 	bl	b60 <USBHwEPRead>
    1350:	e5d51001 	ldrb	r1, [r5, #1]
    1354:	e59f0164 	ldr	r0, [pc, #356]	; 14c0 <.text+0x14c0>
    1358:	ebfffcbc 	bl	650 <printf>
    135c:	e5d50000 	ldrb	r0, [r5]
    1360:	e59f215c 	ldr	r2, [pc, #348]	; 14c4 <.text+0x14c4>
    1364:	e1a032a0 	mov	r3, r0, lsr #5
    1368:	e1d510b6 	ldrh	r1, [r5, #6]
    136c:	e2033003 	and	r3, r3, #3	; 0x3
    1370:	e7923103 	ldr	r3, [r2, r3, lsl #2]
    1374:	e59f414c 	ldr	r4, [pc, #332]	; 14c8 <.text+0x14c8>
    1378:	e59f214c 	ldr	r2, [pc, #332]	; 14cc <.text+0x14cc>
    137c:	e3510000 	cmp	r1, #0	; 0x0
    1380:	e5823000 	str	r3, [r2]
    1384:	e5861000 	str	r1, [r6]
    1388:	e5841000 	str	r1, [r4]
    138c:	0a000001 	beq	1398 <USBHandleControlTransfer+0x78>
    1390:	e1b003a0 	movs	r0, r0, lsr #7
    1394:	0a000045 	beq	14b0 <USBHandleControlTransfer+0x190>
    1398:	e1a00005 	mov	r0, r5
    139c:	e1a01004 	mov	r1, r4
    13a0:	ebffffa1 	bl	122c <_HandleRequest>
    13a4:	e3500000 	cmp	r0, #0	; 0x0
    13a8:	059f0120 	ldreq	r0, [pc, #288]	; 14d0 <.text+0x14d0>
    13ac:	0a000022 	beq	143c <USBHandleControlTransfer+0x11c>
    13b0:	e1d520b6 	ldrh	r2, [r5, #6]
    13b4:	e5943000 	ldr	r3, [r4]
    13b8:	e1520003 	cmp	r2, r3
    13bc:	d5862000 	strle	r2, [r6]
    13c0:	c5863000 	strgt	r3, [r6]
    13c4:	ea00002e 	b	1484 <USBHandleControlTransfer+0x164>
    13c8:	e5962000 	ldr	r2, [r6]
    13cc:	e3520000 	cmp	r2, #0	; 0x0
    13d0:	da00001e 	ble	1450 <USBHandleControlTransfer+0x130>
    13d4:	e59f40f0 	ldr	r4, [pc, #240]	; 14cc <.text+0x14cc>
    13d8:	e5941000 	ldr	r1, [r4]
    13dc:	ebfffddf 	bl	b60 <USBHwEPRead>
    13e0:	e3500000 	cmp	r0, #0	; 0x0
    13e4:	ba000015 	blt	1440 <USBHandleControlTransfer+0x120>
    13e8:	e5962000 	ldr	r2, [r6]
    13ec:	e5943000 	ldr	r3, [r4]
    13f0:	e0602002 	rsb	r2, r0, r2
    13f4:	e0833000 	add	r3, r3, r0
    13f8:	e3520000 	cmp	r2, #0	; 0x0
    13fc:	e5843000 	str	r3, [r4]
    1400:	e5862000 	str	r2, [r6]
    1404:	1a000029 	bne	14b0 <USBHandleControlTransfer+0x190>
    1408:	e59f00ac 	ldr	r0, [pc, #172]	; 14bc <.text+0x14bc>
    140c:	e5d03000 	ldrb	r3, [r0]
    1410:	e59f20ac 	ldr	r2, [pc, #172]	; 14c4 <.text+0x14c4>
    1414:	e1a032a3 	mov	r3, r3, lsr #5
    1418:	e2033003 	and	r3, r3, #3	; 0x3
    141c:	e7923103 	ldr	r3, [r2, r3, lsl #2]
    1420:	e59f10a0 	ldr	r1, [pc, #160]	; 14c8 <.text+0x14c8>
    1424:	e1a02004 	mov	r2, r4
    1428:	e5843000 	str	r3, [r4]
    142c:	ebffff7e 	bl	122c <_HandleRequest>
    1430:	e3500000 	cmp	r0, #0	; 0x0
    1434:	1a000012 	bne	1484 <USBHandleControlTransfer+0x164>
    1438:	e59f0094 	ldr	r0, [pc, #148]	; 14d4 <.text+0x14d4>
    143c:	ebfffcb9 	bl	728 <puts>
    1440:	e1a00007 	mov	r0, r7
    1444:	e28dd004 	add	sp, sp, #4	; 0x4
    1448:	e8bd40f0 	ldmia	sp!, {r4, r5, r6, r7, lr}
    144c:	eaffff88 	b	1274 <StallControlPipe>
    1450:	e1a01000 	mov	r1, r0
    1454:	e1a02000 	mov	r2, r0
    1458:	ebfffdc0 	bl	b60 <USBHwEPRead>
    145c:	e59f2074 	ldr	r2, [pc, #116]	; 14d8 <.text+0x14d8>
    1460:	e59f3074 	ldr	r3, [pc, #116]	; 14dc <.text+0x14dc>
    1464:	e3500000 	cmp	r0, #0	; 0x0
    1468:	d1a00002 	movle	r0, r2
    146c:	c1a00003 	movgt	r0, r3
    1470:	e28dd004 	add	sp, sp, #4	; 0x4
    1474:	e8bd40f0 	ldmia	sp!, {r4, r5, r6, r7, lr}
    1478:	eafffc74 	b	650 <printf>
    147c:	e3500080 	cmp	r0, #128	; 0x80
    1480:	1a000002 	bne	1490 <USBHandleControlTransfer+0x170>
    1484:	e28dd004 	add	sp, sp, #4	; 0x4
    1488:	e8bd40f0 	ldmia	sp!, {r4, r5, r6, r7, lr}
    148c:	eaffff90 	b	12d4 <DataIn>
    1490:	e3a0c0d4 	mov	ip, #212	; 0xd4
    1494:	e59f0044 	ldr	r0, [pc, #68]	; 14e0 <.text+0x14e0>
    1498:	e59f1044 	ldr	r1, [pc, #68]	; 14e4 <.text+0x14e4>
    149c:	e59f2044 	ldr	r2, [pc, #68]	; 14e8 <.text+0x14e8>
    14a0:	e59f3044 	ldr	r3, [pc, #68]	; 14ec <.text+0x14ec>
    14a4:	e58dc000 	str	ip, [sp]
    14a8:	ebfffc68 	bl	650 <printf>
    14ac:	eafffffe 	b	14ac <USBHandleControlTransfer+0x18c>
    14b0:	e28dd004 	add	sp, sp, #4	; 0x4
    14b4:	e8bd80f0 	ldmia	sp!, {r4, r5, r6, r7, pc}
    14b8:	40000284 	andmi	r0, r0, r4, lsl #5
    14bc:	40000278 	andmi	r0, r0, r8, ror r2
    14c0:	00001df8 	streqd	r1, [r0], -r8
    14c4:	40000268 	andmi	r0, r0, r8, ror #4
    14c8:	40000288 	andmi	r0, r0, r8, lsl #5
    14cc:	40000280 	andmi	r0, r0, r0, lsl #5
    14d0:	00001dfc 	streqd	r1, [r0], -ip
    14d4:	00001e14 	andeq	r1, r0, r4, lsl lr
    14d8:	00001d5c 	andeq	r1, r0, ip, asr sp
    14dc:	00001e2c 	andeq	r1, r0, ip, lsr #28
    14e0:	00001d38 	andeq	r1, r0, r8, lsr sp
    14e4:	00001e30 	andeq	r1, r0, r0, lsr lr
    14e8:	00001da0 	andeq	r1, r0, r0, lsr #27
    14ec:	00001c24 	andeq	r1, r0, r4, lsr #24

000014f0 <USBRegisterDescriptors>:
    14f0:	e59f3004 	ldr	r3, [pc, #4]	; 14fc <.text+0x14fc>
    14f4:	e5830000 	str	r0, [r3]
    14f8:	e12fff1e 	bx	lr
    14fc:	40000294 	mulmi	r0, r4, r2

00001500 <USBRegisterCustomReqHandler>:
    1500:	e59f3004 	ldr	r3, [pc, #4]	; 150c <.text+0x150c>
    1504:	e5830000 	str	r0, [r3]
    1508:	e12fff1e 	bx	lr
    150c:	4000028c 	andmi	r0, r0, ip, lsl #5

00001510 <USBGetDescriptor>:
    1510:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
    1514:	e59f10ac 	ldr	r1, [pc, #172]	; 15c8 <.text+0x15c8>
    1518:	e5911000 	ldr	r1, [r1]
    151c:	e1a00800 	mov	r0, r0, lsl #16
    1520:	e3510000 	cmp	r1, #0	; 0x0
    1524:	e1a0c820 	mov	ip, r0, lsr #16
    1528:	e1a05002 	mov	r5, r2
    152c:	e24dd004 	sub	sp, sp, #4	; 0x4
    1530:	e1a06003 	mov	r6, r3
    1534:	11a00c20 	movne	r0, r0, lsr #24
    1538:	120ce0ff 	andne	lr, ip, #255	; 0xff
    153c:	13a02000 	movne	r2, #0	; 0x0
    1540:	1a000017 	bne	15a4 <USBGetDescriptor+0x94>
    1544:	e3a0c06e 	mov	ip, #110	; 0x6e
    1548:	e59f007c 	ldr	r0, [pc, #124]	; 15cc <.text+0x15cc>
    154c:	e59f107c 	ldr	r1, [pc, #124]	; 15d0 <.text+0x15d0>
    1550:	e59f207c 	ldr	r2, [pc, #124]	; 15d4 <.text+0x15d4>
    1554:	e59f307c 	ldr	r3, [pc, #124]	; 15d8 <.text+0x15d8>
    1558:	e58dc000 	str	ip, [sp]
    155c:	ebfffc3b 	bl	650 <printf>
    1560:	eafffffe 	b	1560 <USBGetDescriptor+0x50>
    1564:	e5d13001 	ldrb	r3, [r1, #1]
    1568:	e1530000 	cmp	r3, r0
    156c:	1a00000b 	bne	15a0 <USBGetDescriptor+0x90>
    1570:	e152000e 	cmp	r2, lr
    1574:	1a000008 	bne	159c <USBGetDescriptor+0x8c>
    1578:	e5861000 	str	r1, [r6]
    157c:	e3500002 	cmp	r0, #2	; 0x2
    1580:	05d13002 	ldreqb	r3, [r1, #2]
    1584:	05d12003 	ldreqb	r2, [r1, #3]
    1588:	15d13000 	ldrneb	r3, [r1]
    158c:	01833402 	orreq	r3, r3, r2, lsl #8
    1590:	e3a00001 	mov	r0, #1	; 0x1
    1594:	e5853000 	str	r3, [r5]
    1598:	ea000008 	b	15c0 <USBGetDescriptor+0xb0>
    159c:	e2822001 	add	r2, r2, #1	; 0x1
    15a0:	e0811004 	add	r1, r1, r4
    15a4:	e5d14000 	ldrb	r4, [r1]
    15a8:	e3540000 	cmp	r4, #0	; 0x0
    15ac:	1affffec 	bne	1564 <USBGetDescriptor+0x54>
    15b0:	e1a0100c 	mov	r1, ip
    15b4:	e59f0020 	ldr	r0, [pc, #32]	; 15dc <.text+0x15dc>
    15b8:	ebfffc24 	bl	650 <printf>
    15bc:	e1a00004 	mov	r0, r4
    15c0:	e28dd004 	add	sp, sp, #4	; 0x4
    15c4:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
    15c8:	40000294 	mulmi	r0, r4, r2
    15cc:	00001d38 	andeq	r1, r0, r8, lsr sp
    15d0:	00001e38 	andeq	r1, r0, r8, lsr lr
    15d4:	00001e4c 	andeq	r1, r0, ip, asr #28
    15d8:	00001c54 	andeq	r1, r0, r4, asr ip
    15dc:	00001e58 	andeq	r1, r0, r8, asr lr

000015e0 <USBHandleStandardRequest>:
    15e0:	e92d41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
    15e4:	e59f32f8 	ldr	r3, [pc, #760]	; 18e4 <.text+0x18e4>
    15e8:	e5933000 	ldr	r3, [r3]
    15ec:	e3530000 	cmp	r3, #0	; 0x0
    15f0:	e24dd004 	sub	sp, sp, #4	; 0x4
    15f4:	e1a05000 	mov	r5, r0
    15f8:	e1a06001 	mov	r6, r1
    15fc:	e1a04002 	mov	r4, r2
    1600:	0a000003 	beq	1614 <USBHandleStandardRequest+0x34>
    1604:	e1a0e00f 	mov	lr, pc
    1608:	e12fff13 	bx	r3
    160c:	e3500000 	cmp	r0, #0	; 0x0
    1610:	1a0000a9 	bne	18bc <.text+0x18bc>
    1614:	e5d53000 	ldrb	r3, [r5]
    1618:	e203301f 	and	r3, r3, #31	; 0x1f
    161c:	e3530001 	cmp	r3, #1	; 0x1
    1620:	0a000059 	beq	178c <.text+0x178c>
    1624:	e3530002 	cmp	r3, #2	; 0x2
    1628:	0a00007b 	beq	181c <.text+0x181c>
    162c:	e3530000 	cmp	r3, #0	; 0x0
    1630:	1a0000a7 	bne	18d4 <.text+0x18d4>
    1634:	e5d51001 	ldrb	r1, [r5, #1]
    1638:	e5940000 	ldr	r0, [r4]
    163c:	e3510009 	cmp	r1, #9	; 0x9
    1640:	979ff101 	ldrls	pc, [pc, r1, lsl #2]
    1644:	ea00004e 	b	1784 <.text+0x1784>
    1648:	000017d0 	ldreqd	r1, [r0], -r0
    164c:	000018d4 	ldreqd	r1, [r0], -r4
    1650:	00001784 	andeq	r1, r0, r4, lsl #15
    1654:	000018d4 	ldreqd	r1, [r0], -r4
    1658:	00001784 	andeq	r1, r0, r4, lsl #15
    165c:	00001670 	andeq	r1, r0, r0, ror r6
    1660:	0000167c 	andeq	r1, r0, ip, ror r6
    1664:	0000177c 	andeq	r1, r0, ip, ror r7
    1668:	000016a4 	andeq	r1, r0, r4, lsr #13
    166c:	000016bc 	streqh	r1, [r0], -ip
    1670:	e5d50002 	ldrb	r0, [r5, #2]
    1674:	ebfffcf3 	bl	a48 <USBHwSetAddress>
    1678:	ea00008f 	b	18bc <.text+0x18bc>
    167c:	e1d510b2 	ldrh	r1, [r5, #2]
    1680:	e59f0260 	ldr	r0, [pc, #608]	; 18e8 <.text+0x18e8>
    1684:	ebfffbf1 	bl	650 <printf>
    1688:	e1d510b4 	ldrh	r1, [r5, #4]
    168c:	e1d500b2 	ldrh	r0, [r5, #2]
    1690:	e1a02006 	mov	r2, r6
    1694:	e1a03004 	mov	r3, r4
    1698:	e28dd004 	add	sp, sp, #4	; 0x4
    169c:	e8bd41f0 	ldmia	sp!, {r4, r5, r6, r7, r8, lr}
    16a0:	eaffff9a 	b	1510 <USBGetDescriptor>
    16a4:	e59f3240 	ldr	r3, [pc, #576]	; 18ec <.text+0x18ec>
    16a8:	e5d32000 	ldrb	r2, [r3]
    16ac:	e3a03001 	mov	r3, #1	; 0x1
    16b0:	e1a01003 	mov	r1, r3
    16b4:	e5c02000 	strb	r2, [r0]
    16b8:	ea000072 	b	1888 <.text+0x1888>
    16bc:	e59f322c 	ldr	r3, [pc, #556]	; 18f0 <.text+0x18f0>
    16c0:	e5933000 	ldr	r3, [r3]
    16c4:	e3530000 	cmp	r3, #0	; 0x0
    16c8:	e1d520b2 	ldrh	r2, [r5, #2]
    16cc:	1a000007 	bne	16f0 <.text+0x16f0>
    16d0:	e3a0c0a5 	mov	ip, #165	; 0xa5
    16d4:	e59f0218 	ldr	r0, [pc, #536]	; 18f4 <.text+0x18f4>
    16d8:	e59f1218 	ldr	r1, [pc, #536]	; 18f8 <.text+0x18f8>
    16dc:	e59f2218 	ldr	r2, [pc, #536]	; 18fc <.text+0x18fc>
    16e0:	e59f3218 	ldr	r3, [pc, #536]	; 1900 <.text+0x1900>
    16e4:	e58dc000 	str	ip, [sp]
    16e8:	ebfffbd8 	bl	650 <printf>
    16ec:	eafffffe 	b	16ec <.text+0x16ec>
    16f0:	e21270ff 	ands	r7, r2, #255	; 0xff
    16f4:	13a060ff 	movne	r6, #255	; 0xff
    16f8:	01a00007 	moveq	r0, r7
    16fc:	11a04003 	movne	r4, r3
    1700:	11a08006 	movne	r8, r6
    1704:	1a000012 	bne	1754 <.text+0x1754>
    1708:	ea000015 	b	1764 <.text+0x1764>
    170c:	e5d43001 	ldrb	r3, [r4, #1]
    1710:	e3530004 	cmp	r3, #4	; 0x4
    1714:	05d46003 	ldreqb	r6, [r4, #3]
    1718:	0a00000b 	beq	174c <.text+0x174c>
    171c:	e3530005 	cmp	r3, #5	; 0x5
    1720:	0a000002 	beq	1730 <.text+0x1730>
    1724:	e3530002 	cmp	r3, #2	; 0x2
    1728:	05d48005 	ldreqb	r8, [r4, #5]
    172c:	ea000006 	b	174c <.text+0x174c>
    1730:	e1580007 	cmp	r8, r7
    1734:	03560000 	cmpeq	r6, #0	; 0x0
    1738:	05d43005 	ldreqb	r3, [r4, #5]
    173c:	05d41004 	ldreqb	r1, [r4, #4]
    1740:	05d40002 	ldreqb	r0, [r4, #2]
    1744:	01811403 	orreq	r1, r1, r3, lsl #8
    1748:	0bfffca8 	bleq	9f0 <USBHwEPConfig>
    174c:	e5d43000 	ldrb	r3, [r4]
    1750:	e0844003 	add	r4, r4, r3
    1754:	e5d43000 	ldrb	r3, [r4]
    1758:	e3530000 	cmp	r3, #0	; 0x0
    175c:	1affffea 	bne	170c <.text+0x170c>
    1760:	e3a00001 	mov	r0, #1	; 0x1
    1764:	ebfffd4d 	bl	ca0 <USBHwConfigDevice>
    1768:	e1d520b2 	ldrh	r2, [r5, #2]
    176c:	e59f3178 	ldr	r3, [pc, #376]	; 18ec <.text+0x18ec>
    1770:	e3a01001 	mov	r1, #1	; 0x1
    1774:	e5c32000 	strb	r2, [r3]
    1778:	ea000056 	b	18d8 <.text+0x18d8>
    177c:	e59f0180 	ldr	r0, [pc, #384]	; 1904 <.text+0x1904>
    1780:	ea000052 	b	18d0 <.text+0x18d0>
    1784:	e59f017c 	ldr	r0, [pc, #380]	; 1908 <.text+0x1908>
    1788:	ea000050 	b	18d0 <.text+0x18d0>
    178c:	e5d51001 	ldrb	r1, [r5, #1]
    1790:	e5940000 	ldr	r0, [r4]
    1794:	e351000b 	cmp	r1, #11	; 0xb
    1798:	979ff101 	ldrls	pc, [pc, r1, lsl #2]
    179c:	ea00001c 	b	1814 <.text+0x1814>
    17a0:	000017d0 	ldreqd	r1, [r0], -r0
    17a4:	000018d4 	ldreqd	r1, [r0], -r4
    17a8:	00001814 	andeq	r1, r0, r4, lsl r8
    17ac:	000018d4 	ldreqd	r1, [r0], -r4
    17b0:	00001814 	andeq	r1, r0, r4, lsl r8
    17b4:	00001814 	andeq	r1, r0, r4, lsl r8
    17b8:	00001814 	andeq	r1, r0, r4, lsl r8
    17bc:	00001814 	andeq	r1, r0, r4, lsl r8
    17c0:	00001814 	andeq	r1, r0, r4, lsl r8
    17c4:	00001814 	andeq	r1, r0, r4, lsl r8
    17c8:	000017e4 	andeq	r1, r0, r4, ror #15
    17cc:	000017fc 	streqd	r1, [r0], -ip
    17d0:	e3a03000 	mov	r3, #0	; 0x0
    17d4:	e3a01001 	mov	r1, #1	; 0x1
    17d8:	e5c03001 	strb	r3, [r0, #1]
    17dc:	e5c03000 	strb	r3, [r0]
    17e0:	ea000027 	b	1884 <.text+0x1884>
    17e4:	e3a02001 	mov	r2, #1	; 0x1
    17e8:	e3a03000 	mov	r3, #0	; 0x0
    17ec:	e1a01002 	mov	r1, r2
    17f0:	e5c03000 	strb	r3, [r0]
    17f4:	e5862000 	str	r2, [r6]
    17f8:	ea000036 	b	18d8 <.text+0x18d8>
    17fc:	e1d500b2 	ldrh	r0, [r5, #2]
    1800:	e3500000 	cmp	r0, #0	; 0x0
    1804:	03a01001 	moveq	r1, #1	; 0x1
    1808:	05860000 	streq	r0, [r6]
    180c:	0a000031 	beq	18d8 <.text+0x18d8>
    1810:	ea00002f 	b	18d4 <.text+0x18d4>
    1814:	e59f00f0 	ldr	r0, [pc, #240]	; 190c <.text+0x190c>
    1818:	ea00002c 	b	18d0 <.text+0x18d0>
    181c:	e5d51001 	ldrb	r1, [r5, #1]
    1820:	e5944000 	ldr	r4, [r4]
    1824:	e351000c 	cmp	r1, #12	; 0xc
    1828:	979ff101 	ldrls	pc, [pc, r1, lsl #2]
    182c:	ea000026 	b	18cc <.text+0x18cc>
    1830:	00001864 	andeq	r1, r0, r4, ror #16
    1834:	00001890 	muleq	r0, r0, r8
    1838:	000018cc 	andeq	r1, r0, ip, asr #17
    183c:	000018a4 	andeq	r1, r0, r4, lsr #17
    1840:	000018cc 	andeq	r1, r0, ip, asr #17
    1844:	000018cc 	andeq	r1, r0, ip, asr #17
    1848:	000018cc 	andeq	r1, r0, ip, asr #17
    184c:	000018cc 	andeq	r1, r0, ip, asr #17
    1850:	000018cc 	andeq	r1, r0, ip, asr #17
    1854:	000018cc 	andeq	r1, r0, ip, asr #17
    1858:	000018cc 	andeq	r1, r0, ip, asr #17
    185c:	000018cc 	andeq	r1, r0, ip, asr #17
    1860:	000018c4 	andeq	r1, r0, r4, asr #17
    1864:	e5d50004 	ldrb	r0, [r5, #4]
    1868:	ebfffc89 	bl	a94 <USBHwEPGetStatus>
    186c:	e1a000a0 	mov	r0, r0, lsr #1
    1870:	e2000001 	and	r0, r0, #1	; 0x1
    1874:	e3a03000 	mov	r3, #0	; 0x0
    1878:	e5c43001 	strb	r3, [r4, #1]
    187c:	e5c40000 	strb	r0, [r4]
    1880:	e3a01001 	mov	r1, #1	; 0x1
    1884:	e2833002 	add	r3, r3, #2	; 0x2
    1888:	e5863000 	str	r3, [r6]
    188c:	ea000011 	b	18d8 <.text+0x18d8>
    1890:	e1d510b2 	ldrh	r1, [r5, #2]
    1894:	e3510000 	cmp	r1, #0	; 0x0
    1898:	05d50004 	ldreqb	r0, [r5, #4]
    189c:	0a000005 	beq	18b8 <.text+0x18b8>
    18a0:	ea00000b 	b	18d4 <.text+0x18d4>
    18a4:	e1d530b2 	ldrh	r3, [r5, #2]
    18a8:	e3530000 	cmp	r3, #0	; 0x0
    18ac:	1a000008 	bne	18d4 <.text+0x18d4>
    18b0:	e5d50004 	ldrb	r0, [r5, #4]
    18b4:	e3a01001 	mov	r1, #1	; 0x1
    18b8:	ebfffc7d 	bl	ab4 <USBHwEPStall>
    18bc:	e3a01001 	mov	r1, #1	; 0x1
    18c0:	ea000004 	b	18d8 <.text+0x18d8>
    18c4:	e59f0044 	ldr	r0, [pc, #68]	; 1910 <.text+0x1910>
    18c8:	ea000000 	b	18d0 <.text+0x18d0>
    18cc:	e59f0040 	ldr	r0, [pc, #64]	; 1914 <.text+0x1914>
    18d0:	ebfffb5e 	bl	650 <printf>
    18d4:	e3a01000 	mov	r1, #0	; 0x0
    18d8:	e1a00001 	mov	r0, r1
    18dc:	e28dd004 	add	sp, sp, #4	; 0x4
    18e0:	e8bd81f0 	ldmia	sp!, {r4, r5, r6, r7, r8, pc}
    18e4:	4000028c 	andmi	r0, r0, ip, lsl #5
    18e8:	00001e6c 	andeq	r1, r0, ip, ror #28
    18ec:	40000290 	mulmi	r0, r0, r2
    18f0:	40000294 	mulmi	r0, r4, r2
    18f4:	00001d38 	andeq	r1, r0, r8, lsr sp
    18f8:	00001e38 	andeq	r1, r0, r8, lsr lr
    18fc:	00001e4c 	andeq	r1, r0, ip, asr #28
    1900:	00001c40 	andeq	r1, r0, r0, asr #24
    1904:	00001e70 	andeq	r1, r0, r0, ror lr
    1908:	00001e90 	muleq	r0, r0, lr
    190c:	00001ea8 	andeq	r1, r0, r8, lsr #29
    1910:	00001ec4 	andeq	r1, r0, r4, asr #29
    1914:	00001ee0 	andeq	r1, r0, r0, ror #29

00001918 <USBInit>:
    1918:	e92d4010 	stmdb	sp!, {r4, lr}
    191c:	e59f4050 	ldr	r4, [pc, #80]	; 1974 <.text+0x1974>
    1920:	ebfffd3a 	bl	e10 <USBHwInit>
    1924:	e59f004c 	ldr	r0, [pc, #76]	; 1978 <.text+0x1978>
    1928:	ebfffde9 	bl	10d4 <USBHwRegisterDevIntHandler>
    192c:	e1a01004 	mov	r1, r4
    1930:	e3a00000 	mov	r0, #0	; 0x0
    1934:	ebfffdf1 	bl	1100 <USBHwRegisterEPIntHandler>
    1938:	e1a01004 	mov	r1, r4
    193c:	e3a00080 	mov	r0, #128	; 0x80
    1940:	ebfffdee 	bl	1100 <USBHwRegisterEPIntHandler>
    1944:	e3a00000 	mov	r0, #0	; 0x0
    1948:	e3a01040 	mov	r1, #64	; 0x40
    194c:	ebfffc27 	bl	9f0 <USBHwEPConfig>
    1950:	e3a00080 	mov	r0, #128	; 0x80
    1954:	e3a01040 	mov	r1, #64	; 0x40
    1958:	ebfffc24 	bl	9f0 <USBHwEPConfig>
    195c:	e3a00000 	mov	r0, #0	; 0x0
    1960:	e59f1014 	ldr	r1, [pc, #20]	; 197c <.text+0x197c>
    1964:	e59f2014 	ldr	r2, [pc, #20]	; 1980 <.text+0x1980>
    1968:	ebfffe0c 	bl	11a0 <USBRegisterRequestHandler>
    196c:	e3a00001 	mov	r0, #1	; 0x1
    1970:	e8bd8010 	ldmia	sp!, {r4, pc}
    1974:	00001320 	andeq	r1, r0, r0, lsr #6
    1978:	00001984 	andeq	r1, r0, r4, lsl #19
    197c:	000015e0 	andeq	r1, r0, r0, ror #11
    1980:	40000298 	mulmi	r0, r8, r2

00001984 <HandleUsbReset>:
    1984:	e3100010 	tst	r0, #16	; 0x10
    1988:	012fff1e 	bxeq	lr
    198c:	e59f0000 	ldr	r0, [pc, #0]	; 1994 <.text+0x1994>
    1990:	eafffb2e 	b	650 <printf>
    1994:	00001ef4 	streqd	r1, [r0], -r4

00001998 <__aeabi_uidiv>:
    1998:	e2512001 	subs	r2, r1, #1	; 0x1
    199c:	012fff1e 	bxeq	lr
    19a0:	3a000036 	bcc	1a80 <__aeabi_uidiv+0xe8>
    19a4:	e1500001 	cmp	r0, r1
    19a8:	9a000022 	bls	1a38 <__aeabi_uidiv+0xa0>
    19ac:	e1110002 	tst	r1, r2
    19b0:	0a000023 	beq	1a44 <__aeabi_uidiv+0xac>
    19b4:	e311020e 	tst	r1, #-536870912	; 0xe0000000
    19b8:	01a01181 	moveq	r1, r1, lsl #3
    19bc:	03a03008 	moveq	r3, #8	; 0x8
    19c0:	13a03001 	movne	r3, #1	; 0x1
    19c4:	e3510201 	cmp	r1, #268435456	; 0x10000000
    19c8:	31510000 	cmpcc	r1, r0
    19cc:	31a01201 	movcc	r1, r1, lsl #4
    19d0:	31a03203 	movcc	r3, r3, lsl #4
    19d4:	3afffffa 	bcc	19c4 <__aeabi_uidiv+0x2c>
    19d8:	e3510102 	cmp	r1, #-2147483648	; 0x80000000
    19dc:	31510000 	cmpcc	r1, r0
    19e0:	31a01081 	movcc	r1, r1, lsl #1
    19e4:	31a03083 	movcc	r3, r3, lsl #1
    19e8:	3afffffa 	bcc	19d8 <__aeabi_uidiv+0x40>
    19ec:	e3a02000 	mov	r2, #0	; 0x0
    19f0:	e1500001 	cmp	r0, r1
    19f4:	20400001 	subcs	r0, r0, r1
    19f8:	21822003 	orrcs	r2, r2, r3
    19fc:	e15000a1 	cmp	r0, r1, lsr #1
    1a00:	204000a1 	subcs	r0, r0, r1, lsr #1
    1a04:	218220a3 	orrcs	r2, r2, r3, lsr #1
    1a08:	e1500121 	cmp	r0, r1, lsr #2
    1a0c:	20400121 	subcs	r0, r0, r1, lsr #2
    1a10:	21822123 	orrcs	r2, r2, r3, lsr #2
    1a14:	e15001a1 	cmp	r0, r1, lsr #3
    1a18:	204001a1 	subcs	r0, r0, r1, lsr #3
    1a1c:	218221a3 	orrcs	r2, r2, r3, lsr #3
    1a20:	e3500000 	cmp	r0, #0	; 0x0
    1a24:	11b03223 	movnes	r3, r3, lsr #4
    1a28:	11a01221 	movne	r1, r1, lsr #4
    1a2c:	1affffef 	bne	19f0 <__aeabi_uidiv+0x58>
    1a30:	e1a00002 	mov	r0, r2
    1a34:	e12fff1e 	bx	lr
    1a38:	03a00001 	moveq	r0, #1	; 0x1
    1a3c:	13a00000 	movne	r0, #0	; 0x0
    1a40:	e12fff1e 	bx	lr
    1a44:	e3510801 	cmp	r1, #65536	; 0x10000
    1a48:	21a01821 	movcs	r1, r1, lsr #16
    1a4c:	23a02010 	movcs	r2, #16	; 0x10
    1a50:	33a02000 	movcc	r2, #0	; 0x0
    1a54:	e3510c01 	cmp	r1, #256	; 0x100
    1a58:	21a01421 	movcs	r1, r1, lsr #8
    1a5c:	22822008 	addcs	r2, r2, #8	; 0x8
    1a60:	e3510010 	cmp	r1, #16	; 0x10
    1a64:	21a01221 	movcs	r1, r1, lsr #4
    1a68:	22822004 	addcs	r2, r2, #4	; 0x4
    1a6c:	e3510004 	cmp	r1, #4	; 0x4
    1a70:	82822003 	addhi	r2, r2, #3	; 0x3
    1a74:	908220a1 	addls	r2, r2, r1, lsr #1
    1a78:	e1a00230 	mov	r0, r0, lsr r2
    1a7c:	e12fff1e 	bx	lr
    1a80:	e52de008 	str	lr, [sp, #-8]!
    1a84:	eb00003a 	bl	1b74 <__aeabi_idiv0>
    1a88:	e3a00000 	mov	r0, #0	; 0x0
    1a8c:	e49df008 	ldr	pc, [sp], #8

00001a90 <__aeabi_uidivmod>:
    1a90:	e92d4003 	stmdb	sp!, {r0, r1, lr}
    1a94:	ebffffbf 	bl	1998 <__aeabi_uidiv>
    1a98:	e8bd4006 	ldmia	sp!, {r1, r2, lr}
    1a9c:	e0030092 	mul	r3, r2, r0
    1aa0:	e0411003 	sub	r1, r1, r3
    1aa4:	e12fff1e 	bx	lr

00001aa8 <__umodsi3>:
    1aa8:	e2512001 	subs	r2, r1, #1	; 0x1
    1aac:	3a00002c 	bcc	1b64 <__umodsi3+0xbc>
    1ab0:	11500001 	cmpne	r0, r1
    1ab4:	03a00000 	moveq	r0, #0	; 0x0
    1ab8:	81110002 	tsthi	r1, r2
    1abc:	00000002 	andeq	r0, r0, r2
    1ac0:	912fff1e 	bxls	lr
    1ac4:	e3a02000 	mov	r2, #0	; 0x0
    1ac8:	e3510201 	cmp	r1, #268435456	; 0x10000000
    1acc:	31510000 	cmpcc	r1, r0
    1ad0:	31a01201 	movcc	r1, r1, lsl #4
    1ad4:	32822004 	addcc	r2, r2, #4	; 0x4
    1ad8:	3afffffa 	bcc	1ac8 <__umodsi3+0x20>
    1adc:	e3510102 	cmp	r1, #-2147483648	; 0x80000000
    1ae0:	31510000 	cmpcc	r1, r0
    1ae4:	31a01081 	movcc	r1, r1, lsl #1
    1ae8:	32822001 	addcc	r2, r2, #1	; 0x1
    1aec:	3afffffa 	bcc	1adc <__umodsi3+0x34>
    1af0:	e2522003 	subs	r2, r2, #3	; 0x3
    1af4:	ba00000e 	blt	1b34 <__umodsi3+0x8c>
    1af8:	e1500001 	cmp	r0, r1
    1afc:	20400001 	subcs	r0, r0, r1
    1b00:	e15000a1 	cmp	r0, r1, lsr #1
    1b04:	204000a1 	subcs	r0, r0, r1, lsr #1
    1b08:	e1500121 	cmp	r0, r1, lsr #2
    1b0c:	20400121 	subcs	r0, r0, r1, lsr #2
    1b10:	e15001a1 	cmp	r0, r1, lsr #3
    1b14:	204001a1 	subcs	r0, r0, r1, lsr #3
    1b18:	e3500001 	cmp	r0, #1	; 0x1
    1b1c:	e1a01221 	mov	r1, r1, lsr #4
    1b20:	a2522004 	subges	r2, r2, #4	; 0x4
    1b24:	aafffff3 	bge	1af8 <__umodsi3+0x50>
    1b28:	e3120003 	tst	r2, #3	; 0x3
    1b2c:	13300000 	teqne	r0, #0	; 0x0
    1b30:	0a00000a 	beq	1b60 <__umodsi3+0xb8>
    1b34:	e3720002 	cmn	r2, #2	; 0x2
    1b38:	ba000006 	blt	1b58 <__umodsi3+0xb0>
    1b3c:	0a000002 	beq	1b4c <__umodsi3+0xa4>
    1b40:	e1500001 	cmp	r0, r1
    1b44:	20400001 	subcs	r0, r0, r1
    1b48:	e1a010a1 	mov	r1, r1, lsr #1
    1b4c:	e1500001 	cmp	r0, r1
    1b50:	20400001 	subcs	r0, r0, r1
    1b54:	e1a010a1 	mov	r1, r1, lsr #1
    1b58:	e1500001 	cmp	r0, r1
    1b5c:	20400001 	subcs	r0, r0, r1
    1b60:	e12fff1e 	bx	lr
    1b64:	e52de008 	str	lr, [sp, #-8]!
    1b68:	eb000001 	bl	1b74 <__aeabi_idiv0>
    1b6c:	e3a00000 	mov	r0, #0	; 0x0
    1b70:	e49df008 	ldr	pc, [sp], #8

00001b74 <__aeabi_idiv0>:
    1b74:	e12fff1e 	bx	lr

00001b78 <abDescriptors>:
    1b78:	02000112 400000ff 0004ffff 02010100     .......@........
    1b88:	02090103 01010020 09328000 02000004     .... .....2.....
    1b98:	000000ff 02820507 07000040 40020505     ........@......@
    1ba8:	03040000 030e0409 0050004c 00550043     ........L.P.C.U.
    1bb8:	00420053 004d031a 006d0065 0072006f     S.B...M.e.m.o.r.
    1bc8:	00410079 00630063 00730065 03120073     y.A.c.c.e.s.s...
    1bd8:	00450044 00440041 00300043 00450044     D.E.A.D.C.0.D.E.
    1be8:	00000000                                ....

00001bec <__FUNCTION__.1660>:
    1bec:	48425355 67655277 65747369 49504572     USBHwRegisterEPI
    1bfc:	6148746e 656c646e 00000072              ntHandler...

00001c08 <__FUNCTION__.1651>:
    1c08:	52425355 73696765 52726574 65757165     USBRegisterReque
    1c18:	61487473 656c646e 00000072              stHandler...

00001c24 <__FUNCTION__.1613>:
    1c24:	48425355 6c646e61 6e6f4365 6c6f7274     USBHandleControl
    1c34:	6e617254 72656673 00000000              Transfer....

00001c40 <__FUNCTION__.1627>:
    1c40:	53425355 6f437465 6769666e 74617275     USBSetConfigurat
    1c50:	006e6f69                                ion.

00001c54 <__FUNCTION__.1594>:
    1c54:	47425355 65447465 69726373 726f7470     USBGetDescriptor
    1c64:	00000000 6c756e28 0000296c 74696e49     ....(null)..Init
    1c74:	696c6169 676e6973 42535520 61747320     ialising USB sta
    1c84:	00006b63 72617453 676e6974 42535520     ck..Starting USB
    1c94:	6d6f6320 696e756d 69746163 00006e6f      communication..
    1ca4:	656e6f64 00000000 44414552 6461203a     done....READ: ad
    1cb4:	253d7264 6c202c58 253d6e65 00000a64     dr=%X, len=%d...
    1cc4:	54495257 61203a45 3d726464 202c5825     WRITE: addr=%X, 
    1cd4:	3d6e656c 000a6425 61686e55 656c646e     len=%d..Unhandle
    1ce4:	6c632064 20737361 000a5825 69676552     d class %X..Regi
    1cf4:	72657473 68206465 6c646e61 66207265     stered handler f
    1d04:	6620726f 656d6172 00000000 69676552     or frame....Regi
    1d14:	72657473 68206465 6c646e61 66207265     stered handler f
    1d24:	6420726f 63697665 74732065 73757461     or device status
    1d34:	00000000 7373410a 69747265 27206e6f     .....Assertion '
    1d44:	20277325 6c696166 69206465 7325206e     %s' failed in %s
    1d54:	2373253a 0a216425 00000000 3c786469     :%s#%d!.....idx<
    1d64:	00003233 68627375 706c5f77 00632e63     32..usbhw_lpc.c.
    1d74:	69676552 72657473 68206465 6c646e61     Registered handl
    1d84:	66207265 4520726f 78302050 000a7825     er for EP 0x%x..
    1d94:	70795469 3d3e2065 00003020 63627375     iType >= 0..usbc
    1da4:	72746e6f 632e6c6f 00000000 70795469     ontrol.c....iTyp
    1db4:	203c2065 00000034 68206f4e 6c646e61     e < 4...No handl
    1dc4:	66207265 7220726f 79747165 25206570     er for reqtype %
    1dd4:	00000a64 4c415453 6e6f204c 00005b20     d...STALL on [..
    1de4:	32302520 00000078 7473205d 253d7461      %02x...] stat=%
    1df4:	00000a78 00782553 6e61485f 52656c64     x...S%x._HandleR
    1e04:	65757165 20317473 6c696166 00006465     equest1 failed..
    1e14:	6e61485f 52656c64 65757165 20327473     _HandleRequest2 
    1e24:	6c696166 00006465 0000003f 534c4146     failed..?...FALS
    1e34:	00000045 44626170 72637365 21207069     E...pabDescrip !
    1e44:	554e203d 00004c4c 73627375 65726474     = NULL..usbstdre
    1e54:	00632e71 63736544 20782520 20746f6e     q.c.Desc %x not 
    1e64:	6e756f66 000a2164 00782544 69766544     found!..D%x.Devi
    1e74:	72206563 25207165 6f6e2064 6d692074     ce req %d not im
    1e84:	6d656c70 65746e65 00000a64 656c6c49     plemented...Ille
    1e94:	206c6167 69766564 72206563 25207165     gal device req %
    1ea4:	00000a64 656c6c49 206c6167 65746e69     d...Illegal inte
    1eb4:	63616672 65722065 64252071 0000000a     rface req %d....
    1ec4:	72205045 25207165 6f6e2064 6d692074     EP req %d not im
    1ed4:	6d656c70 65746e65 00000a64 656c6c49     plemented...Ille
    1ee4:	206c6167 72205045 25207165 00000a64     gal EP req %d...
    1ef4:	0000210a                                .!..
