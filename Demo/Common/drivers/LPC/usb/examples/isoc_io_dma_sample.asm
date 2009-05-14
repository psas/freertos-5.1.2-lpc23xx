
isoc_io_dma_sample.elf:     file format elf32-littlearm

Disassembly of section .text:

00000000 <_startup>:
       0:	e59ff018 	ldr	pc, [pc, #24]	; 20 <Reset_Addr>
       4:	e59ff018 	ldr	pc, [pc, #24]	; 24 <Undef_Addr>
       8:	e59ff018 	ldr	pc, [pc, #24]	; 28 <SWI_Addr>
       c:	e59ff018 	ldr	pc, [pc, #24]	; 2c <PAbt_Addr>
      10:	e59ff018 	ldr	pc, [pc, #24]	; 30 <DAbt_Addr>
      14:	e1a00000 	nop			(mov r0,r0)
      18:	e51ff120 	ldr	pc, [pc, #-288]	; ffffff00 <outputIsocFrameArray+0x802ffa00>
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
      bc:	ea0001b9 	b	7a8 <main>
      c0:	40007edc 	ldrmid	r7, [r0], -ip
      c4:	0000217c 	andeq	r2, r0, ip, ror r1
      c8:	40000200 	andmi	r0, r0, r0, lsl #4
      cc:	40000202 	andmi	r0, r0, r2, lsl #4
      d0:	40000204 	andmi	r0, r0, r4, lsl #4
      d4:	400002b8 	strmih	r0, [r0], -r8

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
     394:	eb00066c 	bl	1d4c <__umodsi3>
     398:	e1a03000 	mov	r3, r0
     39c:	e3530009 	cmp	r3, #9	; 0x9
     3a0:	c083300a 	addgt	r3, r3, sl
     3a4:	e2833030 	add	r3, r3, #48	; 0x30
     3a8:	e1a00004 	mov	r0, r4
     3ac:	e5653001 	strb	r3, [r5, #-1]!
     3b0:	e1a01006 	mov	r1, r6
     3b4:	eb000620 	bl	1c3c <__aeabi_uidiv>
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
     614:	00001f04 	andeq	r1, r0, r4, lsl #30

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

0000075c <HandleClassRequest>:
     75c:	e3a00001 	mov	r0, #1	; 0x1
     760:	e12fff1e 	bx	lr

00000764 <USBDevIntHandler>:
     764:	e20000ff 	and	r0, r0, #255	; 0xff
     768:	e59f3030 	ldr	r3, [pc, #48]	; 7a0 <.text+0x7a0>
     76c:	e3500004 	cmp	r0, #4	; 0x4
     770:	e5c30000 	strb	r0, [r3]
     774:	0a000005 	beq	790 <USBDevIntHandler+0x2c>
     778:	e3500010 	cmp	r0, #16	; 0x10
     77c:	0a000003 	beq	790 <USBDevIntHandler+0x2c>
     780:	e3500001 	cmp	r0, #1	; 0x1
     784:	059f3018 	ldreq	r3, [pc, #24]	; 7a4 <.text+0x7a4>
     788:	05830000 	streq	r0, [r3]
     78c:	e12fff1e 	bx	lr
     790:	e59f300c 	ldr	r3, [pc, #12]	; 7a4 <.text+0x7a4>
     794:	e3a02000 	mov	r2, #0	; 0x0
     798:	e5832000 	str	r2, [r3]
     79c:	e12fff1e 	bx	lr
     7a0:	40000208 	andmi	r0, r0, r8, lsl #4
     7a4:	40000204 	andmi	r0, r0, r4, lsl #4

000007a8 <main>:
     7a8:	e92d40f0 	stmdb	sp!, {r4, r5, r6, r7, lr}
     7ac:	e59f5104 	ldr	r5, [pc, #260]	; 8b8 <.text+0x8b8>
     7b0:	e5953008 	ldr	r3, [r5, #8]
     7b4:	e3833b01 	orr	r3, r3, #1024	; 0x400
     7b8:	e5853008 	str	r3, [r5, #8]
     7bc:	e5953008 	ldr	r3, [r5, #8]
     7c0:	e3833b02 	orr	r3, r3, #2048	; 0x800
     7c4:	e5853008 	str	r3, [r5, #8]
     7c8:	ebfffe7a 	bl	1b8 <HalSysInit>
     7cc:	e3a00027 	mov	r0, #39	; 0x27
     7d0:	ebffffab 	bl	684 <ConsoleInit>
     7d4:	e59f00e0 	ldr	r0, [pc, #224]	; 8bc <.text+0x8bc>
     7d8:	ebffffd2 	bl	728 <puts>
     7dc:	eb0004f6 	bl	1bbc <USBInit>
     7e0:	e59f00d8 	ldr	r0, [pc, #216]	; 8c0 <.text+0x8c0>
     7e4:	eb0003ea 	bl	1794 <USBRegisterDescriptors>
     7e8:	e59f20d4 	ldr	r2, [pc, #212]	; 8c4 <.text+0x8c4>
     7ec:	e3a00001 	mov	r0, #1	; 0x1
     7f0:	e59f10d0 	ldr	r1, [pc, #208]	; 8c8 <.text+0x8c8>
     7f4:	eb000312 	bl	1444 <USBRegisterRequestHandler>
     7f8:	e3a01000 	mov	r1, #0	; 0x0
     7fc:	e3a00081 	mov	r0, #129	; 0x81
     800:	eb0002e7 	bl	13a4 <USBHwRegisterEPIntHandler>
     804:	e59f00c0 	ldr	r0, [pc, #192]	; 8cc <.text+0x8cc>
     808:	eb0002cf 	bl	134c <USBHwRegisterFrameHandler>
     80c:	e59f00bc 	ldr	r0, [pc, #188]	; 8d0 <.text+0x8d0>
     810:	eb0002d8 	bl	1378 <USBHwRegisterDevIntHandler>
     814:	e59f30b8 	ldr	r3, [pc, #184]	; 8d4 <.text+0x8d4>
     818:	e3a07000 	mov	r7, #0	; 0x0
     81c:	e5c37000 	strb	r7, [r3]
     820:	e59f00b0 	ldr	r0, [pc, #176]	; 8d8 <.text+0x8d8>
     824:	eb0002be 	bl	1324 <USBInitializeUSBDMA>
     828:	e3a00083 	mov	r0, #131	; 0x83
     82c:	eb000297 	bl	1290 <USBEnableDMAForEndpoint>
     830:	e59f00a4 	ldr	r0, [pc, #164]	; 8dc <.text+0x8dc>
     834:	ebffffbb 	bl	728 <puts>
     838:	e59f00a0 	ldr	r0, [pc, #160]	; 8e0 <.text+0x8e0>
     83c:	ebffffb9 	bl	728 <puts>
     840:	e59f309c 	ldr	r3, [pc, #156]	; 8e4 <.text+0x8e4>
     844:	e3e04000 	mvn	r4, #0	; 0x0
     848:	e3a06001 	mov	r6, #1	; 0x1
     84c:	e5046da7 	str	r6, [r4, #-3495]
     850:	e59f0090 	ldr	r0, [pc, #144]	; 8e8 <.text+0x8e8>
     854:	e5043ea7 	str	r3, [r4, #-3751]
     858:	ebffffb2 	bl	728 <puts>
     85c:	e5143ff3 	ldr	r3, [r4, #-4083]
     860:	e3c33501 	bic	r3, r3, #4194304	; 0x400000
     864:	e5043ff3 	str	r3, [r4, #-4083]
     868:	e5143fef 	ldr	r3, [r4, #-4079]
     86c:	e3833501 	orr	r3, r3, #4194304	; 0x400000
     870:	e5043fef 	str	r3, [r4, #-4079]
     874:	eb0000d1 	bl	bc0 <enableIRQ>
     878:	e59f006c 	ldr	r0, [pc, #108]	; 8ec <.text+0x8ec>
     87c:	ebffffa9 	bl	728 <puts>
     880:	e1a00006 	mov	r0, r6
     884:	eb00011c 	bl	cfc <USBHwConnect>
     888:	e59f0060 	ldr	r0, [pc, #96]	; 8f0 <.text+0x8f0>
     88c:	e59f1060 	ldr	r1, [pc, #96]	; 8f4 <.text+0x8f4>
     890:	e3a03b02 	mov	r3, #2048	; 0x800
     894:	e1a02007 	mov	r2, r7
     898:	e2877001 	add	r7, r7, #1	; 0x1
     89c:	e1570000 	cmp	r7, r0
     8a0:	05853004 	streq	r3, [r5, #4]
     8a4:	0afffffb 	beq	898 <main+0xf0>
     8a8:	e1570001 	cmp	r7, r1
     8ac:	c1a07002 	movgt	r7, r2
     8b0:	c585300c 	strgt	r3, [r5, #12]
     8b4:	eafffff7 	b	898 <main+0xf0>
     8b8:	e0028000 	and	r8, r2, r0
     8bc:	00001f0c 	andeq	r1, r0, ip, lsl #30
     8c0:	00001e1c 	andeq	r1, r0, ip, lsl lr
     8c4:	40000220 	andmi	r0, r0, r0, lsr #4
     8c8:	0000075c 	andeq	r0, r0, ip, asr r7
     8cc:	000009c4 	andeq	r0, r0, r4, asr #19
     8d0:	00000764 	andeq	r0, r0, r4, ror #14
     8d4:	7fd002a4 	svcvc	0x00d002a4
     8d8:	7fd00200 	svcvc	0x00d00200
     8dc:	00001f24 	andeq	r1, r0, r4, lsr #30
     8e0:	00001f40 	andeq	r1, r0, r0, asr #30
     8e4:	000008f8 	streqd	r0, [r0], -r8
     8e8:	00001f48 	andeq	r1, r0, r8, asr #30
     8ec:	00001f60 	andeq	r1, r0, r0, ror #30
     8f0:	00030d40 	andeq	r0, r3, r0, asr #26
     8f4:	00061a7f 	andeq	r1, r6, pc, ror sl

000008f8 <USBIntHandler>:
     8f8:	e24ee004 	sub	lr, lr, #4	; 0x4
     8fc:	e92d41ff 	stmdb	sp!, {r0, r1, r2, r3, r4, r5, r6, r7, r8, lr}
     900:	e14f1000 	mrs	r1, SPSR
     904:	e92d0002 	stmdb	sp!, {r1}
     908:	eb000191 	bl	f54 <USBHwISR>
     90c:	e3a02000 	mov	r2, #0	; 0x0
     910:	e3e03000 	mvn	r3, #0	; 0x0
     914:	e50320ff 	str	r2, [r3, #-255]
     918:	e8bd0002 	ldmia	sp!, {r1}
     91c:	e161f001 	msr	SPSR_c, r1
     920:	e8fd81ff 	ldmia	sp!, {r0, r1, r2, r3, r4, r5, r6, r7, r8, pc}^

00000924 <resetDMATransfer>:
     924:	e92d4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
     928:	e24dd00c 	sub	sp, sp, #12	; 0xc
     92c:	e28d5030 	add	r5, sp, #48	; 0x30
     930:	e89500a0 	ldmia	r5, {r5, r7}
     934:	e20080ff 	and	r8, r0, #255	; 0xff
     938:	e1a0a002 	mov	sl, r2
     93c:	e1a04003 	mov	r4, r3
     940:	e1a00008 	mov	r0, r8
     944:	e1a05805 	mov	r5, r5, lsl #16
     948:	e1a09001 	mov	r9, r1
     94c:	e28d6038 	add	r6, sp, #56	; 0x38
     950:	e8960840 	ldmia	r6, {r6, fp}
     954:	eb000243 	bl	1268 <USBDisableDMAForEndpoint>
     958:	e1a03825 	mov	r3, r5, lsr #16
     95c:	e1a0000a 	mov	r0, sl
     960:	e1a01004 	mov	r1, r4
     964:	e1d720b0 	ldrh	r2, [r7]
     968:	eb000252 	bl	12b8 <USBInitializeISOCFrameArray>
     96c:	e1a04804 	mov	r4, r4, lsl #16
     970:	e1d730b0 	ldrh	r3, [r7]
     974:	e1a04824 	mov	r4, r4, lsr #16
     978:	e0833004 	add	r3, r3, r4
     97c:	e1a06806 	mov	r6, r6, lsl #16
     980:	e1c730b0 	strh	r3, [r7]
     984:	e1a00009 	mov	r0, r9
     988:	e1a03826 	mov	r3, r6, lsr #16
     98c:	e3a01000 	mov	r1, #0	; 0x0
     990:	e3a02001 	mov	r2, #1	; 0x1
     994:	e88d0810 	stmia	sp, {r4, fp}
     998:	e58da008 	str	sl, [sp, #8]
     99c:	eb000213 	bl	11f0 <USBSetupDMADescriptor>
     9a0:	e1a00008 	mov	r0, r8
     9a4:	e1a02009 	mov	r2, r9
     9a8:	e59f1010 	ldr	r1, [pc, #16]	; 9c0 <.text+0x9c0>
     9ac:	eb000256 	bl	130c <USBSetHeadDDForDMA>
     9b0:	e1a00008 	mov	r0, r8
     9b4:	e28dd00c 	add	sp, sp, #12	; 0xc
     9b8:	e8bd4ff0 	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
     9bc:	ea000233 	b	1290 <USBEnableDMAForEndpoint>
     9c0:	7fd00200 	svcvc	0x00d00200

000009c4 <USBFrameHandler>:
     9c4:	e92d4010 	stmdb	sp!, {r4, lr}
     9c8:	e59f3150 	ldr	r3, [pc, #336]	; b20 <.text+0xb20>
     9cc:	e5933000 	ldr	r3, [r3]
     9d0:	e3530000 	cmp	r3, #0	; 0x0
     9d4:	e24dd010 	sub	sp, sp, #16	; 0x10
     9d8:	0a00004e 	beq	b18 <USBFrameHandler+0x154>
     9dc:	e59f2140 	ldr	r2, [pc, #320]	; b24 <.text+0xb24>
     9e0:	e5923000 	ldr	r3, [r2]
     9e4:	e3530efa 	cmp	r3, #4000	; 0xfa0
     9e8:	b2833001 	addlt	r3, r3, #1	; 0x1
     9ec:	b5823000 	strlt	r3, [r2]
     9f0:	ba000048 	blt	b18 <USBFrameHandler+0x154>
     9f4:	e59f112c 	ldr	r1, [pc, #300]	; b28 <.text+0xb28>
     9f8:	e591300c 	ldr	r3, [r1, #12]
     9fc:	e1a030a3 	mov	r3, r3, lsr #1
     a00:	e203300f 	and	r3, r3, #15	; 0xf
     a04:	e3530002 	cmp	r3, #2	; 0x2
     a08:	0a000003 	beq	a1c <USBFrameHandler+0x58>
     a0c:	e59f3118 	ldr	r3, [pc, #280]	; b2c <.text+0xb2c>
     a10:	e5933000 	ldr	r3, [r3]
     a14:	e3530000 	cmp	r3, #0	; 0x0
     a18:	1a000015 	bne	a74 <USBFrameHandler+0xb0>
     a1c:	e59f2108 	ldr	r2, [pc, #264]	; b2c <.text+0xb2c>
     a20:	e59fe108 	ldr	lr, [pc, #264]	; b30 <.text+0xb30>
     a24:	e5923000 	ldr	r3, [r2]
     a28:	e59ec000 	ldr	ip, [lr]
     a2c:	e59f4100 	ldr	r4, [pc, #256]	; b34 <.text+0xb34>
     a30:	e3530000 	cmp	r3, #0	; 0x0
     a34:	e28cc001 	add	ip, ip, #1	; 0x1
     a38:	e58ec000 	str	ip, [lr]
     a3c:	e584c000 	str	ip, [r4]
     a40:	02833001 	addeq	r3, r3, #1	; 0x1
     a44:	e3a0c004 	mov	ip, #4	; 0x4
     a48:	05823000 	streq	r3, [r2]
     a4c:	e58dc000 	str	ip, [sp]
     a50:	e59fc0e0 	ldr	ip, [pc, #224]	; b38 <.text+0xb38>
     a54:	e3a00083 	mov	r0, #131	; 0x83
     a58:	e58dc004 	str	ip, [sp, #4]
     a5c:	e59f20d8 	ldr	r2, [pc, #216]	; b3c <.text+0xb3c>
     a60:	e3a0c080 	mov	ip, #128	; 0x80
     a64:	e3a03001 	mov	r3, #1	; 0x1
     a68:	e58dc008 	str	ip, [sp, #8]
     a6c:	e58d400c 	str	r4, [sp, #12]
     a70:	ebffffab 	bl	924 <resetDMATransfer>
     a74:	e59f30c4 	ldr	r3, [pc, #196]	; b40 <.text+0xb40>
     a78:	e593300c 	ldr	r3, [r3, #12]
     a7c:	e1a030a3 	mov	r3, r3, lsr #1
     a80:	e203300f 	and	r3, r3, #15	; 0xf
     a84:	e3530002 	cmp	r3, #2	; 0x2
     a88:	0a000003 	beq	a9c <USBFrameHandler+0xd8>
     a8c:	e59f30b0 	ldr	r3, [pc, #176]	; b44 <.text+0xb44>
     a90:	e5933000 	ldr	r3, [r3]
     a94:	e3530000 	cmp	r3, #0	; 0x0
     a98:	1a00001e 	bne	b18 <USBFrameHandler+0x154>
     a9c:	e59f20a0 	ldr	r2, [pc, #160]	; b44 <.text+0xb44>
     aa0:	e5923000 	ldr	r3, [r2]
     aa4:	e3530000 	cmp	r3, #0	; 0x0
     aa8:	02833001 	addeq	r3, r3, #1	; 0x1
     aac:	05823000 	streq	r3, [r2]
     ab0:	0a000008 	beq	ad8 <USBFrameHandler+0x114>
     ab4:	e59f308c 	ldr	r3, [pc, #140]	; b48 <.text+0xb48>
     ab8:	e5d33000 	ldrb	r3, [r3]
     abc:	e3530000 	cmp	r3, #0	; 0x0
     ac0:	159f3084 	ldrne	r3, [pc, #132]	; b4c <.text+0xb4c>
     ac4:	059f3080 	ldreq	r3, [pc, #128]	; b4c <.text+0xb4c>
     ac8:	13a02b01 	movne	r2, #1024	; 0x400
     acc:	03a02b01 	moveq	r2, #1024	; 0x400
     ad0:	15832004 	strne	r2, [r3, #4]
     ad4:	0583200c 	streq	r2, [r3, #12]
     ad8:	e59fe070 	ldr	lr, [pc, #112]	; b50 <.text+0xb50>
     adc:	e59ec000 	ldr	ip, [lr]
     ae0:	e28cc001 	add	ip, ip, #1	; 0x1
     ae4:	e58ec000 	str	ip, [lr]
     ae8:	e59fc048 	ldr	ip, [pc, #72]	; b38 <.text+0xb38>
     aec:	e58dc004 	str	ip, [sp, #4]
     af0:	e59fc050 	ldr	ip, [pc, #80]	; b48 <.text+0xb48>
     af4:	e3a04080 	mov	r4, #128	; 0x80
     af8:	e3a00006 	mov	r0, #6	; 0x6
     afc:	e59f103c 	ldr	r1, [pc, #60]	; b40 <.text+0xb40>
     b00:	e59f204c 	ldr	r2, [pc, #76]	; b54 <.text+0xb54>
     b04:	e3a03004 	mov	r3, #4	; 0x4
     b08:	e58d4008 	str	r4, [sp, #8]
     b0c:	e58dc00c 	str	ip, [sp, #12]
     b10:	e58d4000 	str	r4, [sp]
     b14:	ebffff82 	bl	924 <resetDMATransfer>
     b18:	e28dd010 	add	sp, sp, #16	; 0x10
     b1c:	e8bd8010 	ldmia	sp!, {r4, pc}
     b20:	40000204 	andmi	r0, r0, r4, lsl #4
     b24:	4000020c 	andmi	r0, r0, ip, lsl #4
     b28:	7fd00280 	svcvc	0x00d00280
     b2c:	40000210 	andmi	r0, r0, r0, lsl r2
     b30:	4000021c 	andmi	r0, r0, ip, lsl r2
     b34:	7fd002a4 	svcvc	0x00d002a4
     b38:	40000200 	andmi	r0, r0, r0, lsl #4
     b3c:	7fd00294 	svcvc	0x00d00294
     b40:	7fd004a4 	svcvc	0x00d004a4
     b44:	40000218 	andmi	r0, r0, r8, lsl r2
     b48:	7fd00000 	svcvc	0x00d00000
     b4c:	e0028000 	and	r8, r2, r0
     b50:	40000214 	andmi	r0, r0, r4, lsl r2
     b54:	7fd00500 	svcvc	0x00d00500

00000b58 <restoreIRQ>:
     b58:	e10f2000 	mrs	r2, CPSR
     b5c:	e2000080 	and	r0, r0, #128	; 0x80
     b60:	e3c23080 	bic	r3, r2, #128	; 0x80
     b64:	e1833000 	orr	r3, r3, r0
     b68:	e129f003 	msr	CPSR_fc, r3
     b6c:	e1a00002 	mov	r0, r2
     b70:	e12fff1e 	bx	lr

00000b74 <restoreFIQ>:
     b74:	e10f2000 	mrs	r2, CPSR
     b78:	e2000040 	and	r0, r0, #64	; 0x40
     b7c:	e3c23040 	bic	r3, r2, #64	; 0x40
     b80:	e1833000 	orr	r3, r3, r0
     b84:	e129f003 	msr	CPSR_fc, r3
     b88:	e1a00002 	mov	r0, r2
     b8c:	e12fff1e 	bx	lr

00000b90 <disableFIQ>:
     b90:	e10f0000 	mrs	r0, CPSR
     b94:	e3803040 	orr	r3, r0, #64	; 0x40
     b98:	e129f003 	msr	CPSR_fc, r3
     b9c:	e12fff1e 	bx	lr

00000ba0 <enableFIQ>:
     ba0:	e10f0000 	mrs	r0, CPSR
     ba4:	e3c03040 	bic	r3, r0, #64	; 0x40
     ba8:	e129f003 	msr	CPSR_fc, r3
     bac:	e12fff1e 	bx	lr

00000bb0 <disableIRQ>:
     bb0:	e10f0000 	mrs	r0, CPSR
     bb4:	e3803080 	orr	r3, r0, #128	; 0x80
     bb8:	e129f003 	msr	CPSR_fc, r3
     bbc:	e12fff1e 	bx	lr

00000bc0 <enableIRQ>:
     bc0:	e10f0000 	mrs	r0, CPSR
     bc4:	e3c03080 	bic	r3, r0, #128	; 0x80
     bc8:	e129f003 	msr	CPSR_fc, r3
     bcc:	e12fff1e 	bx	lr

00000bd0 <USBHwCmd>:
     bd0:	e1a00800 	mov	r0, r0, lsl #16
     bd4:	e59f2028 	ldr	r2, [pc, #40]	; c04 <.text+0xc04>
     bd8:	e20008ff 	and	r0, r0, #16711680	; 0xff0000
     bdc:	e3800c05 	orr	r0, r0, #1280	; 0x500
     be0:	e3a03030 	mov	r3, #48	; 0x30
     be4:	e5023df7 	str	r3, [r2, #-3575]
     be8:	e5020def 	str	r0, [r2, #-3567]
     bec:	e5123dff 	ldr	r3, [r2, #-3583]
     bf0:	e2033010 	and	r3, r3, #16	; 0x10
     bf4:	e3530010 	cmp	r3, #16	; 0x10
     bf8:	1afffffb 	bne	bec <USBHwCmd+0x1c>
     bfc:	e5023df7 	str	r3, [r2, #-3575]
     c00:	e12fff1e 	bx	lr
     c04:	ffe0cfff 	undefined instruction 0xffe0cfff

00000c08 <USBHwCmdWrite>:
     c08:	e92d4010 	stmdb	sp!, {r4, lr}
     c0c:	e1a04801 	mov	r4, r1, lsl #16
     c10:	e20000ff 	and	r0, r0, #255	; 0xff
     c14:	e1a04824 	mov	r4, r4, lsr #16
     c18:	ebffffec 	bl	bd0 <USBHwCmd>
     c1c:	e1a04804 	mov	r4, r4, lsl #16
     c20:	e59f3020 	ldr	r3, [pc, #32]	; c48 <.text+0xc48>
     c24:	e3844c01 	orr	r4, r4, #256	; 0x100
     c28:	e5034def 	str	r4, [r3, #-3567]
     c2c:	e1a02003 	mov	r2, r3
     c30:	e5123dff 	ldr	r3, [r2, #-3583]
     c34:	e2033010 	and	r3, r3, #16	; 0x10
     c38:	e3530010 	cmp	r3, #16	; 0x10
     c3c:	1afffffb 	bne	c30 <USBHwCmdWrite+0x28>
     c40:	e5023df7 	str	r3, [r2, #-3575]
     c44:	e8bd8010 	ldmia	sp!, {r4, pc}
     c48:	ffe0cfff 	undefined instruction 0xffe0cfff

00000c4c <USBHwCmdRead>:
     c4c:	e92d4010 	stmdb	sp!, {r4, lr}
     c50:	e20040ff 	and	r4, r0, #255	; 0xff
     c54:	e1a00004 	mov	r0, r4
     c58:	ebffffdc 	bl	bd0 <USBHwCmd>
     c5c:	e1a04804 	mov	r4, r4, lsl #16
     c60:	e59f3028 	ldr	r3, [pc, #40]	; c90 <.text+0xc90>
     c64:	e3844c02 	orr	r4, r4, #512	; 0x200
     c68:	e5034def 	str	r4, [r3, #-3567]
     c6c:	e1a02003 	mov	r2, r3
     c70:	e5123dff 	ldr	r3, [r2, #-3583]
     c74:	e2033020 	and	r3, r3, #32	; 0x20
     c78:	e3530020 	cmp	r3, #32	; 0x20
     c7c:	1afffffb 	bne	c70 <USBHwCmdRead+0x24>
     c80:	e5023df7 	str	r3, [r2, #-3575]
     c84:	e5120deb 	ldr	r0, [r2, #-3563]
     c88:	e20000ff 	and	r0, r0, #255	; 0xff
     c8c:	e8bd8010 	ldmia	sp!, {r4, pc}
     c90:	ffe0cfff 	undefined instruction 0xffe0cfff

00000c94 <USBHwEPConfig>:
     c94:	e59fc04c 	ldr	ip, [pc, #76]	; ce8 <.text+0xce8>
     c98:	e200300f 	and	r3, r0, #15	; 0xf
     c9c:	e51c2dbb 	ldr	r2, [ip, #-3515]
     ca0:	e1a03083 	mov	r3, r3, lsl #1
     ca4:	e2000080 	and	r0, r0, #128	; 0x80
     ca8:	e18303a0 	orr	r0, r3, r0, lsr #7
     cac:	e3a03001 	mov	r3, #1	; 0x1
     cb0:	e1822013 	orr	r2, r2, r3, lsl r0
     cb4:	e1a01801 	mov	r1, r1, lsl #16
     cb8:	e1a01821 	mov	r1, r1, lsr #16
     cbc:	e50c2dbb 	str	r2, [ip, #-3515]
     cc0:	e50c0db7 	str	r0, [ip, #-3511]
     cc4:	e50c1db3 	str	r1, [ip, #-3507]
     cc8:	e51c3dff 	ldr	r3, [ip, #-3583]
     ccc:	e2033c01 	and	r3, r3, #256	; 0x100
     cd0:	e3530c01 	cmp	r3, #256	; 0x100
     cd4:	1afffffb 	bne	cc8 <USBHwEPConfig+0x34>
     cd8:	e3800040 	orr	r0, r0, #64	; 0x40
     cdc:	e3a01000 	mov	r1, #0	; 0x0
     ce0:	e50c3df7 	str	r3, [ip, #-3575]
     ce4:	eaffffc7 	b	c08 <USBHwCmdWrite>
     ce8:	ffe0cfff 	undefined instruction 0xffe0cfff

00000cec <USBHwSetAddress>:
     cec:	e200107f 	and	r1, r0, #127	; 0x7f
     cf0:	e3811080 	orr	r1, r1, #128	; 0x80
     cf4:	e3a000d0 	mov	r0, #208	; 0xd0
     cf8:	eaffffc2 	b	c08 <USBHwCmdWrite>

00000cfc <USBHwConnect>:
     cfc:	e3500000 	cmp	r0, #0	; 0x0
     d00:	159f3020 	ldrne	r3, [pc, #32]	; d28 <.text+0xd28>
     d04:	059f301c 	ldreq	r3, [pc, #28]	; d28 <.text+0xd28>
     d08:	13a02901 	movne	r2, #16384	; 0x4000
     d0c:	03a02901 	moveq	r2, #16384	; 0x4000
     d10:	15032fe3 	strne	r2, [r3, #-4067]
     d14:	05032fe7 	streq	r2, [r3, #-4071]
     d18:	e2501000 	subs	r1, r0, #0	; 0x0
     d1c:	13a01001 	movne	r1, #1	; 0x1
     d20:	e3a000fe 	mov	r0, #254	; 0xfe
     d24:	eaffffb7 	b	c08 <USBHwCmdWrite>
     d28:	3fffcfff 	svccc	0x00ffcfff

00000d2c <USBHwNakIntEnable>:
     d2c:	e20010ff 	and	r1, r0, #255	; 0xff
     d30:	e3a000f3 	mov	r0, #243	; 0xf3
     d34:	eaffffb3 	b	c08 <USBHwCmdWrite>

00000d38 <USBHwEPGetStatus>:
     d38:	e1a03000 	mov	r3, r0
     d3c:	e200000f 	and	r0, r0, #15	; 0xf
     d40:	e2033080 	and	r3, r3, #128	; 0x80
     d44:	e1a00080 	mov	r0, r0, lsl #1
     d48:	e52de004 	str	lr, [sp, #-4]!
     d4c:	e18003a3 	orr	r0, r0, r3, lsr #7
     d50:	ebffffbd 	bl	c4c <USBHwCmdRead>
     d54:	e49df004 	ldr	pc, [sp], #4

00000d58 <USBHwEPStall>:
     d58:	e200300f 	and	r3, r0, #15	; 0xf
     d5c:	e1a03083 	mov	r3, r3, lsl #1
     d60:	e2000080 	and	r0, r0, #128	; 0x80
     d64:	e18333a0 	orr	r3, r3, r0, lsr #7
     d68:	e2511000 	subs	r1, r1, #0	; 0x0
     d6c:	13a01001 	movne	r1, #1	; 0x1
     d70:	e3830040 	orr	r0, r3, #64	; 0x40
     d74:	eaffffa3 	b	c08 <USBHwCmdWrite>

00000d78 <USBHwEPWrite>:
     d78:	e92d40f0 	stmdb	sp!, {r4, r5, r6, r7, lr}
     d7c:	e59fc07c 	ldr	ip, [pc, #124]	; e00 <.text+0xe00>
     d80:	e200500f 	and	r5, r0, #15	; 0xf
     d84:	e1a03105 	mov	r3, r5, lsl #2
     d88:	e3833002 	orr	r3, r3, #2	; 0x2
     d8c:	e1a06002 	mov	r6, r2
     d90:	e1a0e001 	mov	lr, r1
     d94:	e1a0400c 	mov	r4, ip
     d98:	e20070ff 	and	r7, r0, #255	; 0xff
     d9c:	e50c3dd7 	str	r3, [ip, #-3543]
     da0:	e50c2ddb 	str	r2, [ip, #-3547]
     da4:	ea000008 	b	dcc <USBHwEPWrite+0x54>
     da8:	e55e3002 	ldrb	r3, [lr, #-2]
     dac:	e55e2001 	ldrb	r2, [lr, #-1]
     db0:	e55e1004 	ldrb	r1, [lr, #-4]
     db4:	e1a03803 	mov	r3, r3, lsl #16
     db8:	e1833c02 	orr	r3, r3, r2, lsl #24
     dbc:	e55e2003 	ldrb	r2, [lr, #-3]
     dc0:	e1833001 	orr	r3, r3, r1
     dc4:	e1833402 	orr	r3, r3, r2, lsl #8
     dc8:	e5003de3 	str	r3, [r0, #-3555]
     dcc:	e5143dd7 	ldr	r3, [r4, #-3543]
     dd0:	e2133002 	ands	r3, r3, #2	; 0x2
     dd4:	e28ee004 	add	lr, lr, #4	; 0x4
     dd8:	e1a00004 	mov	r0, r4
     ddc:	1afffff1 	bne	da8 <USBHwEPWrite+0x30>
     de0:	e1a00085 	mov	r0, r5, lsl #1
     de4:	e18003a7 	orr	r0, r0, r7, lsr #7
     de8:	e5043dd7 	str	r3, [r4, #-3543]
     dec:	ebffff77 	bl	bd0 <USBHwCmd>
     df0:	e3a000fa 	mov	r0, #250	; 0xfa
     df4:	ebffff75 	bl	bd0 <USBHwCmd>
     df8:	e1a00006 	mov	r0, r6
     dfc:	e8bd80f0 	ldmia	sp!, {r4, r5, r6, r7, pc}
     e00:	ffe0cfff 	undefined instruction 0xffe0cfff

00000e04 <USBHwEPRead>:
     e04:	e92d4030 	stmdb	sp!, {r4, r5, lr}
     e08:	e200e00f 	and	lr, r0, #15	; 0xf
     e0c:	e59fc088 	ldr	ip, [pc, #136]	; e9c <.text+0xe9c>
     e10:	e1a0310e 	mov	r3, lr, lsl #2
     e14:	e3833001 	orr	r3, r3, #1	; 0x1
     e18:	e50c3dd7 	str	r3, [ip, #-3543]
     e1c:	e20050ff 	and	r5, r0, #255	; 0xff
     e20:	e51c3ddf 	ldr	r3, [ip, #-3551]
     e24:	e3130b02 	tst	r3, #2048	; 0x800
     e28:	0afffffc 	beq	e20 <USBHwEPRead+0x1c>
     e2c:	e3130b01 	tst	r3, #1024	; 0x400
     e30:	03e04000 	mvneq	r4, #0	; 0x0
     e34:	0a000016 	beq	e94 <USBHwEPRead+0x90>
     e38:	e1a03b03 	mov	r3, r3, lsl #22
     e3c:	e3a04000 	mov	r4, #0	; 0x0
     e40:	e59fc054 	ldr	ip, [pc, #84]	; e9c <.text+0xe9c>
     e44:	e1a03b23 	mov	r3, r3, lsr #22
     e48:	e1a00004 	mov	r0, r4
     e4c:	ea000006 	b	e6c <USBHwEPRead+0x68>
     e50:	e3140003 	tst	r4, #3	; 0x3
     e54:	051c0de7 	ldreq	r0, [ip, #-3559]
     e58:	e3510000 	cmp	r1, #0	; 0x0
     e5c:	11540002 	cmpne	r4, r2
     e60:	b7c40001 	strltb	r0, [r4, r1]
     e64:	e2844001 	add	r4, r4, #1	; 0x1
     e68:	e1a00420 	mov	r0, r0, lsr #8
     e6c:	e1540003 	cmp	r4, r3
     e70:	1afffff6 	bne	e50 <USBHwEPRead+0x4c>
     e74:	e59f3020 	ldr	r3, [pc, #32]	; e9c <.text+0xe9c>
     e78:	e1a0008e 	mov	r0, lr, lsl #1
     e7c:	e3a02000 	mov	r2, #0	; 0x0
     e80:	e18003a5 	orr	r0, r0, r5, lsr #7
     e84:	e5032dd7 	str	r2, [r3, #-3543]
     e88:	ebffff50 	bl	bd0 <USBHwCmd>
     e8c:	e3a000f2 	mov	r0, #242	; 0xf2
     e90:	ebffff4e 	bl	bd0 <USBHwCmd>
     e94:	e1a00004 	mov	r0, r4
     e98:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
     e9c:	ffe0cfff 	undefined instruction 0xffe0cfff

00000ea0 <USBHwISOCEPRead>:
     ea0:	e92d4030 	stmdb	sp!, {r4, r5, lr}
     ea4:	e200e00f 	and	lr, r0, #15	; 0xf
     ea8:	e1a0310e 	mov	r3, lr, lsl #2
     eac:	e59fc08c 	ldr	ip, [pc, #140]	; f40 <.text+0xf40>
     eb0:	e3833001 	orr	r3, r3, #1	; 0x1
     eb4:	e50c3dd7 	str	r3, [ip, #-3543]
     eb8:	e20050ff 	and	r5, r0, #255	; 0xff
     ebc:	e1a00000 	nop			(mov r0,r0)
     ec0:	e51c3ddf 	ldr	r3, [ip, #-3551]
     ec4:	e2130b02 	ands	r0, r3, #2048	; 0x800
     ec8:	0a000001 	beq	ed4 <USBHwISOCEPRead+0x34>
     ecc:	e2130b01 	ands	r0, r3, #1024	; 0x400
     ed0:	1a000002 	bne	ee0 <USBHwISOCEPRead+0x40>
     ed4:	e3e04000 	mvn	r4, #0	; 0x0
     ed8:	e50c0dd7 	str	r0, [ip, #-3543]
     edc:	ea000015 	b	f38 <USBHwISOCEPRead+0x98>
     ee0:	e1a03b03 	mov	r3, r3, lsl #22
     ee4:	e3a04000 	mov	r4, #0	; 0x0
     ee8:	e1a03b23 	mov	r3, r3, lsr #22
     eec:	e1a00004 	mov	r0, r4
     ef0:	ea000006 	b	f10 <USBHwISOCEPRead+0x70>
     ef4:	e3140003 	tst	r4, #3	; 0x3
     ef8:	051c0de7 	ldreq	r0, [ip, #-3559]
     efc:	e3510000 	cmp	r1, #0	; 0x0
     f00:	11540002 	cmpne	r4, r2
     f04:	b7c40001 	strltb	r0, [r4, r1]
     f08:	e2844001 	add	r4, r4, #1	; 0x1
     f0c:	e1a00420 	mov	r0, r0, lsr #8
     f10:	e1540003 	cmp	r4, r3
     f14:	1afffff6 	bne	ef4 <USBHwISOCEPRead+0x54>
     f18:	e59f3020 	ldr	r3, [pc, #32]	; f40 <.text+0xf40>
     f1c:	e1a0008e 	mov	r0, lr, lsl #1
     f20:	e3a02000 	mov	r2, #0	; 0x0
     f24:	e18003a5 	orr	r0, r0, r5, lsr #7
     f28:	e5032dd7 	str	r2, [r3, #-3543]
     f2c:	ebffff27 	bl	bd0 <USBHwCmd>
     f30:	e3a000f2 	mov	r0, #242	; 0xf2
     f34:	ebffff25 	bl	bd0 <USBHwCmd>
     f38:	e1a00004 	mov	r0, r4
     f3c:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
     f40:	ffe0cfff 	undefined instruction 0xffe0cfff

00000f44 <USBHwConfigDevice>:
     f44:	e2501000 	subs	r1, r0, #0	; 0x0
     f48:	13a01001 	movne	r1, #1	; 0x1
     f4c:	e3a000d8 	mov	r0, #216	; 0xd8
     f50:	eaffff2c 	b	c08 <USBHwCmdWrite>

00000f54 <USBHwISR>:
     f54:	e59f3144 	ldr	r3, [pc, #324]	; 10a0 <.text+0x10a0>
     f58:	e3a02002 	mov	r2, #2	; 0x2
     f5c:	e5032fa7 	str	r2, [r3, #-4007]
     f60:	e59f213c 	ldr	r2, [pc, #316]	; 10a4 <.text+0x10a4>
     f64:	e92d45f0 	stmdb	sp!, {r4, r5, r6, r7, r8, sl, lr}
     f68:	e5126dff 	ldr	r6, [r2, #-3583]
     f6c:	e3160001 	tst	r6, #1	; 0x1
     f70:	0a00000b 	beq	fa4 <USBHwISR+0x50>
     f74:	e59f312c 	ldr	r3, [pc, #300]	; 10a8 <.text+0x10a8>
     f78:	e5934000 	ldr	r4, [r3]
     f7c:	e3a03001 	mov	r3, #1	; 0x1
     f80:	e3540000 	cmp	r4, #0	; 0x0
     f84:	e5023df7 	str	r3, [r2, #-3575]
     f88:	0a000005 	beq	fa4 <USBHwISR+0x50>
     f8c:	e3a000f5 	mov	r0, #245	; 0xf5
     f90:	ebffff2d 	bl	c4c <USBHwCmdRead>
     f94:	e1a00800 	mov	r0, r0, lsl #16
     f98:	e1a00820 	mov	r0, r0, lsr #16
     f9c:	e1a0e00f 	mov	lr, pc
     fa0:	e12fff14 	bx	r4
     fa4:	e3160008 	tst	r6, #8	; 0x8
     fa8:	0a000011 	beq	ff4 <USBHwISR+0xa0>
     fac:	e59f30f0 	ldr	r3, [pc, #240]	; 10a4 <.text+0x10a4>
     fb0:	e3a02008 	mov	r2, #8	; 0x8
     fb4:	e3a000fe 	mov	r0, #254	; 0xfe
     fb8:	e5032df7 	str	r2, [r3, #-3575]
     fbc:	ebffff22 	bl	c4c <USBHwCmdRead>
     fc0:	e310001a 	tst	r0, #26	; 0x1a
     fc4:	0a00000a 	beq	ff4 <USBHwISR+0xa0>
     fc8:	e59f30dc 	ldr	r3, [pc, #220]	; 10ac <.text+0x10ac>
     fcc:	e5933000 	ldr	r3, [r3]
     fd0:	e3530000 	cmp	r3, #0	; 0x0
     fd4:	0a000006 	beq	ff4 <USBHwISR+0xa0>
     fd8:	e59f50c0 	ldr	r5, [pc, #192]	; 10a0 <.text+0x10a0>
     fdc:	e3a04001 	mov	r4, #1	; 0x1
     fe0:	e5054fa7 	str	r4, [r5, #-4007]
     fe4:	e2000015 	and	r0, r0, #21	; 0x15
     fe8:	e1a0e00f 	mov	lr, pc
     fec:	e12fff13 	bx	r3
     ff0:	e5054fa3 	str	r4, [r5, #-4003]
     ff4:	e3160004 	tst	r6, #4	; 0x4
     ff8:	0a000024 	beq	1090 <USBHwISR+0x13c>
     ffc:	e59f30a0 	ldr	r3, [pc, #160]	; 10a4 <.text+0x10a4>
    1000:	e3a02004 	mov	r2, #4	; 0x4
    1004:	e5032df7 	str	r2, [r3, #-3575]
    1008:	e59fa0a0 	ldr	sl, [pc, #160]	; 10b0 <.text+0x10b0>
    100c:	e59f708c 	ldr	r7, [pc, #140]	; 10a0 <.text+0x10a0>
    1010:	e1a05003 	mov	r5, r3
    1014:	e1a06002 	mov	r6, r2
    1018:	e3a04000 	mov	r4, #0	; 0x0
    101c:	e3a08001 	mov	r8, #1	; 0x1
    1020:	e1a02418 	mov	r2, r8, lsl r4
    1024:	e5153dcf 	ldr	r3, [r5, #-3535]
    1028:	e1120003 	tst	r2, r3
    102c:	0a000014 	beq	1084 <USBHwISR+0x130>
    1030:	e5052dc7 	str	r2, [r5, #-3527]
    1034:	e5153dff 	ldr	r3, [r5, #-3583]
    1038:	e2032020 	and	r2, r3, #32	; 0x20
    103c:	e3520020 	cmp	r2, #32	; 0x20
    1040:	1afffffb 	bne	1034 <USBHwISR+0xe0>
    1044:	e0843fa4 	add	r3, r4, r4, lsr #31
    1048:	e1a030c3 	mov	r3, r3, asr #1
    104c:	e79a3103 	ldr	r3, [sl, r3, lsl #2]
    1050:	e5052df7 	str	r2, [r5, #-3575]
    1054:	e3530000 	cmp	r3, #0	; 0x0
    1058:	e5151deb 	ldr	r1, [r5, #-3563]
    105c:	0a000008 	beq	1084 <USBHwISR+0x130>
    1060:	e1a000c4 	mov	r0, r4, asr #1
    1064:	e200000f 	and	r0, r0, #15	; 0xf
    1068:	e1800384 	orr	r0, r0, r4, lsl #7
    106c:	e5076fa7 	str	r6, [r7, #-4007]
    1070:	e200008f 	and	r0, r0, #143	; 0x8f
    1074:	e201101f 	and	r1, r1, #31	; 0x1f
    1078:	e1a0e00f 	mov	lr, pc
    107c:	e12fff13 	bx	r3
    1080:	e5076fa3 	str	r6, [r7, #-4003]
    1084:	e2844001 	add	r4, r4, #1	; 0x1
    1088:	e3540020 	cmp	r4, #32	; 0x20
    108c:	1affffe3 	bne	1020 <USBHwISR+0xcc>
    1090:	e59f3008 	ldr	r3, [pc, #8]	; 10a0 <.text+0x10a0>
    1094:	e3a02002 	mov	r2, #2	; 0x2
    1098:	e5032fa3 	str	r2, [r3, #-4003]
    109c:	e8bd85f0 	ldmia	sp!, {r4, r5, r6, r7, r8, sl, pc}
    10a0:	3fffcfff 	svccc	0x00ffcfff
    10a4:	ffe0cfff 	undefined instruction 0xffe0cfff
    10a8:	40000228 	andmi	r0, r0, r8, lsr #4
    10ac:	4000022c 	andmi	r0, r0, ip, lsr #4
    10b0:	40000230 	andmi	r0, r0, r0, lsr r2

000010b4 <USBHwInit>:
    10b4:	e59f2124 	ldr	r2, [pc, #292]	; 11e0 <.text+0x11e0>
    10b8:	e5923004 	ldr	r3, [r2, #4]
    10bc:	e3c33103 	bic	r3, r3, #-1073741824	; 0xc0000000
    10c0:	e3833101 	orr	r3, r3, #1073741824	; 0x40000000
    10c4:	e5823004 	str	r3, [r2, #4]
    10c8:	e592300c 	ldr	r3, [r2, #12]
    10cc:	e3c33203 	bic	r3, r3, #805306368	; 0x30000000
    10d0:	e3833202 	orr	r3, r3, #536870912	; 0x20000000
    10d4:	e582300c 	str	r3, [r2, #12]
    10d8:	e5923000 	ldr	r3, [r2]
    10dc:	e3c3330f 	bic	r3, r3, #1006632960	; 0x3c000000
    10e0:	e3833301 	orr	r3, r3, #67108864	; 0x4000000
    10e4:	e5823000 	str	r3, [r2]
    10e8:	e59f20f4 	ldr	r2, [pc, #244]	; 11e4 <.text+0x11e4>
    10ec:	e5123fff 	ldr	r3, [r2, #-4095]
    10f0:	e3833901 	orr	r3, r3, #16384	; 0x4000
    10f4:	e5023fff 	str	r3, [r2, #-4095]
    10f8:	e3a03901 	mov	r3, #16384	; 0x4000
    10fc:	e5023fe7 	str	r3, [r2, #-4071]
    1100:	e59f20e0 	ldr	r2, [pc, #224]	; 11e8 <.text+0x11e8>
    1104:	e59230c4 	ldr	r3, [r2, #196]
    1108:	e92d4010 	stmdb	sp!, {r4, lr}
    110c:	e3833102 	orr	r3, r3, #-2147483648	; 0x80000000
    1110:	e58230c4 	str	r3, [r2, #196]
    1114:	e59f10d0 	ldr	r1, [pc, #208]	; 11ec <.text+0x11ec>
    1118:	e3a03005 	mov	r3, #5	; 0x5
    111c:	e5823108 	str	r3, [r2, #264]
    1120:	e2833015 	add	r3, r3, #21	; 0x15
    1124:	e501300b 	str	r3, [r1, #-11]
    1128:	e5113007 	ldr	r3, [r1, #-7]
    112c:	e313001a 	tst	r3, #26	; 0x1a
    1130:	0afffffc 	beq	1128 <USBHwInit+0x74>
    1134:	e3a04000 	mov	r4, #0	; 0x0
    1138:	e3e02000 	mvn	r2, #0	; 0x0
    113c:	e3a03003 	mov	r3, #3	; 0x3
    1140:	e5013eef 	str	r3, [r1, #-3823]
    1144:	e1a00004 	mov	r0, r4
    1148:	e5014dfb 	str	r4, [r1, #-3579]
    114c:	e5012df7 	str	r2, [r1, #-3575]
    1150:	e5014dd3 	str	r4, [r1, #-3539]
    1154:	e5014dcb 	str	r4, [r1, #-3531]
    1158:	e5012dc7 	str	r2, [r1, #-3527]
    115c:	e5014dbf 	str	r4, [r1, #-3519]
    1160:	ebfffef1 	bl	d2c <USBHwNakIntEnable>
    1164:	e59f107c 	ldr	r1, [pc, #124]	; 11e8 <.text+0x11e8>
    1168:	e59131a0 	ldr	r3, [r1, #416]
    116c:	e59fc06c 	ldr	ip, [pc, #108]	; 11e0 <.text+0x11e0>
    1170:	e3833001 	orr	r3, r3, #1	; 0x1
    1174:	e58131a0 	str	r3, [r1, #416]
    1178:	e59f2064 	ldr	r2, [pc, #100]	; 11e4 <.text+0x11e4>
    117c:	e58c4028 	str	r4, [ip, #40]
    1180:	e5123fbf 	ldr	r3, [r2, #-4031]
    1184:	e3a00001 	mov	r0, #1	; 0x1
    1188:	e3833001 	orr	r3, r3, #1	; 0x1
    118c:	e5023fbf 	str	r3, [r2, #-4031]
    1190:	e5020fa3 	str	r0, [r2, #-4003]
    1194:	e59131a0 	ldr	r3, [r1, #416]
    1198:	e1833000 	orr	r3, r3, r0
    119c:	e58131a0 	str	r3, [r1, #416]
    11a0:	e58c4028 	str	r4, [ip, #40]
    11a4:	e5123fbf 	ldr	r3, [r2, #-4031]
    11a8:	e3833002 	orr	r3, r3, #2	; 0x2
    11ac:	e5023fbf 	str	r3, [r2, #-4031]
    11b0:	e3a03002 	mov	r3, #2	; 0x2
    11b4:	e5023fa3 	str	r3, [r2, #-4003]
    11b8:	e59131a0 	ldr	r3, [r1, #416]
    11bc:	e1833000 	orr	r3, r3, r0
    11c0:	e58131a0 	str	r3, [r1, #416]
    11c4:	e58c4028 	str	r4, [ip, #40]
    11c8:	e5123fbf 	ldr	r3, [r2, #-4031]
    11cc:	e3833004 	orr	r3, r3, #4	; 0x4
    11d0:	e5023fbf 	str	r3, [r2, #-4031]
    11d4:	e3a03004 	mov	r3, #4	; 0x4
    11d8:	e5023fa3 	str	r3, [r2, #-4003]
    11dc:	e8bd8010 	ldmia	sp!, {r4, pc}
    11e0:	e002c000 	and	ip, r2, r0
    11e4:	3fffcfff 	svccc	0x00ffcfff
    11e8:	e01fc000 	ands	ip, pc, r0
    11ec:	ffe0cfff 	undefined instruction 0xffe0cfff

000011f0 <USBSetupDMADescriptor>:
    11f0:	e52de004 	str	lr, [sp, #-4]!
    11f4:	e3a0e000 	mov	lr, #0	; 0x0
    11f8:	e580e004 	str	lr, [r0, #4]
    11fc:	e5801000 	str	r1, [r0]
    1200:	e1a0c001 	mov	ip, r1
    1204:	e1a03b03 	mov	r3, r3, lsl #22
    1208:	e5901004 	ldr	r1, [r0, #4]
    120c:	e1a03b23 	mov	r3, r3, lsr #22
    1210:	e1811283 	orr	r1, r1, r3, lsl #5
    1214:	e5801004 	str	r1, [r0, #4]
    1218:	e1dd10b4 	ldrh	r1, [sp, #4]
    121c:	e5903004 	ldr	r3, [r0, #4]
    1220:	e1833801 	orr	r3, r3, r1, lsl #16
    1224:	e5803004 	str	r3, [r0, #4]
    1228:	e21220ff 	ands	r2, r2, #255	; 0xff
    122c:	15903004 	ldrne	r3, [r0, #4]
    1230:	13833010 	orrne	r3, r3, #16	; 0x10
    1234:	15803004 	strne	r3, [r0, #4]
    1238:	e35c0000 	cmp	ip, #0	; 0x0
    123c:	15903004 	ldrne	r3, [r0, #4]
    1240:	e59d100c 	ldr	r1, [sp, #12]
    1244:	13833004 	orrne	r3, r3, #4	; 0x4
    1248:	15803004 	strne	r3, [r0, #4]
    124c:	e59d3008 	ldr	r3, [sp, #8]
    1250:	e3520000 	cmp	r2, #0	; 0x0
    1254:	13510000 	cmpne	r1, #0	; 0x0
    1258:	e5803008 	str	r3, [r0, #8]
    125c:	15801010 	strne	r1, [r0, #16]
    1260:	e580e00c 	str	lr, [r0, #12]
    1264:	e49df004 	ldr	pc, [sp], #4

00001268 <USBDisableDMAForEndpoint>:
    1268:	e200200f 	and	r2, r0, #15	; 0xf
    126c:	e1a02082 	mov	r2, r2, lsl #1
    1270:	e2000080 	and	r0, r0, #128	; 0x80
    1274:	e18223a0 	orr	r2, r2, r0, lsr #7
    1278:	e3a03001 	mov	r3, #1	; 0x1
    127c:	e1a03213 	mov	r3, r3, lsl r2
    1280:	e59f2004 	ldr	r2, [pc, #4]	; 128c <.text+0x128c>
    1284:	e5023d73 	str	r3, [r2, #-3443]
    1288:	e12fff1e 	bx	lr
    128c:	ffe0cfff 	undefined instruction 0xffe0cfff

00001290 <USBEnableDMAForEndpoint>:
    1290:	e200200f 	and	r2, r0, #15	; 0xf
    1294:	e1a02082 	mov	r2, r2, lsl #1
    1298:	e2000080 	and	r0, r0, #128	; 0x80
    129c:	e18223a0 	orr	r2, r2, r0, lsr #7
    12a0:	e3a03001 	mov	r3, #1	; 0x1
    12a4:	e1a03213 	mov	r3, r3, lsl r2
    12a8:	e59f2004 	ldr	r2, [pc, #4]	; 12b4 <.text+0x12b4>
    12ac:	e5023d77 	str	r3, [r2, #-3447]
    12b0:	e12fff1e 	bx	lr
    12b4:	ffe0cfff 	undefined instruction 0xffe0cfff

000012b8 <USBInitializeISOCFrameArray>:
    12b8:	e92d4030 	stmdb	sp!, {r4, r5, lr}
    12bc:	e1a03b03 	mov	r3, r3, lsl #22
    12c0:	e1a02802 	mov	r2, r2, lsl #16
    12c4:	e1a03b23 	mov	r3, r3, lsr #22
    12c8:	e1a05000 	mov	r5, r0
    12cc:	e1a04001 	mov	r4, r1
    12d0:	e1a0c822 	mov	ip, r2, lsr #16
    12d4:	e3830902 	orr	r0, r3, #32768	; 0x8000
    12d8:	e3a0e000 	mov	lr, #0	; 0x0
    12dc:	ea000000 	b	12e4 <USBInitializeISOCFrameArray+0x2c>
    12e0:	e7851102 	str	r1, [r5, r2, lsl #2]
    12e4:	e1a0280e 	mov	r2, lr, lsl #16
    12e8:	e28c3001 	add	r3, ip, #1	; 0x1
    12ec:	e1a02822 	mov	r2, r2, lsr #16
    12f0:	e1a03803 	mov	r3, r3, lsl #16
    12f4:	e1520004 	cmp	r2, r4
    12f8:	e180180c 	orr	r1, r0, ip, lsl #16
    12fc:	e28ee001 	add	lr, lr, #1	; 0x1
    1300:	e1a0c823 	mov	ip, r3, lsr #16
    1304:	3afffff5 	bcc	12e0 <USBInitializeISOCFrameArray+0x28>
    1308:	e8bd8030 	ldmia	sp!, {r4, r5, pc}

0000130c <USBSetHeadDDForDMA>:
    130c:	e200300f 	and	r3, r0, #15	; 0xf
    1310:	e1a03083 	mov	r3, r3, lsl #1
    1314:	e2000080 	and	r0, r0, #128	; 0x80
    1318:	e18333a0 	orr	r3, r3, r0, lsr #7
    131c:	e7812103 	str	r2, [r1, r3, lsl #2]
    1320:	e12fff1e 	bx	lr

00001324 <USBInitializeUSBDMA>:
    1324:	e3a03000 	mov	r3, #0	; 0x0
    1328:	e1a02003 	mov	r2, r3
    132c:	e7832000 	str	r2, [r3, r0]
    1330:	e2833004 	add	r3, r3, #4	; 0x4
    1334:	e3530080 	cmp	r3, #128	; 0x80
    1338:	1afffffb 	bne	132c <USBInitializeUSBDMA+0x8>
    133c:	e59f3004 	ldr	r3, [pc, #4]	; 1348 <.text+0x1348>
    1340:	e5030d7f 	str	r0, [r3, #-3455]
    1344:	e12fff1e 	bx	lr
    1348:	ffe0cfff 	undefined instruction 0xffe0cfff

0000134c <USBHwRegisterFrameHandler>:
    134c:	e59f1018 	ldr	r1, [pc, #24]	; 136c <.text+0x136c>
    1350:	e59f3018 	ldr	r3, [pc, #24]	; 1370 <.text+0x1370>
    1354:	e5112dfb 	ldr	r2, [r1, #-3579]
    1358:	e5830000 	str	r0, [r3]
    135c:	e59f0010 	ldr	r0, [pc, #16]	; 1374 <.text+0x1374>
    1360:	e3822001 	orr	r2, r2, #1	; 0x1
    1364:	e5012dfb 	str	r2, [r1, #-3579]
    1368:	eafffcee 	b	728 <puts>
    136c:	ffe0cfff 	undefined instruction 0xffe0cfff
    1370:	40000228 	andmi	r0, r0, r8, lsr #4
    1374:	00001f74 	andeq	r1, r0, r4, ror pc

00001378 <USBHwRegisterDevIntHandler>:
    1378:	e59f1018 	ldr	r1, [pc, #24]	; 1398 <.text+0x1398>
    137c:	e59f3018 	ldr	r3, [pc, #24]	; 139c <.text+0x139c>
    1380:	e5112dfb 	ldr	r2, [r1, #-3579]
    1384:	e5830000 	str	r0, [r3]
    1388:	e59f0010 	ldr	r0, [pc, #16]	; 13a0 <.text+0x13a0>
    138c:	e3822008 	orr	r2, r2, #8	; 0x8
    1390:	e5012dfb 	str	r2, [r1, #-3579]
    1394:	eafffce3 	b	728 <puts>
    1398:	ffe0cfff 	undefined instruction 0xffe0cfff
    139c:	4000022c 	andmi	r0, r0, ip, lsr #4
    13a0:	00001f94 	muleq	r0, r4, pc

000013a4 <USBHwRegisterEPIntHandler>:
    13a4:	e92d4010 	stmdb	sp!, {r4, lr}
    13a8:	e200300f 	and	r3, r0, #15	; 0xf
    13ac:	e1a03083 	mov	r3, r3, lsl #1
    13b0:	e2002080 	and	r2, r0, #128	; 0x80
    13b4:	e183e3a2 	orr	lr, r3, r2, lsr #7
    13b8:	e35e001f 	cmp	lr, #31	; 0x1f
    13bc:	e1a04001 	mov	r4, r1
    13c0:	e24dd004 	sub	sp, sp, #4	; 0x4
    13c4:	e20010ff 	and	r1, r0, #255	; 0xff
    13c8:	da000007 	ble	13ec <USBHwRegisterEPIntHandler+0x48>
    13cc:	e3a0c0d2 	mov	ip, #210	; 0xd2
    13d0:	e59f0050 	ldr	r0, [pc, #80]	; 1428 <.text+0x1428>
    13d4:	e59f1050 	ldr	r1, [pc, #80]	; 142c <.text+0x142c>
    13d8:	e59f2050 	ldr	r2, [pc, #80]	; 1430 <.text+0x1430>
    13dc:	e59f3050 	ldr	r3, [pc, #80]	; 1434 <.text+0x1434>
    13e0:	e58dc000 	str	ip, [sp]
    13e4:	ebfffc99 	bl	650 <printf>
    13e8:	eafffffe 	b	13e8 <USBHwRegisterEPIntHandler+0x44>
    13ec:	e59fc044 	ldr	ip, [pc, #68]	; 1438 <.text+0x1438>
    13f0:	e51c3dcb 	ldr	r3, [ip, #-3531]
    13f4:	e3a02001 	mov	r2, #1	; 0x1
    13f8:	e1833e12 	orr	r3, r3, r2, lsl lr
    13fc:	e50c3dcb 	str	r3, [ip, #-3531]
    1400:	e51c2dfb 	ldr	r2, [ip, #-3579]
    1404:	e59f3030 	ldr	r3, [pc, #48]	; 143c <.text+0x143c>
    1408:	e59f0030 	ldr	r0, [pc, #48]	; 1440 <.text+0x1440>
    140c:	e3822004 	orr	r2, r2, #4	; 0x4
    1410:	e1a0e0ae 	mov	lr, lr, lsr #1
    1414:	e783410e 	str	r4, [r3, lr, lsl #2]
    1418:	e50c2dfb 	str	r2, [ip, #-3579]
    141c:	e28dd004 	add	sp, sp, #4	; 0x4
    1420:	e8bd4010 	ldmia	sp!, {r4, lr}
    1424:	eafffc89 	b	650 <printf>
    1428:	00001fbc 	streqh	r1, [r0], -ip
    142c:	00001fe4 	andeq	r1, r0, r4, ror #31
    1430:	00001fec 	andeq	r1, r0, ip, ror #31
    1434:	00001e88 	andeq	r1, r0, r8, lsl #29
    1438:	ffe0cfff 	undefined instruction 0xffe0cfff
    143c:	40000230 	andmi	r0, r0, r0, lsr r2
    1440:	00001ff8 	streqd	r1, [r0], -r8

00001444 <USBRegisterRequestHandler>:
    1444:	e52de004 	str	lr, [sp, #-4]!
    1448:	e3500000 	cmp	r0, #0	; 0x0
    144c:	e24dd004 	sub	sp, sp, #4	; 0x4
    1450:	aa000007 	bge	1474 <USBRegisterRequestHandler+0x30>
    1454:	e3a0c0e2 	mov	ip, #226	; 0xe2
    1458:	e59f0054 	ldr	r0, [pc, #84]	; 14b4 <.text+0x14b4>
    145c:	e59f1054 	ldr	r1, [pc, #84]	; 14b8 <.text+0x14b8>
    1460:	e59f2054 	ldr	r2, [pc, #84]	; 14bc <.text+0x14bc>
    1464:	e59f3054 	ldr	r3, [pc, #84]	; 14c0 <.text+0x14c0>
    1468:	e58dc000 	str	ip, [sp]
    146c:	ebfffc77 	bl	650 <printf>
    1470:	eafffffe 	b	1470 <USBRegisterRequestHandler+0x2c>
    1474:	e3500003 	cmp	r0, #3	; 0x3
    1478:	da000007 	ble	149c <USBRegisterRequestHandler+0x58>
    147c:	e3a0c0e3 	mov	ip, #227	; 0xe3
    1480:	e59f002c 	ldr	r0, [pc, #44]	; 14b4 <.text+0x14b4>
    1484:	e59f1038 	ldr	r1, [pc, #56]	; 14c4 <.text+0x14c4>
    1488:	e59f202c 	ldr	r2, [pc, #44]	; 14bc <.text+0x14bc>
    148c:	e59f302c 	ldr	r3, [pc, #44]	; 14c0 <.text+0x14c0>
    1490:	e58dc000 	str	ip, [sp]
    1494:	ebfffc6d 	bl	650 <printf>
    1498:	eafffffe 	b	1498 <USBRegisterRequestHandler+0x54>
    149c:	e59f3024 	ldr	r3, [pc, #36]	; 14c8 <.text+0x14c8>
    14a0:	e7832100 	str	r2, [r3, r0, lsl #2]
    14a4:	e59f3020 	ldr	r3, [pc, #32]	; 14cc <.text+0x14cc>
    14a8:	e7831100 	str	r1, [r3, r0, lsl #2]
    14ac:	e28dd004 	add	sp, sp, #4	; 0x4
    14b0:	e8bd8000 	ldmia	sp!, {pc}
    14b4:	00001fbc 	streqh	r1, [r0], -ip
    14b8:	00002018 	andeq	r2, r0, r8, lsl r0
    14bc:	00002024 	andeq	r2, r0, r4, lsr #32
    14c0:	00001ea4 	andeq	r1, r0, r4, lsr #29
    14c4:	00002034 	andeq	r2, r0, r4, lsr r0
    14c8:	40000280 	andmi	r0, r0, r0, lsl #5
    14cc:	40000270 	andmi	r0, r0, r0, ror r2

000014d0 <_HandleRequest>:
    14d0:	e92d4010 	stmdb	sp!, {r4, lr}
    14d4:	e5d03000 	ldrb	r3, [r0]
    14d8:	e1a032a3 	mov	r3, r3, lsr #5
    14dc:	e203c003 	and	ip, r3, #3	; 0x3
    14e0:	e59f3028 	ldr	r3, [pc, #40]	; 1510 <.text+0x1510>
    14e4:	e793410c 	ldr	r4, [r3, ip, lsl #2]
    14e8:	e3540000 	cmp	r4, #0	; 0x0
    14ec:	1a000004 	bne	1504 <_HandleRequest+0x34>
    14f0:	e1a0100c 	mov	r1, ip
    14f4:	e59f0018 	ldr	r0, [pc, #24]	; 1514 <.text+0x1514>
    14f8:	ebfffc54 	bl	650 <printf>
    14fc:	e1a00004 	mov	r0, r4
    1500:	e8bd8010 	ldmia	sp!, {r4, pc}
    1504:	e1a0e00f 	mov	lr, pc
    1508:	e12fff14 	bx	r4
    150c:	e8bd8010 	ldmia	sp!, {r4, pc}
    1510:	40000270 	andmi	r0, r0, r0, ror r2
    1514:	00002040 	andeq	r2, r0, r0, asr #32

00001518 <StallControlPipe>:
    1518:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
    151c:	e1a03000 	mov	r3, r0
    1520:	e3a01001 	mov	r1, #1	; 0x1
    1524:	e3a00080 	mov	r0, #128	; 0x80
    1528:	e20350ff 	and	r5, r3, #255	; 0xff
    152c:	ebfffe09 	bl	d58 <USBHwEPStall>
    1530:	e59f0030 	ldr	r0, [pc, #48]	; 1568 <.text+0x1568>
    1534:	ebfffc45 	bl	650 <printf>
    1538:	e59f602c 	ldr	r6, [pc, #44]	; 156c <.text+0x156c>
    153c:	e3a04000 	mov	r4, #0	; 0x0
    1540:	e7d41006 	ldrb	r1, [r4, r6]
    1544:	e59f0024 	ldr	r0, [pc, #36]	; 1570 <.text+0x1570>
    1548:	e2844001 	add	r4, r4, #1	; 0x1
    154c:	ebfffc3f 	bl	650 <printf>
    1550:	e3540008 	cmp	r4, #8	; 0x8
    1554:	1afffff9 	bne	1540 <StallControlPipe+0x28>
    1558:	e59f0014 	ldr	r0, [pc, #20]	; 1574 <.text+0x1574>
    155c:	e1a01005 	mov	r1, r5
    1560:	e8bd4070 	ldmia	sp!, {r4, r5, r6, lr}
    1564:	eafffc39 	b	650 <printf>
    1568:	0000205c 	andeq	r2, r0, ip, asr r0
    156c:	40000290 	mulmi	r0, r0, r2
    1570:	00002068 	andeq	r2, r0, r8, rrx
    1574:	00002070 	andeq	r2, r0, r0, ror r0

00001578 <DataIn>:
    1578:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
    157c:	e59f6038 	ldr	r6, [pc, #56]	; 15bc <.text+0x15bc>
    1580:	e5964000 	ldr	r4, [r6]
    1584:	e59f5034 	ldr	r5, [pc, #52]	; 15c0 <.text+0x15c0>
    1588:	e3540040 	cmp	r4, #64	; 0x40
    158c:	a3a04040 	movge	r4, #64	; 0x40
    1590:	e1a02004 	mov	r2, r4
    1594:	e3a00080 	mov	r0, #128	; 0x80
    1598:	e5951000 	ldr	r1, [r5]
    159c:	ebfffdf5 	bl	d78 <USBHwEPWrite>
    15a0:	e5953000 	ldr	r3, [r5]
    15a4:	e5962000 	ldr	r2, [r6]
    15a8:	e0833004 	add	r3, r3, r4
    15ac:	e0642002 	rsb	r2, r4, r2
    15b0:	e5853000 	str	r3, [r5]
    15b4:	e5862000 	str	r2, [r6]
    15b8:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
    15bc:	4000029c 	mulmi	r0, ip, r2
    15c0:	40000298 	mulmi	r0, r8, r2

000015c4 <USBHandleControlTransfer>:
    15c4:	e92d40f0 	stmdb	sp!, {r4, r5, r6, r7, lr}
    15c8:	e21000ff 	ands	r0, r0, #255	; 0xff
    15cc:	e24dd004 	sub	sp, sp, #4	; 0x4
    15d0:	e20170ff 	and	r7, r1, #255	; 0xff
    15d4:	1a000051 	bne	1720 <USBHandleControlTransfer+0x15c>
    15d8:	e3110004 	tst	r1, #4	; 0x4
    15dc:	e59f6178 	ldr	r6, [pc, #376]	; 175c <.text+0x175c>
    15e0:	0a000021 	beq	166c <USBHandleControlTransfer+0xa8>
    15e4:	e59f5174 	ldr	r5, [pc, #372]	; 1760 <.text+0x1760>
    15e8:	e3a02008 	mov	r2, #8	; 0x8
    15ec:	e1a01005 	mov	r1, r5
    15f0:	ebfffe03 	bl	e04 <USBHwEPRead>
    15f4:	e5d51001 	ldrb	r1, [r5, #1]
    15f8:	e59f0164 	ldr	r0, [pc, #356]	; 1764 <.text+0x1764>
    15fc:	ebfffc13 	bl	650 <printf>
    1600:	e5d50000 	ldrb	r0, [r5]
    1604:	e59f215c 	ldr	r2, [pc, #348]	; 1768 <.text+0x1768>
    1608:	e1a032a0 	mov	r3, r0, lsr #5
    160c:	e1d510b6 	ldrh	r1, [r5, #6]
    1610:	e2033003 	and	r3, r3, #3	; 0x3
    1614:	e7923103 	ldr	r3, [r2, r3, lsl #2]
    1618:	e59f414c 	ldr	r4, [pc, #332]	; 176c <.text+0x176c>
    161c:	e59f214c 	ldr	r2, [pc, #332]	; 1770 <.text+0x1770>
    1620:	e3510000 	cmp	r1, #0	; 0x0
    1624:	e5823000 	str	r3, [r2]
    1628:	e5861000 	str	r1, [r6]
    162c:	e5841000 	str	r1, [r4]
    1630:	0a000001 	beq	163c <USBHandleControlTransfer+0x78>
    1634:	e1b003a0 	movs	r0, r0, lsr #7
    1638:	0a000045 	beq	1754 <USBHandleControlTransfer+0x190>
    163c:	e1a00005 	mov	r0, r5
    1640:	e1a01004 	mov	r1, r4
    1644:	ebffffa1 	bl	14d0 <_HandleRequest>
    1648:	e3500000 	cmp	r0, #0	; 0x0
    164c:	059f0120 	ldreq	r0, [pc, #288]	; 1774 <.text+0x1774>
    1650:	0a000022 	beq	16e0 <USBHandleControlTransfer+0x11c>
    1654:	e1d520b6 	ldrh	r2, [r5, #6]
    1658:	e5943000 	ldr	r3, [r4]
    165c:	e1520003 	cmp	r2, r3
    1660:	d5862000 	strle	r2, [r6]
    1664:	c5863000 	strgt	r3, [r6]
    1668:	ea00002e 	b	1728 <USBHandleControlTransfer+0x164>
    166c:	e5962000 	ldr	r2, [r6]
    1670:	e3520000 	cmp	r2, #0	; 0x0
    1674:	da00001e 	ble	16f4 <USBHandleControlTransfer+0x130>
    1678:	e59f40f0 	ldr	r4, [pc, #240]	; 1770 <.text+0x1770>
    167c:	e5941000 	ldr	r1, [r4]
    1680:	ebfffddf 	bl	e04 <USBHwEPRead>
    1684:	e3500000 	cmp	r0, #0	; 0x0
    1688:	ba000015 	blt	16e4 <USBHandleControlTransfer+0x120>
    168c:	e5962000 	ldr	r2, [r6]
    1690:	e5943000 	ldr	r3, [r4]
    1694:	e0602002 	rsb	r2, r0, r2
    1698:	e0833000 	add	r3, r3, r0
    169c:	e3520000 	cmp	r2, #0	; 0x0
    16a0:	e5843000 	str	r3, [r4]
    16a4:	e5862000 	str	r2, [r6]
    16a8:	1a000029 	bne	1754 <USBHandleControlTransfer+0x190>
    16ac:	e59f00ac 	ldr	r0, [pc, #172]	; 1760 <.text+0x1760>
    16b0:	e5d03000 	ldrb	r3, [r0]
    16b4:	e59f20ac 	ldr	r2, [pc, #172]	; 1768 <.text+0x1768>
    16b8:	e1a032a3 	mov	r3, r3, lsr #5
    16bc:	e2033003 	and	r3, r3, #3	; 0x3
    16c0:	e7923103 	ldr	r3, [r2, r3, lsl #2]
    16c4:	e59f10a0 	ldr	r1, [pc, #160]	; 176c <.text+0x176c>
    16c8:	e1a02004 	mov	r2, r4
    16cc:	e5843000 	str	r3, [r4]
    16d0:	ebffff7e 	bl	14d0 <_HandleRequest>
    16d4:	e3500000 	cmp	r0, #0	; 0x0
    16d8:	1a000012 	bne	1728 <USBHandleControlTransfer+0x164>
    16dc:	e59f0094 	ldr	r0, [pc, #148]	; 1778 <.text+0x1778>
    16e0:	ebfffc10 	bl	728 <puts>
    16e4:	e1a00007 	mov	r0, r7
    16e8:	e28dd004 	add	sp, sp, #4	; 0x4
    16ec:	e8bd40f0 	ldmia	sp!, {r4, r5, r6, r7, lr}
    16f0:	eaffff88 	b	1518 <StallControlPipe>
    16f4:	e1a01000 	mov	r1, r0
    16f8:	e1a02000 	mov	r2, r0
    16fc:	ebfffdc0 	bl	e04 <USBHwEPRead>
    1700:	e59f2074 	ldr	r2, [pc, #116]	; 177c <.text+0x177c>
    1704:	e59f3074 	ldr	r3, [pc, #116]	; 1780 <.text+0x1780>
    1708:	e3500000 	cmp	r0, #0	; 0x0
    170c:	d1a00002 	movle	r0, r2
    1710:	c1a00003 	movgt	r0, r3
    1714:	e28dd004 	add	sp, sp, #4	; 0x4
    1718:	e8bd40f0 	ldmia	sp!, {r4, r5, r6, r7, lr}
    171c:	eafffbcb 	b	650 <printf>
    1720:	e3500080 	cmp	r0, #128	; 0x80
    1724:	1a000002 	bne	1734 <USBHandleControlTransfer+0x170>
    1728:	e28dd004 	add	sp, sp, #4	; 0x4
    172c:	e8bd40f0 	ldmia	sp!, {r4, r5, r6, r7, lr}
    1730:	eaffff90 	b	1578 <DataIn>
    1734:	e3a0c0d4 	mov	ip, #212	; 0xd4
    1738:	e59f0044 	ldr	r0, [pc, #68]	; 1784 <.text+0x1784>
    173c:	e59f1044 	ldr	r1, [pc, #68]	; 1788 <.text+0x1788>
    1740:	e59f2044 	ldr	r2, [pc, #68]	; 178c <.text+0x178c>
    1744:	e59f3044 	ldr	r3, [pc, #68]	; 1790 <.text+0x1790>
    1748:	e58dc000 	str	ip, [sp]
    174c:	ebfffbbf 	bl	650 <printf>
    1750:	eafffffe 	b	1750 <USBHandleControlTransfer+0x18c>
    1754:	e28dd004 	add	sp, sp, #4	; 0x4
    1758:	e8bd80f0 	ldmia	sp!, {r4, r5, r6, r7, pc}
    175c:	4000029c 	mulmi	r0, ip, r2
    1760:	40000290 	mulmi	r0, r0, r2
    1764:	0000207c 	andeq	r2, r0, ip, ror r0
    1768:	40000280 	andmi	r0, r0, r0, lsl #5
    176c:	400002a0 	andmi	r0, r0, r0, lsr #5
    1770:	40000298 	mulmi	r0, r8, r2
    1774:	00002080 	andeq	r2, r0, r0, lsl #1
    1778:	00002098 	muleq	r0, r8, r0
    177c:	00001fe0 	andeq	r1, r0, r0, ror #31
    1780:	000020b0 	streqh	r2, [r0], -r0
    1784:	00001fbc 	streqh	r1, [r0], -ip
    1788:	000020b4 	streqh	r2, [r0], -r4
    178c:	00002024 	andeq	r2, r0, r4, lsr #32
    1790:	00001ec0 	andeq	r1, r0, r0, asr #29

00001794 <USBRegisterDescriptors>:
    1794:	e59f3004 	ldr	r3, [pc, #4]	; 17a0 <.text+0x17a0>
    1798:	e5830000 	str	r0, [r3]
    179c:	e12fff1e 	bx	lr
    17a0:	400002ac 	andmi	r0, r0, ip, lsr #5

000017a4 <USBRegisterCustomReqHandler>:
    17a4:	e59f3004 	ldr	r3, [pc, #4]	; 17b0 <.text+0x17b0>
    17a8:	e5830000 	str	r0, [r3]
    17ac:	e12fff1e 	bx	lr
    17b0:	400002a4 	andmi	r0, r0, r4, lsr #5

000017b4 <USBGetDescriptor>:
    17b4:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
    17b8:	e59f10ac 	ldr	r1, [pc, #172]	; 186c <.text+0x186c>
    17bc:	e5911000 	ldr	r1, [r1]
    17c0:	e1a00800 	mov	r0, r0, lsl #16
    17c4:	e3510000 	cmp	r1, #0	; 0x0
    17c8:	e1a0c820 	mov	ip, r0, lsr #16
    17cc:	e1a05002 	mov	r5, r2
    17d0:	e24dd004 	sub	sp, sp, #4	; 0x4
    17d4:	e1a06003 	mov	r6, r3
    17d8:	11a00c20 	movne	r0, r0, lsr #24
    17dc:	120ce0ff 	andne	lr, ip, #255	; 0xff
    17e0:	13a02000 	movne	r2, #0	; 0x0
    17e4:	1a000017 	bne	1848 <USBGetDescriptor+0x94>
    17e8:	e3a0c06e 	mov	ip, #110	; 0x6e
    17ec:	e59f007c 	ldr	r0, [pc, #124]	; 1870 <.text+0x1870>
    17f0:	e59f107c 	ldr	r1, [pc, #124]	; 1874 <.text+0x1874>
    17f4:	e59f207c 	ldr	r2, [pc, #124]	; 1878 <.text+0x1878>
    17f8:	e59f307c 	ldr	r3, [pc, #124]	; 187c <.text+0x187c>
    17fc:	e58dc000 	str	ip, [sp]
    1800:	ebfffb92 	bl	650 <printf>
    1804:	eafffffe 	b	1804 <USBGetDescriptor+0x50>
    1808:	e5d13001 	ldrb	r3, [r1, #1]
    180c:	e1530000 	cmp	r3, r0
    1810:	1a00000b 	bne	1844 <USBGetDescriptor+0x90>
    1814:	e152000e 	cmp	r2, lr
    1818:	1a000008 	bne	1840 <USBGetDescriptor+0x8c>
    181c:	e5861000 	str	r1, [r6]
    1820:	e3500002 	cmp	r0, #2	; 0x2
    1824:	05d13002 	ldreqb	r3, [r1, #2]
    1828:	05d12003 	ldreqb	r2, [r1, #3]
    182c:	15d13000 	ldrneb	r3, [r1]
    1830:	01833402 	orreq	r3, r3, r2, lsl #8
    1834:	e3a00001 	mov	r0, #1	; 0x1
    1838:	e5853000 	str	r3, [r5]
    183c:	ea000008 	b	1864 <USBGetDescriptor+0xb0>
    1840:	e2822001 	add	r2, r2, #1	; 0x1
    1844:	e0811004 	add	r1, r1, r4
    1848:	e5d14000 	ldrb	r4, [r1]
    184c:	e3540000 	cmp	r4, #0	; 0x0
    1850:	1affffec 	bne	1808 <USBGetDescriptor+0x54>
    1854:	e1a0100c 	mov	r1, ip
    1858:	e59f0020 	ldr	r0, [pc, #32]	; 1880 <.text+0x1880>
    185c:	ebfffb7b 	bl	650 <printf>
    1860:	e1a00004 	mov	r0, r4
    1864:	e28dd004 	add	sp, sp, #4	; 0x4
    1868:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
    186c:	400002ac 	andmi	r0, r0, ip, lsr #5
    1870:	00001fbc 	streqh	r1, [r0], -ip
    1874:	000020bc 	streqh	r2, [r0], -ip
    1878:	000020d0 	ldreqd	r2, [r0], -r0
    187c:	00001ef0 	streqd	r1, [r0], -r0
    1880:	000020dc 	ldreqd	r2, [r0], -ip

00001884 <USBHandleStandardRequest>:
    1884:	e92d41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
    1888:	e59f32f8 	ldr	r3, [pc, #760]	; 1b88 <.text+0x1b88>
    188c:	e5933000 	ldr	r3, [r3]
    1890:	e3530000 	cmp	r3, #0	; 0x0
    1894:	e24dd004 	sub	sp, sp, #4	; 0x4
    1898:	e1a05000 	mov	r5, r0
    189c:	e1a06001 	mov	r6, r1
    18a0:	e1a04002 	mov	r4, r2
    18a4:	0a000003 	beq	18b8 <USBHandleStandardRequest+0x34>
    18a8:	e1a0e00f 	mov	lr, pc
    18ac:	e12fff13 	bx	r3
    18b0:	e3500000 	cmp	r0, #0	; 0x0
    18b4:	1a0000a9 	bne	1b60 <.text+0x1b60>
    18b8:	e5d53000 	ldrb	r3, [r5]
    18bc:	e203301f 	and	r3, r3, #31	; 0x1f
    18c0:	e3530001 	cmp	r3, #1	; 0x1
    18c4:	0a000059 	beq	1a30 <.text+0x1a30>
    18c8:	e3530002 	cmp	r3, #2	; 0x2
    18cc:	0a00007b 	beq	1ac0 <.text+0x1ac0>
    18d0:	e3530000 	cmp	r3, #0	; 0x0
    18d4:	1a0000a7 	bne	1b78 <.text+0x1b78>
    18d8:	e5d51001 	ldrb	r1, [r5, #1]
    18dc:	e5940000 	ldr	r0, [r4]
    18e0:	e3510009 	cmp	r1, #9	; 0x9
    18e4:	979ff101 	ldrls	pc, [pc, r1, lsl #2]
    18e8:	ea00004e 	b	1a28 <.text+0x1a28>
    18ec:	00001a74 	andeq	r1, r0, r4, ror sl
    18f0:	00001b78 	andeq	r1, r0, r8, ror fp
    18f4:	00001a28 	andeq	r1, r0, r8, lsr #20
    18f8:	00001b78 	andeq	r1, r0, r8, ror fp
    18fc:	00001a28 	andeq	r1, r0, r8, lsr #20
    1900:	00001914 	andeq	r1, r0, r4, lsl r9
    1904:	00001920 	andeq	r1, r0, r0, lsr #18
    1908:	00001a20 	andeq	r1, r0, r0, lsr #20
    190c:	00001948 	andeq	r1, r0, r8, asr #18
    1910:	00001960 	andeq	r1, r0, r0, ror #18
    1914:	e5d50002 	ldrb	r0, [r5, #2]
    1918:	ebfffcf3 	bl	cec <USBHwSetAddress>
    191c:	ea00008f 	b	1b60 <.text+0x1b60>
    1920:	e1d510b2 	ldrh	r1, [r5, #2]
    1924:	e59f0260 	ldr	r0, [pc, #608]	; 1b8c <.text+0x1b8c>
    1928:	ebfffb48 	bl	650 <printf>
    192c:	e1d510b4 	ldrh	r1, [r5, #4]
    1930:	e1d500b2 	ldrh	r0, [r5, #2]
    1934:	e1a02006 	mov	r2, r6
    1938:	e1a03004 	mov	r3, r4
    193c:	e28dd004 	add	sp, sp, #4	; 0x4
    1940:	e8bd41f0 	ldmia	sp!, {r4, r5, r6, r7, r8, lr}
    1944:	eaffff9a 	b	17b4 <USBGetDescriptor>
    1948:	e59f3240 	ldr	r3, [pc, #576]	; 1b90 <.text+0x1b90>
    194c:	e5d32000 	ldrb	r2, [r3]
    1950:	e3a03001 	mov	r3, #1	; 0x1
    1954:	e1a01003 	mov	r1, r3
    1958:	e5c02000 	strb	r2, [r0]
    195c:	ea000072 	b	1b2c <.text+0x1b2c>
    1960:	e59f322c 	ldr	r3, [pc, #556]	; 1b94 <.text+0x1b94>
    1964:	e5933000 	ldr	r3, [r3]
    1968:	e3530000 	cmp	r3, #0	; 0x0
    196c:	e1d520b2 	ldrh	r2, [r5, #2]
    1970:	1a000007 	bne	1994 <.text+0x1994>
    1974:	e3a0c0a5 	mov	ip, #165	; 0xa5
    1978:	e59f0218 	ldr	r0, [pc, #536]	; 1b98 <.text+0x1b98>
    197c:	e59f1218 	ldr	r1, [pc, #536]	; 1b9c <.text+0x1b9c>
    1980:	e59f2218 	ldr	r2, [pc, #536]	; 1ba0 <.text+0x1ba0>
    1984:	e59f3218 	ldr	r3, [pc, #536]	; 1ba4 <.text+0x1ba4>
    1988:	e58dc000 	str	ip, [sp]
    198c:	ebfffb2f 	bl	650 <printf>
    1990:	eafffffe 	b	1990 <.text+0x1990>
    1994:	e21270ff 	ands	r7, r2, #255	; 0xff
    1998:	13a060ff 	movne	r6, #255	; 0xff
    199c:	01a00007 	moveq	r0, r7
    19a0:	11a04003 	movne	r4, r3
    19a4:	11a08006 	movne	r8, r6
    19a8:	1a000012 	bne	19f8 <.text+0x19f8>
    19ac:	ea000015 	b	1a08 <.text+0x1a08>
    19b0:	e5d43001 	ldrb	r3, [r4, #1]
    19b4:	e3530004 	cmp	r3, #4	; 0x4
    19b8:	05d46003 	ldreqb	r6, [r4, #3]
    19bc:	0a00000b 	beq	19f0 <.text+0x19f0>
    19c0:	e3530005 	cmp	r3, #5	; 0x5
    19c4:	0a000002 	beq	19d4 <.text+0x19d4>
    19c8:	e3530002 	cmp	r3, #2	; 0x2
    19cc:	05d48005 	ldreqb	r8, [r4, #5]
    19d0:	ea000006 	b	19f0 <.text+0x19f0>
    19d4:	e1580007 	cmp	r8, r7
    19d8:	03560000 	cmpeq	r6, #0	; 0x0
    19dc:	05d43005 	ldreqb	r3, [r4, #5]
    19e0:	05d41004 	ldreqb	r1, [r4, #4]
    19e4:	05d40002 	ldreqb	r0, [r4, #2]
    19e8:	01811403 	orreq	r1, r1, r3, lsl #8
    19ec:	0bfffca8 	bleq	c94 <USBHwEPConfig>
    19f0:	e5d43000 	ldrb	r3, [r4]
    19f4:	e0844003 	add	r4, r4, r3
    19f8:	e5d43000 	ldrb	r3, [r4]
    19fc:	e3530000 	cmp	r3, #0	; 0x0
    1a00:	1affffea 	bne	19b0 <.text+0x19b0>
    1a04:	e3a00001 	mov	r0, #1	; 0x1
    1a08:	ebfffd4d 	bl	f44 <USBHwConfigDevice>
    1a0c:	e1d520b2 	ldrh	r2, [r5, #2]
    1a10:	e59f3178 	ldr	r3, [pc, #376]	; 1b90 <.text+0x1b90>
    1a14:	e3a01001 	mov	r1, #1	; 0x1
    1a18:	e5c32000 	strb	r2, [r3]
    1a1c:	ea000056 	b	1b7c <.text+0x1b7c>
    1a20:	e59f0180 	ldr	r0, [pc, #384]	; 1ba8 <.text+0x1ba8>
    1a24:	ea000052 	b	1b74 <.text+0x1b74>
    1a28:	e59f017c 	ldr	r0, [pc, #380]	; 1bac <.text+0x1bac>
    1a2c:	ea000050 	b	1b74 <.text+0x1b74>
    1a30:	e5d51001 	ldrb	r1, [r5, #1]
    1a34:	e5940000 	ldr	r0, [r4]
    1a38:	e351000b 	cmp	r1, #11	; 0xb
    1a3c:	979ff101 	ldrls	pc, [pc, r1, lsl #2]
    1a40:	ea00001c 	b	1ab8 <.text+0x1ab8>
    1a44:	00001a74 	andeq	r1, r0, r4, ror sl
    1a48:	00001b78 	andeq	r1, r0, r8, ror fp
    1a4c:	00001ab8 	streqh	r1, [r0], -r8
    1a50:	00001b78 	andeq	r1, r0, r8, ror fp
    1a54:	00001ab8 	streqh	r1, [r0], -r8
    1a58:	00001ab8 	streqh	r1, [r0], -r8
    1a5c:	00001ab8 	streqh	r1, [r0], -r8
    1a60:	00001ab8 	streqh	r1, [r0], -r8
    1a64:	00001ab8 	streqh	r1, [r0], -r8
    1a68:	00001ab8 	streqh	r1, [r0], -r8
    1a6c:	00001a88 	andeq	r1, r0, r8, lsl #21
    1a70:	00001aa0 	andeq	r1, r0, r0, lsr #21
    1a74:	e3a03000 	mov	r3, #0	; 0x0
    1a78:	e3a01001 	mov	r1, #1	; 0x1
    1a7c:	e5c03001 	strb	r3, [r0, #1]
    1a80:	e5c03000 	strb	r3, [r0]
    1a84:	ea000027 	b	1b28 <.text+0x1b28>
    1a88:	e3a02001 	mov	r2, #1	; 0x1
    1a8c:	e3a03000 	mov	r3, #0	; 0x0
    1a90:	e1a01002 	mov	r1, r2
    1a94:	e5c03000 	strb	r3, [r0]
    1a98:	e5862000 	str	r2, [r6]
    1a9c:	ea000036 	b	1b7c <.text+0x1b7c>
    1aa0:	e1d500b2 	ldrh	r0, [r5, #2]
    1aa4:	e3500000 	cmp	r0, #0	; 0x0
    1aa8:	03a01001 	moveq	r1, #1	; 0x1
    1aac:	05860000 	streq	r0, [r6]
    1ab0:	0a000031 	beq	1b7c <.text+0x1b7c>
    1ab4:	ea00002f 	b	1b78 <.text+0x1b78>
    1ab8:	e59f00f0 	ldr	r0, [pc, #240]	; 1bb0 <.text+0x1bb0>
    1abc:	ea00002c 	b	1b74 <.text+0x1b74>
    1ac0:	e5d51001 	ldrb	r1, [r5, #1]
    1ac4:	e5944000 	ldr	r4, [r4]
    1ac8:	e351000c 	cmp	r1, #12	; 0xc
    1acc:	979ff101 	ldrls	pc, [pc, r1, lsl #2]
    1ad0:	ea000026 	b	1b70 <.text+0x1b70>
    1ad4:	00001b08 	andeq	r1, r0, r8, lsl #22
    1ad8:	00001b34 	andeq	r1, r0, r4, lsr fp
    1adc:	00001b70 	andeq	r1, r0, r0, ror fp
    1ae0:	00001b48 	andeq	r1, r0, r8, asr #22
    1ae4:	00001b70 	andeq	r1, r0, r0, ror fp
    1ae8:	00001b70 	andeq	r1, r0, r0, ror fp
    1aec:	00001b70 	andeq	r1, r0, r0, ror fp
    1af0:	00001b70 	andeq	r1, r0, r0, ror fp
    1af4:	00001b70 	andeq	r1, r0, r0, ror fp
    1af8:	00001b70 	andeq	r1, r0, r0, ror fp
    1afc:	00001b70 	andeq	r1, r0, r0, ror fp
    1b00:	00001b70 	andeq	r1, r0, r0, ror fp
    1b04:	00001b68 	andeq	r1, r0, r8, ror #22
    1b08:	e5d50004 	ldrb	r0, [r5, #4]
    1b0c:	ebfffc89 	bl	d38 <USBHwEPGetStatus>
    1b10:	e1a000a0 	mov	r0, r0, lsr #1
    1b14:	e2000001 	and	r0, r0, #1	; 0x1
    1b18:	e3a03000 	mov	r3, #0	; 0x0
    1b1c:	e5c43001 	strb	r3, [r4, #1]
    1b20:	e5c40000 	strb	r0, [r4]
    1b24:	e3a01001 	mov	r1, #1	; 0x1
    1b28:	e2833002 	add	r3, r3, #2	; 0x2
    1b2c:	e5863000 	str	r3, [r6]
    1b30:	ea000011 	b	1b7c <.text+0x1b7c>
    1b34:	e1d510b2 	ldrh	r1, [r5, #2]
    1b38:	e3510000 	cmp	r1, #0	; 0x0
    1b3c:	05d50004 	ldreqb	r0, [r5, #4]
    1b40:	0a000005 	beq	1b5c <.text+0x1b5c>
    1b44:	ea00000b 	b	1b78 <.text+0x1b78>
    1b48:	e1d530b2 	ldrh	r3, [r5, #2]
    1b4c:	e3530000 	cmp	r3, #0	; 0x0
    1b50:	1a000008 	bne	1b78 <.text+0x1b78>
    1b54:	e5d50004 	ldrb	r0, [r5, #4]
    1b58:	e3a01001 	mov	r1, #1	; 0x1
    1b5c:	ebfffc7d 	bl	d58 <USBHwEPStall>
    1b60:	e3a01001 	mov	r1, #1	; 0x1
    1b64:	ea000004 	b	1b7c <.text+0x1b7c>
    1b68:	e59f0044 	ldr	r0, [pc, #68]	; 1bb4 <.text+0x1bb4>
    1b6c:	ea000000 	b	1b74 <.text+0x1b74>
    1b70:	e59f0040 	ldr	r0, [pc, #64]	; 1bb8 <.text+0x1bb8>
    1b74:	ebfffab5 	bl	650 <printf>
    1b78:	e3a01000 	mov	r1, #0	; 0x0
    1b7c:	e1a00001 	mov	r0, r1
    1b80:	e28dd004 	add	sp, sp, #4	; 0x4
    1b84:	e8bd81f0 	ldmia	sp!, {r4, r5, r6, r7, r8, pc}
    1b88:	400002a4 	andmi	r0, r0, r4, lsr #5
    1b8c:	000020f0 	streqd	r2, [r0], -r0
    1b90:	400002a8 	andmi	r0, r0, r8, lsr #5
    1b94:	400002ac 	andmi	r0, r0, ip, lsr #5
    1b98:	00001fbc 	streqh	r1, [r0], -ip
    1b9c:	000020bc 	streqh	r2, [r0], -ip
    1ba0:	000020d0 	ldreqd	r2, [r0], -r0
    1ba4:	00001edc 	ldreqd	r1, [r0], -ip
    1ba8:	000020f4 	streqd	r2, [r0], -r4
    1bac:	00002114 	andeq	r2, r0, r4, lsl r1
    1bb0:	0000212c 	andeq	r2, r0, ip, lsr #2
    1bb4:	00002148 	andeq	r2, r0, r8, asr #2
    1bb8:	00002164 	andeq	r2, r0, r4, ror #2

00001bbc <USBInit>:
    1bbc:	e92d4010 	stmdb	sp!, {r4, lr}
    1bc0:	e59f4050 	ldr	r4, [pc, #80]	; 1c18 <.text+0x1c18>
    1bc4:	ebfffd3a 	bl	10b4 <USBHwInit>
    1bc8:	e59f004c 	ldr	r0, [pc, #76]	; 1c1c <.text+0x1c1c>
    1bcc:	ebfffde9 	bl	1378 <USBHwRegisterDevIntHandler>
    1bd0:	e1a01004 	mov	r1, r4
    1bd4:	e3a00000 	mov	r0, #0	; 0x0
    1bd8:	ebfffdf1 	bl	13a4 <USBHwRegisterEPIntHandler>
    1bdc:	e1a01004 	mov	r1, r4
    1be0:	e3a00080 	mov	r0, #128	; 0x80
    1be4:	ebfffdee 	bl	13a4 <USBHwRegisterEPIntHandler>
    1be8:	e3a00000 	mov	r0, #0	; 0x0
    1bec:	e3a01040 	mov	r1, #64	; 0x40
    1bf0:	ebfffc27 	bl	c94 <USBHwEPConfig>
    1bf4:	e3a00080 	mov	r0, #128	; 0x80
    1bf8:	e3a01040 	mov	r1, #64	; 0x40
    1bfc:	ebfffc24 	bl	c94 <USBHwEPConfig>
    1c00:	e3a00000 	mov	r0, #0	; 0x0
    1c04:	e59f1014 	ldr	r1, [pc, #20]	; 1c20 <.text+0x1c20>
    1c08:	e59f2014 	ldr	r2, [pc, #20]	; 1c24 <.text+0x1c24>
    1c0c:	ebfffe0c 	bl	1444 <USBRegisterRequestHandler>
    1c10:	e3a00001 	mov	r0, #1	; 0x1
    1c14:	e8bd8010 	ldmia	sp!, {r4, pc}
    1c18:	000015c4 	andeq	r1, r0, r4, asr #11
    1c1c:	00001c28 	andeq	r1, r0, r8, lsr #24
    1c20:	00001884 	andeq	r1, r0, r4, lsl #17
    1c24:	400002b0 	strmih	r0, [r0], -r0

00001c28 <HandleUsbReset>:
    1c28:	e3100010 	tst	r0, #16	; 0x10
    1c2c:	012fff1e 	bxeq	lr
    1c30:	e59f0000 	ldr	r0, [pc, #0]	; 1c38 <.text+0x1c38>
    1c34:	eafffa85 	b	650 <printf>
    1c38:	00002178 	andeq	r2, r0, r8, ror r1

00001c3c <__aeabi_uidiv>:
    1c3c:	e2512001 	subs	r2, r1, #1	; 0x1
    1c40:	012fff1e 	bxeq	lr
    1c44:	3a000036 	bcc	1d24 <__aeabi_uidiv+0xe8>
    1c48:	e1500001 	cmp	r0, r1
    1c4c:	9a000022 	bls	1cdc <__aeabi_uidiv+0xa0>
    1c50:	e1110002 	tst	r1, r2
    1c54:	0a000023 	beq	1ce8 <__aeabi_uidiv+0xac>
    1c58:	e311020e 	tst	r1, #-536870912	; 0xe0000000
    1c5c:	01a01181 	moveq	r1, r1, lsl #3
    1c60:	03a03008 	moveq	r3, #8	; 0x8
    1c64:	13a03001 	movne	r3, #1	; 0x1
    1c68:	e3510201 	cmp	r1, #268435456	; 0x10000000
    1c6c:	31510000 	cmpcc	r1, r0
    1c70:	31a01201 	movcc	r1, r1, lsl #4
    1c74:	31a03203 	movcc	r3, r3, lsl #4
    1c78:	3afffffa 	bcc	1c68 <__aeabi_uidiv+0x2c>
    1c7c:	e3510102 	cmp	r1, #-2147483648	; 0x80000000
    1c80:	31510000 	cmpcc	r1, r0
    1c84:	31a01081 	movcc	r1, r1, lsl #1
    1c88:	31a03083 	movcc	r3, r3, lsl #1
    1c8c:	3afffffa 	bcc	1c7c <__aeabi_uidiv+0x40>
    1c90:	e3a02000 	mov	r2, #0	; 0x0
    1c94:	e1500001 	cmp	r0, r1
    1c98:	20400001 	subcs	r0, r0, r1
    1c9c:	21822003 	orrcs	r2, r2, r3
    1ca0:	e15000a1 	cmp	r0, r1, lsr #1
    1ca4:	204000a1 	subcs	r0, r0, r1, lsr #1
    1ca8:	218220a3 	orrcs	r2, r2, r3, lsr #1
    1cac:	e1500121 	cmp	r0, r1, lsr #2
    1cb0:	20400121 	subcs	r0, r0, r1, lsr #2
    1cb4:	21822123 	orrcs	r2, r2, r3, lsr #2
    1cb8:	e15001a1 	cmp	r0, r1, lsr #3
    1cbc:	204001a1 	subcs	r0, r0, r1, lsr #3
    1cc0:	218221a3 	orrcs	r2, r2, r3, lsr #3
    1cc4:	e3500000 	cmp	r0, #0	; 0x0
    1cc8:	11b03223 	movnes	r3, r3, lsr #4
    1ccc:	11a01221 	movne	r1, r1, lsr #4
    1cd0:	1affffef 	bne	1c94 <__aeabi_uidiv+0x58>
    1cd4:	e1a00002 	mov	r0, r2
    1cd8:	e12fff1e 	bx	lr
    1cdc:	03a00001 	moveq	r0, #1	; 0x1
    1ce0:	13a00000 	movne	r0, #0	; 0x0
    1ce4:	e12fff1e 	bx	lr
    1ce8:	e3510801 	cmp	r1, #65536	; 0x10000
    1cec:	21a01821 	movcs	r1, r1, lsr #16
    1cf0:	23a02010 	movcs	r2, #16	; 0x10
    1cf4:	33a02000 	movcc	r2, #0	; 0x0
    1cf8:	e3510c01 	cmp	r1, #256	; 0x100
    1cfc:	21a01421 	movcs	r1, r1, lsr #8
    1d00:	22822008 	addcs	r2, r2, #8	; 0x8
    1d04:	e3510010 	cmp	r1, #16	; 0x10
    1d08:	21a01221 	movcs	r1, r1, lsr #4
    1d0c:	22822004 	addcs	r2, r2, #4	; 0x4
    1d10:	e3510004 	cmp	r1, #4	; 0x4
    1d14:	82822003 	addhi	r2, r2, #3	; 0x3
    1d18:	908220a1 	addls	r2, r2, r1, lsr #1
    1d1c:	e1a00230 	mov	r0, r0, lsr r2
    1d20:	e12fff1e 	bx	lr
    1d24:	e52de008 	str	lr, [sp, #-8]!
    1d28:	eb00003a 	bl	1e18 <__aeabi_idiv0>
    1d2c:	e3a00000 	mov	r0, #0	; 0x0
    1d30:	e49df008 	ldr	pc, [sp], #8

00001d34 <__aeabi_uidivmod>:
    1d34:	e92d4003 	stmdb	sp!, {r0, r1, lr}
    1d38:	ebffffbf 	bl	1c3c <__aeabi_uidiv>
    1d3c:	e8bd4006 	ldmia	sp!, {r1, r2, lr}
    1d40:	e0030092 	mul	r3, r2, r0
    1d44:	e0411003 	sub	r1, r1, r3
    1d48:	e12fff1e 	bx	lr

00001d4c <__umodsi3>:
    1d4c:	e2512001 	subs	r2, r1, #1	; 0x1
    1d50:	3a00002c 	bcc	1e08 <__umodsi3+0xbc>
    1d54:	11500001 	cmpne	r0, r1
    1d58:	03a00000 	moveq	r0, #0	; 0x0
    1d5c:	81110002 	tsthi	r1, r2
    1d60:	00000002 	andeq	r0, r0, r2
    1d64:	912fff1e 	bxls	lr
    1d68:	e3a02000 	mov	r2, #0	; 0x0
    1d6c:	e3510201 	cmp	r1, #268435456	; 0x10000000
    1d70:	31510000 	cmpcc	r1, r0
    1d74:	31a01201 	movcc	r1, r1, lsl #4
    1d78:	32822004 	addcc	r2, r2, #4	; 0x4
    1d7c:	3afffffa 	bcc	1d6c <__umodsi3+0x20>
    1d80:	e3510102 	cmp	r1, #-2147483648	; 0x80000000
    1d84:	31510000 	cmpcc	r1, r0
    1d88:	31a01081 	movcc	r1, r1, lsl #1
    1d8c:	32822001 	addcc	r2, r2, #1	; 0x1
    1d90:	3afffffa 	bcc	1d80 <__umodsi3+0x34>
    1d94:	e2522003 	subs	r2, r2, #3	; 0x3
    1d98:	ba00000e 	blt	1dd8 <__umodsi3+0x8c>
    1d9c:	e1500001 	cmp	r0, r1
    1da0:	20400001 	subcs	r0, r0, r1
    1da4:	e15000a1 	cmp	r0, r1, lsr #1
    1da8:	204000a1 	subcs	r0, r0, r1, lsr #1
    1dac:	e1500121 	cmp	r0, r1, lsr #2
    1db0:	20400121 	subcs	r0, r0, r1, lsr #2
    1db4:	e15001a1 	cmp	r0, r1, lsr #3
    1db8:	204001a1 	subcs	r0, r0, r1, lsr #3
    1dbc:	e3500001 	cmp	r0, #1	; 0x1
    1dc0:	e1a01221 	mov	r1, r1, lsr #4
    1dc4:	a2522004 	subges	r2, r2, #4	; 0x4
    1dc8:	aafffff3 	bge	1d9c <__umodsi3+0x50>
    1dcc:	e3120003 	tst	r2, #3	; 0x3
    1dd0:	13300000 	teqne	r0, #0	; 0x0
    1dd4:	0a00000a 	beq	1e04 <__umodsi3+0xb8>
    1dd8:	e3720002 	cmn	r2, #2	; 0x2
    1ddc:	ba000006 	blt	1dfc <__umodsi3+0xb0>
    1de0:	0a000002 	beq	1df0 <__umodsi3+0xa4>
    1de4:	e1500001 	cmp	r0, r1
    1de8:	20400001 	subcs	r0, r0, r1
    1dec:	e1a010a1 	mov	r1, r1, lsr #1
    1df0:	e1500001 	cmp	r0, r1
    1df4:	20400001 	subcs	r0, r0, r1
    1df8:	e1a010a1 	mov	r1, r1, lsr #1
    1dfc:	e1500001 	cmp	r0, r1
    1e00:	20400001 	subcs	r0, r0, r1
    1e04:	e12fff1e 	bx	lr
    1e08:	e52de008 	str	lr, [sp, #-8]!
    1e0c:	eb000001 	bl	1e18 <__aeabi_idiv0>
    1e10:	e3a00000 	mov	r0, #0	; 0x0
    1e14:	e49df008 	ldr	pc, [sp], #8

00001e18 <__aeabi_idiv0>:
    1e18:	e12fff1e 	bx	lr

00001e1c <abDescriptors>:
    1e1c:	01010112 40000002 0005ffff 02010100     .......@........
    1e2c:	02090103 01010020 0932c000 02000004     .... .....2.....
    1e3c:	000000ff 0d060507 07010080 800d8305     ................
    1e4c:	03040100 030e0409 0050004c 00550043     ........L.P.C.U.
    1e5c:	00420053 00550314 00420053 00650053     S.B...U.S.B.S.e.
    1e6c:	00690072 006c0061 00440312 00410045     r.i.a.l...D.E.A.
    1e7c:	00430044 00440030 00000045              D.C.0.D.E...

00001e88 <__FUNCTION__.1660>:
    1e88:	48425355 67655277 65747369 49504572     USBHwRegisterEPI
    1e98:	6148746e 656c646e 00000072              ntHandler...

00001ea4 <__FUNCTION__.1651>:
    1ea4:	52425355 73696765 52726574 65757165     USBRegisterReque
    1eb4:	61487473 656c646e 00000072              stHandler...

00001ec0 <__FUNCTION__.1613>:
    1ec0:	48425355 6c646e61 6e6f4365 6c6f7274     USBHandleControl
    1ed0:	6e617254 72656673 00000000              Transfer....

00001edc <__FUNCTION__.1627>:
    1edc:	53425355 6f437465 6769666e 74617275     USBSetConfigurat
    1eec:	006e6f69                                ion.

00001ef0 <__FUNCTION__.1594>:
    1ef0:	47425355 65447465 69726373 726f7470     USBGetDescriptor
    1f00:	00000000 6c756e28 0000296c 74696e49     ....(null)..Init
    1f10:	696c6169 676e6973 42535520 61747320     ialising USB sta
    1f20:	00006b63 72617453 676e6974 42535520     ck..Starting USB
    1f30:	6d6f6320 696e756d 69746163 00006e6f      communication..
    1f40:	78783332 002e2e2e 62616e45 676e696c     23xx....Enabling
    1f50:	746e6920 70757265 2e2e2e74 00000000      interupt.......
    1f60:	20425355 6e6e6f43 69746365 2e2e676e     USB Connecting..
    1f70:	00002e2e 69676552 72657473 68206465     ....Registered h
    1f80:	6c646e61 66207265 6620726f 656d6172     andler for frame
    1f90:	00000000 69676552 72657473 68206465     ....Registered h
    1fa0:	6c646e61 66207265 6420726f 63697665     andler for devic
    1fb0:	74732065 73757461 00000000 7373410a     e status.....Ass
    1fc0:	69747265 27206e6f 20277325 6c696166     ertion '%s' fail
    1fd0:	69206465 7325206e 2373253a 0a216425     ed in %s:%s#%d!.
    1fe0:	00000000 3c786469 00003233 68627375     ....idx<32..usbh
    1ff0:	706c5f77 00632e63 69676552 72657473     w_lpc.c.Register
    2000:	68206465 6c646e61 66207265 4520726f     ed handler for E
    2010:	78302050 000a7825 70795469 3d3e2065     P 0x%x..iType >=
    2020:	00003020 63627375 72746e6f 632e6c6f      0..usbcontrol.c
    2030:	00000000 70795469 203c2065 00000034     ....iType < 4...
    2040:	68206f4e 6c646e61 66207265 7220726f     No handler for r
    2050:	79747165 25206570 00000a64 4c415453     eqtype %d...STAL
    2060:	6e6f204c 00005b20 32302520 00000078     L on [.. %02x...
    2070:	7473205d 253d7461 00000a78 00782553     ] stat=%x...S%x.
    2080:	6e61485f 52656c64 65757165 20317473     _HandleRequest1 
    2090:	6c696166 00006465 6e61485f 52656c64     failed.._HandleR
    20a0:	65757165 20327473 6c696166 00006465     equest2 failed..
    20b0:	0000003f 534c4146 00000045 44626170     ?...FALSE...pabD
    20c0:	72637365 21207069 554e203d 00004c4c     escrip != NULL..
    20d0:	73627375 65726474 00632e71 63736544     usbstdreq.c.Desc
    20e0:	20782520 20746f6e 6e756f66 000a2164      %x not found!..
    20f0:	00782544 69766544 72206563 25207165     D%x.Device req %
    2100:	6f6e2064 6d692074 6d656c70 65746e65     d not implemente
    2110:	00000a64 656c6c49 206c6167 69766564     d...Illegal devi
    2120:	72206563 25207165 00000a64 656c6c49     ce req %d...Ille
    2130:	206c6167 65746e69 63616672 65722065     gal interface re
    2140:	64252071 0000000a 72205045 25207165     q %d....EP req %
    2150:	6f6e2064 6d692074 6d656c70 65746e65     d not implemente
    2160:	00000a64 656c6c49 206c6167 72205045     d...Illegal EP r
    2170:	25207165 00000a64 0000210a              eq %d....!..
