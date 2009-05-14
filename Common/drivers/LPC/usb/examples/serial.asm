
serial.elf:     file format elf32-littlearm

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
      bc:	ea00026b 	b	a70 <main>
      c0:	40007edc 	ldrmid	r7, [r0], -ip
      c4:	000023c4 	andeq	r2, r0, r4, asr #7
      c8:	40000200 	andmi	r0, r0, r0, lsl #4
      cc:	40000208 	andmi	r0, r0, r8, lsl #4
      d0:	40000208 	andmi	r0, r0, r8, lsl #4
      d4:	40000400 	andmi	r0, r0, r0, lsl #8

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
     394:	eb0006b4 	bl	1e6c <__umodsi3>
     398:	e1a03000 	mov	r3, r0
     39c:	e3530009 	cmp	r3, #9	; 0x9
     3a0:	c083300a 	addgt	r3, r3, sl
     3a4:	e2833030 	add	r3, r3, #48	; 0x30
     3a8:	e1a00004 	mov	r0, r4
     3ac:	e5653001 	strb	r3, [r5, #-1]!
     3b0:	e1a01006 	mov	r1, r6
     3b4:	eb000668 	bl	1d5c <__aeabi_uidiv>
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
     614:	000020f8 	streqd	r2, [r0], -r8

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

0000075c <USBDevIntHandler>:
     75c:	e3100010 	tst	r0, #16	; 0x10
     760:	159f3008 	ldrne	r3, [pc, #8]	; 770 <.text+0x770>
     764:	13a02000 	movne	r2, #0	; 0x0
     768:	15832000 	strne	r2, [r3]
     76c:	e12fff1e 	bx	lr
     770:	40000250 	andmi	r0, r0, r0, asr r2

00000774 <USBIntHandler>:
     774:	e24ee004 	sub	lr, lr, #4	; 0x4
     778:	e92d500f 	stmdb	sp!, {r0, r1, r2, r3, ip, lr}
     77c:	eb00023c 	bl	1074 <USBHwISR>
     780:	e3a02000 	mov	r2, #0	; 0x0
     784:	e3e03000 	mvn	r3, #0	; 0x0
     788:	e50320ff 	str	r2, [r3, #-255]
     78c:	e8fd900f 	ldmia	sp!, {r0, r1, r2, r3, ip, pc}^

00000790 <VCOM_getchar>:
     790:	e52de004 	str	lr, [sp, #-4]!
     794:	e24dd004 	sub	sp, sp, #4	; 0x4
     798:	e28d1003 	add	r1, sp, #3	; 0x3
     79c:	e59f0014 	ldr	r0, [pc, #20]	; 7b8 <.text+0x7b8>
     7a0:	eb00010e 	bl	be0 <fifo_get>
     7a4:	e3500000 	cmp	r0, #0	; 0x0
     7a8:	15dd0003 	ldrneb	r0, [sp, #3]
     7ac:	03e00000 	mvneq	r0, #0	; 0x0
     7b0:	e28dd004 	add	sp, sp, #4	; 0x4
     7b4:	e8bd8000 	ldmia	sp!, {pc}
     7b8:	40000364 	andmi	r0, r0, r4, ror #6

000007bc <SendNextBulkIn>:
     7bc:	e59f307c 	ldr	r3, [pc, #124]	; 840 <.text+0x840>
     7c0:	e3510000 	cmp	r1, #0	; 0x0
     7c4:	e3a02000 	mov	r2, #0	; 0x0
     7c8:	e5832000 	str	r2, [r3]
     7cc:	159f3070 	ldrne	r3, [pc, #112]	; 844 <.text+0x844>
     7d0:	15832000 	strne	r2, [r3]
     7d4:	e59f3068 	ldr	r3, [pc, #104]	; 844 <.text+0x844>
     7d8:	e5932000 	ldr	r2, [r3]
     7dc:	e3520000 	cmp	r2, #0	; 0x0
     7e0:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
     7e4:	e20050ff 	and	r5, r0, #255	; 0xff
     7e8:	18bd8070 	ldmneia	sp!, {r4, r5, r6, pc}
     7ec:	e59f6054 	ldr	r6, [pc, #84]	; 848 <.text+0x848>
     7f0:	e1a04002 	mov	r4, r2
     7f4:	e0841006 	add	r1, r4, r6
     7f8:	e59f004c 	ldr	r0, [pc, #76]	; 84c <.text+0x84c>
     7fc:	eb0000f7 	bl	be0 <fifo_get>
     800:	e3500000 	cmp	r0, #0	; 0x0
     804:	0a000002 	beq	814 <SendNextBulkIn+0x58>
     808:	e2844001 	add	r4, r4, #1	; 0x1
     80c:	e3540040 	cmp	r4, #64	; 0x40
     810:	1afffff7 	bne	7f4 <SendNextBulkIn+0x38>
     814:	e1a02004 	mov	r2, r4
     818:	e1a00005 	mov	r0, r5
     81c:	e59f1024 	ldr	r1, [pc, #36]	; 848 <.text+0x848>
     820:	eb00019c 	bl	e98 <USBHwEPWrite>
     824:	e59f3014 	ldr	r3, [pc, #20]	; 840 <.text+0x840>
     828:	e354003f 	cmp	r4, #63	; 0x3f
     82c:	e3a02001 	mov	r2, #1	; 0x1
     830:	e5832000 	str	r2, [r3]
     834:	d59f3008 	ldrle	r3, [pc, #8]	; 844 <.text+0x844>
     838:	d5832000 	strle	r2, [r3]
     83c:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
     840:	40000250 	andmi	r0, r0, r0, asr r2
     844:	40000254 	andmi	r0, r0, r4, asr r2
     848:	40000208 	andmi	r0, r0, r8, lsl #4
     84c:	40000358 	andmi	r0, r0, r8, asr r3

00000850 <USBFrameHandler>:
     850:	e59f302c 	ldr	r3, [pc, #44]	; 884 <.text+0x884>
     854:	e5933000 	ldr	r3, [r3]
     858:	e3530000 	cmp	r3, #0	; 0x0
     85c:	e52de004 	str	lr, [sp, #-4]!
     860:	149df004 	ldrne	pc, [sp], #4
     864:	e59f001c 	ldr	r0, [pc, #28]	; 888 <.text+0x888>
     868:	eb0000f1 	bl	c34 <fifo_avail>
     86c:	e3500000 	cmp	r0, #0	; 0x0
     870:	049df004 	ldreq	pc, [sp], #4
     874:	e3a00082 	mov	r0, #130	; 0x82
     878:	e3a01001 	mov	r1, #1	; 0x1
     87c:	e49de004 	ldr	lr, [sp], #4
     880:	eaffffcd 	b	7bc <SendNextBulkIn>
     884:	40000250 	andmi	r0, r0, r0, asr r2
     888:	40000358 	andmi	r0, r0, r8, asr r3

0000088c <BulkIn>:
     88c:	e20000ff 	and	r0, r0, #255	; 0xff
     890:	e3a01000 	mov	r1, #0	; 0x0
     894:	eaffffc8 	b	7bc <SendNextBulkIn>

00000898 <VCOM_putchar>:
     898:	e92d4010 	stmdb	sp!, {r4, lr}
     89c:	e20010ff 	and	r1, r0, #255	; 0xff
     8a0:	e1a04000 	mov	r4, r0
     8a4:	e59f0010 	ldr	r0, [pc, #16]	; 8bc <.text+0x8bc>
     8a8:	eb0000b9 	bl	b94 <fifo_put>
     8ac:	e3500000 	cmp	r0, #0	; 0x0
     8b0:	11a00004 	movne	r0, r4
     8b4:	03e00000 	mvneq	r0, #0	; 0x0
     8b8:	e8bd8010 	ldmia	sp!, {r4, pc}
     8bc:	40000358 	andmi	r0, r0, r8, asr r3

000008c0 <BulkOut>:
     8c0:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
     8c4:	e1a03000 	mov	r3, r0
     8c8:	e24dd004 	sub	sp, sp, #4	; 0x4
     8cc:	e59f0074 	ldr	r0, [pc, #116]	; 948 <.text+0x948>
     8d0:	e20340ff 	and	r4, r3, #255	; 0xff
     8d4:	eb0000e3 	bl	c68 <fifo_free>
     8d8:	e350003f 	cmp	r0, #63	; 0x3f
     8dc:	da000017 	ble	940 <BulkOut+0x80>
     8e0:	e1a00004 	mov	r0, r4
     8e4:	e59f1060 	ldr	r1, [pc, #96]	; 94c <.text+0x94c>
     8e8:	e3a02040 	mov	r2, #64	; 0x40
     8ec:	eb00018c 	bl	f24 <USBHwEPRead>
     8f0:	e59f6054 	ldr	r6, [pc, #84]	; 94c <.text+0x94c>
     8f4:	e1a05000 	mov	r5, r0
     8f8:	e3a04000 	mov	r4, #0	; 0x0
     8fc:	ea00000c 	b	934 <BulkOut+0x74>
     900:	e7d41006 	ldrb	r1, [r4, r6]
     904:	eb0000a2 	bl	b94 <fifo_put>
     908:	e3500000 	cmp	r0, #0	; 0x0
     90c:	1a000007 	bne	930 <BulkOut+0x70>
     910:	e3a0c0f9 	mov	ip, #249	; 0xf9
     914:	e59f0034 	ldr	r0, [pc, #52]	; 950 <.text+0x950>
     918:	e59f1034 	ldr	r1, [pc, #52]	; 954 <.text+0x954>
     91c:	e59f2034 	ldr	r2, [pc, #52]	; 958 <.text+0x958>
     920:	e59f3034 	ldr	r3, [pc, #52]	; 95c <.text+0x95c>
     924:	e58dc000 	str	ip, [sp]
     928:	ebffff48 	bl	650 <printf>
     92c:	eafffffe 	b	92c <BulkOut+0x6c>
     930:	e2844001 	add	r4, r4, #1	; 0x1
     934:	e1540005 	cmp	r4, r5
     938:	e59f0008 	ldr	r0, [pc, #8]	; 948 <.text+0x948>
     93c:	baffffef 	blt	900 <BulkOut+0x40>
     940:	e28dd004 	add	sp, sp, #4	; 0x4
     944:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
     948:	40000364 	andmi	r0, r0, r4, ror #6
     94c:	40000208 	andmi	r0, r0, r8, lsl #4
     950:	00002100 	andeq	r2, r0, r0, lsl #2
     954:	00002128 	andeq	r2, r0, r8, lsr #2
     958:	00002130 	andeq	r2, r0, r0, lsr r1
     95c:	00002074 	andeq	r2, r0, r4, ror r0

00000960 <HandleClassRequest>:
     960:	e92d40f0 	stmdb	sp!, {r4, r5, r6, r7, lr}
     964:	e5d03001 	ldrb	r3, [r0, #1]
     968:	e3530021 	cmp	r3, #33	; 0x21
     96c:	e24dd004 	sub	sp, sp, #4	; 0x4
     970:	e1a07001 	mov	r7, r1
     974:	e1a06002 	mov	r6, r2
     978:	0a000015 	beq	9d4 <HandleClassRequest+0x74>
     97c:	e3530022 	cmp	r3, #34	; 0x22
     980:	0a00001b 	beq	9f4 <HandleClassRequest+0x94>
     984:	e3530020 	cmp	r3, #32	; 0x20
     988:	13a00000 	movne	r0, #0	; 0x0
     98c:	1a00001c 	bne	a04 <HandleClassRequest+0xa4>
     990:	e59f4074 	ldr	r4, [pc, #116]	; a0c <.text+0xa0c>
     994:	e3a05007 	mov	r5, #7	; 0x7
     998:	e59f0070 	ldr	r0, [pc, #112]	; a10 <.text+0xa10>
     99c:	ebffff61 	bl	728 <puts>
     9a0:	e5961000 	ldr	r1, [r6]
     9a4:	e1a02005 	mov	r2, r5
     9a8:	e1a00004 	mov	r0, r4
     9ac:	eb000562 	bl	1f3c <memcpy>
     9b0:	e5875000 	str	r5, [r7]
     9b4:	e5d4c006 	ldrb	ip, [r4, #6]
     9b8:	e5d42004 	ldrb	r2, [r4, #4]
     9bc:	e5d43005 	ldrb	r3, [r4, #5]
     9c0:	e5941000 	ldr	r1, [r4]
     9c4:	e59f0048 	ldr	r0, [pc, #72]	; a14 <.text+0xa14>
     9c8:	e58dc000 	str	ip, [sp]
     9cc:	ebffff1f 	bl	650 <printf>
     9d0:	ea00000a 	b	a00 <HandleClassRequest+0xa0>
     9d4:	e59f003c 	ldr	r0, [pc, #60]	; a18 <.text+0xa18>
     9d8:	ebffff52 	bl	728 <puts>
     9dc:	e59f3028 	ldr	r3, [pc, #40]	; a0c <.text+0xa0c>
     9e0:	e3a00001 	mov	r0, #1	; 0x1
     9e4:	e5863000 	str	r3, [r6]
     9e8:	e3a03007 	mov	r3, #7	; 0x7
     9ec:	e5873000 	str	r3, [r7]
     9f0:	ea000003 	b	a04 <HandleClassRequest+0xa4>
     9f4:	e1d010b2 	ldrh	r1, [r0, #2]
     9f8:	e59f001c 	ldr	r0, [pc, #28]	; a1c <.text+0xa1c>
     9fc:	ebffff13 	bl	650 <printf>
     a00:	e3a00001 	mov	r0, #1	; 0x1
     a04:	e28dd004 	add	sp, sp, #4	; 0x4
     a08:	e8bd80f0 	ldmia	sp!, {r4, r5, r6, r7, pc}
     a0c:	40000200 	andmi	r0, r0, r0, lsl #4
     a10:	00002140 	andeq	r2, r0, r0, asr #2
     a14:	00002150 	andeq	r2, r0, r0, asr r1
     a18:	0000218c 	andeq	r2, r0, ip, lsl #3
     a1c:	0000219c 	muleq	r0, ip, r1

00000a20 <VCOM_init>:
     a20:	e52de004 	str	lr, [sp, #-4]!
     a24:	e59f002c 	ldr	r0, [pc, #44]	; a58 <.text+0xa58>
     a28:	e59f102c 	ldr	r1, [pc, #44]	; a5c <.text+0xa5c>
     a2c:	eb000053 	bl	b80 <fifo_init>
     a30:	e59f0028 	ldr	r0, [pc, #40]	; a60 <.text+0xa60>
     a34:	e59f1028 	ldr	r1, [pc, #40]	; a64 <.text+0xa64>
     a38:	eb000050 	bl	b80 <fifo_init>
     a3c:	e59f3024 	ldr	r3, [pc, #36]	; a68 <.text+0xa68>
     a40:	e3a02000 	mov	r2, #0	; 0x0
     a44:	e5832000 	str	r2, [r3]
     a48:	e59f301c 	ldr	r3, [pc, #28]	; a6c <.text+0xa6c>
     a4c:	e2822001 	add	r2, r2, #1	; 0x1
     a50:	e5832000 	str	r2, [r3]
     a54:	e49df004 	ldr	pc, [sp], #4
     a58:	40000358 	andmi	r0, r0, r8, asr r3
     a5c:	40000258 	andmi	r0, r0, r8, asr r2
     a60:	40000364 	andmi	r0, r0, r4, ror #6
     a64:	400002d8 	ldrmid	r0, [r0], -r8
     a68:	40000250 	andmi	r0, r0, r0, asr r2
     a6c:	40000254 	andmi	r0, r0, r4, asr r2

00000a70 <main>:
     a70:	e92d4010 	stmdb	sp!, {r4, lr}
     a74:	ebfffdcf 	bl	1b8 <HalSysInit>
     a78:	e3a00027 	mov	r0, #39	; 0x27
     a7c:	ebffff00 	bl	684 <ConsoleInit>
     a80:	e59f00d0 	ldr	r0, [pc, #208]	; b58 <.text+0xb58>
     a84:	ebffff27 	bl	728 <puts>
     a88:	eb000493 	bl	1cdc <USBInit>
     a8c:	e59f00c8 	ldr	r0, [pc, #200]	; b5c <.text+0xb5c>
     a90:	eb000387 	bl	18b4 <USBRegisterDescriptors>
     a94:	e59f20c4 	ldr	r2, [pc, #196]	; b60 <.text+0xb60>
     a98:	e3a00001 	mov	r0, #1	; 0x1
     a9c:	e59f10c0 	ldr	r1, [pc, #192]	; b64 <.text+0xb64>
     aa0:	eb0002af 	bl	1564 <USBRegisterRequestHandler>
     aa4:	e3a00081 	mov	r0, #129	; 0x81
     aa8:	e3a01000 	mov	r1, #0	; 0x0
     aac:	eb000284 	bl	14c4 <USBHwRegisterEPIntHandler>
     ab0:	e3a00082 	mov	r0, #130	; 0x82
     ab4:	e59f10ac 	ldr	r1, [pc, #172]	; b68 <.text+0xb68>
     ab8:	eb000281 	bl	14c4 <USBHwRegisterEPIntHandler>
     abc:	e59f10a8 	ldr	r1, [pc, #168]	; b6c <.text+0xb6c>
     ac0:	e3a00005 	mov	r0, #5	; 0x5
     ac4:	eb00027e 	bl	14c4 <USBHwRegisterEPIntHandler>
     ac8:	e59f00a0 	ldr	r0, [pc, #160]	; b70 <.text+0xb70>
     acc:	eb000266 	bl	146c <USBHwRegisterFrameHandler>
     ad0:	e59f009c 	ldr	r0, [pc, #156]	; b74 <.text+0xb74>
     ad4:	eb00026f 	bl	1498 <USBHwRegisterDevIntHandler>
     ad8:	ebffffd0 	bl	a20 <VCOM_init>
     adc:	e59f0094 	ldr	r0, [pc, #148]	; b78 <.text+0xb78>
     ae0:	ebffff10 	bl	728 <puts>
     ae4:	e59f3090 	ldr	r3, [pc, #144]	; b7c <.text+0xb7c>
     ae8:	e3e02000 	mvn	r2, #0	; 0x0
     aec:	e3a04001 	mov	r4, #1	; 0x1
     af0:	e5024da7 	str	r4, [r2, #-3495]
     af4:	e5023ea7 	str	r3, [r2, #-3751]
     af8:	e5123ff3 	ldr	r3, [r2, #-4083]
     afc:	e3c33501 	bic	r3, r3, #4194304	; 0x400000
     b00:	e5023ff3 	str	r3, [r2, #-4083]
     b04:	e5123fef 	ldr	r3, [r2, #-4079]
     b08:	e3833501 	orr	r3, r3, #4194304	; 0x400000
     b0c:	e5023fef 	str	r3, [r2, #-4079]
     b10:	eb000072 	bl	ce0 <enableIRQ>
     b14:	e1a00004 	mov	r0, r4
     b18:	eb0000bf 	bl	e1c <USBHwConnect>
     b1c:	ebffff1b 	bl	790 <VCOM_getchar>
     b20:	e3700001 	cmn	r0, #1	; 0x1
     b24:	e1a04000 	mov	r4, r0
     b28:	e2403009 	sub	r3, r0, #9	; 0x9
     b2c:	e2402020 	sub	r2, r0, #32	; 0x20
     b30:	0afffff9 	beq	b1c <main+0xac>
     b34:	e350000d 	cmp	r0, #13	; 0xd
     b38:	13530001 	cmpne	r3, #1	; 0x1
     b3c:	9a000001 	bls	b48 <main+0xd8>
     b40:	e352005e 	cmp	r2, #94	; 0x5e
     b44:	83a0002e 	movhi	r0, #46	; 0x2e
     b48:	ebfffee0 	bl	6d0 <putchar>
     b4c:	e1a00004 	mov	r0, r4
     b50:	ebffff50 	bl	898 <VCOM_putchar>
     b54:	eafffff0 	b	b1c <main+0xac>
     b58:	000021b8 	streqh	r2, [r0], -r8
     b5c:	00001fe4 	andeq	r1, r0, r4, ror #31
     b60:	40000248 	andmi	r0, r0, r8, asr #4
     b64:	00000960 	andeq	r0, r0, r0, ror #18
     b68:	0000088c 	andeq	r0, r0, ip, lsl #17
     b6c:	000008c0 	andeq	r0, r0, r0, asr #17
     b70:	00000850 	andeq	r0, r0, r0, asr r8
     b74:	0000075c 	andeq	r0, r0, ip, asr r7
     b78:	000021d0 	ldreqd	r2, [r0], -r0
     b7c:	00000774 	andeq	r0, r0, r4, ror r7

00000b80 <fifo_init>:
     b80:	e3a03000 	mov	r3, #0	; 0x0
     b84:	e5801008 	str	r1, [r0, #8]
     b88:	e5803004 	str	r3, [r0, #4]
     b8c:	e5803000 	str	r3, [r0]
     b90:	e12fff1e 	bx	lr

00000b94 <fifo_put>:
     b94:	e590c000 	ldr	ip, [r0]
     b98:	e59f203c 	ldr	r2, [pc, #60]	; bdc <.text+0xbdc>
     b9c:	e28c3001 	add	r3, ip, #1	; 0x1
     ba0:	e0032002 	and	r2, r3, r2
     ba4:	e3520000 	cmp	r2, #0	; 0x0
     ba8:	b2422001 	sublt	r2, r2, #1	; 0x1
     bac:	b1e02c82 	mvnlt	r2, r2, lsl #25
     bb0:	e5903004 	ldr	r3, [r0, #4]
     bb4:	b1e02ca2 	mvnlt	r2, r2, lsr #25
     bb8:	b2822001 	addlt	r2, r2, #1	; 0x1
     bbc:	e1520003 	cmp	r2, r3
     bc0:	15903008 	ldrne	r3, [r0, #8]
     bc4:	e20110ff 	and	r1, r1, #255	; 0xff
     bc8:	17c3100c 	strneb	r1, [r3, ip]
     bcc:	03a00000 	moveq	r0, #0	; 0x0
     bd0:	15802000 	strne	r2, [r0]
     bd4:	13a00001 	movne	r0, #1	; 0x1
     bd8:	e12fff1e 	bx	lr
     bdc:	8000007f 	andhi	r0, r0, pc, ror r0

00000be0 <fifo_get>:
     be0:	e5903000 	ldr	r3, [r0]
     be4:	e52de004 	str	lr, [sp, #-4]!
     be8:	e590e004 	ldr	lr, [r0, #4]
     bec:	e153000e 	cmp	r3, lr
     bf0:	03a00000 	moveq	r0, #0	; 0x0
     bf4:	049df004 	ldreq	pc, [sp], #4
     bf8:	e59fc030 	ldr	ip, [pc, #48]	; c30 <.text+0xc30>
     bfc:	e28e2001 	add	r2, lr, #1	; 0x1
     c00:	e002c00c 	and	ip, r2, ip
     c04:	e35c0000 	cmp	ip, #0	; 0x0
     c08:	b24cc001 	sublt	ip, ip, #1	; 0x1
     c0c:	e5903008 	ldr	r3, [r0, #8]
     c10:	b1e0cc8c 	mvnlt	ip, ip, lsl #25
     c14:	e7d3300e 	ldrb	r3, [r3, lr]
     c18:	b1e0ccac 	mvnlt	ip, ip, lsr #25
     c1c:	b28cc001 	addlt	ip, ip, #1	; 0x1
     c20:	e5c13000 	strb	r3, [r1]
     c24:	e580c004 	str	ip, [r0, #4]
     c28:	e3a00001 	mov	r0, #1	; 0x1
     c2c:	e49df004 	ldr	pc, [sp], #4
     c30:	8000007f 	andhi	r0, r0, pc, ror r0

00000c34 <fifo_avail>:
     c34:	e5903000 	ldr	r3, [r0]
     c38:	e5902004 	ldr	r2, [r0, #4]
     c3c:	e2833080 	add	r3, r3, #128	; 0x80
     c40:	e59f001c 	ldr	r0, [pc, #28]	; c64 <.text+0xc64>
     c44:	e0623003 	rsb	r3, r2, r3
     c48:	e0030000 	and	r0, r3, r0
     c4c:	e3500000 	cmp	r0, #0	; 0x0
     c50:	b2400001 	sublt	r0, r0, #1	; 0x1
     c54:	b1e00c80 	mvnlt	r0, r0, lsl #25
     c58:	b1e00ca0 	mvnlt	r0, r0, lsr #25
     c5c:	b2800001 	addlt	r0, r0, #1	; 0x1
     c60:	e12fff1e 	bx	lr
     c64:	8000007f 	andhi	r0, r0, pc, ror r0

00000c68 <fifo_free>:
     c68:	e52de004 	str	lr, [sp, #-4]!
     c6c:	ebfffff0 	bl	c34 <fifo_avail>
     c70:	e260007f 	rsb	r0, r0, #127	; 0x7f
     c74:	e49df004 	ldr	pc, [sp], #4

00000c78 <restoreIRQ>:
     c78:	e10f2000 	mrs	r2, CPSR
     c7c:	e2000080 	and	r0, r0, #128	; 0x80
     c80:	e3c23080 	bic	r3, r2, #128	; 0x80
     c84:	e1833000 	orr	r3, r3, r0
     c88:	e129f003 	msr	CPSR_fc, r3
     c8c:	e1a00002 	mov	r0, r2
     c90:	e12fff1e 	bx	lr

00000c94 <restoreFIQ>:
     c94:	e10f2000 	mrs	r2, CPSR
     c98:	e2000040 	and	r0, r0, #64	; 0x40
     c9c:	e3c23040 	bic	r3, r2, #64	; 0x40
     ca0:	e1833000 	orr	r3, r3, r0
     ca4:	e129f003 	msr	CPSR_fc, r3
     ca8:	e1a00002 	mov	r0, r2
     cac:	e12fff1e 	bx	lr

00000cb0 <disableFIQ>:
     cb0:	e10f0000 	mrs	r0, CPSR
     cb4:	e3803040 	orr	r3, r0, #64	; 0x40
     cb8:	e129f003 	msr	CPSR_fc, r3
     cbc:	e12fff1e 	bx	lr

00000cc0 <enableFIQ>:
     cc0:	e10f0000 	mrs	r0, CPSR
     cc4:	e3c03040 	bic	r3, r0, #64	; 0x40
     cc8:	e129f003 	msr	CPSR_fc, r3
     ccc:	e12fff1e 	bx	lr

00000cd0 <disableIRQ>:
     cd0:	e10f0000 	mrs	r0, CPSR
     cd4:	e3803080 	orr	r3, r0, #128	; 0x80
     cd8:	e129f003 	msr	CPSR_fc, r3
     cdc:	e12fff1e 	bx	lr

00000ce0 <enableIRQ>:
     ce0:	e10f0000 	mrs	r0, CPSR
     ce4:	e3c03080 	bic	r3, r0, #128	; 0x80
     ce8:	e129f003 	msr	CPSR_fc, r3
     cec:	e12fff1e 	bx	lr

00000cf0 <USBHwCmd>:
     cf0:	e1a00800 	mov	r0, r0, lsl #16
     cf4:	e59f2028 	ldr	r2, [pc, #40]	; d24 <.text+0xd24>
     cf8:	e20008ff 	and	r0, r0, #16711680	; 0xff0000
     cfc:	e3800c05 	orr	r0, r0, #1280	; 0x500
     d00:	e3a03030 	mov	r3, #48	; 0x30
     d04:	e5023df7 	str	r3, [r2, #-3575]
     d08:	e5020def 	str	r0, [r2, #-3567]
     d0c:	e5123dff 	ldr	r3, [r2, #-3583]
     d10:	e2033010 	and	r3, r3, #16	; 0x10
     d14:	e3530010 	cmp	r3, #16	; 0x10
     d18:	1afffffb 	bne	d0c <USBHwCmd+0x1c>
     d1c:	e5023df7 	str	r3, [r2, #-3575]
     d20:	e12fff1e 	bx	lr
     d24:	ffe0cfff 	undefined instruction 0xffe0cfff

00000d28 <USBHwCmdWrite>:
     d28:	e92d4010 	stmdb	sp!, {r4, lr}
     d2c:	e1a04801 	mov	r4, r1, lsl #16
     d30:	e20000ff 	and	r0, r0, #255	; 0xff
     d34:	e1a04824 	mov	r4, r4, lsr #16
     d38:	ebffffec 	bl	cf0 <USBHwCmd>
     d3c:	e1a04804 	mov	r4, r4, lsl #16
     d40:	e59f3020 	ldr	r3, [pc, #32]	; d68 <.text+0xd68>
     d44:	e3844c01 	orr	r4, r4, #256	; 0x100
     d48:	e5034def 	str	r4, [r3, #-3567]
     d4c:	e1a02003 	mov	r2, r3
     d50:	e5123dff 	ldr	r3, [r2, #-3583]
     d54:	e2033010 	and	r3, r3, #16	; 0x10
     d58:	e3530010 	cmp	r3, #16	; 0x10
     d5c:	1afffffb 	bne	d50 <USBHwCmdWrite+0x28>
     d60:	e5023df7 	str	r3, [r2, #-3575]
     d64:	e8bd8010 	ldmia	sp!, {r4, pc}
     d68:	ffe0cfff 	undefined instruction 0xffe0cfff

00000d6c <USBHwCmdRead>:
     d6c:	e92d4010 	stmdb	sp!, {r4, lr}
     d70:	e20040ff 	and	r4, r0, #255	; 0xff
     d74:	e1a00004 	mov	r0, r4
     d78:	ebffffdc 	bl	cf0 <USBHwCmd>
     d7c:	e1a04804 	mov	r4, r4, lsl #16
     d80:	e59f3028 	ldr	r3, [pc, #40]	; db0 <.text+0xdb0>
     d84:	e3844c02 	orr	r4, r4, #512	; 0x200
     d88:	e5034def 	str	r4, [r3, #-3567]
     d8c:	e1a02003 	mov	r2, r3
     d90:	e5123dff 	ldr	r3, [r2, #-3583]
     d94:	e2033020 	and	r3, r3, #32	; 0x20
     d98:	e3530020 	cmp	r3, #32	; 0x20
     d9c:	1afffffb 	bne	d90 <USBHwCmdRead+0x24>
     da0:	e5023df7 	str	r3, [r2, #-3575]
     da4:	e5120deb 	ldr	r0, [r2, #-3563]
     da8:	e20000ff 	and	r0, r0, #255	; 0xff
     dac:	e8bd8010 	ldmia	sp!, {r4, pc}
     db0:	ffe0cfff 	undefined instruction 0xffe0cfff

00000db4 <USBHwEPConfig>:
     db4:	e59fc04c 	ldr	ip, [pc, #76]	; e08 <.text+0xe08>
     db8:	e200300f 	and	r3, r0, #15	; 0xf
     dbc:	e51c2dbb 	ldr	r2, [ip, #-3515]
     dc0:	e1a03083 	mov	r3, r3, lsl #1
     dc4:	e2000080 	and	r0, r0, #128	; 0x80
     dc8:	e18303a0 	orr	r0, r3, r0, lsr #7
     dcc:	e3a03001 	mov	r3, #1	; 0x1
     dd0:	e1822013 	orr	r2, r2, r3, lsl r0
     dd4:	e1a01801 	mov	r1, r1, lsl #16
     dd8:	e1a01821 	mov	r1, r1, lsr #16
     ddc:	e50c2dbb 	str	r2, [ip, #-3515]
     de0:	e50c0db7 	str	r0, [ip, #-3511]
     de4:	e50c1db3 	str	r1, [ip, #-3507]
     de8:	e51c3dff 	ldr	r3, [ip, #-3583]
     dec:	e2033c01 	and	r3, r3, #256	; 0x100
     df0:	e3530c01 	cmp	r3, #256	; 0x100
     df4:	1afffffb 	bne	de8 <USBHwEPConfig+0x34>
     df8:	e3800040 	orr	r0, r0, #64	; 0x40
     dfc:	e3a01000 	mov	r1, #0	; 0x0
     e00:	e50c3df7 	str	r3, [ip, #-3575]
     e04:	eaffffc7 	b	d28 <USBHwCmdWrite>
     e08:	ffe0cfff 	undefined instruction 0xffe0cfff

00000e0c <USBHwSetAddress>:
     e0c:	e200107f 	and	r1, r0, #127	; 0x7f
     e10:	e3811080 	orr	r1, r1, #128	; 0x80
     e14:	e3a000d0 	mov	r0, #208	; 0xd0
     e18:	eaffffc2 	b	d28 <USBHwCmdWrite>

00000e1c <USBHwConnect>:
     e1c:	e3500000 	cmp	r0, #0	; 0x0
     e20:	159f3020 	ldrne	r3, [pc, #32]	; e48 <.text+0xe48>
     e24:	059f301c 	ldreq	r3, [pc, #28]	; e48 <.text+0xe48>
     e28:	13a02901 	movne	r2, #16384	; 0x4000
     e2c:	03a02901 	moveq	r2, #16384	; 0x4000
     e30:	15032fe3 	strne	r2, [r3, #-4067]
     e34:	05032fe7 	streq	r2, [r3, #-4071]
     e38:	e2501000 	subs	r1, r0, #0	; 0x0
     e3c:	13a01001 	movne	r1, #1	; 0x1
     e40:	e3a000fe 	mov	r0, #254	; 0xfe
     e44:	eaffffb7 	b	d28 <USBHwCmdWrite>
     e48:	3fffcfff 	svccc	0x00ffcfff

00000e4c <USBHwNakIntEnable>:
     e4c:	e20010ff 	and	r1, r0, #255	; 0xff
     e50:	e3a000f3 	mov	r0, #243	; 0xf3
     e54:	eaffffb3 	b	d28 <USBHwCmdWrite>

00000e58 <USBHwEPGetStatus>:
     e58:	e1a03000 	mov	r3, r0
     e5c:	e200000f 	and	r0, r0, #15	; 0xf
     e60:	e2033080 	and	r3, r3, #128	; 0x80
     e64:	e1a00080 	mov	r0, r0, lsl #1
     e68:	e52de004 	str	lr, [sp, #-4]!
     e6c:	e18003a3 	orr	r0, r0, r3, lsr #7
     e70:	ebffffbd 	bl	d6c <USBHwCmdRead>
     e74:	e49df004 	ldr	pc, [sp], #4

00000e78 <USBHwEPStall>:
     e78:	e200300f 	and	r3, r0, #15	; 0xf
     e7c:	e1a03083 	mov	r3, r3, lsl #1
     e80:	e2000080 	and	r0, r0, #128	; 0x80
     e84:	e18333a0 	orr	r3, r3, r0, lsr #7
     e88:	e2511000 	subs	r1, r1, #0	; 0x0
     e8c:	13a01001 	movne	r1, #1	; 0x1
     e90:	e3830040 	orr	r0, r3, #64	; 0x40
     e94:	eaffffa3 	b	d28 <USBHwCmdWrite>

00000e98 <USBHwEPWrite>:
     e98:	e92d40f0 	stmdb	sp!, {r4, r5, r6, r7, lr}
     e9c:	e59fc07c 	ldr	ip, [pc, #124]	; f20 <.text+0xf20>
     ea0:	e200500f 	and	r5, r0, #15	; 0xf
     ea4:	e1a03105 	mov	r3, r5, lsl #2
     ea8:	e3833002 	orr	r3, r3, #2	; 0x2
     eac:	e1a06002 	mov	r6, r2
     eb0:	e1a0e001 	mov	lr, r1
     eb4:	e1a0400c 	mov	r4, ip
     eb8:	e20070ff 	and	r7, r0, #255	; 0xff
     ebc:	e50c3dd7 	str	r3, [ip, #-3543]
     ec0:	e50c2ddb 	str	r2, [ip, #-3547]
     ec4:	ea000008 	b	eec <USBHwEPWrite+0x54>
     ec8:	e55e3002 	ldrb	r3, [lr, #-2]
     ecc:	e55e2001 	ldrb	r2, [lr, #-1]
     ed0:	e55e1004 	ldrb	r1, [lr, #-4]
     ed4:	e1a03803 	mov	r3, r3, lsl #16
     ed8:	e1833c02 	orr	r3, r3, r2, lsl #24
     edc:	e55e2003 	ldrb	r2, [lr, #-3]
     ee0:	e1833001 	orr	r3, r3, r1
     ee4:	e1833402 	orr	r3, r3, r2, lsl #8
     ee8:	e5003de3 	str	r3, [r0, #-3555]
     eec:	e5143dd7 	ldr	r3, [r4, #-3543]
     ef0:	e2133002 	ands	r3, r3, #2	; 0x2
     ef4:	e28ee004 	add	lr, lr, #4	; 0x4
     ef8:	e1a00004 	mov	r0, r4
     efc:	1afffff1 	bne	ec8 <USBHwEPWrite+0x30>
     f00:	e1a00085 	mov	r0, r5, lsl #1
     f04:	e18003a7 	orr	r0, r0, r7, lsr #7
     f08:	e5043dd7 	str	r3, [r4, #-3543]
     f0c:	ebffff77 	bl	cf0 <USBHwCmd>
     f10:	e3a000fa 	mov	r0, #250	; 0xfa
     f14:	ebffff75 	bl	cf0 <USBHwCmd>
     f18:	e1a00006 	mov	r0, r6
     f1c:	e8bd80f0 	ldmia	sp!, {r4, r5, r6, r7, pc}
     f20:	ffe0cfff 	undefined instruction 0xffe0cfff

00000f24 <USBHwEPRead>:
     f24:	e92d4030 	stmdb	sp!, {r4, r5, lr}
     f28:	e200e00f 	and	lr, r0, #15	; 0xf
     f2c:	e59fc088 	ldr	ip, [pc, #136]	; fbc <.text+0xfbc>
     f30:	e1a0310e 	mov	r3, lr, lsl #2
     f34:	e3833001 	orr	r3, r3, #1	; 0x1
     f38:	e50c3dd7 	str	r3, [ip, #-3543]
     f3c:	e20050ff 	and	r5, r0, #255	; 0xff
     f40:	e51c3ddf 	ldr	r3, [ip, #-3551]
     f44:	e3130b02 	tst	r3, #2048	; 0x800
     f48:	0afffffc 	beq	f40 <USBHwEPRead+0x1c>
     f4c:	e3130b01 	tst	r3, #1024	; 0x400
     f50:	03e04000 	mvneq	r4, #0	; 0x0
     f54:	0a000016 	beq	fb4 <USBHwEPRead+0x90>
     f58:	e1a03b03 	mov	r3, r3, lsl #22
     f5c:	e3a04000 	mov	r4, #0	; 0x0
     f60:	e59fc054 	ldr	ip, [pc, #84]	; fbc <.text+0xfbc>
     f64:	e1a03b23 	mov	r3, r3, lsr #22
     f68:	e1a00004 	mov	r0, r4
     f6c:	ea000006 	b	f8c <USBHwEPRead+0x68>
     f70:	e3140003 	tst	r4, #3	; 0x3
     f74:	051c0de7 	ldreq	r0, [ip, #-3559]
     f78:	e3510000 	cmp	r1, #0	; 0x0
     f7c:	11540002 	cmpne	r4, r2
     f80:	b7c40001 	strltb	r0, [r4, r1]
     f84:	e2844001 	add	r4, r4, #1	; 0x1
     f88:	e1a00420 	mov	r0, r0, lsr #8
     f8c:	e1540003 	cmp	r4, r3
     f90:	1afffff6 	bne	f70 <USBHwEPRead+0x4c>
     f94:	e59f3020 	ldr	r3, [pc, #32]	; fbc <.text+0xfbc>
     f98:	e1a0008e 	mov	r0, lr, lsl #1
     f9c:	e3a02000 	mov	r2, #0	; 0x0
     fa0:	e18003a5 	orr	r0, r0, r5, lsr #7
     fa4:	e5032dd7 	str	r2, [r3, #-3543]
     fa8:	ebffff50 	bl	cf0 <USBHwCmd>
     fac:	e3a000f2 	mov	r0, #242	; 0xf2
     fb0:	ebffff4e 	bl	cf0 <USBHwCmd>
     fb4:	e1a00004 	mov	r0, r4
     fb8:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
     fbc:	ffe0cfff 	undefined instruction 0xffe0cfff

00000fc0 <USBHwISOCEPRead>:
     fc0:	e92d4030 	stmdb	sp!, {r4, r5, lr}
     fc4:	e200e00f 	and	lr, r0, #15	; 0xf
     fc8:	e1a0310e 	mov	r3, lr, lsl #2
     fcc:	e59fc08c 	ldr	ip, [pc, #140]	; 1060 <.text+0x1060>
     fd0:	e3833001 	orr	r3, r3, #1	; 0x1
     fd4:	e50c3dd7 	str	r3, [ip, #-3543]
     fd8:	e20050ff 	and	r5, r0, #255	; 0xff
     fdc:	e1a00000 	nop			(mov r0,r0)
     fe0:	e51c3ddf 	ldr	r3, [ip, #-3551]
     fe4:	e2130b02 	ands	r0, r3, #2048	; 0x800
     fe8:	0a000001 	beq	ff4 <USBHwISOCEPRead+0x34>
     fec:	e2130b01 	ands	r0, r3, #1024	; 0x400
     ff0:	1a000002 	bne	1000 <USBHwISOCEPRead+0x40>
     ff4:	e3e04000 	mvn	r4, #0	; 0x0
     ff8:	e50c0dd7 	str	r0, [ip, #-3543]
     ffc:	ea000015 	b	1058 <USBHwISOCEPRead+0x98>
    1000:	e1a03b03 	mov	r3, r3, lsl #22
    1004:	e3a04000 	mov	r4, #0	; 0x0
    1008:	e1a03b23 	mov	r3, r3, lsr #22
    100c:	e1a00004 	mov	r0, r4
    1010:	ea000006 	b	1030 <USBHwISOCEPRead+0x70>
    1014:	e3140003 	tst	r4, #3	; 0x3
    1018:	051c0de7 	ldreq	r0, [ip, #-3559]
    101c:	e3510000 	cmp	r1, #0	; 0x0
    1020:	11540002 	cmpne	r4, r2
    1024:	b7c40001 	strltb	r0, [r4, r1]
    1028:	e2844001 	add	r4, r4, #1	; 0x1
    102c:	e1a00420 	mov	r0, r0, lsr #8
    1030:	e1540003 	cmp	r4, r3
    1034:	1afffff6 	bne	1014 <USBHwISOCEPRead+0x54>
    1038:	e59f3020 	ldr	r3, [pc, #32]	; 1060 <.text+0x1060>
    103c:	e1a0008e 	mov	r0, lr, lsl #1
    1040:	e3a02000 	mov	r2, #0	; 0x0
    1044:	e18003a5 	orr	r0, r0, r5, lsr #7
    1048:	e5032dd7 	str	r2, [r3, #-3543]
    104c:	ebffff27 	bl	cf0 <USBHwCmd>
    1050:	e3a000f2 	mov	r0, #242	; 0xf2
    1054:	ebffff25 	bl	cf0 <USBHwCmd>
    1058:	e1a00004 	mov	r0, r4
    105c:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
    1060:	ffe0cfff 	undefined instruction 0xffe0cfff

00001064 <USBHwConfigDevice>:
    1064:	e2501000 	subs	r1, r0, #0	; 0x0
    1068:	13a01001 	movne	r1, #1	; 0x1
    106c:	e3a000d8 	mov	r0, #216	; 0xd8
    1070:	eaffff2c 	b	d28 <USBHwCmdWrite>

00001074 <USBHwISR>:
    1074:	e59f3144 	ldr	r3, [pc, #324]	; 11c0 <.text+0x11c0>
    1078:	e3a02002 	mov	r2, #2	; 0x2
    107c:	e5032fa7 	str	r2, [r3, #-4007]
    1080:	e59f213c 	ldr	r2, [pc, #316]	; 11c4 <.text+0x11c4>
    1084:	e92d45f0 	stmdb	sp!, {r4, r5, r6, r7, r8, sl, lr}
    1088:	e5126dff 	ldr	r6, [r2, #-3583]
    108c:	e3160001 	tst	r6, #1	; 0x1
    1090:	0a00000b 	beq	10c4 <USBHwISR+0x50>
    1094:	e59f312c 	ldr	r3, [pc, #300]	; 11c8 <.text+0x11c8>
    1098:	e5934000 	ldr	r4, [r3]
    109c:	e3a03001 	mov	r3, #1	; 0x1
    10a0:	e3540000 	cmp	r4, #0	; 0x0
    10a4:	e5023df7 	str	r3, [r2, #-3575]
    10a8:	0a000005 	beq	10c4 <USBHwISR+0x50>
    10ac:	e3a000f5 	mov	r0, #245	; 0xf5
    10b0:	ebffff2d 	bl	d6c <USBHwCmdRead>
    10b4:	e1a00800 	mov	r0, r0, lsl #16
    10b8:	e1a00820 	mov	r0, r0, lsr #16
    10bc:	e1a0e00f 	mov	lr, pc
    10c0:	e12fff14 	bx	r4
    10c4:	e3160008 	tst	r6, #8	; 0x8
    10c8:	0a000011 	beq	1114 <USBHwISR+0xa0>
    10cc:	e59f30f0 	ldr	r3, [pc, #240]	; 11c4 <.text+0x11c4>
    10d0:	e3a02008 	mov	r2, #8	; 0x8
    10d4:	e3a000fe 	mov	r0, #254	; 0xfe
    10d8:	e5032df7 	str	r2, [r3, #-3575]
    10dc:	ebffff22 	bl	d6c <USBHwCmdRead>
    10e0:	e310001a 	tst	r0, #26	; 0x1a
    10e4:	0a00000a 	beq	1114 <USBHwISR+0xa0>
    10e8:	e59f30dc 	ldr	r3, [pc, #220]	; 11cc <.text+0x11cc>
    10ec:	e5933000 	ldr	r3, [r3]
    10f0:	e3530000 	cmp	r3, #0	; 0x0
    10f4:	0a000006 	beq	1114 <USBHwISR+0xa0>
    10f8:	e59f50c0 	ldr	r5, [pc, #192]	; 11c0 <.text+0x11c0>
    10fc:	e3a04001 	mov	r4, #1	; 0x1
    1100:	e5054fa7 	str	r4, [r5, #-4007]
    1104:	e2000015 	and	r0, r0, #21	; 0x15
    1108:	e1a0e00f 	mov	lr, pc
    110c:	e12fff13 	bx	r3
    1110:	e5054fa3 	str	r4, [r5, #-4003]
    1114:	e3160004 	tst	r6, #4	; 0x4
    1118:	0a000024 	beq	11b0 <USBHwISR+0x13c>
    111c:	e59f30a0 	ldr	r3, [pc, #160]	; 11c4 <.text+0x11c4>
    1120:	e3a02004 	mov	r2, #4	; 0x4
    1124:	e5032df7 	str	r2, [r3, #-3575]
    1128:	e59fa0a0 	ldr	sl, [pc, #160]	; 11d0 <.text+0x11d0>
    112c:	e59f708c 	ldr	r7, [pc, #140]	; 11c0 <.text+0x11c0>
    1130:	e1a05003 	mov	r5, r3
    1134:	e1a06002 	mov	r6, r2
    1138:	e3a04000 	mov	r4, #0	; 0x0
    113c:	e3a08001 	mov	r8, #1	; 0x1
    1140:	e1a02418 	mov	r2, r8, lsl r4
    1144:	e5153dcf 	ldr	r3, [r5, #-3535]
    1148:	e1120003 	tst	r2, r3
    114c:	0a000014 	beq	11a4 <USBHwISR+0x130>
    1150:	e5052dc7 	str	r2, [r5, #-3527]
    1154:	e5153dff 	ldr	r3, [r5, #-3583]
    1158:	e2032020 	and	r2, r3, #32	; 0x20
    115c:	e3520020 	cmp	r2, #32	; 0x20
    1160:	1afffffb 	bne	1154 <USBHwISR+0xe0>
    1164:	e0843fa4 	add	r3, r4, r4, lsr #31
    1168:	e1a030c3 	mov	r3, r3, asr #1
    116c:	e79a3103 	ldr	r3, [sl, r3, lsl #2]
    1170:	e5052df7 	str	r2, [r5, #-3575]
    1174:	e3530000 	cmp	r3, #0	; 0x0
    1178:	e5151deb 	ldr	r1, [r5, #-3563]
    117c:	0a000008 	beq	11a4 <USBHwISR+0x130>
    1180:	e1a000c4 	mov	r0, r4, asr #1
    1184:	e200000f 	and	r0, r0, #15	; 0xf
    1188:	e1800384 	orr	r0, r0, r4, lsl #7
    118c:	e5076fa7 	str	r6, [r7, #-4007]
    1190:	e200008f 	and	r0, r0, #143	; 0x8f
    1194:	e201101f 	and	r1, r1, #31	; 0x1f
    1198:	e1a0e00f 	mov	lr, pc
    119c:	e12fff13 	bx	r3
    11a0:	e5076fa3 	str	r6, [r7, #-4003]
    11a4:	e2844001 	add	r4, r4, #1	; 0x1
    11a8:	e3540020 	cmp	r4, #32	; 0x20
    11ac:	1affffe3 	bne	1140 <USBHwISR+0xcc>
    11b0:	e59f3008 	ldr	r3, [pc, #8]	; 11c0 <.text+0x11c0>
    11b4:	e3a02002 	mov	r2, #2	; 0x2
    11b8:	e5032fa3 	str	r2, [r3, #-4003]
    11bc:	e8bd85f0 	ldmia	sp!, {r4, r5, r6, r7, r8, sl, pc}
    11c0:	3fffcfff 	svccc	0x00ffcfff
    11c4:	ffe0cfff 	undefined instruction 0xffe0cfff
    11c8:	40000370 	andmi	r0, r0, r0, ror r3
    11cc:	40000374 	andmi	r0, r0, r4, ror r3
    11d0:	40000378 	andmi	r0, r0, r8, ror r3

000011d4 <USBHwInit>:
    11d4:	e59f2124 	ldr	r2, [pc, #292]	; 1300 <.text+0x1300>
    11d8:	e5923004 	ldr	r3, [r2, #4]
    11dc:	e3c33103 	bic	r3, r3, #-1073741824	; 0xc0000000
    11e0:	e3833101 	orr	r3, r3, #1073741824	; 0x40000000
    11e4:	e5823004 	str	r3, [r2, #4]
    11e8:	e592300c 	ldr	r3, [r2, #12]
    11ec:	e3c33203 	bic	r3, r3, #805306368	; 0x30000000
    11f0:	e3833202 	orr	r3, r3, #536870912	; 0x20000000
    11f4:	e582300c 	str	r3, [r2, #12]
    11f8:	e5923000 	ldr	r3, [r2]
    11fc:	e3c3330f 	bic	r3, r3, #1006632960	; 0x3c000000
    1200:	e3833301 	orr	r3, r3, #67108864	; 0x4000000
    1204:	e5823000 	str	r3, [r2]
    1208:	e59f20f4 	ldr	r2, [pc, #244]	; 1304 <.text+0x1304>
    120c:	e5123fff 	ldr	r3, [r2, #-4095]
    1210:	e3833901 	orr	r3, r3, #16384	; 0x4000
    1214:	e5023fff 	str	r3, [r2, #-4095]
    1218:	e3a03901 	mov	r3, #16384	; 0x4000
    121c:	e5023fe7 	str	r3, [r2, #-4071]
    1220:	e59f20e0 	ldr	r2, [pc, #224]	; 1308 <.text+0x1308>
    1224:	e59230c4 	ldr	r3, [r2, #196]
    1228:	e92d4010 	stmdb	sp!, {r4, lr}
    122c:	e3833102 	orr	r3, r3, #-2147483648	; 0x80000000
    1230:	e58230c4 	str	r3, [r2, #196]
    1234:	e59f10d0 	ldr	r1, [pc, #208]	; 130c <.text+0x130c>
    1238:	e3a03005 	mov	r3, #5	; 0x5
    123c:	e5823108 	str	r3, [r2, #264]
    1240:	e2833015 	add	r3, r3, #21	; 0x15
    1244:	e501300b 	str	r3, [r1, #-11]
    1248:	e5113007 	ldr	r3, [r1, #-7]
    124c:	e313001a 	tst	r3, #26	; 0x1a
    1250:	0afffffc 	beq	1248 <USBHwInit+0x74>
    1254:	e3a04000 	mov	r4, #0	; 0x0
    1258:	e3e02000 	mvn	r2, #0	; 0x0
    125c:	e3a03003 	mov	r3, #3	; 0x3
    1260:	e5013eef 	str	r3, [r1, #-3823]
    1264:	e1a00004 	mov	r0, r4
    1268:	e5014dfb 	str	r4, [r1, #-3579]
    126c:	e5012df7 	str	r2, [r1, #-3575]
    1270:	e5014dd3 	str	r4, [r1, #-3539]
    1274:	e5014dcb 	str	r4, [r1, #-3531]
    1278:	e5012dc7 	str	r2, [r1, #-3527]
    127c:	e5014dbf 	str	r4, [r1, #-3519]
    1280:	ebfffef1 	bl	e4c <USBHwNakIntEnable>
    1284:	e59f107c 	ldr	r1, [pc, #124]	; 1308 <.text+0x1308>
    1288:	e59131a0 	ldr	r3, [r1, #416]
    128c:	e59fc06c 	ldr	ip, [pc, #108]	; 1300 <.text+0x1300>
    1290:	e3833001 	orr	r3, r3, #1	; 0x1
    1294:	e58131a0 	str	r3, [r1, #416]
    1298:	e59f2064 	ldr	r2, [pc, #100]	; 1304 <.text+0x1304>
    129c:	e58c4028 	str	r4, [ip, #40]
    12a0:	e5123fbf 	ldr	r3, [r2, #-4031]
    12a4:	e3a00001 	mov	r0, #1	; 0x1
    12a8:	e3833001 	orr	r3, r3, #1	; 0x1
    12ac:	e5023fbf 	str	r3, [r2, #-4031]
    12b0:	e5020fa3 	str	r0, [r2, #-4003]
    12b4:	e59131a0 	ldr	r3, [r1, #416]
    12b8:	e1833000 	orr	r3, r3, r0
    12bc:	e58131a0 	str	r3, [r1, #416]
    12c0:	e58c4028 	str	r4, [ip, #40]
    12c4:	e5123fbf 	ldr	r3, [r2, #-4031]
    12c8:	e3833002 	orr	r3, r3, #2	; 0x2
    12cc:	e5023fbf 	str	r3, [r2, #-4031]
    12d0:	e3a03002 	mov	r3, #2	; 0x2
    12d4:	e5023fa3 	str	r3, [r2, #-4003]
    12d8:	e59131a0 	ldr	r3, [r1, #416]
    12dc:	e1833000 	orr	r3, r3, r0
    12e0:	e58131a0 	str	r3, [r1, #416]
    12e4:	e58c4028 	str	r4, [ip, #40]
    12e8:	e5123fbf 	ldr	r3, [r2, #-4031]
    12ec:	e3833004 	orr	r3, r3, #4	; 0x4
    12f0:	e5023fbf 	str	r3, [r2, #-4031]
    12f4:	e3a03004 	mov	r3, #4	; 0x4
    12f8:	e5023fa3 	str	r3, [r2, #-4003]
    12fc:	e8bd8010 	ldmia	sp!, {r4, pc}
    1300:	e002c000 	and	ip, r2, r0
    1304:	3fffcfff 	svccc	0x00ffcfff
    1308:	e01fc000 	ands	ip, pc, r0
    130c:	ffe0cfff 	undefined instruction 0xffe0cfff

00001310 <USBSetupDMADescriptor>:
    1310:	e52de004 	str	lr, [sp, #-4]!
    1314:	e3a0e000 	mov	lr, #0	; 0x0
    1318:	e580e004 	str	lr, [r0, #4]
    131c:	e5801000 	str	r1, [r0]
    1320:	e1a0c001 	mov	ip, r1
    1324:	e1a03b03 	mov	r3, r3, lsl #22
    1328:	e5901004 	ldr	r1, [r0, #4]
    132c:	e1a03b23 	mov	r3, r3, lsr #22
    1330:	e1811283 	orr	r1, r1, r3, lsl #5
    1334:	e5801004 	str	r1, [r0, #4]
    1338:	e1dd10b4 	ldrh	r1, [sp, #4]
    133c:	e5903004 	ldr	r3, [r0, #4]
    1340:	e1833801 	orr	r3, r3, r1, lsl #16
    1344:	e5803004 	str	r3, [r0, #4]
    1348:	e21220ff 	ands	r2, r2, #255	; 0xff
    134c:	15903004 	ldrne	r3, [r0, #4]
    1350:	13833010 	orrne	r3, r3, #16	; 0x10
    1354:	15803004 	strne	r3, [r0, #4]
    1358:	e35c0000 	cmp	ip, #0	; 0x0
    135c:	15903004 	ldrne	r3, [r0, #4]
    1360:	e59d100c 	ldr	r1, [sp, #12]
    1364:	13833004 	orrne	r3, r3, #4	; 0x4
    1368:	15803004 	strne	r3, [r0, #4]
    136c:	e59d3008 	ldr	r3, [sp, #8]
    1370:	e3520000 	cmp	r2, #0	; 0x0
    1374:	13510000 	cmpne	r1, #0	; 0x0
    1378:	e5803008 	str	r3, [r0, #8]
    137c:	15801010 	strne	r1, [r0, #16]
    1380:	e580e00c 	str	lr, [r0, #12]
    1384:	e49df004 	ldr	pc, [sp], #4

00001388 <USBDisableDMAForEndpoint>:
    1388:	e200200f 	and	r2, r0, #15	; 0xf
    138c:	e1a02082 	mov	r2, r2, lsl #1
    1390:	e2000080 	and	r0, r0, #128	; 0x80
    1394:	e18223a0 	orr	r2, r2, r0, lsr #7
    1398:	e3a03001 	mov	r3, #1	; 0x1
    139c:	e1a03213 	mov	r3, r3, lsl r2
    13a0:	e59f2004 	ldr	r2, [pc, #4]	; 13ac <.text+0x13ac>
    13a4:	e5023d73 	str	r3, [r2, #-3443]
    13a8:	e12fff1e 	bx	lr
    13ac:	ffe0cfff 	undefined instruction 0xffe0cfff

000013b0 <USBEnableDMAForEndpoint>:
    13b0:	e200200f 	and	r2, r0, #15	; 0xf
    13b4:	e1a02082 	mov	r2, r2, lsl #1
    13b8:	e2000080 	and	r0, r0, #128	; 0x80
    13bc:	e18223a0 	orr	r2, r2, r0, lsr #7
    13c0:	e3a03001 	mov	r3, #1	; 0x1
    13c4:	e1a03213 	mov	r3, r3, lsl r2
    13c8:	e59f2004 	ldr	r2, [pc, #4]	; 13d4 <.text+0x13d4>
    13cc:	e5023d77 	str	r3, [r2, #-3447]
    13d0:	e12fff1e 	bx	lr
    13d4:	ffe0cfff 	undefined instruction 0xffe0cfff

000013d8 <USBInitializeISOCFrameArray>:
    13d8:	e92d4030 	stmdb	sp!, {r4, r5, lr}
    13dc:	e1a03b03 	mov	r3, r3, lsl #22
    13e0:	e1a02802 	mov	r2, r2, lsl #16
    13e4:	e1a03b23 	mov	r3, r3, lsr #22
    13e8:	e1a05000 	mov	r5, r0
    13ec:	e1a04001 	mov	r4, r1
    13f0:	e1a0c822 	mov	ip, r2, lsr #16
    13f4:	e3830902 	orr	r0, r3, #32768	; 0x8000
    13f8:	e3a0e000 	mov	lr, #0	; 0x0
    13fc:	ea000000 	b	1404 <USBInitializeISOCFrameArray+0x2c>
    1400:	e7851102 	str	r1, [r5, r2, lsl #2]
    1404:	e1a0280e 	mov	r2, lr, lsl #16
    1408:	e28c3001 	add	r3, ip, #1	; 0x1
    140c:	e1a02822 	mov	r2, r2, lsr #16
    1410:	e1a03803 	mov	r3, r3, lsl #16
    1414:	e1520004 	cmp	r2, r4
    1418:	e180180c 	orr	r1, r0, ip, lsl #16
    141c:	e28ee001 	add	lr, lr, #1	; 0x1
    1420:	e1a0c823 	mov	ip, r3, lsr #16
    1424:	3afffff5 	bcc	1400 <USBInitializeISOCFrameArray+0x28>
    1428:	e8bd8030 	ldmia	sp!, {r4, r5, pc}

0000142c <USBSetHeadDDForDMA>:
    142c:	e200300f 	and	r3, r0, #15	; 0xf
    1430:	e1a03083 	mov	r3, r3, lsl #1
    1434:	e2000080 	and	r0, r0, #128	; 0x80
    1438:	e18333a0 	orr	r3, r3, r0, lsr #7
    143c:	e7812103 	str	r2, [r1, r3, lsl #2]
    1440:	e12fff1e 	bx	lr

00001444 <USBInitializeUSBDMA>:
    1444:	e3a03000 	mov	r3, #0	; 0x0
    1448:	e1a02003 	mov	r2, r3
    144c:	e7832000 	str	r2, [r3, r0]
    1450:	e2833004 	add	r3, r3, #4	; 0x4
    1454:	e3530080 	cmp	r3, #128	; 0x80
    1458:	1afffffb 	bne	144c <USBInitializeUSBDMA+0x8>
    145c:	e59f3004 	ldr	r3, [pc, #4]	; 1468 <.text+0x1468>
    1460:	e5030d7f 	str	r0, [r3, #-3455]
    1464:	e12fff1e 	bx	lr
    1468:	ffe0cfff 	undefined instruction 0xffe0cfff

0000146c <USBHwRegisterFrameHandler>:
    146c:	e59f1018 	ldr	r1, [pc, #24]	; 148c <.text+0x148c>
    1470:	e59f3018 	ldr	r3, [pc, #24]	; 1490 <.text+0x1490>
    1474:	e5112dfb 	ldr	r2, [r1, #-3579]
    1478:	e5830000 	str	r0, [r3]
    147c:	e59f0010 	ldr	r0, [pc, #16]	; 1494 <.text+0x1494>
    1480:	e3822001 	orr	r2, r2, #1	; 0x1
    1484:	e5012dfb 	str	r2, [r1, #-3579]
    1488:	eafffca6 	b	728 <puts>
    148c:	ffe0cfff 	undefined instruction 0xffe0cfff
    1490:	40000370 	andmi	r0, r0, r0, ror r3
    1494:	000021ec 	andeq	r2, r0, ip, ror #3

00001498 <USBHwRegisterDevIntHandler>:
    1498:	e59f1018 	ldr	r1, [pc, #24]	; 14b8 <.text+0x14b8>
    149c:	e59f3018 	ldr	r3, [pc, #24]	; 14bc <.text+0x14bc>
    14a0:	e5112dfb 	ldr	r2, [r1, #-3579]
    14a4:	e5830000 	str	r0, [r3]
    14a8:	e59f0010 	ldr	r0, [pc, #16]	; 14c0 <.text+0x14c0>
    14ac:	e3822008 	orr	r2, r2, #8	; 0x8
    14b0:	e5012dfb 	str	r2, [r1, #-3579]
    14b4:	eafffc9b 	b	728 <puts>
    14b8:	ffe0cfff 	undefined instruction 0xffe0cfff
    14bc:	40000374 	andmi	r0, r0, r4, ror r3
    14c0:	0000220c 	andeq	r2, r0, ip, lsl #4

000014c4 <USBHwRegisterEPIntHandler>:
    14c4:	e92d4010 	stmdb	sp!, {r4, lr}
    14c8:	e200300f 	and	r3, r0, #15	; 0xf
    14cc:	e1a03083 	mov	r3, r3, lsl #1
    14d0:	e2002080 	and	r2, r0, #128	; 0x80
    14d4:	e183e3a2 	orr	lr, r3, r2, lsr #7
    14d8:	e35e001f 	cmp	lr, #31	; 0x1f
    14dc:	e1a04001 	mov	r4, r1
    14e0:	e24dd004 	sub	sp, sp, #4	; 0x4
    14e4:	e20010ff 	and	r1, r0, #255	; 0xff
    14e8:	da000007 	ble	150c <USBHwRegisterEPIntHandler+0x48>
    14ec:	e3a0c0d2 	mov	ip, #210	; 0xd2
    14f0:	e59f0050 	ldr	r0, [pc, #80]	; 1548 <.text+0x1548>
    14f4:	e59f1050 	ldr	r1, [pc, #80]	; 154c <.text+0x154c>
    14f8:	e59f2050 	ldr	r2, [pc, #80]	; 1550 <.text+0x1550>
    14fc:	e59f3050 	ldr	r3, [pc, #80]	; 1554 <.text+0x1554>
    1500:	e58dc000 	str	ip, [sp]
    1504:	ebfffc51 	bl	650 <printf>
    1508:	eafffffe 	b	1508 <USBHwRegisterEPIntHandler+0x44>
    150c:	e59fc044 	ldr	ip, [pc, #68]	; 1558 <.text+0x1558>
    1510:	e51c3dcb 	ldr	r3, [ip, #-3531]
    1514:	e3a02001 	mov	r2, #1	; 0x1
    1518:	e1833e12 	orr	r3, r3, r2, lsl lr
    151c:	e50c3dcb 	str	r3, [ip, #-3531]
    1520:	e51c2dfb 	ldr	r2, [ip, #-3579]
    1524:	e59f3030 	ldr	r3, [pc, #48]	; 155c <.text+0x155c>
    1528:	e59f0030 	ldr	r0, [pc, #48]	; 1560 <.text+0x1560>
    152c:	e3822004 	orr	r2, r2, #4	; 0x4
    1530:	e1a0e0ae 	mov	lr, lr, lsr #1
    1534:	e783410e 	str	r4, [r3, lr, lsl #2]
    1538:	e50c2dfb 	str	r2, [ip, #-3579]
    153c:	e28dd004 	add	sp, sp, #4	; 0x4
    1540:	e8bd4010 	ldmia	sp!, {r4, lr}
    1544:	eafffc41 	b	650 <printf>
    1548:	00002100 	andeq	r2, r0, r0, lsl #2
    154c:	00002234 	andeq	r2, r0, r4, lsr r2
    1550:	0000223c 	andeq	r2, r0, ip, lsr r2
    1554:	0000207c 	andeq	r2, r0, ip, ror r0
    1558:	ffe0cfff 	undefined instruction 0xffe0cfff
    155c:	40000378 	andmi	r0, r0, r8, ror r3
    1560:	00002248 	andeq	r2, r0, r8, asr #4

00001564 <USBRegisterRequestHandler>:
    1564:	e52de004 	str	lr, [sp, #-4]!
    1568:	e3500000 	cmp	r0, #0	; 0x0
    156c:	e24dd004 	sub	sp, sp, #4	; 0x4
    1570:	aa000007 	bge	1594 <USBRegisterRequestHandler+0x30>
    1574:	e3a0c0e2 	mov	ip, #226	; 0xe2
    1578:	e59f0054 	ldr	r0, [pc, #84]	; 15d4 <.text+0x15d4>
    157c:	e59f1054 	ldr	r1, [pc, #84]	; 15d8 <.text+0x15d8>
    1580:	e59f2054 	ldr	r2, [pc, #84]	; 15dc <.text+0x15dc>
    1584:	e59f3054 	ldr	r3, [pc, #84]	; 15e0 <.text+0x15e0>
    1588:	e58dc000 	str	ip, [sp]
    158c:	ebfffc2f 	bl	650 <printf>
    1590:	eafffffe 	b	1590 <USBRegisterRequestHandler+0x2c>
    1594:	e3500003 	cmp	r0, #3	; 0x3
    1598:	da000007 	ble	15bc <USBRegisterRequestHandler+0x58>
    159c:	e3a0c0e3 	mov	ip, #227	; 0xe3
    15a0:	e59f002c 	ldr	r0, [pc, #44]	; 15d4 <.text+0x15d4>
    15a4:	e59f1038 	ldr	r1, [pc, #56]	; 15e4 <.text+0x15e4>
    15a8:	e59f202c 	ldr	r2, [pc, #44]	; 15dc <.text+0x15dc>
    15ac:	e59f302c 	ldr	r3, [pc, #44]	; 15e0 <.text+0x15e0>
    15b0:	e58dc000 	str	ip, [sp]
    15b4:	ebfffc25 	bl	650 <printf>
    15b8:	eafffffe 	b	15b8 <USBRegisterRequestHandler+0x54>
    15bc:	e59f3024 	ldr	r3, [pc, #36]	; 15e8 <.text+0x15e8>
    15c0:	e7832100 	str	r2, [r3, r0, lsl #2]
    15c4:	e59f3020 	ldr	r3, [pc, #32]	; 15ec <.text+0x15ec>
    15c8:	e7831100 	str	r1, [r3, r0, lsl #2]
    15cc:	e28dd004 	add	sp, sp, #4	; 0x4
    15d0:	e8bd8000 	ldmia	sp!, {pc}
    15d4:	00002100 	andeq	r2, r0, r0, lsl #2
    15d8:	00002268 	andeq	r2, r0, r8, ror #4
    15dc:	00002274 	andeq	r2, r0, r4, ror r2
    15e0:	00002098 	muleq	r0, r8, r0
    15e4:	00002284 	andeq	r2, r0, r4, lsl #5
    15e8:	400003c8 	andmi	r0, r0, r8, asr #7
    15ec:	400003b8 	strmih	r0, [r0], -r8

000015f0 <_HandleRequest>:
    15f0:	e92d4010 	stmdb	sp!, {r4, lr}
    15f4:	e5d03000 	ldrb	r3, [r0]
    15f8:	e1a032a3 	mov	r3, r3, lsr #5
    15fc:	e203c003 	and	ip, r3, #3	; 0x3
    1600:	e59f3028 	ldr	r3, [pc, #40]	; 1630 <.text+0x1630>
    1604:	e793410c 	ldr	r4, [r3, ip, lsl #2]
    1608:	e3540000 	cmp	r4, #0	; 0x0
    160c:	1a000004 	bne	1624 <_HandleRequest+0x34>
    1610:	e1a0100c 	mov	r1, ip
    1614:	e59f0018 	ldr	r0, [pc, #24]	; 1634 <.text+0x1634>
    1618:	ebfffc0c 	bl	650 <printf>
    161c:	e1a00004 	mov	r0, r4
    1620:	e8bd8010 	ldmia	sp!, {r4, pc}
    1624:	e1a0e00f 	mov	lr, pc
    1628:	e12fff14 	bx	r4
    162c:	e8bd8010 	ldmia	sp!, {r4, pc}
    1630:	400003b8 	strmih	r0, [r0], -r8
    1634:	00002290 	muleq	r0, r0, r2

00001638 <StallControlPipe>:
    1638:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
    163c:	e1a03000 	mov	r3, r0
    1640:	e3a01001 	mov	r1, #1	; 0x1
    1644:	e3a00080 	mov	r0, #128	; 0x80
    1648:	e20350ff 	and	r5, r3, #255	; 0xff
    164c:	ebfffe09 	bl	e78 <USBHwEPStall>
    1650:	e59f0030 	ldr	r0, [pc, #48]	; 1688 <.text+0x1688>
    1654:	ebfffbfd 	bl	650 <printf>
    1658:	e59f602c 	ldr	r6, [pc, #44]	; 168c <.text+0x168c>
    165c:	e3a04000 	mov	r4, #0	; 0x0
    1660:	e7d41006 	ldrb	r1, [r4, r6]
    1664:	e59f0024 	ldr	r0, [pc, #36]	; 1690 <.text+0x1690>
    1668:	e2844001 	add	r4, r4, #1	; 0x1
    166c:	ebfffbf7 	bl	650 <printf>
    1670:	e3540008 	cmp	r4, #8	; 0x8
    1674:	1afffff9 	bne	1660 <StallControlPipe+0x28>
    1678:	e59f0014 	ldr	r0, [pc, #20]	; 1694 <.text+0x1694>
    167c:	e1a01005 	mov	r1, r5
    1680:	e8bd4070 	ldmia	sp!, {r4, r5, r6, lr}
    1684:	eafffbf1 	b	650 <printf>
    1688:	000022ac 	andeq	r2, r0, ip, lsr #5
    168c:	400003d8 	ldrmid	r0, [r0], -r8
    1690:	000022b8 	streqh	r2, [r0], -r8
    1694:	000022c0 	andeq	r2, r0, r0, asr #5

00001698 <DataIn>:
    1698:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
    169c:	e59f6038 	ldr	r6, [pc, #56]	; 16dc <.text+0x16dc>
    16a0:	e5964000 	ldr	r4, [r6]
    16a4:	e59f5034 	ldr	r5, [pc, #52]	; 16e0 <.text+0x16e0>
    16a8:	e3540040 	cmp	r4, #64	; 0x40
    16ac:	a3a04040 	movge	r4, #64	; 0x40
    16b0:	e1a02004 	mov	r2, r4
    16b4:	e3a00080 	mov	r0, #128	; 0x80
    16b8:	e5951000 	ldr	r1, [r5]
    16bc:	ebfffdf5 	bl	e98 <USBHwEPWrite>
    16c0:	e5953000 	ldr	r3, [r5]
    16c4:	e5962000 	ldr	r2, [r6]
    16c8:	e0833004 	add	r3, r3, r4
    16cc:	e0642002 	rsb	r2, r4, r2
    16d0:	e5853000 	str	r3, [r5]
    16d4:	e5862000 	str	r2, [r6]
    16d8:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
    16dc:	400003e4 	andmi	r0, r0, r4, ror #7
    16e0:	400003e0 	andmi	r0, r0, r0, ror #7

000016e4 <USBHandleControlTransfer>:
    16e4:	e92d40f0 	stmdb	sp!, {r4, r5, r6, r7, lr}
    16e8:	e21000ff 	ands	r0, r0, #255	; 0xff
    16ec:	e24dd004 	sub	sp, sp, #4	; 0x4
    16f0:	e20170ff 	and	r7, r1, #255	; 0xff
    16f4:	1a000051 	bne	1840 <USBHandleControlTransfer+0x15c>
    16f8:	e3110004 	tst	r1, #4	; 0x4
    16fc:	e59f6178 	ldr	r6, [pc, #376]	; 187c <.text+0x187c>
    1700:	0a000021 	beq	178c <USBHandleControlTransfer+0xa8>
    1704:	e59f5174 	ldr	r5, [pc, #372]	; 1880 <.text+0x1880>
    1708:	e3a02008 	mov	r2, #8	; 0x8
    170c:	e1a01005 	mov	r1, r5
    1710:	ebfffe03 	bl	f24 <USBHwEPRead>
    1714:	e5d51001 	ldrb	r1, [r5, #1]
    1718:	e59f0164 	ldr	r0, [pc, #356]	; 1884 <.text+0x1884>
    171c:	ebfffbcb 	bl	650 <printf>
    1720:	e5d50000 	ldrb	r0, [r5]
    1724:	e59f215c 	ldr	r2, [pc, #348]	; 1888 <.text+0x1888>
    1728:	e1a032a0 	mov	r3, r0, lsr #5
    172c:	e1d510b6 	ldrh	r1, [r5, #6]
    1730:	e2033003 	and	r3, r3, #3	; 0x3
    1734:	e7923103 	ldr	r3, [r2, r3, lsl #2]
    1738:	e59f414c 	ldr	r4, [pc, #332]	; 188c <.text+0x188c>
    173c:	e59f214c 	ldr	r2, [pc, #332]	; 1890 <.text+0x1890>
    1740:	e3510000 	cmp	r1, #0	; 0x0
    1744:	e5823000 	str	r3, [r2]
    1748:	e5861000 	str	r1, [r6]
    174c:	e5841000 	str	r1, [r4]
    1750:	0a000001 	beq	175c <USBHandleControlTransfer+0x78>
    1754:	e1b003a0 	movs	r0, r0, lsr #7
    1758:	0a000045 	beq	1874 <USBHandleControlTransfer+0x190>
    175c:	e1a00005 	mov	r0, r5
    1760:	e1a01004 	mov	r1, r4
    1764:	ebffffa1 	bl	15f0 <_HandleRequest>
    1768:	e3500000 	cmp	r0, #0	; 0x0
    176c:	059f0120 	ldreq	r0, [pc, #288]	; 1894 <.text+0x1894>
    1770:	0a000022 	beq	1800 <USBHandleControlTransfer+0x11c>
    1774:	e1d520b6 	ldrh	r2, [r5, #6]
    1778:	e5943000 	ldr	r3, [r4]
    177c:	e1520003 	cmp	r2, r3
    1780:	d5862000 	strle	r2, [r6]
    1784:	c5863000 	strgt	r3, [r6]
    1788:	ea00002e 	b	1848 <USBHandleControlTransfer+0x164>
    178c:	e5962000 	ldr	r2, [r6]
    1790:	e3520000 	cmp	r2, #0	; 0x0
    1794:	da00001e 	ble	1814 <USBHandleControlTransfer+0x130>
    1798:	e59f40f0 	ldr	r4, [pc, #240]	; 1890 <.text+0x1890>
    179c:	e5941000 	ldr	r1, [r4]
    17a0:	ebfffddf 	bl	f24 <USBHwEPRead>
    17a4:	e3500000 	cmp	r0, #0	; 0x0
    17a8:	ba000015 	blt	1804 <USBHandleControlTransfer+0x120>
    17ac:	e5962000 	ldr	r2, [r6]
    17b0:	e5943000 	ldr	r3, [r4]
    17b4:	e0602002 	rsb	r2, r0, r2
    17b8:	e0833000 	add	r3, r3, r0
    17bc:	e3520000 	cmp	r2, #0	; 0x0
    17c0:	e5843000 	str	r3, [r4]
    17c4:	e5862000 	str	r2, [r6]
    17c8:	1a000029 	bne	1874 <USBHandleControlTransfer+0x190>
    17cc:	e59f00ac 	ldr	r0, [pc, #172]	; 1880 <.text+0x1880>
    17d0:	e5d03000 	ldrb	r3, [r0]
    17d4:	e59f20ac 	ldr	r2, [pc, #172]	; 1888 <.text+0x1888>
    17d8:	e1a032a3 	mov	r3, r3, lsr #5
    17dc:	e2033003 	and	r3, r3, #3	; 0x3
    17e0:	e7923103 	ldr	r3, [r2, r3, lsl #2]
    17e4:	e59f10a0 	ldr	r1, [pc, #160]	; 188c <.text+0x188c>
    17e8:	e1a02004 	mov	r2, r4
    17ec:	e5843000 	str	r3, [r4]
    17f0:	ebffff7e 	bl	15f0 <_HandleRequest>
    17f4:	e3500000 	cmp	r0, #0	; 0x0
    17f8:	1a000012 	bne	1848 <USBHandleControlTransfer+0x164>
    17fc:	e59f0094 	ldr	r0, [pc, #148]	; 1898 <.text+0x1898>
    1800:	ebfffbc8 	bl	728 <puts>
    1804:	e1a00007 	mov	r0, r7
    1808:	e28dd004 	add	sp, sp, #4	; 0x4
    180c:	e8bd40f0 	ldmia	sp!, {r4, r5, r6, r7, lr}
    1810:	eaffff88 	b	1638 <StallControlPipe>
    1814:	e1a01000 	mov	r1, r0
    1818:	e1a02000 	mov	r2, r0
    181c:	ebfffdc0 	bl	f24 <USBHwEPRead>
    1820:	e59f2074 	ldr	r2, [pc, #116]	; 189c <.text+0x189c>
    1824:	e59f3074 	ldr	r3, [pc, #116]	; 18a0 <.text+0x18a0>
    1828:	e3500000 	cmp	r0, #0	; 0x0
    182c:	d1a00002 	movle	r0, r2
    1830:	c1a00003 	movgt	r0, r3
    1834:	e28dd004 	add	sp, sp, #4	; 0x4
    1838:	e8bd40f0 	ldmia	sp!, {r4, r5, r6, r7, lr}
    183c:	eafffb83 	b	650 <printf>
    1840:	e3500080 	cmp	r0, #128	; 0x80
    1844:	1a000002 	bne	1854 <USBHandleControlTransfer+0x170>
    1848:	e28dd004 	add	sp, sp, #4	; 0x4
    184c:	e8bd40f0 	ldmia	sp!, {r4, r5, r6, r7, lr}
    1850:	eaffff90 	b	1698 <DataIn>
    1854:	e3a0c0d4 	mov	ip, #212	; 0xd4
    1858:	e59f0044 	ldr	r0, [pc, #68]	; 18a4 <.text+0x18a4>
    185c:	e59f1044 	ldr	r1, [pc, #68]	; 18a8 <.text+0x18a8>
    1860:	e59f2044 	ldr	r2, [pc, #68]	; 18ac <.text+0x18ac>
    1864:	e59f3044 	ldr	r3, [pc, #68]	; 18b0 <.text+0x18b0>
    1868:	e58dc000 	str	ip, [sp]
    186c:	ebfffb77 	bl	650 <printf>
    1870:	eafffffe 	b	1870 <USBHandleControlTransfer+0x18c>
    1874:	e28dd004 	add	sp, sp, #4	; 0x4
    1878:	e8bd80f0 	ldmia	sp!, {r4, r5, r6, r7, pc}
    187c:	400003e4 	andmi	r0, r0, r4, ror #7
    1880:	400003d8 	ldrmid	r0, [r0], -r8
    1884:	000022cc 	andeq	r2, r0, ip, asr #5
    1888:	400003c8 	andmi	r0, r0, r8, asr #7
    188c:	400003e8 	andmi	r0, r0, r8, ror #7
    1890:	400003e0 	andmi	r0, r0, r0, ror #7
    1894:	000022d0 	ldreqd	r2, [r0], -r0
    1898:	000022e8 	andeq	r2, r0, r8, ror #5
    189c:	00002124 	andeq	r2, r0, r4, lsr #2
    18a0:	00002300 	andeq	r2, r0, r0, lsl #6
    18a4:	00002100 	andeq	r2, r0, r0, lsl #2
    18a8:	00002128 	andeq	r2, r0, r8, lsr #2
    18ac:	00002274 	andeq	r2, r0, r4, ror r2
    18b0:	000020b4 	streqh	r2, [r0], -r4

000018b4 <USBRegisterDescriptors>:
    18b4:	e59f3004 	ldr	r3, [pc, #4]	; 18c0 <.text+0x18c0>
    18b8:	e5830000 	str	r0, [r3]
    18bc:	e12fff1e 	bx	lr
    18c0:	400003f4 	strmid	r0, [r0], -r4

000018c4 <USBRegisterCustomReqHandler>:
    18c4:	e59f3004 	ldr	r3, [pc, #4]	; 18d0 <.text+0x18d0>
    18c8:	e5830000 	str	r0, [r3]
    18cc:	e12fff1e 	bx	lr
    18d0:	400003ec 	andmi	r0, r0, ip, ror #7

000018d4 <USBGetDescriptor>:
    18d4:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
    18d8:	e59f10ac 	ldr	r1, [pc, #172]	; 198c <.text+0x198c>
    18dc:	e5911000 	ldr	r1, [r1]
    18e0:	e1a00800 	mov	r0, r0, lsl #16
    18e4:	e3510000 	cmp	r1, #0	; 0x0
    18e8:	e1a0c820 	mov	ip, r0, lsr #16
    18ec:	e1a05002 	mov	r5, r2
    18f0:	e24dd004 	sub	sp, sp, #4	; 0x4
    18f4:	e1a06003 	mov	r6, r3
    18f8:	11a00c20 	movne	r0, r0, lsr #24
    18fc:	120ce0ff 	andne	lr, ip, #255	; 0xff
    1900:	13a02000 	movne	r2, #0	; 0x0
    1904:	1a000017 	bne	1968 <USBGetDescriptor+0x94>
    1908:	e3a0c06e 	mov	ip, #110	; 0x6e
    190c:	e59f007c 	ldr	r0, [pc, #124]	; 1990 <.text+0x1990>
    1910:	e59f107c 	ldr	r1, [pc, #124]	; 1994 <.text+0x1994>
    1914:	e59f207c 	ldr	r2, [pc, #124]	; 1998 <.text+0x1998>
    1918:	e59f307c 	ldr	r3, [pc, #124]	; 199c <.text+0x199c>
    191c:	e58dc000 	str	ip, [sp]
    1920:	ebfffb4a 	bl	650 <printf>
    1924:	eafffffe 	b	1924 <USBGetDescriptor+0x50>
    1928:	e5d13001 	ldrb	r3, [r1, #1]
    192c:	e1530000 	cmp	r3, r0
    1930:	1a00000b 	bne	1964 <USBGetDescriptor+0x90>
    1934:	e152000e 	cmp	r2, lr
    1938:	1a000008 	bne	1960 <USBGetDescriptor+0x8c>
    193c:	e5861000 	str	r1, [r6]
    1940:	e3500002 	cmp	r0, #2	; 0x2
    1944:	05d13002 	ldreqb	r3, [r1, #2]
    1948:	05d12003 	ldreqb	r2, [r1, #3]
    194c:	15d13000 	ldrneb	r3, [r1]
    1950:	01833402 	orreq	r3, r3, r2, lsl #8
    1954:	e3a00001 	mov	r0, #1	; 0x1
    1958:	e5853000 	str	r3, [r5]
    195c:	ea000008 	b	1984 <USBGetDescriptor+0xb0>
    1960:	e2822001 	add	r2, r2, #1	; 0x1
    1964:	e0811004 	add	r1, r1, r4
    1968:	e5d14000 	ldrb	r4, [r1]
    196c:	e3540000 	cmp	r4, #0	; 0x0
    1970:	1affffec 	bne	1928 <USBGetDescriptor+0x54>
    1974:	e1a0100c 	mov	r1, ip
    1978:	e59f0020 	ldr	r0, [pc, #32]	; 19a0 <.text+0x19a0>
    197c:	ebfffb33 	bl	650 <printf>
    1980:	e1a00004 	mov	r0, r4
    1984:	e28dd004 	add	sp, sp, #4	; 0x4
    1988:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
    198c:	400003f4 	strmid	r0, [r0], -r4
    1990:	00002100 	andeq	r2, r0, r0, lsl #2
    1994:	00002304 	andeq	r2, r0, r4, lsl #6
    1998:	00002318 	andeq	r2, r0, r8, lsl r3
    199c:	000020e4 	andeq	r2, r0, r4, ror #1
    19a0:	00002324 	andeq	r2, r0, r4, lsr #6

000019a4 <USBHandleStandardRequest>:
    19a4:	e92d41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
    19a8:	e59f32f8 	ldr	r3, [pc, #760]	; 1ca8 <.text+0x1ca8>
    19ac:	e5933000 	ldr	r3, [r3]
    19b0:	e3530000 	cmp	r3, #0	; 0x0
    19b4:	e24dd004 	sub	sp, sp, #4	; 0x4
    19b8:	e1a05000 	mov	r5, r0
    19bc:	e1a06001 	mov	r6, r1
    19c0:	e1a04002 	mov	r4, r2
    19c4:	0a000003 	beq	19d8 <USBHandleStandardRequest+0x34>
    19c8:	e1a0e00f 	mov	lr, pc
    19cc:	e12fff13 	bx	r3
    19d0:	e3500000 	cmp	r0, #0	; 0x0
    19d4:	1a0000a9 	bne	1c80 <.text+0x1c80>
    19d8:	e5d53000 	ldrb	r3, [r5]
    19dc:	e203301f 	and	r3, r3, #31	; 0x1f
    19e0:	e3530001 	cmp	r3, #1	; 0x1
    19e4:	0a000059 	beq	1b50 <.text+0x1b50>
    19e8:	e3530002 	cmp	r3, #2	; 0x2
    19ec:	0a00007b 	beq	1be0 <.text+0x1be0>
    19f0:	e3530000 	cmp	r3, #0	; 0x0
    19f4:	1a0000a7 	bne	1c98 <.text+0x1c98>
    19f8:	e5d51001 	ldrb	r1, [r5, #1]
    19fc:	e5940000 	ldr	r0, [r4]
    1a00:	e3510009 	cmp	r1, #9	; 0x9
    1a04:	979ff101 	ldrls	pc, [pc, r1, lsl #2]
    1a08:	ea00004e 	b	1b48 <.text+0x1b48>
    1a0c:	00001b94 	muleq	r0, r4, fp
    1a10:	00001c98 	muleq	r0, r8, ip
    1a14:	00001b48 	andeq	r1, r0, r8, asr #22
    1a18:	00001c98 	muleq	r0, r8, ip
    1a1c:	00001b48 	andeq	r1, r0, r8, asr #22
    1a20:	00001a34 	andeq	r1, r0, r4, lsr sl
    1a24:	00001a40 	andeq	r1, r0, r0, asr #20
    1a28:	00001b40 	andeq	r1, r0, r0, asr #22
    1a2c:	00001a68 	andeq	r1, r0, r8, ror #20
    1a30:	00001a80 	andeq	r1, r0, r0, lsl #21
    1a34:	e5d50002 	ldrb	r0, [r5, #2]
    1a38:	ebfffcf3 	bl	e0c <USBHwSetAddress>
    1a3c:	ea00008f 	b	1c80 <.text+0x1c80>
    1a40:	e1d510b2 	ldrh	r1, [r5, #2]
    1a44:	e59f0260 	ldr	r0, [pc, #608]	; 1cac <.text+0x1cac>
    1a48:	ebfffb00 	bl	650 <printf>
    1a4c:	e1d510b4 	ldrh	r1, [r5, #4]
    1a50:	e1d500b2 	ldrh	r0, [r5, #2]
    1a54:	e1a02006 	mov	r2, r6
    1a58:	e1a03004 	mov	r3, r4
    1a5c:	e28dd004 	add	sp, sp, #4	; 0x4
    1a60:	e8bd41f0 	ldmia	sp!, {r4, r5, r6, r7, r8, lr}
    1a64:	eaffff9a 	b	18d4 <USBGetDescriptor>
    1a68:	e59f3240 	ldr	r3, [pc, #576]	; 1cb0 <.text+0x1cb0>
    1a6c:	e5d32000 	ldrb	r2, [r3]
    1a70:	e3a03001 	mov	r3, #1	; 0x1
    1a74:	e1a01003 	mov	r1, r3
    1a78:	e5c02000 	strb	r2, [r0]
    1a7c:	ea000072 	b	1c4c <.text+0x1c4c>
    1a80:	e59f322c 	ldr	r3, [pc, #556]	; 1cb4 <.text+0x1cb4>
    1a84:	e5933000 	ldr	r3, [r3]
    1a88:	e3530000 	cmp	r3, #0	; 0x0
    1a8c:	e1d520b2 	ldrh	r2, [r5, #2]
    1a90:	1a000007 	bne	1ab4 <.text+0x1ab4>
    1a94:	e3a0c0a5 	mov	ip, #165	; 0xa5
    1a98:	e59f0218 	ldr	r0, [pc, #536]	; 1cb8 <.text+0x1cb8>
    1a9c:	e59f1218 	ldr	r1, [pc, #536]	; 1cbc <.text+0x1cbc>
    1aa0:	e59f2218 	ldr	r2, [pc, #536]	; 1cc0 <.text+0x1cc0>
    1aa4:	e59f3218 	ldr	r3, [pc, #536]	; 1cc4 <.text+0x1cc4>
    1aa8:	e58dc000 	str	ip, [sp]
    1aac:	ebfffae7 	bl	650 <printf>
    1ab0:	eafffffe 	b	1ab0 <.text+0x1ab0>
    1ab4:	e21270ff 	ands	r7, r2, #255	; 0xff
    1ab8:	13a060ff 	movne	r6, #255	; 0xff
    1abc:	01a00007 	moveq	r0, r7
    1ac0:	11a04003 	movne	r4, r3
    1ac4:	11a08006 	movne	r8, r6
    1ac8:	1a000012 	bne	1b18 <.text+0x1b18>
    1acc:	ea000015 	b	1b28 <.text+0x1b28>
    1ad0:	e5d43001 	ldrb	r3, [r4, #1]
    1ad4:	e3530004 	cmp	r3, #4	; 0x4
    1ad8:	05d46003 	ldreqb	r6, [r4, #3]
    1adc:	0a00000b 	beq	1b10 <.text+0x1b10>
    1ae0:	e3530005 	cmp	r3, #5	; 0x5
    1ae4:	0a000002 	beq	1af4 <.text+0x1af4>
    1ae8:	e3530002 	cmp	r3, #2	; 0x2
    1aec:	05d48005 	ldreqb	r8, [r4, #5]
    1af0:	ea000006 	b	1b10 <.text+0x1b10>
    1af4:	e1580007 	cmp	r8, r7
    1af8:	03560000 	cmpeq	r6, #0	; 0x0
    1afc:	05d43005 	ldreqb	r3, [r4, #5]
    1b00:	05d41004 	ldreqb	r1, [r4, #4]
    1b04:	05d40002 	ldreqb	r0, [r4, #2]
    1b08:	01811403 	orreq	r1, r1, r3, lsl #8
    1b0c:	0bfffca8 	bleq	db4 <USBHwEPConfig>
    1b10:	e5d43000 	ldrb	r3, [r4]
    1b14:	e0844003 	add	r4, r4, r3
    1b18:	e5d43000 	ldrb	r3, [r4]
    1b1c:	e3530000 	cmp	r3, #0	; 0x0
    1b20:	1affffea 	bne	1ad0 <.text+0x1ad0>
    1b24:	e3a00001 	mov	r0, #1	; 0x1
    1b28:	ebfffd4d 	bl	1064 <USBHwConfigDevice>
    1b2c:	e1d520b2 	ldrh	r2, [r5, #2]
    1b30:	e59f3178 	ldr	r3, [pc, #376]	; 1cb0 <.text+0x1cb0>
    1b34:	e3a01001 	mov	r1, #1	; 0x1
    1b38:	e5c32000 	strb	r2, [r3]
    1b3c:	ea000056 	b	1c9c <.text+0x1c9c>
    1b40:	e59f0180 	ldr	r0, [pc, #384]	; 1cc8 <.text+0x1cc8>
    1b44:	ea000052 	b	1c94 <.text+0x1c94>
    1b48:	e59f017c 	ldr	r0, [pc, #380]	; 1ccc <.text+0x1ccc>
    1b4c:	ea000050 	b	1c94 <.text+0x1c94>
    1b50:	e5d51001 	ldrb	r1, [r5, #1]
    1b54:	e5940000 	ldr	r0, [r4]
    1b58:	e351000b 	cmp	r1, #11	; 0xb
    1b5c:	979ff101 	ldrls	pc, [pc, r1, lsl #2]
    1b60:	ea00001c 	b	1bd8 <.text+0x1bd8>
    1b64:	00001b94 	muleq	r0, r4, fp
    1b68:	00001c98 	muleq	r0, r8, ip
    1b6c:	00001bd8 	ldreqd	r1, [r0], -r8
    1b70:	00001c98 	muleq	r0, r8, ip
    1b74:	00001bd8 	ldreqd	r1, [r0], -r8
    1b78:	00001bd8 	ldreqd	r1, [r0], -r8
    1b7c:	00001bd8 	ldreqd	r1, [r0], -r8
    1b80:	00001bd8 	ldreqd	r1, [r0], -r8
    1b84:	00001bd8 	ldreqd	r1, [r0], -r8
    1b88:	00001bd8 	ldreqd	r1, [r0], -r8
    1b8c:	00001ba8 	andeq	r1, r0, r8, lsr #23
    1b90:	00001bc0 	andeq	r1, r0, r0, asr #23
    1b94:	e3a03000 	mov	r3, #0	; 0x0
    1b98:	e3a01001 	mov	r1, #1	; 0x1
    1b9c:	e5c03001 	strb	r3, [r0, #1]
    1ba0:	e5c03000 	strb	r3, [r0]
    1ba4:	ea000027 	b	1c48 <.text+0x1c48>
    1ba8:	e3a02001 	mov	r2, #1	; 0x1
    1bac:	e3a03000 	mov	r3, #0	; 0x0
    1bb0:	e1a01002 	mov	r1, r2
    1bb4:	e5c03000 	strb	r3, [r0]
    1bb8:	e5862000 	str	r2, [r6]
    1bbc:	ea000036 	b	1c9c <.text+0x1c9c>
    1bc0:	e1d500b2 	ldrh	r0, [r5, #2]
    1bc4:	e3500000 	cmp	r0, #0	; 0x0
    1bc8:	03a01001 	moveq	r1, #1	; 0x1
    1bcc:	05860000 	streq	r0, [r6]
    1bd0:	0a000031 	beq	1c9c <.text+0x1c9c>
    1bd4:	ea00002f 	b	1c98 <.text+0x1c98>
    1bd8:	e59f00f0 	ldr	r0, [pc, #240]	; 1cd0 <.text+0x1cd0>
    1bdc:	ea00002c 	b	1c94 <.text+0x1c94>
    1be0:	e5d51001 	ldrb	r1, [r5, #1]
    1be4:	e5944000 	ldr	r4, [r4]
    1be8:	e351000c 	cmp	r1, #12	; 0xc
    1bec:	979ff101 	ldrls	pc, [pc, r1, lsl #2]
    1bf0:	ea000026 	b	1c90 <.text+0x1c90>
    1bf4:	00001c28 	andeq	r1, r0, r8, lsr #24
    1bf8:	00001c54 	andeq	r1, r0, r4, asr ip
    1bfc:	00001c90 	muleq	r0, r0, ip
    1c00:	00001c68 	andeq	r1, r0, r8, ror #24
    1c04:	00001c90 	muleq	r0, r0, ip
    1c08:	00001c90 	muleq	r0, r0, ip
    1c0c:	00001c90 	muleq	r0, r0, ip
    1c10:	00001c90 	muleq	r0, r0, ip
    1c14:	00001c90 	muleq	r0, r0, ip
    1c18:	00001c90 	muleq	r0, r0, ip
    1c1c:	00001c90 	muleq	r0, r0, ip
    1c20:	00001c90 	muleq	r0, r0, ip
    1c24:	00001c88 	andeq	r1, r0, r8, lsl #25
    1c28:	e5d50004 	ldrb	r0, [r5, #4]
    1c2c:	ebfffc89 	bl	e58 <USBHwEPGetStatus>
    1c30:	e1a000a0 	mov	r0, r0, lsr #1
    1c34:	e2000001 	and	r0, r0, #1	; 0x1
    1c38:	e3a03000 	mov	r3, #0	; 0x0
    1c3c:	e5c43001 	strb	r3, [r4, #1]
    1c40:	e5c40000 	strb	r0, [r4]
    1c44:	e3a01001 	mov	r1, #1	; 0x1
    1c48:	e2833002 	add	r3, r3, #2	; 0x2
    1c4c:	e5863000 	str	r3, [r6]
    1c50:	ea000011 	b	1c9c <.text+0x1c9c>
    1c54:	e1d510b2 	ldrh	r1, [r5, #2]
    1c58:	e3510000 	cmp	r1, #0	; 0x0
    1c5c:	05d50004 	ldreqb	r0, [r5, #4]
    1c60:	0a000005 	beq	1c7c <.text+0x1c7c>
    1c64:	ea00000b 	b	1c98 <.text+0x1c98>
    1c68:	e1d530b2 	ldrh	r3, [r5, #2]
    1c6c:	e3530000 	cmp	r3, #0	; 0x0
    1c70:	1a000008 	bne	1c98 <.text+0x1c98>
    1c74:	e5d50004 	ldrb	r0, [r5, #4]
    1c78:	e3a01001 	mov	r1, #1	; 0x1
    1c7c:	ebfffc7d 	bl	e78 <USBHwEPStall>
    1c80:	e3a01001 	mov	r1, #1	; 0x1
    1c84:	ea000004 	b	1c9c <.text+0x1c9c>
    1c88:	e59f0044 	ldr	r0, [pc, #68]	; 1cd4 <.text+0x1cd4>
    1c8c:	ea000000 	b	1c94 <.text+0x1c94>
    1c90:	e59f0040 	ldr	r0, [pc, #64]	; 1cd8 <.text+0x1cd8>
    1c94:	ebfffa6d 	bl	650 <printf>
    1c98:	e3a01000 	mov	r1, #0	; 0x0
    1c9c:	e1a00001 	mov	r0, r1
    1ca0:	e28dd004 	add	sp, sp, #4	; 0x4
    1ca4:	e8bd81f0 	ldmia	sp!, {r4, r5, r6, r7, r8, pc}
    1ca8:	400003ec 	andmi	r0, r0, ip, ror #7
    1cac:	00002338 	andeq	r2, r0, r8, lsr r3
    1cb0:	400003f0 	strmid	r0, [r0], -r0
    1cb4:	400003f4 	strmid	r0, [r0], -r4
    1cb8:	00002100 	andeq	r2, r0, r0, lsl #2
    1cbc:	00002304 	andeq	r2, r0, r4, lsl #6
    1cc0:	00002318 	andeq	r2, r0, r8, lsl r3
    1cc4:	000020d0 	ldreqd	r2, [r0], -r0
    1cc8:	0000233c 	andeq	r2, r0, ip, lsr r3
    1ccc:	0000235c 	andeq	r2, r0, ip, asr r3
    1cd0:	00002374 	andeq	r2, r0, r4, ror r3
    1cd4:	00002390 	muleq	r0, r0, r3
    1cd8:	000023ac 	andeq	r2, r0, ip, lsr #7

00001cdc <USBInit>:
    1cdc:	e92d4010 	stmdb	sp!, {r4, lr}
    1ce0:	e59f4050 	ldr	r4, [pc, #80]	; 1d38 <.text+0x1d38>
    1ce4:	ebfffd3a 	bl	11d4 <USBHwInit>
    1ce8:	e59f004c 	ldr	r0, [pc, #76]	; 1d3c <.text+0x1d3c>
    1cec:	ebfffde9 	bl	1498 <USBHwRegisterDevIntHandler>
    1cf0:	e1a01004 	mov	r1, r4
    1cf4:	e3a00000 	mov	r0, #0	; 0x0
    1cf8:	ebfffdf1 	bl	14c4 <USBHwRegisterEPIntHandler>
    1cfc:	e1a01004 	mov	r1, r4
    1d00:	e3a00080 	mov	r0, #128	; 0x80
    1d04:	ebfffdee 	bl	14c4 <USBHwRegisterEPIntHandler>
    1d08:	e3a00000 	mov	r0, #0	; 0x0
    1d0c:	e3a01040 	mov	r1, #64	; 0x40
    1d10:	ebfffc27 	bl	db4 <USBHwEPConfig>
    1d14:	e3a00080 	mov	r0, #128	; 0x80
    1d18:	e3a01040 	mov	r1, #64	; 0x40
    1d1c:	ebfffc24 	bl	db4 <USBHwEPConfig>
    1d20:	e3a00000 	mov	r0, #0	; 0x0
    1d24:	e59f1014 	ldr	r1, [pc, #20]	; 1d40 <.text+0x1d40>
    1d28:	e59f2014 	ldr	r2, [pc, #20]	; 1d44 <.text+0x1d44>
    1d2c:	ebfffe0c 	bl	1564 <USBRegisterRequestHandler>
    1d30:	e3a00001 	mov	r0, #1	; 0x1
    1d34:	e8bd8010 	ldmia	sp!, {r4, pc}
    1d38:	000016e4 	andeq	r1, r0, r4, ror #13
    1d3c:	00001d48 	andeq	r1, r0, r8, asr #26
    1d40:	000019a4 	andeq	r1, r0, r4, lsr #19
    1d44:	400003f8 	strmid	r0, [r0], -r8

00001d48 <HandleUsbReset>:
    1d48:	e3100010 	tst	r0, #16	; 0x10
    1d4c:	012fff1e 	bxeq	lr
    1d50:	e59f0000 	ldr	r0, [pc, #0]	; 1d58 <.text+0x1d58>
    1d54:	eafffa3d 	b	650 <printf>
    1d58:	000023c0 	andeq	r2, r0, r0, asr #7

00001d5c <__aeabi_uidiv>:
    1d5c:	e2512001 	subs	r2, r1, #1	; 0x1
    1d60:	012fff1e 	bxeq	lr
    1d64:	3a000036 	bcc	1e44 <__aeabi_uidiv+0xe8>
    1d68:	e1500001 	cmp	r0, r1
    1d6c:	9a000022 	bls	1dfc <__aeabi_uidiv+0xa0>
    1d70:	e1110002 	tst	r1, r2
    1d74:	0a000023 	beq	1e08 <__aeabi_uidiv+0xac>
    1d78:	e311020e 	tst	r1, #-536870912	; 0xe0000000
    1d7c:	01a01181 	moveq	r1, r1, lsl #3
    1d80:	03a03008 	moveq	r3, #8	; 0x8
    1d84:	13a03001 	movne	r3, #1	; 0x1
    1d88:	e3510201 	cmp	r1, #268435456	; 0x10000000
    1d8c:	31510000 	cmpcc	r1, r0
    1d90:	31a01201 	movcc	r1, r1, lsl #4
    1d94:	31a03203 	movcc	r3, r3, lsl #4
    1d98:	3afffffa 	bcc	1d88 <__aeabi_uidiv+0x2c>
    1d9c:	e3510102 	cmp	r1, #-2147483648	; 0x80000000
    1da0:	31510000 	cmpcc	r1, r0
    1da4:	31a01081 	movcc	r1, r1, lsl #1
    1da8:	31a03083 	movcc	r3, r3, lsl #1
    1dac:	3afffffa 	bcc	1d9c <__aeabi_uidiv+0x40>
    1db0:	e3a02000 	mov	r2, #0	; 0x0
    1db4:	e1500001 	cmp	r0, r1
    1db8:	20400001 	subcs	r0, r0, r1
    1dbc:	21822003 	orrcs	r2, r2, r3
    1dc0:	e15000a1 	cmp	r0, r1, lsr #1
    1dc4:	204000a1 	subcs	r0, r0, r1, lsr #1
    1dc8:	218220a3 	orrcs	r2, r2, r3, lsr #1
    1dcc:	e1500121 	cmp	r0, r1, lsr #2
    1dd0:	20400121 	subcs	r0, r0, r1, lsr #2
    1dd4:	21822123 	orrcs	r2, r2, r3, lsr #2
    1dd8:	e15001a1 	cmp	r0, r1, lsr #3
    1ddc:	204001a1 	subcs	r0, r0, r1, lsr #3
    1de0:	218221a3 	orrcs	r2, r2, r3, lsr #3
    1de4:	e3500000 	cmp	r0, #0	; 0x0
    1de8:	11b03223 	movnes	r3, r3, lsr #4
    1dec:	11a01221 	movne	r1, r1, lsr #4
    1df0:	1affffef 	bne	1db4 <__aeabi_uidiv+0x58>
    1df4:	e1a00002 	mov	r0, r2
    1df8:	e12fff1e 	bx	lr
    1dfc:	03a00001 	moveq	r0, #1	; 0x1
    1e00:	13a00000 	movne	r0, #0	; 0x0
    1e04:	e12fff1e 	bx	lr
    1e08:	e3510801 	cmp	r1, #65536	; 0x10000
    1e0c:	21a01821 	movcs	r1, r1, lsr #16
    1e10:	23a02010 	movcs	r2, #16	; 0x10
    1e14:	33a02000 	movcc	r2, #0	; 0x0
    1e18:	e3510c01 	cmp	r1, #256	; 0x100
    1e1c:	21a01421 	movcs	r1, r1, lsr #8
    1e20:	22822008 	addcs	r2, r2, #8	; 0x8
    1e24:	e3510010 	cmp	r1, #16	; 0x10
    1e28:	21a01221 	movcs	r1, r1, lsr #4
    1e2c:	22822004 	addcs	r2, r2, #4	; 0x4
    1e30:	e3510004 	cmp	r1, #4	; 0x4
    1e34:	82822003 	addhi	r2, r2, #3	; 0x3
    1e38:	908220a1 	addls	r2, r2, r1, lsr #1
    1e3c:	e1a00230 	mov	r0, r0, lsr r2
    1e40:	e12fff1e 	bx	lr
    1e44:	e52de008 	str	lr, [sp, #-8]!
    1e48:	eb00003a 	bl	1f38 <__aeabi_idiv0>
    1e4c:	e3a00000 	mov	r0, #0	; 0x0
    1e50:	e49df008 	ldr	pc, [sp], #8

00001e54 <__aeabi_uidivmod>:
    1e54:	e92d4003 	stmdb	sp!, {r0, r1, lr}
    1e58:	ebffffbf 	bl	1d5c <__aeabi_uidiv>
    1e5c:	e8bd4006 	ldmia	sp!, {r1, r2, lr}
    1e60:	e0030092 	mul	r3, r2, r0
    1e64:	e0411003 	sub	r1, r1, r3
    1e68:	e12fff1e 	bx	lr

00001e6c <__umodsi3>:
    1e6c:	e2512001 	subs	r2, r1, #1	; 0x1
    1e70:	3a00002c 	bcc	1f28 <__umodsi3+0xbc>
    1e74:	11500001 	cmpne	r0, r1
    1e78:	03a00000 	moveq	r0, #0	; 0x0
    1e7c:	81110002 	tsthi	r1, r2
    1e80:	00000002 	andeq	r0, r0, r2
    1e84:	912fff1e 	bxls	lr
    1e88:	e3a02000 	mov	r2, #0	; 0x0
    1e8c:	e3510201 	cmp	r1, #268435456	; 0x10000000
    1e90:	31510000 	cmpcc	r1, r0
    1e94:	31a01201 	movcc	r1, r1, lsl #4
    1e98:	32822004 	addcc	r2, r2, #4	; 0x4
    1e9c:	3afffffa 	bcc	1e8c <__umodsi3+0x20>
    1ea0:	e3510102 	cmp	r1, #-2147483648	; 0x80000000
    1ea4:	31510000 	cmpcc	r1, r0
    1ea8:	31a01081 	movcc	r1, r1, lsl #1
    1eac:	32822001 	addcc	r2, r2, #1	; 0x1
    1eb0:	3afffffa 	bcc	1ea0 <__umodsi3+0x34>
    1eb4:	e2522003 	subs	r2, r2, #3	; 0x3
    1eb8:	ba00000e 	blt	1ef8 <__umodsi3+0x8c>
    1ebc:	e1500001 	cmp	r0, r1
    1ec0:	20400001 	subcs	r0, r0, r1
    1ec4:	e15000a1 	cmp	r0, r1, lsr #1
    1ec8:	204000a1 	subcs	r0, r0, r1, lsr #1
    1ecc:	e1500121 	cmp	r0, r1, lsr #2
    1ed0:	20400121 	subcs	r0, r0, r1, lsr #2
    1ed4:	e15001a1 	cmp	r0, r1, lsr #3
    1ed8:	204001a1 	subcs	r0, r0, r1, lsr #3
    1edc:	e3500001 	cmp	r0, #1	; 0x1
    1ee0:	e1a01221 	mov	r1, r1, lsr #4
    1ee4:	a2522004 	subges	r2, r2, #4	; 0x4
    1ee8:	aafffff3 	bge	1ebc <__umodsi3+0x50>
    1eec:	e3120003 	tst	r2, #3	; 0x3
    1ef0:	13300000 	teqne	r0, #0	; 0x0
    1ef4:	0a00000a 	beq	1f24 <__umodsi3+0xb8>
    1ef8:	e3720002 	cmn	r2, #2	; 0x2
    1efc:	ba000006 	blt	1f1c <__umodsi3+0xb0>
    1f00:	0a000002 	beq	1f10 <__umodsi3+0xa4>
    1f04:	e1500001 	cmp	r0, r1
    1f08:	20400001 	subcs	r0, r0, r1
    1f0c:	e1a010a1 	mov	r1, r1, lsr #1
    1f10:	e1500001 	cmp	r0, r1
    1f14:	20400001 	subcs	r0, r0, r1
    1f18:	e1a010a1 	mov	r1, r1, lsr #1
    1f1c:	e1500001 	cmp	r0, r1
    1f20:	20400001 	subcs	r0, r0, r1
    1f24:	e12fff1e 	bx	lr
    1f28:	e52de008 	str	lr, [sp, #-8]!
    1f2c:	eb000001 	bl	1f38 <__aeabi_idiv0>
    1f30:	e3a00000 	mov	r0, #0	; 0x0
    1f34:	e49df008 	ldr	pc, [sp], #8

00001f38 <__aeabi_idiv0>:
    1f38:	e12fff1e 	bx	lr

00001f3c <memcpy>:
    1f3c:	e352000f 	cmp	r2, #15	; 0xf
    1f40:	e92d4010 	stmdb	sp!, {r4, lr}
    1f44:	e1a0c000 	mov	ip, r0
    1f48:	e1a04002 	mov	r4, r2
    1f4c:	e1a0e002 	mov	lr, r2
    1f50:	9a000002 	bls	1f60 <memcpy+0x24>
    1f54:	e1813000 	orr	r3, r1, r0
    1f58:	e3130003 	tst	r3, #3	; 0x3
    1f5c:	0a000008 	beq	1f84 <memcpy+0x48>
    1f60:	e35e0000 	cmp	lr, #0	; 0x0
    1f64:	08bd8010 	ldmeqia	sp!, {r4, pc}
    1f68:	e3a02000 	mov	r2, #0	; 0x0
    1f6c:	e4d13001 	ldrb	r3, [r1], #1
    1f70:	e7c2300c 	strb	r3, [r2, ip]
    1f74:	e2822001 	add	r2, r2, #1	; 0x1
    1f78:	e152000e 	cmp	r2, lr
    1f7c:	1afffffa 	bne	1f6c <memcpy+0x30>
    1f80:	e8bd8010 	ldmia	sp!, {r4, pc}
    1f84:	e5913000 	ldr	r3, [r1]
    1f88:	e58c3000 	str	r3, [ip]
    1f8c:	e5912004 	ldr	r2, [r1, #4]
    1f90:	e58c2004 	str	r2, [ip, #4]
    1f94:	e5913008 	ldr	r3, [r1, #8]
    1f98:	e58c3008 	str	r3, [ip, #8]
    1f9c:	e244e010 	sub	lr, r4, #16	; 0x10
    1fa0:	e591300c 	ldr	r3, [r1, #12]
    1fa4:	e35e000f 	cmp	lr, #15	; 0xf
    1fa8:	e58c300c 	str	r3, [ip, #12]
    1fac:	e2811010 	add	r1, r1, #16	; 0x10
    1fb0:	e28cc010 	add	ip, ip, #16	; 0x10
    1fb4:	e1a0400e 	mov	r4, lr
    1fb8:	8afffff1 	bhi	1f84 <memcpy+0x48>
    1fbc:	e35e0003 	cmp	lr, #3	; 0x3
    1fc0:	9affffe6 	bls	1f60 <memcpy+0x24>
    1fc4:	e24ee004 	sub	lr, lr, #4	; 0x4
    1fc8:	e4913004 	ldr	r3, [r1], #4
    1fcc:	e35e0003 	cmp	lr, #3	; 0x3
    1fd0:	e48c3004 	str	r3, [ip], #4
    1fd4:	8afffffa 	bhi	1fc4 <memcpy+0x88>
    1fd8:	e35e0000 	cmp	lr, #0	; 0x0
    1fdc:	1affffe1 	bne	1f68 <memcpy+0x2c>
    1fe0:	e8bd8010 	ldmia	sp!, {r4, pc}

00001fe4 <abDescriptors>:
    1fe4:	01010112 40000002 0005ffff 02010100     .......@........
    1ff4:	02090103 01020043 0932c000 01000004     ....C.....2.....
    2004:	00010202 10002405 01240501 24040101     .....$....$....$
    2014:	24050202 07010006 08038105 04090a00     ...$............
    2024:	0a020001 07000000 40020505 05070000     ...........@....
    2034:	00400282 09030400 4c030e04 43005000     ..@........L.P.C
    2044:	53005500 14004200 53005503 53004200     .U.S.B...U.S.B.S
    2054:	72006500 61006900 12006c00 45004403     .e.r.i.a.l...D.E
    2064:	44004100 30004300 45004400 00000000     .A.D.C.0.D.E....

00002074 <__FUNCTION__.1927>:
    2074:	6b6c7542 0074754f                       BulkOut.

0000207c <__FUNCTION__.1660>:
    207c:	48425355 67655277 65747369 49504572     USBHwRegisterEPI
    208c:	6148746e 656c646e 00000072              ntHandler...

00002098 <__FUNCTION__.1651>:
    2098:	52425355 73696765 52726574 65757165     USBRegisterReque
    20a8:	61487473 656c646e 00000072              stHandler...

000020b4 <__FUNCTION__.1613>:
    20b4:	48425355 6c646e61 6e6f4365 6c6f7274     USBHandleControl
    20c4:	6e617254 72656673 00000000              Transfer....

000020d0 <__FUNCTION__.1627>:
    20d0:	53425355 6f437465 6769666e 74617275     USBSetConfigurat
    20e0:	006e6f69                                ion.

000020e4 <__FUNCTION__.1594>:
    20e4:	47425355 65447465 69726373 726f7470     USBGetDescriptor
    20f4:	00000000 6c756e28 0000296c 7373410a     ....(null)...Ass
    2104:	69747265 27206e6f 20277325 6c696166     ertion '%s' fail
    2114:	69206465 7325206e 2373253a 0a216425     ed in %s:%s#%d!.
    2124:	00000000 534c4146 00000045 6e69616d     ....FALSE...main
    2134:	7265735f 2e6c6169 00000063 5f544553     _serial.c...SET_
    2144:	454e494c 444f435f 00474e49 54447764     LINE_CODING.dwDT
    2154:	74615245 75253d65 4362202c 46726168     ERate=%u, bCharF
    2164:	616d726f 75253d74 5062202c 74697261     ormat=%u, bParit
    2174:	70795479 75253d65 4462202c 42617461     yType=%u, bDataB
    2184:	3d737469 000a7525 5f544547 454e494c     its=%u..GET_LINE
    2194:	444f435f 00474e49 5f544553 544e4f43     _CODING.SET_CONT
    21a4:	5f4c4f52 454e494c 4154535f 25204554     ROL_LINE_STATE %
    21b4:	00000a58 74696e49 696c6169 676e6973     X...Initialising
    21c4:	42535520 61747320 00006b63 72617453      USB stack..Star
    21d4:	676e6974 42535520 6d6f6320 696e756d     ting USB communi
    21e4:	69746163 00006e6f 69676552 72657473     cation..Register
    21f4:	68206465 6c646e61 66207265 6620726f     ed handler for f
    2204:	656d6172 00000000 69676552 72657473     rame....Register
    2214:	68206465 6c646e61 66207265 6420726f     ed handler for d
    2224:	63697665 74732065 73757461 00000000     evice status....
    2234:	3c786469 00003233 68627375 706c5f77     idx<32..usbhw_lp
    2244:	00632e63 69676552 72657473 68206465     c.c.Registered h
    2254:	6c646e61 66207265 4520726f 78302050     andler for EP 0x
    2264:	000a7825 70795469 3d3e2065 00003020     %x..iType >= 0..
    2274:	63627375 72746e6f 632e6c6f 00000000     usbcontrol.c....
    2284:	70795469 203c2065 00000034 68206f4e     iType < 4...No h
    2294:	6c646e61 66207265 7220726f 79747165     andler for reqty
    22a4:	25206570 00000a64 4c415453 6e6f204c     pe %d...STALL on
    22b4:	00005b20 32302520 00000078 7473205d      [.. %02x...] st
    22c4:	253d7461 00000a78 00782553 6e61485f     at=%x...S%x._Han
    22d4:	52656c64 65757165 20317473 6c696166     dleRequest1 fail
    22e4:	00006465 6e61485f 52656c64 65757165     ed.._HandleReque
    22f4:	20327473 6c696166 00006465 0000003f     st2 failed..?...
    2304:	44626170 72637365 21207069 554e203d     pabDescrip != NU
    2314:	00004c4c 73627375 65726474 00632e71     LL..usbstdreq.c.
    2324:	63736544 20782520 20746f6e 6e756f66     Desc %x not foun
    2334:	000a2164 00782544 69766544 72206563     d!..D%x.Device r
    2344:	25207165 6f6e2064 6d692074 6d656c70     eq %d not implem
    2354:	65746e65 00000a64 656c6c49 206c6167     ented...Illegal 
    2364:	69766564 72206563 25207165 00000a64     device req %d...
    2374:	656c6c49 206c6167 65746e69 63616672     Illegal interfac
    2384:	65722065 64252071 0000000a 72205045     e req %d....EP r
    2394:	25207165 6f6e2064 6d692074 6d656c70     eq %d not implem
    23a4:	65746e65 00000a64 656c6c49 206c6167     ented...Illegal 
    23b4:	72205045 25207165 00000a64 0000210a     EP req %d....!..
