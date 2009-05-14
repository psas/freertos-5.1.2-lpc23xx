
isoc_io_sample.elf:     file format elf32-littlearm

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
      bc:	ea0001b9 	b	7a8 <main>
      c0:	40007edc 	ldrmid	r7, [r0], -ip
      c4:	00001fbc 	streqh	r1, [r0], -ip
      c8:	40000200 	andmi	r0, r0, r0, lsl #4
      cc:	40000200 	andmi	r0, r0, r0, lsl #4
      d0:	40000200 	andmi	r0, r0, r0, lsl #4
      d4:	400006a8 	andmi	r0, r0, r8, lsr #13

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
     394:	eb000601 	bl	1ba0 <__umodsi3>
     398:	e1a03000 	mov	r3, r0
     39c:	e3530009 	cmp	r3, #9	; 0x9
     3a0:	c083300a 	addgt	r3, r3, sl
     3a4:	e2833030 	add	r3, r3, #48	; 0x30
     3a8:	e1a00004 	mov	r0, r4
     3ac:	e5653001 	strb	r3, [r5, #-1]!
     3b0:	e1a01006 	mov	r1, r6
     3b4:	eb0005b5 	bl	1a90 <__aeabi_uidiv>
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
     614:	00001d58 	andeq	r1, r0, r8, asr sp

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
     7a0:	40000204 	andmi	r0, r0, r4, lsl #4
     7a4:	40000200 	andmi	r0, r0, r0, lsl #4

000007a8 <main>:
     7a8:	e59f20f4 	ldr	r2, [pc, #244]	; 8a4 <.text+0x8a4>
     7ac:	e59231a0 	ldr	r3, [r2, #416]
     7b0:	e3833001 	orr	r3, r3, #1	; 0x1
     7b4:	e92d40f0 	stmdb	sp!, {r4, r5, r6, r7, lr}
     7b8:	e58231a0 	str	r3, [r2, #416]
     7bc:	e59f60e4 	ldr	r6, [pc, #228]	; 8a8 <.text+0x8a8>
     7c0:	e5163fdf 	ldr	r3, [r6, #-4063]
     7c4:	e3833702 	orr	r3, r3, #524288	; 0x80000
     7c8:	e5063fdf 	str	r3, [r6, #-4063]
     7cc:	ebfffe79 	bl	1b8 <HalSysInit>
     7d0:	e3a0001a 	mov	r0, #26	; 0x1a
     7d4:	ebffffaa 	bl	684 <ConsoleInit>
     7d8:	e59f00cc 	ldr	r0, [pc, #204]	; 8ac <.text+0x8ac>
     7dc:	ebffffd1 	bl	728 <puts>
     7e0:	eb00048a 	bl	1a10 <USBInit>
     7e4:	e59f00c4 	ldr	r0, [pc, #196]	; 8b0 <.text+0x8b0>
     7e8:	eb00037e 	bl	15e8 <USBRegisterDescriptors>
     7ec:	e59f20c0 	ldr	r2, [pc, #192]	; 8b4 <.text+0x8b4>
     7f0:	e3a00001 	mov	r0, #1	; 0x1
     7f4:	e59f10bc 	ldr	r1, [pc, #188]	; 8b8 <.text+0x8b8>
     7f8:	eb0002a6 	bl	1298 <USBRegisterRequestHandler>
     7fc:	e3a01000 	mov	r1, #0	; 0x0
     800:	e3a00081 	mov	r0, #129	; 0x81
     804:	eb00027b 	bl	11f8 <USBHwRegisterEPIntHandler>
     808:	e59f00ac 	ldr	r0, [pc, #172]	; 8bc <.text+0x8bc>
     80c:	eb000263 	bl	11a0 <USBHwRegisterFrameHandler>
     810:	e59f00a8 	ldr	r0, [pc, #168]	; 8c0 <.text+0x8c0>
     814:	eb00026c 	bl	11cc <USBHwRegisterDevIntHandler>
     818:	e59f30a4 	ldr	r3, [pc, #164]	; 8c4 <.text+0x8c4>
     81c:	e3a07000 	mov	r7, #0	; 0x0
     820:	e5837000 	str	r7, [r3]
     824:	e59f009c 	ldr	r0, [pc, #156]	; 8c8 <.text+0x8c8>
     828:	ebffffbe 	bl	728 <puts>
     82c:	e59f0098 	ldr	r0, [pc, #152]	; 8cc <.text+0x8cc>
     830:	ebffffbc 	bl	728 <puts>
     834:	e59f3094 	ldr	r3, [pc, #148]	; 8d0 <.text+0x8d0>
     838:	e3e04000 	mvn	r4, #0	; 0x0
     83c:	e3a05001 	mov	r5, #1	; 0x1
     840:	e5045da7 	str	r5, [r4, #-3495]
     844:	e59f0088 	ldr	r0, [pc, #136]	; 8d4 <.text+0x8d4>
     848:	e5043ea7 	str	r3, [r4, #-3751]
     84c:	ebffffb5 	bl	728 <puts>
     850:	e5143ff3 	ldr	r3, [r4, #-4083]
     854:	e3c33501 	bic	r3, r3, #4194304	; 0x400000
     858:	e5043ff3 	str	r3, [r4, #-4083]
     85c:	e5143fef 	ldr	r3, [r4, #-4079]
     860:	e3833501 	orr	r3, r3, #4194304	; 0x400000
     864:	e5043fef 	str	r3, [r4, #-4079]
     868:	eb000069 	bl	a14 <enableIRQ>
     86c:	e1a00005 	mov	r0, r5
     870:	eb0000b6 	bl	b50 <USBHwConnect>
     874:	e59f005c 	ldr	r0, [pc, #92]	; 8d8 <.text+0x8d8>
     878:	e59f105c 	ldr	r1, [pc, #92]	; 8dc <.text+0x8dc>
     87c:	e3a03702 	mov	r3, #524288	; 0x80000
     880:	e1a02007 	mov	r2, r7
     884:	e2877001 	add	r7, r7, #1	; 0x1
     888:	e1570000 	cmp	r7, r0
     88c:	05063fc7 	streq	r3, [r6, #-4039]
     890:	0afffffb 	beq	884 <main+0xdc>
     894:	e1570001 	cmp	r7, r1
     898:	c1a07002 	movgt	r7, r2
     89c:	c5063fc3 	strgt	r3, [r6, #-4035]
     8a0:	eafffff7 	b	884 <main+0xdc>
     8a4:	e01fc000 	ands	ip, pc, r0
     8a8:	3fffcfff 	svccc	0x00ffcfff
     8ac:	00001d60 	andeq	r1, r0, r0, ror #26
     8b0:	00001c70 	andeq	r1, r0, r0, ror ip
     8b4:	4000020c 	andmi	r0, r0, ip, lsl #4
     8b8:	0000075c 	andeq	r0, r0, ip, asr r7
     8bc:	0000090c 	andeq	r0, r0, ip, lsl #18
     8c0:	00000764 	andeq	r0, r0, r4, ror #14
     8c4:	400006a4 	andmi	r0, r0, r4, lsr #13
     8c8:	00001d78 	andeq	r1, r0, r8, ror sp
     8cc:	00001d94 	muleq	r0, r4, sp
     8d0:	000008e0 	andeq	r0, r0, r0, ror #17
     8d4:	00001d9c 	muleq	r0, ip, sp
     8d8:	00030d40 	andeq	r0, r3, r0, asr #26
     8dc:	00061a7f 	andeq	r1, r6, pc, ror sl

000008e0 <USBIntHandler>:
     8e0:	e24ee004 	sub	lr, lr, #4	; 0x4
     8e4:	e92d41ff 	stmdb	sp!, {r0, r1, r2, r3, r4, r5, r6, r7, r8, lr}
     8e8:	e14f1000 	mrs	r1, SPSR
     8ec:	e92d0002 	stmdb	sp!, {r1}
     8f0:	eb00012c 	bl	da8 <USBHwISR>
     8f4:	e3a02000 	mov	r2, #0	; 0x0
     8f8:	e3e03000 	mvn	r3, #0	; 0x0
     8fc:	e50320ff 	str	r2, [r3, #-255]
     900:	e8bd0002 	ldmia	sp!, {r1}
     904:	e161f001 	msr	SPSR_c, r1
     908:	e8fd81ff 	ldmia	sp!, {r0, r1, r2, r3, r4, r5, r6, r7, r8, pc}^

0000090c <USBFrameHandler>:
     90c:	e59f3084 	ldr	r3, [pc, #132]	; 998 <.text+0x998>
     910:	e5933000 	ldr	r3, [r3]
     914:	e3530000 	cmp	r3, #0	; 0x0
     918:	e92d4010 	stmdb	sp!, {r4, lr}
     91c:	08bd8010 	ldmeqia	sp!, {r4, pc}
     920:	e59f2074 	ldr	r2, [pc, #116]	; 99c <.text+0x99c>
     924:	e5923000 	ldr	r3, [r2]
     928:	e3530efa 	cmp	r3, #4000	; 0xfa0
     92c:	b2833001 	addlt	r3, r3, #1	; 0x1
     930:	b5823000 	strlt	r3, [r2]
     934:	b8bd8010 	ldmltia	sp!, {r4, pc}
     938:	e59fc060 	ldr	ip, [pc, #96]	; 9a0 <.text+0x9a0>
     93c:	e59c3000 	ldr	r3, [ip]
     940:	e59f405c 	ldr	r4, [pc, #92]	; 9a4 <.text+0x9a4>
     944:	e2833001 	add	r3, r3, #1	; 0x1
     948:	e1a0100c 	mov	r1, ip
     94c:	e3a02004 	mov	r2, #4	; 0x4
     950:	e3a00083 	mov	r0, #131	; 0x83
     954:	e58c3000 	str	r3, [ip]
     958:	eb00009b 	bl	bcc <USBHwEPWrite>
     95c:	e3a00006 	mov	r0, #6	; 0x6
     960:	e1a01004 	mov	r1, r4
     964:	e3a02b01 	mov	r2, #1024	; 0x400
     968:	eb0000e1 	bl	cf4 <USBHwISOCEPRead>
     96c:	e3500000 	cmp	r0, #0	; 0x0
     970:	d8bd8010 	ldmleia	sp!, {r4, pc}
     974:	e5d43000 	ldrb	r3, [r4]
     978:	e3530000 	cmp	r3, #0	; 0x0
     97c:	159f3024 	ldrne	r3, [pc, #36]	; 9a8 <.text+0x9a8>
     980:	059f3020 	ldreq	r3, [pc, #32]	; 9a8 <.text+0x9a8>
     984:	13a02702 	movne	r2, #524288	; 0x80000
     988:	03a02702 	moveq	r2, #524288	; 0x80000
     98c:	15032fc7 	strne	r2, [r3, #-4039]
     990:	05032fc3 	streq	r2, [r3, #-4035]
     994:	e8bd8010 	ldmia	sp!, {r4, pc}
     998:	40000200 	andmi	r0, r0, r0, lsl #4
     99c:	40000208 	andmi	r0, r0, r8, lsl #4
     9a0:	400006a4 	andmi	r0, r0, r4, lsr #13
     9a4:	400002a4 	andmi	r0, r0, r4, lsr #5
     9a8:	3fffcfff 	svccc	0x00ffcfff

000009ac <restoreIRQ>:
     9ac:	e10f2000 	mrs	r2, CPSR
     9b0:	e2000080 	and	r0, r0, #128	; 0x80
     9b4:	e3c23080 	bic	r3, r2, #128	; 0x80
     9b8:	e1833000 	orr	r3, r3, r0
     9bc:	e129f003 	msr	CPSR_fc, r3
     9c0:	e1a00002 	mov	r0, r2
     9c4:	e12fff1e 	bx	lr

000009c8 <restoreFIQ>:
     9c8:	e10f2000 	mrs	r2, CPSR
     9cc:	e2000040 	and	r0, r0, #64	; 0x40
     9d0:	e3c23040 	bic	r3, r2, #64	; 0x40
     9d4:	e1833000 	orr	r3, r3, r0
     9d8:	e129f003 	msr	CPSR_fc, r3
     9dc:	e1a00002 	mov	r0, r2
     9e0:	e12fff1e 	bx	lr

000009e4 <disableFIQ>:
     9e4:	e10f0000 	mrs	r0, CPSR
     9e8:	e3803040 	orr	r3, r0, #64	; 0x40
     9ec:	e129f003 	msr	CPSR_fc, r3
     9f0:	e12fff1e 	bx	lr

000009f4 <enableFIQ>:
     9f4:	e10f0000 	mrs	r0, CPSR
     9f8:	e3c03040 	bic	r3, r0, #64	; 0x40
     9fc:	e129f003 	msr	CPSR_fc, r3
     a00:	e12fff1e 	bx	lr

00000a04 <disableIRQ>:
     a04:	e10f0000 	mrs	r0, CPSR
     a08:	e3803080 	orr	r3, r0, #128	; 0x80
     a0c:	e129f003 	msr	CPSR_fc, r3
     a10:	e12fff1e 	bx	lr

00000a14 <enableIRQ>:
     a14:	e10f0000 	mrs	r0, CPSR
     a18:	e3c03080 	bic	r3, r0, #128	; 0x80
     a1c:	e129f003 	msr	CPSR_fc, r3
     a20:	e12fff1e 	bx	lr

00000a24 <USBHwCmd>:
     a24:	e1a00800 	mov	r0, r0, lsl #16
     a28:	e59f2028 	ldr	r2, [pc, #40]	; a58 <.text+0xa58>
     a2c:	e20008ff 	and	r0, r0, #16711680	; 0xff0000
     a30:	e3800c05 	orr	r0, r0, #1280	; 0x500
     a34:	e3a03030 	mov	r3, #48	; 0x30
     a38:	e5023df7 	str	r3, [r2, #-3575]
     a3c:	e5020def 	str	r0, [r2, #-3567]
     a40:	e5123dff 	ldr	r3, [r2, #-3583]
     a44:	e2033010 	and	r3, r3, #16	; 0x10
     a48:	e3530010 	cmp	r3, #16	; 0x10
     a4c:	1afffffb 	bne	a40 <USBHwCmd+0x1c>
     a50:	e5023df7 	str	r3, [r2, #-3575]
     a54:	e12fff1e 	bx	lr
     a58:	ffe0cfff 	undefined instruction 0xffe0cfff

00000a5c <USBHwCmdWrite>:
     a5c:	e92d4010 	stmdb	sp!, {r4, lr}
     a60:	e1a04801 	mov	r4, r1, lsl #16
     a64:	e20000ff 	and	r0, r0, #255	; 0xff
     a68:	e1a04824 	mov	r4, r4, lsr #16
     a6c:	ebffffec 	bl	a24 <USBHwCmd>
     a70:	e1a04804 	mov	r4, r4, lsl #16
     a74:	e59f3020 	ldr	r3, [pc, #32]	; a9c <.text+0xa9c>
     a78:	e3844c01 	orr	r4, r4, #256	; 0x100
     a7c:	e5034def 	str	r4, [r3, #-3567]
     a80:	e1a02003 	mov	r2, r3
     a84:	e5123dff 	ldr	r3, [r2, #-3583]
     a88:	e2033010 	and	r3, r3, #16	; 0x10
     a8c:	e3530010 	cmp	r3, #16	; 0x10
     a90:	1afffffb 	bne	a84 <USBHwCmdWrite+0x28>
     a94:	e5023df7 	str	r3, [r2, #-3575]
     a98:	e8bd8010 	ldmia	sp!, {r4, pc}
     a9c:	ffe0cfff 	undefined instruction 0xffe0cfff

00000aa0 <USBHwCmdRead>:
     aa0:	e92d4010 	stmdb	sp!, {r4, lr}
     aa4:	e20040ff 	and	r4, r0, #255	; 0xff
     aa8:	e1a00004 	mov	r0, r4
     aac:	ebffffdc 	bl	a24 <USBHwCmd>
     ab0:	e1a04804 	mov	r4, r4, lsl #16
     ab4:	e59f3028 	ldr	r3, [pc, #40]	; ae4 <.text+0xae4>
     ab8:	e3844c02 	orr	r4, r4, #512	; 0x200
     abc:	e5034def 	str	r4, [r3, #-3567]
     ac0:	e1a02003 	mov	r2, r3
     ac4:	e5123dff 	ldr	r3, [r2, #-3583]
     ac8:	e2033020 	and	r3, r3, #32	; 0x20
     acc:	e3530020 	cmp	r3, #32	; 0x20
     ad0:	1afffffb 	bne	ac4 <USBHwCmdRead+0x24>
     ad4:	e5023df7 	str	r3, [r2, #-3575]
     ad8:	e5120deb 	ldr	r0, [r2, #-3563]
     adc:	e20000ff 	and	r0, r0, #255	; 0xff
     ae0:	e8bd8010 	ldmia	sp!, {r4, pc}
     ae4:	ffe0cfff 	undefined instruction 0xffe0cfff

00000ae8 <USBHwEPConfig>:
     ae8:	e59fc04c 	ldr	ip, [pc, #76]	; b3c <.text+0xb3c>
     aec:	e200300f 	and	r3, r0, #15	; 0xf
     af0:	e51c2dbb 	ldr	r2, [ip, #-3515]
     af4:	e1a03083 	mov	r3, r3, lsl #1
     af8:	e2000080 	and	r0, r0, #128	; 0x80
     afc:	e18303a0 	orr	r0, r3, r0, lsr #7
     b00:	e3a03001 	mov	r3, #1	; 0x1
     b04:	e1822013 	orr	r2, r2, r3, lsl r0
     b08:	e1a01801 	mov	r1, r1, lsl #16
     b0c:	e1a01821 	mov	r1, r1, lsr #16
     b10:	e50c2dbb 	str	r2, [ip, #-3515]
     b14:	e50c0db7 	str	r0, [ip, #-3511]
     b18:	e50c1db3 	str	r1, [ip, #-3507]
     b1c:	e51c3dff 	ldr	r3, [ip, #-3583]
     b20:	e2033c01 	and	r3, r3, #256	; 0x100
     b24:	e3530c01 	cmp	r3, #256	; 0x100
     b28:	1afffffb 	bne	b1c <USBHwEPConfig+0x34>
     b2c:	e3800040 	orr	r0, r0, #64	; 0x40
     b30:	e3a01000 	mov	r1, #0	; 0x0
     b34:	e50c3df7 	str	r3, [ip, #-3575]
     b38:	eaffffc7 	b	a5c <USBHwCmdWrite>
     b3c:	ffe0cfff 	undefined instruction 0xffe0cfff

00000b40 <USBHwSetAddress>:
     b40:	e200107f 	and	r1, r0, #127	; 0x7f
     b44:	e3811080 	orr	r1, r1, #128	; 0x80
     b48:	e3a000d0 	mov	r0, #208	; 0xd0
     b4c:	eaffffc2 	b	a5c <USBHwCmdWrite>

00000b50 <USBHwConnect>:
     b50:	e3500000 	cmp	r0, #0	; 0x0
     b54:	159f3020 	ldrne	r3, [pc, #32]	; b7c <.text+0xb7c>
     b58:	059f301c 	ldreq	r3, [pc, #28]	; b7c <.text+0xb7c>
     b5c:	13a02901 	movne	r2, #16384	; 0x4000
     b60:	03a02901 	moveq	r2, #16384	; 0x4000
     b64:	15032fe3 	strne	r2, [r3, #-4067]
     b68:	05032fe7 	streq	r2, [r3, #-4071]
     b6c:	e2501000 	subs	r1, r0, #0	; 0x0
     b70:	13a01001 	movne	r1, #1	; 0x1
     b74:	e3a000fe 	mov	r0, #254	; 0xfe
     b78:	eaffffb7 	b	a5c <USBHwCmdWrite>
     b7c:	3fffcfff 	svccc	0x00ffcfff

00000b80 <USBHwNakIntEnable>:
     b80:	e20010ff 	and	r1, r0, #255	; 0xff
     b84:	e3a000f3 	mov	r0, #243	; 0xf3
     b88:	eaffffb3 	b	a5c <USBHwCmdWrite>

00000b8c <USBHwEPGetStatus>:
     b8c:	e1a03000 	mov	r3, r0
     b90:	e200000f 	and	r0, r0, #15	; 0xf
     b94:	e2033080 	and	r3, r3, #128	; 0x80
     b98:	e1a00080 	mov	r0, r0, lsl #1
     b9c:	e52de004 	str	lr, [sp, #-4]!
     ba0:	e18003a3 	orr	r0, r0, r3, lsr #7
     ba4:	ebffffbd 	bl	aa0 <USBHwCmdRead>
     ba8:	e49df004 	ldr	pc, [sp], #4

00000bac <USBHwEPStall>:
     bac:	e200300f 	and	r3, r0, #15	; 0xf
     bb0:	e1a03083 	mov	r3, r3, lsl #1
     bb4:	e2000080 	and	r0, r0, #128	; 0x80
     bb8:	e18333a0 	orr	r3, r3, r0, lsr #7
     bbc:	e2511000 	subs	r1, r1, #0	; 0x0
     bc0:	13a01001 	movne	r1, #1	; 0x1
     bc4:	e3830040 	orr	r0, r3, #64	; 0x40
     bc8:	eaffffa3 	b	a5c <USBHwCmdWrite>

00000bcc <USBHwEPWrite>:
     bcc:	e92d40f0 	stmdb	sp!, {r4, r5, r6, r7, lr}
     bd0:	e59fc07c 	ldr	ip, [pc, #124]	; c54 <.text+0xc54>
     bd4:	e200500f 	and	r5, r0, #15	; 0xf
     bd8:	e1a03105 	mov	r3, r5, lsl #2
     bdc:	e3833002 	orr	r3, r3, #2	; 0x2
     be0:	e1a06002 	mov	r6, r2
     be4:	e1a0e001 	mov	lr, r1
     be8:	e1a0400c 	mov	r4, ip
     bec:	e20070ff 	and	r7, r0, #255	; 0xff
     bf0:	e50c3dd7 	str	r3, [ip, #-3543]
     bf4:	e50c2ddb 	str	r2, [ip, #-3547]
     bf8:	ea000008 	b	c20 <USBHwEPWrite+0x54>
     bfc:	e55e3002 	ldrb	r3, [lr, #-2]
     c00:	e55e2001 	ldrb	r2, [lr, #-1]
     c04:	e55e1004 	ldrb	r1, [lr, #-4]
     c08:	e1a03803 	mov	r3, r3, lsl #16
     c0c:	e1833c02 	orr	r3, r3, r2, lsl #24
     c10:	e55e2003 	ldrb	r2, [lr, #-3]
     c14:	e1833001 	orr	r3, r3, r1
     c18:	e1833402 	orr	r3, r3, r2, lsl #8
     c1c:	e5003de3 	str	r3, [r0, #-3555]
     c20:	e5143dd7 	ldr	r3, [r4, #-3543]
     c24:	e2133002 	ands	r3, r3, #2	; 0x2
     c28:	e28ee004 	add	lr, lr, #4	; 0x4
     c2c:	e1a00004 	mov	r0, r4
     c30:	1afffff1 	bne	bfc <USBHwEPWrite+0x30>
     c34:	e1a00085 	mov	r0, r5, lsl #1
     c38:	e18003a7 	orr	r0, r0, r7, lsr #7
     c3c:	e5043dd7 	str	r3, [r4, #-3543]
     c40:	ebffff77 	bl	a24 <USBHwCmd>
     c44:	e3a000fa 	mov	r0, #250	; 0xfa
     c48:	ebffff75 	bl	a24 <USBHwCmd>
     c4c:	e1a00006 	mov	r0, r6
     c50:	e8bd80f0 	ldmia	sp!, {r4, r5, r6, r7, pc}
     c54:	ffe0cfff 	undefined instruction 0xffe0cfff

00000c58 <USBHwEPRead>:
     c58:	e92d4030 	stmdb	sp!, {r4, r5, lr}
     c5c:	e200e00f 	and	lr, r0, #15	; 0xf
     c60:	e59fc088 	ldr	ip, [pc, #136]	; cf0 <.text+0xcf0>
     c64:	e1a0310e 	mov	r3, lr, lsl #2
     c68:	e3833001 	orr	r3, r3, #1	; 0x1
     c6c:	e50c3dd7 	str	r3, [ip, #-3543]
     c70:	e20050ff 	and	r5, r0, #255	; 0xff
     c74:	e51c3ddf 	ldr	r3, [ip, #-3551]
     c78:	e3130b02 	tst	r3, #2048	; 0x800
     c7c:	0afffffc 	beq	c74 <USBHwEPRead+0x1c>
     c80:	e3130b01 	tst	r3, #1024	; 0x400
     c84:	03e04000 	mvneq	r4, #0	; 0x0
     c88:	0a000016 	beq	ce8 <USBHwEPRead+0x90>
     c8c:	e1a03b03 	mov	r3, r3, lsl #22
     c90:	e3a04000 	mov	r4, #0	; 0x0
     c94:	e59fc054 	ldr	ip, [pc, #84]	; cf0 <.text+0xcf0>
     c98:	e1a03b23 	mov	r3, r3, lsr #22
     c9c:	e1a00004 	mov	r0, r4
     ca0:	ea000006 	b	cc0 <USBHwEPRead+0x68>
     ca4:	e3140003 	tst	r4, #3	; 0x3
     ca8:	051c0de7 	ldreq	r0, [ip, #-3559]
     cac:	e3510000 	cmp	r1, #0	; 0x0
     cb0:	11540002 	cmpne	r4, r2
     cb4:	b7c40001 	strltb	r0, [r4, r1]
     cb8:	e2844001 	add	r4, r4, #1	; 0x1
     cbc:	e1a00420 	mov	r0, r0, lsr #8
     cc0:	e1540003 	cmp	r4, r3
     cc4:	1afffff6 	bne	ca4 <USBHwEPRead+0x4c>
     cc8:	e59f3020 	ldr	r3, [pc, #32]	; cf0 <.text+0xcf0>
     ccc:	e1a0008e 	mov	r0, lr, lsl #1
     cd0:	e3a02000 	mov	r2, #0	; 0x0
     cd4:	e18003a5 	orr	r0, r0, r5, lsr #7
     cd8:	e5032dd7 	str	r2, [r3, #-3543]
     cdc:	ebffff50 	bl	a24 <USBHwCmd>
     ce0:	e3a000f2 	mov	r0, #242	; 0xf2
     ce4:	ebffff4e 	bl	a24 <USBHwCmd>
     ce8:	e1a00004 	mov	r0, r4
     cec:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
     cf0:	ffe0cfff 	undefined instruction 0xffe0cfff

00000cf4 <USBHwISOCEPRead>:
     cf4:	e92d4030 	stmdb	sp!, {r4, r5, lr}
     cf8:	e200e00f 	and	lr, r0, #15	; 0xf
     cfc:	e1a0310e 	mov	r3, lr, lsl #2
     d00:	e59fc08c 	ldr	ip, [pc, #140]	; d94 <.text+0xd94>
     d04:	e3833001 	orr	r3, r3, #1	; 0x1
     d08:	e50c3dd7 	str	r3, [ip, #-3543]
     d0c:	e20050ff 	and	r5, r0, #255	; 0xff
     d10:	e1a00000 	nop			(mov r0,r0)
     d14:	e51c3ddf 	ldr	r3, [ip, #-3551]
     d18:	e2130b02 	ands	r0, r3, #2048	; 0x800
     d1c:	0a000001 	beq	d28 <USBHwISOCEPRead+0x34>
     d20:	e2130b01 	ands	r0, r3, #1024	; 0x400
     d24:	1a000002 	bne	d34 <USBHwISOCEPRead+0x40>
     d28:	e3e04000 	mvn	r4, #0	; 0x0
     d2c:	e50c0dd7 	str	r0, [ip, #-3543]
     d30:	ea000015 	b	d8c <USBHwISOCEPRead+0x98>
     d34:	e1a03b03 	mov	r3, r3, lsl #22
     d38:	e3a04000 	mov	r4, #0	; 0x0
     d3c:	e1a03b23 	mov	r3, r3, lsr #22
     d40:	e1a00004 	mov	r0, r4
     d44:	ea000006 	b	d64 <USBHwISOCEPRead+0x70>
     d48:	e3140003 	tst	r4, #3	; 0x3
     d4c:	051c0de7 	ldreq	r0, [ip, #-3559]
     d50:	e3510000 	cmp	r1, #0	; 0x0
     d54:	11540002 	cmpne	r4, r2
     d58:	b7c40001 	strltb	r0, [r4, r1]
     d5c:	e2844001 	add	r4, r4, #1	; 0x1
     d60:	e1a00420 	mov	r0, r0, lsr #8
     d64:	e1540003 	cmp	r4, r3
     d68:	1afffff6 	bne	d48 <USBHwISOCEPRead+0x54>
     d6c:	e59f3020 	ldr	r3, [pc, #32]	; d94 <.text+0xd94>
     d70:	e1a0008e 	mov	r0, lr, lsl #1
     d74:	e3a02000 	mov	r2, #0	; 0x0
     d78:	e18003a5 	orr	r0, r0, r5, lsr #7
     d7c:	e5032dd7 	str	r2, [r3, #-3543]
     d80:	ebffff27 	bl	a24 <USBHwCmd>
     d84:	e3a000f2 	mov	r0, #242	; 0xf2
     d88:	ebffff25 	bl	a24 <USBHwCmd>
     d8c:	e1a00004 	mov	r0, r4
     d90:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
     d94:	ffe0cfff 	undefined instruction 0xffe0cfff

00000d98 <USBHwConfigDevice>:
     d98:	e2501000 	subs	r1, r0, #0	; 0x0
     d9c:	13a01001 	movne	r1, #1	; 0x1
     da0:	e3a000d8 	mov	r0, #216	; 0xd8
     da4:	eaffff2c 	b	a5c <USBHwCmdWrite>

00000da8 <USBHwISR>:
     da8:	e59f3144 	ldr	r3, [pc, #324]	; ef4 <.text+0xef4>
     dac:	e3a02002 	mov	r2, #2	; 0x2
     db0:	e5032fa7 	str	r2, [r3, #-4007]
     db4:	e59f213c 	ldr	r2, [pc, #316]	; ef8 <.text+0xef8>
     db8:	e92d45f0 	stmdb	sp!, {r4, r5, r6, r7, r8, sl, lr}
     dbc:	e5126dff 	ldr	r6, [r2, #-3583]
     dc0:	e3160001 	tst	r6, #1	; 0x1
     dc4:	0a00000b 	beq	df8 <USBHwISR+0x50>
     dc8:	e59f312c 	ldr	r3, [pc, #300]	; efc <.text+0xefc>
     dcc:	e5934000 	ldr	r4, [r3]
     dd0:	e3a03001 	mov	r3, #1	; 0x1
     dd4:	e3540000 	cmp	r4, #0	; 0x0
     dd8:	e5023df7 	str	r3, [r2, #-3575]
     ddc:	0a000005 	beq	df8 <USBHwISR+0x50>
     de0:	e3a000f5 	mov	r0, #245	; 0xf5
     de4:	ebffff2d 	bl	aa0 <USBHwCmdRead>
     de8:	e1a00800 	mov	r0, r0, lsl #16
     dec:	e1a00820 	mov	r0, r0, lsr #16
     df0:	e1a0e00f 	mov	lr, pc
     df4:	e12fff14 	bx	r4
     df8:	e3160008 	tst	r6, #8	; 0x8
     dfc:	0a000011 	beq	e48 <USBHwISR+0xa0>
     e00:	e59f30f0 	ldr	r3, [pc, #240]	; ef8 <.text+0xef8>
     e04:	e3a02008 	mov	r2, #8	; 0x8
     e08:	e3a000fe 	mov	r0, #254	; 0xfe
     e0c:	e5032df7 	str	r2, [r3, #-3575]
     e10:	ebffff22 	bl	aa0 <USBHwCmdRead>
     e14:	e310001a 	tst	r0, #26	; 0x1a
     e18:	0a00000a 	beq	e48 <USBHwISR+0xa0>
     e1c:	e59f30dc 	ldr	r3, [pc, #220]	; f00 <.text+0xf00>
     e20:	e5933000 	ldr	r3, [r3]
     e24:	e3530000 	cmp	r3, #0	; 0x0
     e28:	0a000006 	beq	e48 <USBHwISR+0xa0>
     e2c:	e59f50c0 	ldr	r5, [pc, #192]	; ef4 <.text+0xef4>
     e30:	e3a04001 	mov	r4, #1	; 0x1
     e34:	e5054fa7 	str	r4, [r5, #-4007]
     e38:	e2000015 	and	r0, r0, #21	; 0x15
     e3c:	e1a0e00f 	mov	lr, pc
     e40:	e12fff13 	bx	r3
     e44:	e5054fa3 	str	r4, [r5, #-4003]
     e48:	e3160004 	tst	r6, #4	; 0x4
     e4c:	0a000024 	beq	ee4 <USBHwISR+0x13c>
     e50:	e59f30a0 	ldr	r3, [pc, #160]	; ef8 <.text+0xef8>
     e54:	e3a02004 	mov	r2, #4	; 0x4
     e58:	e5032df7 	str	r2, [r3, #-3575]
     e5c:	e59fa0a0 	ldr	sl, [pc, #160]	; f04 <.text+0xf04>
     e60:	e59f708c 	ldr	r7, [pc, #140]	; ef4 <.text+0xef4>
     e64:	e1a05003 	mov	r5, r3
     e68:	e1a06002 	mov	r6, r2
     e6c:	e3a04000 	mov	r4, #0	; 0x0
     e70:	e3a08001 	mov	r8, #1	; 0x1
     e74:	e1a02418 	mov	r2, r8, lsl r4
     e78:	e5153dcf 	ldr	r3, [r5, #-3535]
     e7c:	e1120003 	tst	r2, r3
     e80:	0a000014 	beq	ed8 <USBHwISR+0x130>
     e84:	e5052dc7 	str	r2, [r5, #-3527]
     e88:	e5153dff 	ldr	r3, [r5, #-3583]
     e8c:	e2032020 	and	r2, r3, #32	; 0x20
     e90:	e3520020 	cmp	r2, #32	; 0x20
     e94:	1afffffb 	bne	e88 <USBHwISR+0xe0>
     e98:	e0843fa4 	add	r3, r4, r4, lsr #31
     e9c:	e1a030c3 	mov	r3, r3, asr #1
     ea0:	e79a3103 	ldr	r3, [sl, r3, lsl #2]
     ea4:	e5052df7 	str	r2, [r5, #-3575]
     ea8:	e3530000 	cmp	r3, #0	; 0x0
     eac:	e5151deb 	ldr	r1, [r5, #-3563]
     eb0:	0a000008 	beq	ed8 <USBHwISR+0x130>
     eb4:	e1a000c4 	mov	r0, r4, asr #1
     eb8:	e200000f 	and	r0, r0, #15	; 0xf
     ebc:	e1800384 	orr	r0, r0, r4, lsl #7
     ec0:	e5076fa7 	str	r6, [r7, #-4007]
     ec4:	e200008f 	and	r0, r0, #143	; 0x8f
     ec8:	e201101f 	and	r1, r1, #31	; 0x1f
     ecc:	e1a0e00f 	mov	lr, pc
     ed0:	e12fff13 	bx	r3
     ed4:	e5076fa3 	str	r6, [r7, #-4003]
     ed8:	e2844001 	add	r4, r4, #1	; 0x1
     edc:	e3540020 	cmp	r4, #32	; 0x20
     ee0:	1affffe3 	bne	e74 <USBHwISR+0xcc>
     ee4:	e59f3008 	ldr	r3, [pc, #8]	; ef4 <.text+0xef4>
     ee8:	e3a02002 	mov	r2, #2	; 0x2
     eec:	e5032fa3 	str	r2, [r3, #-4003]
     ef0:	e8bd85f0 	ldmia	sp!, {r4, r5, r6, r7, r8, sl, pc}
     ef4:	3fffcfff 	svccc	0x00ffcfff
     ef8:	ffe0cfff 	undefined instruction 0xffe0cfff
     efc:	40000214 	andmi	r0, r0, r4, lsl r2
     f00:	40000218 	andmi	r0, r0, r8, lsl r2
     f04:	4000021c 	andmi	r0, r0, ip, lsl r2

00000f08 <USBHwInit>:
     f08:	e59f2124 	ldr	r2, [pc, #292]	; 1034 <.text+0x1034>
     f0c:	e5923004 	ldr	r3, [r2, #4]
     f10:	e3c33103 	bic	r3, r3, #-1073741824	; 0xc0000000
     f14:	e3833101 	orr	r3, r3, #1073741824	; 0x40000000
     f18:	e5823004 	str	r3, [r2, #4]
     f1c:	e592300c 	ldr	r3, [r2, #12]
     f20:	e3c33203 	bic	r3, r3, #805306368	; 0x30000000
     f24:	e3833202 	orr	r3, r3, #536870912	; 0x20000000
     f28:	e582300c 	str	r3, [r2, #12]
     f2c:	e5923000 	ldr	r3, [r2]
     f30:	e3c3330f 	bic	r3, r3, #1006632960	; 0x3c000000
     f34:	e3833301 	orr	r3, r3, #67108864	; 0x4000000
     f38:	e5823000 	str	r3, [r2]
     f3c:	e59f20f4 	ldr	r2, [pc, #244]	; 1038 <.text+0x1038>
     f40:	e5123fff 	ldr	r3, [r2, #-4095]
     f44:	e3833901 	orr	r3, r3, #16384	; 0x4000
     f48:	e5023fff 	str	r3, [r2, #-4095]
     f4c:	e3a03901 	mov	r3, #16384	; 0x4000
     f50:	e5023fe7 	str	r3, [r2, #-4071]
     f54:	e59f20e0 	ldr	r2, [pc, #224]	; 103c <.text+0x103c>
     f58:	e59230c4 	ldr	r3, [r2, #196]
     f5c:	e92d4010 	stmdb	sp!, {r4, lr}
     f60:	e3833102 	orr	r3, r3, #-2147483648	; 0x80000000
     f64:	e58230c4 	str	r3, [r2, #196]
     f68:	e59f10d0 	ldr	r1, [pc, #208]	; 1040 <.text+0x1040>
     f6c:	e3a03005 	mov	r3, #5	; 0x5
     f70:	e5823108 	str	r3, [r2, #264]
     f74:	e2833015 	add	r3, r3, #21	; 0x15
     f78:	e501300b 	str	r3, [r1, #-11]
     f7c:	e5113007 	ldr	r3, [r1, #-7]
     f80:	e313001a 	tst	r3, #26	; 0x1a
     f84:	0afffffc 	beq	f7c <USBHwInit+0x74>
     f88:	e3a04000 	mov	r4, #0	; 0x0
     f8c:	e3e02000 	mvn	r2, #0	; 0x0
     f90:	e3a03003 	mov	r3, #3	; 0x3
     f94:	e5013eef 	str	r3, [r1, #-3823]
     f98:	e1a00004 	mov	r0, r4
     f9c:	e5014dfb 	str	r4, [r1, #-3579]
     fa0:	e5012df7 	str	r2, [r1, #-3575]
     fa4:	e5014dd3 	str	r4, [r1, #-3539]
     fa8:	e5014dcb 	str	r4, [r1, #-3531]
     fac:	e5012dc7 	str	r2, [r1, #-3527]
     fb0:	e5014dbf 	str	r4, [r1, #-3519]
     fb4:	ebfffef1 	bl	b80 <USBHwNakIntEnable>
     fb8:	e59f107c 	ldr	r1, [pc, #124]	; 103c <.text+0x103c>
     fbc:	e59131a0 	ldr	r3, [r1, #416]
     fc0:	e59fc06c 	ldr	ip, [pc, #108]	; 1034 <.text+0x1034>
     fc4:	e3833001 	orr	r3, r3, #1	; 0x1
     fc8:	e58131a0 	str	r3, [r1, #416]
     fcc:	e59f2064 	ldr	r2, [pc, #100]	; 1038 <.text+0x1038>
     fd0:	e58c4028 	str	r4, [ip, #40]
     fd4:	e5123fbf 	ldr	r3, [r2, #-4031]
     fd8:	e3a00001 	mov	r0, #1	; 0x1
     fdc:	e3833001 	orr	r3, r3, #1	; 0x1
     fe0:	e5023fbf 	str	r3, [r2, #-4031]
     fe4:	e5020fa3 	str	r0, [r2, #-4003]
     fe8:	e59131a0 	ldr	r3, [r1, #416]
     fec:	e1833000 	orr	r3, r3, r0
     ff0:	e58131a0 	str	r3, [r1, #416]
     ff4:	e58c4028 	str	r4, [ip, #40]
     ff8:	e5123fbf 	ldr	r3, [r2, #-4031]
     ffc:	e3833002 	orr	r3, r3, #2	; 0x2
    1000:	e5023fbf 	str	r3, [r2, #-4031]
    1004:	e3a03002 	mov	r3, #2	; 0x2
    1008:	e5023fa3 	str	r3, [r2, #-4003]
    100c:	e59131a0 	ldr	r3, [r1, #416]
    1010:	e1833000 	orr	r3, r3, r0
    1014:	e58131a0 	str	r3, [r1, #416]
    1018:	e58c4028 	str	r4, [ip, #40]
    101c:	e5123fbf 	ldr	r3, [r2, #-4031]
    1020:	e3833004 	orr	r3, r3, #4	; 0x4
    1024:	e5023fbf 	str	r3, [r2, #-4031]
    1028:	e3a03004 	mov	r3, #4	; 0x4
    102c:	e5023fa3 	str	r3, [r2, #-4003]
    1030:	e8bd8010 	ldmia	sp!, {r4, pc}
    1034:	e002c000 	and	ip, r2, r0
    1038:	3fffcfff 	svccc	0x00ffcfff
    103c:	e01fc000 	ands	ip, pc, r0
    1040:	ffe0cfff 	undefined instruction 0xffe0cfff

00001044 <USBSetupDMADescriptor>:
    1044:	e52de004 	str	lr, [sp, #-4]!
    1048:	e3a0e000 	mov	lr, #0	; 0x0
    104c:	e580e004 	str	lr, [r0, #4]
    1050:	e5801000 	str	r1, [r0]
    1054:	e1a0c001 	mov	ip, r1
    1058:	e1a03b03 	mov	r3, r3, lsl #22
    105c:	e5901004 	ldr	r1, [r0, #4]
    1060:	e1a03b23 	mov	r3, r3, lsr #22
    1064:	e1811283 	orr	r1, r1, r3, lsl #5
    1068:	e5801004 	str	r1, [r0, #4]
    106c:	e1dd10b4 	ldrh	r1, [sp, #4]
    1070:	e5903004 	ldr	r3, [r0, #4]
    1074:	e1833801 	orr	r3, r3, r1, lsl #16
    1078:	e5803004 	str	r3, [r0, #4]
    107c:	e21220ff 	ands	r2, r2, #255	; 0xff
    1080:	15903004 	ldrne	r3, [r0, #4]
    1084:	13833010 	orrne	r3, r3, #16	; 0x10
    1088:	15803004 	strne	r3, [r0, #4]
    108c:	e35c0000 	cmp	ip, #0	; 0x0
    1090:	15903004 	ldrne	r3, [r0, #4]
    1094:	e59d100c 	ldr	r1, [sp, #12]
    1098:	13833004 	orrne	r3, r3, #4	; 0x4
    109c:	15803004 	strne	r3, [r0, #4]
    10a0:	e59d3008 	ldr	r3, [sp, #8]
    10a4:	e3520000 	cmp	r2, #0	; 0x0
    10a8:	13510000 	cmpne	r1, #0	; 0x0
    10ac:	e5803008 	str	r3, [r0, #8]
    10b0:	15801010 	strne	r1, [r0, #16]
    10b4:	e580e00c 	str	lr, [r0, #12]
    10b8:	e49df004 	ldr	pc, [sp], #4

000010bc <USBDisableDMAForEndpoint>:
    10bc:	e200200f 	and	r2, r0, #15	; 0xf
    10c0:	e1a02082 	mov	r2, r2, lsl #1
    10c4:	e2000080 	and	r0, r0, #128	; 0x80
    10c8:	e18223a0 	orr	r2, r2, r0, lsr #7
    10cc:	e3a03001 	mov	r3, #1	; 0x1
    10d0:	e1a03213 	mov	r3, r3, lsl r2
    10d4:	e59f2004 	ldr	r2, [pc, #4]	; 10e0 <.text+0x10e0>
    10d8:	e5023d73 	str	r3, [r2, #-3443]
    10dc:	e12fff1e 	bx	lr
    10e0:	ffe0cfff 	undefined instruction 0xffe0cfff

000010e4 <USBEnableDMAForEndpoint>:
    10e4:	e200200f 	and	r2, r0, #15	; 0xf
    10e8:	e1a02082 	mov	r2, r2, lsl #1
    10ec:	e2000080 	and	r0, r0, #128	; 0x80
    10f0:	e18223a0 	orr	r2, r2, r0, lsr #7
    10f4:	e3a03001 	mov	r3, #1	; 0x1
    10f8:	e1a03213 	mov	r3, r3, lsl r2
    10fc:	e59f2004 	ldr	r2, [pc, #4]	; 1108 <.text+0x1108>
    1100:	e5023d77 	str	r3, [r2, #-3447]
    1104:	e12fff1e 	bx	lr
    1108:	ffe0cfff 	undefined instruction 0xffe0cfff

0000110c <USBInitializeISOCFrameArray>:
    110c:	e92d4030 	stmdb	sp!, {r4, r5, lr}
    1110:	e1a03b03 	mov	r3, r3, lsl #22
    1114:	e1a02802 	mov	r2, r2, lsl #16
    1118:	e1a03b23 	mov	r3, r3, lsr #22
    111c:	e1a05000 	mov	r5, r0
    1120:	e1a04001 	mov	r4, r1
    1124:	e1a0c822 	mov	ip, r2, lsr #16
    1128:	e3830902 	orr	r0, r3, #32768	; 0x8000
    112c:	e3a0e000 	mov	lr, #0	; 0x0
    1130:	ea000000 	b	1138 <USBInitializeISOCFrameArray+0x2c>
    1134:	e7851102 	str	r1, [r5, r2, lsl #2]
    1138:	e1a0280e 	mov	r2, lr, lsl #16
    113c:	e28c3001 	add	r3, ip, #1	; 0x1
    1140:	e1a02822 	mov	r2, r2, lsr #16
    1144:	e1a03803 	mov	r3, r3, lsl #16
    1148:	e1520004 	cmp	r2, r4
    114c:	e180180c 	orr	r1, r0, ip, lsl #16
    1150:	e28ee001 	add	lr, lr, #1	; 0x1
    1154:	e1a0c823 	mov	ip, r3, lsr #16
    1158:	3afffff5 	bcc	1134 <USBInitializeISOCFrameArray+0x28>
    115c:	e8bd8030 	ldmia	sp!, {r4, r5, pc}

00001160 <USBSetHeadDDForDMA>:
    1160:	e200300f 	and	r3, r0, #15	; 0xf
    1164:	e1a03083 	mov	r3, r3, lsl #1
    1168:	e2000080 	and	r0, r0, #128	; 0x80
    116c:	e18333a0 	orr	r3, r3, r0, lsr #7
    1170:	e7812103 	str	r2, [r1, r3, lsl #2]
    1174:	e12fff1e 	bx	lr

00001178 <USBInitializeUSBDMA>:
    1178:	e3a03000 	mov	r3, #0	; 0x0
    117c:	e1a02003 	mov	r2, r3
    1180:	e7832000 	str	r2, [r3, r0]
    1184:	e2833004 	add	r3, r3, #4	; 0x4
    1188:	e3530080 	cmp	r3, #128	; 0x80
    118c:	1afffffb 	bne	1180 <USBInitializeUSBDMA+0x8>
    1190:	e59f3004 	ldr	r3, [pc, #4]	; 119c <.text+0x119c>
    1194:	e5030d7f 	str	r0, [r3, #-3455]
    1198:	e12fff1e 	bx	lr
    119c:	ffe0cfff 	undefined instruction 0xffe0cfff

000011a0 <USBHwRegisterFrameHandler>:
    11a0:	e59f1018 	ldr	r1, [pc, #24]	; 11c0 <.text+0x11c0>
    11a4:	e59f3018 	ldr	r3, [pc, #24]	; 11c4 <.text+0x11c4>
    11a8:	e5112dfb 	ldr	r2, [r1, #-3579]
    11ac:	e5830000 	str	r0, [r3]
    11b0:	e59f0010 	ldr	r0, [pc, #16]	; 11c8 <.text+0x11c8>
    11b4:	e3822001 	orr	r2, r2, #1	; 0x1
    11b8:	e5012dfb 	str	r2, [r1, #-3579]
    11bc:	eafffd59 	b	728 <puts>
    11c0:	ffe0cfff 	undefined instruction 0xffe0cfff
    11c4:	40000214 	andmi	r0, r0, r4, lsl r2
    11c8:	00001db4 	streqh	r1, [r0], -r4

000011cc <USBHwRegisterDevIntHandler>:
    11cc:	e59f1018 	ldr	r1, [pc, #24]	; 11ec <.text+0x11ec>
    11d0:	e59f3018 	ldr	r3, [pc, #24]	; 11f0 <.text+0x11f0>
    11d4:	e5112dfb 	ldr	r2, [r1, #-3579]
    11d8:	e5830000 	str	r0, [r3]
    11dc:	e59f0010 	ldr	r0, [pc, #16]	; 11f4 <.text+0x11f4>
    11e0:	e3822008 	orr	r2, r2, #8	; 0x8
    11e4:	e5012dfb 	str	r2, [r1, #-3579]
    11e8:	eafffd4e 	b	728 <puts>
    11ec:	ffe0cfff 	undefined instruction 0xffe0cfff
    11f0:	40000218 	andmi	r0, r0, r8, lsl r2
    11f4:	00001dd4 	ldreqd	r1, [r0], -r4

000011f8 <USBHwRegisterEPIntHandler>:
    11f8:	e92d4010 	stmdb	sp!, {r4, lr}
    11fc:	e200300f 	and	r3, r0, #15	; 0xf
    1200:	e1a03083 	mov	r3, r3, lsl #1
    1204:	e2002080 	and	r2, r0, #128	; 0x80
    1208:	e183e3a2 	orr	lr, r3, r2, lsr #7
    120c:	e35e001f 	cmp	lr, #31	; 0x1f
    1210:	e1a04001 	mov	r4, r1
    1214:	e24dd004 	sub	sp, sp, #4	; 0x4
    1218:	e20010ff 	and	r1, r0, #255	; 0xff
    121c:	da000007 	ble	1240 <USBHwRegisterEPIntHandler+0x48>
    1220:	e3a0c0d2 	mov	ip, #210	; 0xd2
    1224:	e59f0050 	ldr	r0, [pc, #80]	; 127c <.text+0x127c>
    1228:	e59f1050 	ldr	r1, [pc, #80]	; 1280 <.text+0x1280>
    122c:	e59f2050 	ldr	r2, [pc, #80]	; 1284 <.text+0x1284>
    1230:	e59f3050 	ldr	r3, [pc, #80]	; 1288 <.text+0x1288>
    1234:	e58dc000 	str	ip, [sp]
    1238:	ebfffd04 	bl	650 <printf>
    123c:	eafffffe 	b	123c <USBHwRegisterEPIntHandler+0x44>
    1240:	e59fc044 	ldr	ip, [pc, #68]	; 128c <.text+0x128c>
    1244:	e51c3dcb 	ldr	r3, [ip, #-3531]
    1248:	e3a02001 	mov	r2, #1	; 0x1
    124c:	e1833e12 	orr	r3, r3, r2, lsl lr
    1250:	e50c3dcb 	str	r3, [ip, #-3531]
    1254:	e51c2dfb 	ldr	r2, [ip, #-3579]
    1258:	e59f3030 	ldr	r3, [pc, #48]	; 1290 <.text+0x1290>
    125c:	e59f0030 	ldr	r0, [pc, #48]	; 1294 <.text+0x1294>
    1260:	e3822004 	orr	r2, r2, #4	; 0x4
    1264:	e1a0e0ae 	mov	lr, lr, lsr #1
    1268:	e783410e 	str	r4, [r3, lr, lsl #2]
    126c:	e50c2dfb 	str	r2, [ip, #-3579]
    1270:	e28dd004 	add	sp, sp, #4	; 0x4
    1274:	e8bd4010 	ldmia	sp!, {r4, lr}
    1278:	eafffcf4 	b	650 <printf>
    127c:	00001dfc 	streqd	r1, [r0], -ip
    1280:	00001e24 	andeq	r1, r0, r4, lsr #28
    1284:	00001e2c 	andeq	r1, r0, ip, lsr #28
    1288:	00001cdc 	ldreqd	r1, [r0], -ip
    128c:	ffe0cfff 	undefined instruction 0xffe0cfff
    1290:	4000021c 	andmi	r0, r0, ip, lsl r2
    1294:	00001e38 	andeq	r1, r0, r8, lsr lr

00001298 <USBRegisterRequestHandler>:
    1298:	e52de004 	str	lr, [sp, #-4]!
    129c:	e3500000 	cmp	r0, #0	; 0x0
    12a0:	e24dd004 	sub	sp, sp, #4	; 0x4
    12a4:	aa000007 	bge	12c8 <USBRegisterRequestHandler+0x30>
    12a8:	e3a0c0e2 	mov	ip, #226	; 0xe2
    12ac:	e59f0054 	ldr	r0, [pc, #84]	; 1308 <.text+0x1308>
    12b0:	e59f1054 	ldr	r1, [pc, #84]	; 130c <.text+0x130c>
    12b4:	e59f2054 	ldr	r2, [pc, #84]	; 1310 <.text+0x1310>
    12b8:	e59f3054 	ldr	r3, [pc, #84]	; 1314 <.text+0x1314>
    12bc:	e58dc000 	str	ip, [sp]
    12c0:	ebfffce2 	bl	650 <printf>
    12c4:	eafffffe 	b	12c4 <USBRegisterRequestHandler+0x2c>
    12c8:	e3500003 	cmp	r0, #3	; 0x3
    12cc:	da000007 	ble	12f0 <USBRegisterRequestHandler+0x58>
    12d0:	e3a0c0e3 	mov	ip, #227	; 0xe3
    12d4:	e59f002c 	ldr	r0, [pc, #44]	; 1308 <.text+0x1308>
    12d8:	e59f1038 	ldr	r1, [pc, #56]	; 1318 <.text+0x1318>
    12dc:	e59f202c 	ldr	r2, [pc, #44]	; 1310 <.text+0x1310>
    12e0:	e59f302c 	ldr	r3, [pc, #44]	; 1314 <.text+0x1314>
    12e4:	e58dc000 	str	ip, [sp]
    12e8:	ebfffcd8 	bl	650 <printf>
    12ec:	eafffffe 	b	12ec <USBRegisterRequestHandler+0x54>
    12f0:	e59f3024 	ldr	r3, [pc, #36]	; 131c <.text+0x131c>
    12f4:	e7832100 	str	r2, [r3, r0, lsl #2]
    12f8:	e59f3020 	ldr	r3, [pc, #32]	; 1320 <.text+0x1320>
    12fc:	e7831100 	str	r1, [r3, r0, lsl #2]
    1300:	e28dd004 	add	sp, sp, #4	; 0x4
    1304:	e8bd8000 	ldmia	sp!, {pc}
    1308:	00001dfc 	streqd	r1, [r0], -ip
    130c:	00001e58 	andeq	r1, r0, r8, asr lr
    1310:	00001e64 	andeq	r1, r0, r4, ror #28
    1314:	00001cf8 	streqd	r1, [r0], -r8
    1318:	00001e74 	andeq	r1, r0, r4, ror lr
    131c:	4000026c 	andmi	r0, r0, ip, ror #4
    1320:	4000025c 	andmi	r0, r0, ip, asr r2

00001324 <_HandleRequest>:
    1324:	e92d4010 	stmdb	sp!, {r4, lr}
    1328:	e5d03000 	ldrb	r3, [r0]
    132c:	e1a032a3 	mov	r3, r3, lsr #5
    1330:	e203c003 	and	ip, r3, #3	; 0x3
    1334:	e59f3028 	ldr	r3, [pc, #40]	; 1364 <.text+0x1364>
    1338:	e793410c 	ldr	r4, [r3, ip, lsl #2]
    133c:	e3540000 	cmp	r4, #0	; 0x0
    1340:	1a000004 	bne	1358 <_HandleRequest+0x34>
    1344:	e1a0100c 	mov	r1, ip
    1348:	e59f0018 	ldr	r0, [pc, #24]	; 1368 <.text+0x1368>
    134c:	ebfffcbf 	bl	650 <printf>
    1350:	e1a00004 	mov	r0, r4
    1354:	e8bd8010 	ldmia	sp!, {r4, pc}
    1358:	e1a0e00f 	mov	lr, pc
    135c:	e12fff14 	bx	r4
    1360:	e8bd8010 	ldmia	sp!, {r4, pc}
    1364:	4000025c 	andmi	r0, r0, ip, asr r2
    1368:	00001e80 	andeq	r1, r0, r0, lsl #29

0000136c <StallControlPipe>:
    136c:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
    1370:	e1a03000 	mov	r3, r0
    1374:	e3a01001 	mov	r1, #1	; 0x1
    1378:	e3a00080 	mov	r0, #128	; 0x80
    137c:	e20350ff 	and	r5, r3, #255	; 0xff
    1380:	ebfffe09 	bl	bac <USBHwEPStall>
    1384:	e59f0030 	ldr	r0, [pc, #48]	; 13bc <.text+0x13bc>
    1388:	ebfffcb0 	bl	650 <printf>
    138c:	e59f602c 	ldr	r6, [pc, #44]	; 13c0 <.text+0x13c0>
    1390:	e3a04000 	mov	r4, #0	; 0x0
    1394:	e7d41006 	ldrb	r1, [r4, r6]
    1398:	e59f0024 	ldr	r0, [pc, #36]	; 13c4 <.text+0x13c4>
    139c:	e2844001 	add	r4, r4, #1	; 0x1
    13a0:	ebfffcaa 	bl	650 <printf>
    13a4:	e3540008 	cmp	r4, #8	; 0x8
    13a8:	1afffff9 	bne	1394 <StallControlPipe+0x28>
    13ac:	e59f0014 	ldr	r0, [pc, #20]	; 13c8 <.text+0x13c8>
    13b0:	e1a01005 	mov	r1, r5
    13b4:	e8bd4070 	ldmia	sp!, {r4, r5, r6, lr}
    13b8:	eafffca4 	b	650 <printf>
    13bc:	00001e9c 	muleq	r0, ip, lr
    13c0:	4000027c 	andmi	r0, r0, ip, ror r2
    13c4:	00001ea8 	andeq	r1, r0, r8, lsr #29
    13c8:	00001eb0 	streqh	r1, [r0], -r0

000013cc <DataIn>:
    13cc:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
    13d0:	e59f6038 	ldr	r6, [pc, #56]	; 1410 <.text+0x1410>
    13d4:	e5964000 	ldr	r4, [r6]
    13d8:	e59f5034 	ldr	r5, [pc, #52]	; 1414 <.text+0x1414>
    13dc:	e3540040 	cmp	r4, #64	; 0x40
    13e0:	a3a04040 	movge	r4, #64	; 0x40
    13e4:	e1a02004 	mov	r2, r4
    13e8:	e3a00080 	mov	r0, #128	; 0x80
    13ec:	e5951000 	ldr	r1, [r5]
    13f0:	ebfffdf5 	bl	bcc <USBHwEPWrite>
    13f4:	e5953000 	ldr	r3, [r5]
    13f8:	e5962000 	ldr	r2, [r6]
    13fc:	e0833004 	add	r3, r3, r4
    1400:	e0642002 	rsb	r2, r4, r2
    1404:	e5853000 	str	r3, [r5]
    1408:	e5862000 	str	r2, [r6]
    140c:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
    1410:	40000288 	andmi	r0, r0, r8, lsl #5
    1414:	40000284 	andmi	r0, r0, r4, lsl #5

00001418 <USBHandleControlTransfer>:
    1418:	e92d40f0 	stmdb	sp!, {r4, r5, r6, r7, lr}
    141c:	e21000ff 	ands	r0, r0, #255	; 0xff
    1420:	e24dd004 	sub	sp, sp, #4	; 0x4
    1424:	e20170ff 	and	r7, r1, #255	; 0xff
    1428:	1a000051 	bne	1574 <USBHandleControlTransfer+0x15c>
    142c:	e3110004 	tst	r1, #4	; 0x4
    1430:	e59f6178 	ldr	r6, [pc, #376]	; 15b0 <.text+0x15b0>
    1434:	0a000021 	beq	14c0 <USBHandleControlTransfer+0xa8>
    1438:	e59f5174 	ldr	r5, [pc, #372]	; 15b4 <.text+0x15b4>
    143c:	e3a02008 	mov	r2, #8	; 0x8
    1440:	e1a01005 	mov	r1, r5
    1444:	ebfffe03 	bl	c58 <USBHwEPRead>
    1448:	e5d51001 	ldrb	r1, [r5, #1]
    144c:	e59f0164 	ldr	r0, [pc, #356]	; 15b8 <.text+0x15b8>
    1450:	ebfffc7e 	bl	650 <printf>
    1454:	e5d50000 	ldrb	r0, [r5]
    1458:	e59f215c 	ldr	r2, [pc, #348]	; 15bc <.text+0x15bc>
    145c:	e1a032a0 	mov	r3, r0, lsr #5
    1460:	e1d510b6 	ldrh	r1, [r5, #6]
    1464:	e2033003 	and	r3, r3, #3	; 0x3
    1468:	e7923103 	ldr	r3, [r2, r3, lsl #2]
    146c:	e59f414c 	ldr	r4, [pc, #332]	; 15c0 <.text+0x15c0>
    1470:	e59f214c 	ldr	r2, [pc, #332]	; 15c4 <.text+0x15c4>
    1474:	e3510000 	cmp	r1, #0	; 0x0
    1478:	e5823000 	str	r3, [r2]
    147c:	e5861000 	str	r1, [r6]
    1480:	e5841000 	str	r1, [r4]
    1484:	0a000001 	beq	1490 <USBHandleControlTransfer+0x78>
    1488:	e1b003a0 	movs	r0, r0, lsr #7
    148c:	0a000045 	beq	15a8 <USBHandleControlTransfer+0x190>
    1490:	e1a00005 	mov	r0, r5
    1494:	e1a01004 	mov	r1, r4
    1498:	ebffffa1 	bl	1324 <_HandleRequest>
    149c:	e3500000 	cmp	r0, #0	; 0x0
    14a0:	059f0120 	ldreq	r0, [pc, #288]	; 15c8 <.text+0x15c8>
    14a4:	0a000022 	beq	1534 <USBHandleControlTransfer+0x11c>
    14a8:	e1d520b6 	ldrh	r2, [r5, #6]
    14ac:	e5943000 	ldr	r3, [r4]
    14b0:	e1520003 	cmp	r2, r3
    14b4:	d5862000 	strle	r2, [r6]
    14b8:	c5863000 	strgt	r3, [r6]
    14bc:	ea00002e 	b	157c <USBHandleControlTransfer+0x164>
    14c0:	e5962000 	ldr	r2, [r6]
    14c4:	e3520000 	cmp	r2, #0	; 0x0
    14c8:	da00001e 	ble	1548 <USBHandleControlTransfer+0x130>
    14cc:	e59f40f0 	ldr	r4, [pc, #240]	; 15c4 <.text+0x15c4>
    14d0:	e5941000 	ldr	r1, [r4]
    14d4:	ebfffddf 	bl	c58 <USBHwEPRead>
    14d8:	e3500000 	cmp	r0, #0	; 0x0
    14dc:	ba000015 	blt	1538 <USBHandleControlTransfer+0x120>
    14e0:	e5962000 	ldr	r2, [r6]
    14e4:	e5943000 	ldr	r3, [r4]
    14e8:	e0602002 	rsb	r2, r0, r2
    14ec:	e0833000 	add	r3, r3, r0
    14f0:	e3520000 	cmp	r2, #0	; 0x0
    14f4:	e5843000 	str	r3, [r4]
    14f8:	e5862000 	str	r2, [r6]
    14fc:	1a000029 	bne	15a8 <USBHandleControlTransfer+0x190>
    1500:	e59f00ac 	ldr	r0, [pc, #172]	; 15b4 <.text+0x15b4>
    1504:	e5d03000 	ldrb	r3, [r0]
    1508:	e59f20ac 	ldr	r2, [pc, #172]	; 15bc <.text+0x15bc>
    150c:	e1a032a3 	mov	r3, r3, lsr #5
    1510:	e2033003 	and	r3, r3, #3	; 0x3
    1514:	e7923103 	ldr	r3, [r2, r3, lsl #2]
    1518:	e59f10a0 	ldr	r1, [pc, #160]	; 15c0 <.text+0x15c0>
    151c:	e1a02004 	mov	r2, r4
    1520:	e5843000 	str	r3, [r4]
    1524:	ebffff7e 	bl	1324 <_HandleRequest>
    1528:	e3500000 	cmp	r0, #0	; 0x0
    152c:	1a000012 	bne	157c <USBHandleControlTransfer+0x164>
    1530:	e59f0094 	ldr	r0, [pc, #148]	; 15cc <.text+0x15cc>
    1534:	ebfffc7b 	bl	728 <puts>
    1538:	e1a00007 	mov	r0, r7
    153c:	e28dd004 	add	sp, sp, #4	; 0x4
    1540:	e8bd40f0 	ldmia	sp!, {r4, r5, r6, r7, lr}
    1544:	eaffff88 	b	136c <StallControlPipe>
    1548:	e1a01000 	mov	r1, r0
    154c:	e1a02000 	mov	r2, r0
    1550:	ebfffdc0 	bl	c58 <USBHwEPRead>
    1554:	e59f2074 	ldr	r2, [pc, #116]	; 15d0 <.text+0x15d0>
    1558:	e59f3074 	ldr	r3, [pc, #116]	; 15d4 <.text+0x15d4>
    155c:	e3500000 	cmp	r0, #0	; 0x0
    1560:	d1a00002 	movle	r0, r2
    1564:	c1a00003 	movgt	r0, r3
    1568:	e28dd004 	add	sp, sp, #4	; 0x4
    156c:	e8bd40f0 	ldmia	sp!, {r4, r5, r6, r7, lr}
    1570:	eafffc36 	b	650 <printf>
    1574:	e3500080 	cmp	r0, #128	; 0x80
    1578:	1a000002 	bne	1588 <USBHandleControlTransfer+0x170>
    157c:	e28dd004 	add	sp, sp, #4	; 0x4
    1580:	e8bd40f0 	ldmia	sp!, {r4, r5, r6, r7, lr}
    1584:	eaffff90 	b	13cc <DataIn>
    1588:	e3a0c0d4 	mov	ip, #212	; 0xd4
    158c:	e59f0044 	ldr	r0, [pc, #68]	; 15d8 <.text+0x15d8>
    1590:	e59f1044 	ldr	r1, [pc, #68]	; 15dc <.text+0x15dc>
    1594:	e59f2044 	ldr	r2, [pc, #68]	; 15e0 <.text+0x15e0>
    1598:	e59f3044 	ldr	r3, [pc, #68]	; 15e4 <.text+0x15e4>
    159c:	e58dc000 	str	ip, [sp]
    15a0:	ebfffc2a 	bl	650 <printf>
    15a4:	eafffffe 	b	15a4 <USBHandleControlTransfer+0x18c>
    15a8:	e28dd004 	add	sp, sp, #4	; 0x4
    15ac:	e8bd80f0 	ldmia	sp!, {r4, r5, r6, r7, pc}
    15b0:	40000288 	andmi	r0, r0, r8, lsl #5
    15b4:	4000027c 	andmi	r0, r0, ip, ror r2
    15b8:	00001ebc 	streqh	r1, [r0], -ip
    15bc:	4000026c 	andmi	r0, r0, ip, ror #4
    15c0:	4000028c 	andmi	r0, r0, ip, lsl #5
    15c4:	40000284 	andmi	r0, r0, r4, lsl #5
    15c8:	00001ec0 	andeq	r1, r0, r0, asr #29
    15cc:	00001ed8 	ldreqd	r1, [r0], -r8
    15d0:	00001e20 	andeq	r1, r0, r0, lsr #28
    15d4:	00001ef0 	streqd	r1, [r0], -r0
    15d8:	00001dfc 	streqd	r1, [r0], -ip
    15dc:	00001ef4 	streqd	r1, [r0], -r4
    15e0:	00001e64 	andeq	r1, r0, r4, ror #28
    15e4:	00001d14 	andeq	r1, r0, r4, lsl sp

000015e8 <USBRegisterDescriptors>:
    15e8:	e59f3004 	ldr	r3, [pc, #4]	; 15f4 <.text+0x15f4>
    15ec:	e5830000 	str	r0, [r3]
    15f0:	e12fff1e 	bx	lr
    15f4:	40000298 	mulmi	r0, r8, r2

000015f8 <USBRegisterCustomReqHandler>:
    15f8:	e59f3004 	ldr	r3, [pc, #4]	; 1604 <.text+0x1604>
    15fc:	e5830000 	str	r0, [r3]
    1600:	e12fff1e 	bx	lr
    1604:	40000290 	mulmi	r0, r0, r2

00001608 <USBGetDescriptor>:
    1608:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
    160c:	e59f10ac 	ldr	r1, [pc, #172]	; 16c0 <.text+0x16c0>
    1610:	e5911000 	ldr	r1, [r1]
    1614:	e1a00800 	mov	r0, r0, lsl #16
    1618:	e3510000 	cmp	r1, #0	; 0x0
    161c:	e1a0c820 	mov	ip, r0, lsr #16
    1620:	e1a05002 	mov	r5, r2
    1624:	e24dd004 	sub	sp, sp, #4	; 0x4
    1628:	e1a06003 	mov	r6, r3
    162c:	11a00c20 	movne	r0, r0, lsr #24
    1630:	120ce0ff 	andne	lr, ip, #255	; 0xff
    1634:	13a02000 	movne	r2, #0	; 0x0
    1638:	1a000017 	bne	169c <USBGetDescriptor+0x94>
    163c:	e3a0c06e 	mov	ip, #110	; 0x6e
    1640:	e59f007c 	ldr	r0, [pc, #124]	; 16c4 <.text+0x16c4>
    1644:	e59f107c 	ldr	r1, [pc, #124]	; 16c8 <.text+0x16c8>
    1648:	e59f207c 	ldr	r2, [pc, #124]	; 16cc <.text+0x16cc>
    164c:	e59f307c 	ldr	r3, [pc, #124]	; 16d0 <.text+0x16d0>
    1650:	e58dc000 	str	ip, [sp]
    1654:	ebfffbfd 	bl	650 <printf>
    1658:	eafffffe 	b	1658 <USBGetDescriptor+0x50>
    165c:	e5d13001 	ldrb	r3, [r1, #1]
    1660:	e1530000 	cmp	r3, r0
    1664:	1a00000b 	bne	1698 <USBGetDescriptor+0x90>
    1668:	e152000e 	cmp	r2, lr
    166c:	1a000008 	bne	1694 <USBGetDescriptor+0x8c>
    1670:	e5861000 	str	r1, [r6]
    1674:	e3500002 	cmp	r0, #2	; 0x2
    1678:	05d13002 	ldreqb	r3, [r1, #2]
    167c:	05d12003 	ldreqb	r2, [r1, #3]
    1680:	15d13000 	ldrneb	r3, [r1]
    1684:	01833402 	orreq	r3, r3, r2, lsl #8
    1688:	e3a00001 	mov	r0, #1	; 0x1
    168c:	e5853000 	str	r3, [r5]
    1690:	ea000008 	b	16b8 <USBGetDescriptor+0xb0>
    1694:	e2822001 	add	r2, r2, #1	; 0x1
    1698:	e0811004 	add	r1, r1, r4
    169c:	e5d14000 	ldrb	r4, [r1]
    16a0:	e3540000 	cmp	r4, #0	; 0x0
    16a4:	1affffec 	bne	165c <USBGetDescriptor+0x54>
    16a8:	e1a0100c 	mov	r1, ip
    16ac:	e59f0020 	ldr	r0, [pc, #32]	; 16d4 <.text+0x16d4>
    16b0:	ebfffbe6 	bl	650 <printf>
    16b4:	e1a00004 	mov	r0, r4
    16b8:	e28dd004 	add	sp, sp, #4	; 0x4
    16bc:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
    16c0:	40000298 	mulmi	r0, r8, r2
    16c4:	00001dfc 	streqd	r1, [r0], -ip
    16c8:	00001efc 	streqd	r1, [r0], -ip
    16cc:	00001f10 	andeq	r1, r0, r0, lsl pc
    16d0:	00001d44 	andeq	r1, r0, r4, asr #26
    16d4:	00001f1c 	andeq	r1, r0, ip, lsl pc

000016d8 <USBHandleStandardRequest>:
    16d8:	e92d41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
    16dc:	e59f32f8 	ldr	r3, [pc, #760]	; 19dc <.text+0x19dc>
    16e0:	e5933000 	ldr	r3, [r3]
    16e4:	e3530000 	cmp	r3, #0	; 0x0
    16e8:	e24dd004 	sub	sp, sp, #4	; 0x4
    16ec:	e1a05000 	mov	r5, r0
    16f0:	e1a06001 	mov	r6, r1
    16f4:	e1a04002 	mov	r4, r2
    16f8:	0a000003 	beq	170c <USBHandleStandardRequest+0x34>
    16fc:	e1a0e00f 	mov	lr, pc
    1700:	e12fff13 	bx	r3
    1704:	e3500000 	cmp	r0, #0	; 0x0
    1708:	1a0000a9 	bne	19b4 <.text+0x19b4>
    170c:	e5d53000 	ldrb	r3, [r5]
    1710:	e203301f 	and	r3, r3, #31	; 0x1f
    1714:	e3530001 	cmp	r3, #1	; 0x1
    1718:	0a000059 	beq	1884 <.text+0x1884>
    171c:	e3530002 	cmp	r3, #2	; 0x2
    1720:	0a00007b 	beq	1914 <.text+0x1914>
    1724:	e3530000 	cmp	r3, #0	; 0x0
    1728:	1a0000a7 	bne	19cc <.text+0x19cc>
    172c:	e5d51001 	ldrb	r1, [r5, #1]
    1730:	e5940000 	ldr	r0, [r4]
    1734:	e3510009 	cmp	r1, #9	; 0x9
    1738:	979ff101 	ldrls	pc, [pc, r1, lsl #2]
    173c:	ea00004e 	b	187c <.text+0x187c>
    1740:	000018c8 	andeq	r1, r0, r8, asr #17
    1744:	000019cc 	andeq	r1, r0, ip, asr #19
    1748:	0000187c 	andeq	r1, r0, ip, ror r8
    174c:	000019cc 	andeq	r1, r0, ip, asr #19
    1750:	0000187c 	andeq	r1, r0, ip, ror r8
    1754:	00001768 	andeq	r1, r0, r8, ror #14
    1758:	00001774 	andeq	r1, r0, r4, ror r7
    175c:	00001874 	andeq	r1, r0, r4, ror r8
    1760:	0000179c 	muleq	r0, ip, r7
    1764:	000017b4 	streqh	r1, [r0], -r4
    1768:	e5d50002 	ldrb	r0, [r5, #2]
    176c:	ebfffcf3 	bl	b40 <USBHwSetAddress>
    1770:	ea00008f 	b	19b4 <.text+0x19b4>
    1774:	e1d510b2 	ldrh	r1, [r5, #2]
    1778:	e59f0260 	ldr	r0, [pc, #608]	; 19e0 <.text+0x19e0>
    177c:	ebfffbb3 	bl	650 <printf>
    1780:	e1d510b4 	ldrh	r1, [r5, #4]
    1784:	e1d500b2 	ldrh	r0, [r5, #2]
    1788:	e1a02006 	mov	r2, r6
    178c:	e1a03004 	mov	r3, r4
    1790:	e28dd004 	add	sp, sp, #4	; 0x4
    1794:	e8bd41f0 	ldmia	sp!, {r4, r5, r6, r7, r8, lr}
    1798:	eaffff9a 	b	1608 <USBGetDescriptor>
    179c:	e59f3240 	ldr	r3, [pc, #576]	; 19e4 <.text+0x19e4>
    17a0:	e5d32000 	ldrb	r2, [r3]
    17a4:	e3a03001 	mov	r3, #1	; 0x1
    17a8:	e1a01003 	mov	r1, r3
    17ac:	e5c02000 	strb	r2, [r0]
    17b0:	ea000072 	b	1980 <.text+0x1980>
    17b4:	e59f322c 	ldr	r3, [pc, #556]	; 19e8 <.text+0x19e8>
    17b8:	e5933000 	ldr	r3, [r3]
    17bc:	e3530000 	cmp	r3, #0	; 0x0
    17c0:	e1d520b2 	ldrh	r2, [r5, #2]
    17c4:	1a000007 	bne	17e8 <.text+0x17e8>
    17c8:	e3a0c0a5 	mov	ip, #165	; 0xa5
    17cc:	e59f0218 	ldr	r0, [pc, #536]	; 19ec <.text+0x19ec>
    17d0:	e59f1218 	ldr	r1, [pc, #536]	; 19f0 <.text+0x19f0>
    17d4:	e59f2218 	ldr	r2, [pc, #536]	; 19f4 <.text+0x19f4>
    17d8:	e59f3218 	ldr	r3, [pc, #536]	; 19f8 <.text+0x19f8>
    17dc:	e58dc000 	str	ip, [sp]
    17e0:	ebfffb9a 	bl	650 <printf>
    17e4:	eafffffe 	b	17e4 <.text+0x17e4>
    17e8:	e21270ff 	ands	r7, r2, #255	; 0xff
    17ec:	13a060ff 	movne	r6, #255	; 0xff
    17f0:	01a00007 	moveq	r0, r7
    17f4:	11a04003 	movne	r4, r3
    17f8:	11a08006 	movne	r8, r6
    17fc:	1a000012 	bne	184c <.text+0x184c>
    1800:	ea000015 	b	185c <.text+0x185c>
    1804:	e5d43001 	ldrb	r3, [r4, #1]
    1808:	e3530004 	cmp	r3, #4	; 0x4
    180c:	05d46003 	ldreqb	r6, [r4, #3]
    1810:	0a00000b 	beq	1844 <.text+0x1844>
    1814:	e3530005 	cmp	r3, #5	; 0x5
    1818:	0a000002 	beq	1828 <.text+0x1828>
    181c:	e3530002 	cmp	r3, #2	; 0x2
    1820:	05d48005 	ldreqb	r8, [r4, #5]
    1824:	ea000006 	b	1844 <.text+0x1844>
    1828:	e1580007 	cmp	r8, r7
    182c:	03560000 	cmpeq	r6, #0	; 0x0
    1830:	05d43005 	ldreqb	r3, [r4, #5]
    1834:	05d41004 	ldreqb	r1, [r4, #4]
    1838:	05d40002 	ldreqb	r0, [r4, #2]
    183c:	01811403 	orreq	r1, r1, r3, lsl #8
    1840:	0bfffca8 	bleq	ae8 <USBHwEPConfig>
    1844:	e5d43000 	ldrb	r3, [r4]
    1848:	e0844003 	add	r4, r4, r3
    184c:	e5d43000 	ldrb	r3, [r4]
    1850:	e3530000 	cmp	r3, #0	; 0x0
    1854:	1affffea 	bne	1804 <.text+0x1804>
    1858:	e3a00001 	mov	r0, #1	; 0x1
    185c:	ebfffd4d 	bl	d98 <USBHwConfigDevice>
    1860:	e1d520b2 	ldrh	r2, [r5, #2]
    1864:	e59f3178 	ldr	r3, [pc, #376]	; 19e4 <.text+0x19e4>
    1868:	e3a01001 	mov	r1, #1	; 0x1
    186c:	e5c32000 	strb	r2, [r3]
    1870:	ea000056 	b	19d0 <.text+0x19d0>
    1874:	e59f0180 	ldr	r0, [pc, #384]	; 19fc <.text+0x19fc>
    1878:	ea000052 	b	19c8 <.text+0x19c8>
    187c:	e59f017c 	ldr	r0, [pc, #380]	; 1a00 <.text+0x1a00>
    1880:	ea000050 	b	19c8 <.text+0x19c8>
    1884:	e5d51001 	ldrb	r1, [r5, #1]
    1888:	e5940000 	ldr	r0, [r4]
    188c:	e351000b 	cmp	r1, #11	; 0xb
    1890:	979ff101 	ldrls	pc, [pc, r1, lsl #2]
    1894:	ea00001c 	b	190c <.text+0x190c>
    1898:	000018c8 	andeq	r1, r0, r8, asr #17
    189c:	000019cc 	andeq	r1, r0, ip, asr #19
    18a0:	0000190c 	andeq	r1, r0, ip, lsl #18
    18a4:	000019cc 	andeq	r1, r0, ip, asr #19
    18a8:	0000190c 	andeq	r1, r0, ip, lsl #18
    18ac:	0000190c 	andeq	r1, r0, ip, lsl #18
    18b0:	0000190c 	andeq	r1, r0, ip, lsl #18
    18b4:	0000190c 	andeq	r1, r0, ip, lsl #18
    18b8:	0000190c 	andeq	r1, r0, ip, lsl #18
    18bc:	0000190c 	andeq	r1, r0, ip, lsl #18
    18c0:	000018dc 	ldreqd	r1, [r0], -ip
    18c4:	000018f4 	streqd	r1, [r0], -r4
    18c8:	e3a03000 	mov	r3, #0	; 0x0
    18cc:	e3a01001 	mov	r1, #1	; 0x1
    18d0:	e5c03001 	strb	r3, [r0, #1]
    18d4:	e5c03000 	strb	r3, [r0]
    18d8:	ea000027 	b	197c <.text+0x197c>
    18dc:	e3a02001 	mov	r2, #1	; 0x1
    18e0:	e3a03000 	mov	r3, #0	; 0x0
    18e4:	e1a01002 	mov	r1, r2
    18e8:	e5c03000 	strb	r3, [r0]
    18ec:	e5862000 	str	r2, [r6]
    18f0:	ea000036 	b	19d0 <.text+0x19d0>
    18f4:	e1d500b2 	ldrh	r0, [r5, #2]
    18f8:	e3500000 	cmp	r0, #0	; 0x0
    18fc:	03a01001 	moveq	r1, #1	; 0x1
    1900:	05860000 	streq	r0, [r6]
    1904:	0a000031 	beq	19d0 <.text+0x19d0>
    1908:	ea00002f 	b	19cc <.text+0x19cc>
    190c:	e59f00f0 	ldr	r0, [pc, #240]	; 1a04 <.text+0x1a04>
    1910:	ea00002c 	b	19c8 <.text+0x19c8>
    1914:	e5d51001 	ldrb	r1, [r5, #1]
    1918:	e5944000 	ldr	r4, [r4]
    191c:	e351000c 	cmp	r1, #12	; 0xc
    1920:	979ff101 	ldrls	pc, [pc, r1, lsl #2]
    1924:	ea000026 	b	19c4 <.text+0x19c4>
    1928:	0000195c 	andeq	r1, r0, ip, asr r9
    192c:	00001988 	andeq	r1, r0, r8, lsl #19
    1930:	000019c4 	andeq	r1, r0, r4, asr #19
    1934:	0000199c 	muleq	r0, ip, r9
    1938:	000019c4 	andeq	r1, r0, r4, asr #19
    193c:	000019c4 	andeq	r1, r0, r4, asr #19
    1940:	000019c4 	andeq	r1, r0, r4, asr #19
    1944:	000019c4 	andeq	r1, r0, r4, asr #19
    1948:	000019c4 	andeq	r1, r0, r4, asr #19
    194c:	000019c4 	andeq	r1, r0, r4, asr #19
    1950:	000019c4 	andeq	r1, r0, r4, asr #19
    1954:	000019c4 	andeq	r1, r0, r4, asr #19
    1958:	000019bc 	streqh	r1, [r0], -ip
    195c:	e5d50004 	ldrb	r0, [r5, #4]
    1960:	ebfffc89 	bl	b8c <USBHwEPGetStatus>
    1964:	e1a000a0 	mov	r0, r0, lsr #1
    1968:	e2000001 	and	r0, r0, #1	; 0x1
    196c:	e3a03000 	mov	r3, #0	; 0x0
    1970:	e5c43001 	strb	r3, [r4, #1]
    1974:	e5c40000 	strb	r0, [r4]
    1978:	e3a01001 	mov	r1, #1	; 0x1
    197c:	e2833002 	add	r3, r3, #2	; 0x2
    1980:	e5863000 	str	r3, [r6]
    1984:	ea000011 	b	19d0 <.text+0x19d0>
    1988:	e1d510b2 	ldrh	r1, [r5, #2]
    198c:	e3510000 	cmp	r1, #0	; 0x0
    1990:	05d50004 	ldreqb	r0, [r5, #4]
    1994:	0a000005 	beq	19b0 <.text+0x19b0>
    1998:	ea00000b 	b	19cc <.text+0x19cc>
    199c:	e1d530b2 	ldrh	r3, [r5, #2]
    19a0:	e3530000 	cmp	r3, #0	; 0x0
    19a4:	1a000008 	bne	19cc <.text+0x19cc>
    19a8:	e5d50004 	ldrb	r0, [r5, #4]
    19ac:	e3a01001 	mov	r1, #1	; 0x1
    19b0:	ebfffc7d 	bl	bac <USBHwEPStall>
    19b4:	e3a01001 	mov	r1, #1	; 0x1
    19b8:	ea000004 	b	19d0 <.text+0x19d0>
    19bc:	e59f0044 	ldr	r0, [pc, #68]	; 1a08 <.text+0x1a08>
    19c0:	ea000000 	b	19c8 <.text+0x19c8>
    19c4:	e59f0040 	ldr	r0, [pc, #64]	; 1a0c <.text+0x1a0c>
    19c8:	ebfffb20 	bl	650 <printf>
    19cc:	e3a01000 	mov	r1, #0	; 0x0
    19d0:	e1a00001 	mov	r0, r1
    19d4:	e28dd004 	add	sp, sp, #4	; 0x4
    19d8:	e8bd81f0 	ldmia	sp!, {r4, r5, r6, r7, r8, pc}
    19dc:	40000290 	mulmi	r0, r0, r2
    19e0:	00001f30 	andeq	r1, r0, r0, lsr pc
    19e4:	40000294 	mulmi	r0, r4, r2
    19e8:	40000298 	mulmi	r0, r8, r2
    19ec:	00001dfc 	streqd	r1, [r0], -ip
    19f0:	00001efc 	streqd	r1, [r0], -ip
    19f4:	00001f10 	andeq	r1, r0, r0, lsl pc
    19f8:	00001d30 	andeq	r1, r0, r0, lsr sp
    19fc:	00001f34 	andeq	r1, r0, r4, lsr pc
    1a00:	00001f54 	andeq	r1, r0, r4, asr pc
    1a04:	00001f6c 	andeq	r1, r0, ip, ror #30
    1a08:	00001f88 	andeq	r1, r0, r8, lsl #31
    1a0c:	00001fa4 	andeq	r1, r0, r4, lsr #31

00001a10 <USBInit>:
    1a10:	e92d4010 	stmdb	sp!, {r4, lr}
    1a14:	e59f4050 	ldr	r4, [pc, #80]	; 1a6c <.text+0x1a6c>
    1a18:	ebfffd3a 	bl	f08 <USBHwInit>
    1a1c:	e59f004c 	ldr	r0, [pc, #76]	; 1a70 <.text+0x1a70>
    1a20:	ebfffde9 	bl	11cc <USBHwRegisterDevIntHandler>
    1a24:	e1a01004 	mov	r1, r4
    1a28:	e3a00000 	mov	r0, #0	; 0x0
    1a2c:	ebfffdf1 	bl	11f8 <USBHwRegisterEPIntHandler>
    1a30:	e1a01004 	mov	r1, r4
    1a34:	e3a00080 	mov	r0, #128	; 0x80
    1a38:	ebfffdee 	bl	11f8 <USBHwRegisterEPIntHandler>
    1a3c:	e3a00000 	mov	r0, #0	; 0x0
    1a40:	e3a01040 	mov	r1, #64	; 0x40
    1a44:	ebfffc27 	bl	ae8 <USBHwEPConfig>
    1a48:	e3a00080 	mov	r0, #128	; 0x80
    1a4c:	e3a01040 	mov	r1, #64	; 0x40
    1a50:	ebfffc24 	bl	ae8 <USBHwEPConfig>
    1a54:	e3a00000 	mov	r0, #0	; 0x0
    1a58:	e59f1014 	ldr	r1, [pc, #20]	; 1a74 <.text+0x1a74>
    1a5c:	e59f2014 	ldr	r2, [pc, #20]	; 1a78 <.text+0x1a78>
    1a60:	ebfffe0c 	bl	1298 <USBRegisterRequestHandler>
    1a64:	e3a00001 	mov	r0, #1	; 0x1
    1a68:	e8bd8010 	ldmia	sp!, {r4, pc}
    1a6c:	00001418 	andeq	r1, r0, r8, lsl r4
    1a70:	00001a7c 	andeq	r1, r0, ip, ror sl
    1a74:	000016d8 	ldreqd	r1, [r0], -r8
    1a78:	4000029c 	mulmi	r0, ip, r2

00001a7c <HandleUsbReset>:
    1a7c:	e3100010 	tst	r0, #16	; 0x10
    1a80:	012fff1e 	bxeq	lr
    1a84:	e59f0000 	ldr	r0, [pc, #0]	; 1a8c <.text+0x1a8c>
    1a88:	eafffaf0 	b	650 <printf>
    1a8c:	00001fb8 	streqh	r1, [r0], -r8

00001a90 <__aeabi_uidiv>:
    1a90:	e2512001 	subs	r2, r1, #1	; 0x1
    1a94:	012fff1e 	bxeq	lr
    1a98:	3a000036 	bcc	1b78 <__aeabi_uidiv+0xe8>
    1a9c:	e1500001 	cmp	r0, r1
    1aa0:	9a000022 	bls	1b30 <__aeabi_uidiv+0xa0>
    1aa4:	e1110002 	tst	r1, r2
    1aa8:	0a000023 	beq	1b3c <__aeabi_uidiv+0xac>
    1aac:	e311020e 	tst	r1, #-536870912	; 0xe0000000
    1ab0:	01a01181 	moveq	r1, r1, lsl #3
    1ab4:	03a03008 	moveq	r3, #8	; 0x8
    1ab8:	13a03001 	movne	r3, #1	; 0x1
    1abc:	e3510201 	cmp	r1, #268435456	; 0x10000000
    1ac0:	31510000 	cmpcc	r1, r0
    1ac4:	31a01201 	movcc	r1, r1, lsl #4
    1ac8:	31a03203 	movcc	r3, r3, lsl #4
    1acc:	3afffffa 	bcc	1abc <__aeabi_uidiv+0x2c>
    1ad0:	e3510102 	cmp	r1, #-2147483648	; 0x80000000
    1ad4:	31510000 	cmpcc	r1, r0
    1ad8:	31a01081 	movcc	r1, r1, lsl #1
    1adc:	31a03083 	movcc	r3, r3, lsl #1
    1ae0:	3afffffa 	bcc	1ad0 <__aeabi_uidiv+0x40>
    1ae4:	e3a02000 	mov	r2, #0	; 0x0
    1ae8:	e1500001 	cmp	r0, r1
    1aec:	20400001 	subcs	r0, r0, r1
    1af0:	21822003 	orrcs	r2, r2, r3
    1af4:	e15000a1 	cmp	r0, r1, lsr #1
    1af8:	204000a1 	subcs	r0, r0, r1, lsr #1
    1afc:	218220a3 	orrcs	r2, r2, r3, lsr #1
    1b00:	e1500121 	cmp	r0, r1, lsr #2
    1b04:	20400121 	subcs	r0, r0, r1, lsr #2
    1b08:	21822123 	orrcs	r2, r2, r3, lsr #2
    1b0c:	e15001a1 	cmp	r0, r1, lsr #3
    1b10:	204001a1 	subcs	r0, r0, r1, lsr #3
    1b14:	218221a3 	orrcs	r2, r2, r3, lsr #3
    1b18:	e3500000 	cmp	r0, #0	; 0x0
    1b1c:	11b03223 	movnes	r3, r3, lsr #4
    1b20:	11a01221 	movne	r1, r1, lsr #4
    1b24:	1affffef 	bne	1ae8 <__aeabi_uidiv+0x58>
    1b28:	e1a00002 	mov	r0, r2
    1b2c:	e12fff1e 	bx	lr
    1b30:	03a00001 	moveq	r0, #1	; 0x1
    1b34:	13a00000 	movne	r0, #0	; 0x0
    1b38:	e12fff1e 	bx	lr
    1b3c:	e3510801 	cmp	r1, #65536	; 0x10000
    1b40:	21a01821 	movcs	r1, r1, lsr #16
    1b44:	23a02010 	movcs	r2, #16	; 0x10
    1b48:	33a02000 	movcc	r2, #0	; 0x0
    1b4c:	e3510c01 	cmp	r1, #256	; 0x100
    1b50:	21a01421 	movcs	r1, r1, lsr #8
    1b54:	22822008 	addcs	r2, r2, #8	; 0x8
    1b58:	e3510010 	cmp	r1, #16	; 0x10
    1b5c:	21a01221 	movcs	r1, r1, lsr #4
    1b60:	22822004 	addcs	r2, r2, #4	; 0x4
    1b64:	e3510004 	cmp	r1, #4	; 0x4
    1b68:	82822003 	addhi	r2, r2, #3	; 0x3
    1b6c:	908220a1 	addls	r2, r2, r1, lsr #1
    1b70:	e1a00230 	mov	r0, r0, lsr r2
    1b74:	e12fff1e 	bx	lr
    1b78:	e52de008 	str	lr, [sp, #-8]!
    1b7c:	eb00003a 	bl	1c6c <__aeabi_idiv0>
    1b80:	e3a00000 	mov	r0, #0	; 0x0
    1b84:	e49df008 	ldr	pc, [sp], #8

00001b88 <__aeabi_uidivmod>:
    1b88:	e92d4003 	stmdb	sp!, {r0, r1, lr}
    1b8c:	ebffffbf 	bl	1a90 <__aeabi_uidiv>
    1b90:	e8bd4006 	ldmia	sp!, {r1, r2, lr}
    1b94:	e0030092 	mul	r3, r2, r0
    1b98:	e0411003 	sub	r1, r1, r3
    1b9c:	e12fff1e 	bx	lr

00001ba0 <__umodsi3>:
    1ba0:	e2512001 	subs	r2, r1, #1	; 0x1
    1ba4:	3a00002c 	bcc	1c5c <__umodsi3+0xbc>
    1ba8:	11500001 	cmpne	r0, r1
    1bac:	03a00000 	moveq	r0, #0	; 0x0
    1bb0:	81110002 	tsthi	r1, r2
    1bb4:	00000002 	andeq	r0, r0, r2
    1bb8:	912fff1e 	bxls	lr
    1bbc:	e3a02000 	mov	r2, #0	; 0x0
    1bc0:	e3510201 	cmp	r1, #268435456	; 0x10000000
    1bc4:	31510000 	cmpcc	r1, r0
    1bc8:	31a01201 	movcc	r1, r1, lsl #4
    1bcc:	32822004 	addcc	r2, r2, #4	; 0x4
    1bd0:	3afffffa 	bcc	1bc0 <__umodsi3+0x20>
    1bd4:	e3510102 	cmp	r1, #-2147483648	; 0x80000000
    1bd8:	31510000 	cmpcc	r1, r0
    1bdc:	31a01081 	movcc	r1, r1, lsl #1
    1be0:	32822001 	addcc	r2, r2, #1	; 0x1
    1be4:	3afffffa 	bcc	1bd4 <__umodsi3+0x34>
    1be8:	e2522003 	subs	r2, r2, #3	; 0x3
    1bec:	ba00000e 	blt	1c2c <__umodsi3+0x8c>
    1bf0:	e1500001 	cmp	r0, r1
    1bf4:	20400001 	subcs	r0, r0, r1
    1bf8:	e15000a1 	cmp	r0, r1, lsr #1
    1bfc:	204000a1 	subcs	r0, r0, r1, lsr #1
    1c00:	e1500121 	cmp	r0, r1, lsr #2
    1c04:	20400121 	subcs	r0, r0, r1, lsr #2
    1c08:	e15001a1 	cmp	r0, r1, lsr #3
    1c0c:	204001a1 	subcs	r0, r0, r1, lsr #3
    1c10:	e3500001 	cmp	r0, #1	; 0x1
    1c14:	e1a01221 	mov	r1, r1, lsr #4
    1c18:	a2522004 	subges	r2, r2, #4	; 0x4
    1c1c:	aafffff3 	bge	1bf0 <__umodsi3+0x50>
    1c20:	e3120003 	tst	r2, #3	; 0x3
    1c24:	13300000 	teqne	r0, #0	; 0x0
    1c28:	0a00000a 	beq	1c58 <__umodsi3+0xb8>
    1c2c:	e3720002 	cmn	r2, #2	; 0x2
    1c30:	ba000006 	blt	1c50 <__umodsi3+0xb0>
    1c34:	0a000002 	beq	1c44 <__umodsi3+0xa4>
    1c38:	e1500001 	cmp	r0, r1
    1c3c:	20400001 	subcs	r0, r0, r1
    1c40:	e1a010a1 	mov	r1, r1, lsr #1
    1c44:	e1500001 	cmp	r0, r1
    1c48:	20400001 	subcs	r0, r0, r1
    1c4c:	e1a010a1 	mov	r1, r1, lsr #1
    1c50:	e1500001 	cmp	r0, r1
    1c54:	20400001 	subcs	r0, r0, r1
    1c58:	e12fff1e 	bx	lr
    1c5c:	e52de008 	str	lr, [sp, #-8]!
    1c60:	eb000001 	bl	1c6c <__aeabi_idiv0>
    1c64:	e3a00000 	mov	r0, #0	; 0x0
    1c68:	e49df008 	ldr	pc, [sp], #8

00001c6c <__aeabi_idiv0>:
    1c6c:	e12fff1e 	bx	lr

00001c70 <abDescriptors>:
    1c70:	01010112 40000002 0005ffff 02010100     .......@........
    1c80:	02090103 01010020 0932c000 02000004     .... .....2.....
    1c90:	000000ff 0d060507 07010080 800d8305     ................
    1ca0:	03040100 030e0409 0050004c 00550043     ........L.P.C.U.
    1cb0:	00420053 00550314 00420053 00650053     S.B...U.S.B.S.e.
    1cc0:	00690072 006c0061 00440312 00410045     r.i.a.l...D.E.A.
    1cd0:	00430044 00440030 00000045              D.C.0.D.E...

00001cdc <__FUNCTION__.1660>:
    1cdc:	48425355 67655277 65747369 49504572     USBHwRegisterEPI
    1cec:	6148746e 656c646e 00000072              ntHandler...

00001cf8 <__FUNCTION__.1651>:
    1cf8:	52425355 73696765 52726574 65757165     USBRegisterReque
    1d08:	61487473 656c646e 00000072              stHandler...

00001d14 <__FUNCTION__.1613>:
    1d14:	48425355 6c646e61 6e6f4365 6c6f7274     USBHandleControl
    1d24:	6e617254 72656673 00000000              Transfer....

00001d30 <__FUNCTION__.1627>:
    1d30:	53425355 6f437465 6769666e 74617275     USBSetConfigurat
    1d40:	006e6f69                                ion.

00001d44 <__FUNCTION__.1594>:
    1d44:	47425355 65447465 69726373 726f7470     USBGetDescriptor
    1d54:	00000000 6c756e28 0000296c 74696e49     ....(null)..Init
    1d64:	696c6169 676e6973 42535520 61747320     ialising USB sta
    1d74:	00006b63 72617453 676e6974 42535520     ck..Starting USB
    1d84:	6d6f6320 696e756d 69746163 00006e6f      communication..
    1d94:	78783332 00000000 74746553 20676e69     23xx....Setting 
    1da4:	69207075 7265746e 73747075 002e2e2e     up interupts....
    1db4:	69676552 72657473 68206465 6c646e61     Registered handl
    1dc4:	66207265 6620726f 656d6172 00000000     er for frame....
    1dd4:	69676552 72657473 68206465 6c646e61     Registered handl
    1de4:	66207265 6420726f 63697665 74732065     er for device st
    1df4:	73757461 00000000 7373410a 69747265     atus.....Asserti
    1e04:	27206e6f 20277325 6c696166 69206465     on '%s' failed i
    1e14:	7325206e 2373253a 0a216425 00000000     n %s:%s#%d!.....
    1e24:	3c786469 00003233 68627375 706c5f77     idx<32..usbhw_lp
    1e34:	00632e63 69676552 72657473 68206465     c.c.Registered h
    1e44:	6c646e61 66207265 4520726f 78302050     andler for EP 0x
    1e54:	000a7825 70795469 3d3e2065 00003020     %x..iType >= 0..
    1e64:	63627375 72746e6f 632e6c6f 00000000     usbcontrol.c....
    1e74:	70795469 203c2065 00000034 68206f4e     iType < 4...No h
    1e84:	6c646e61 66207265 7220726f 79747165     andler for reqty
    1e94:	25206570 00000a64 4c415453 6e6f204c     pe %d...STALL on
    1ea4:	00005b20 32302520 00000078 7473205d      [.. %02x...] st
    1eb4:	253d7461 00000a78 00782553 6e61485f     at=%x...S%x._Han
    1ec4:	52656c64 65757165 20317473 6c696166     dleRequest1 fail
    1ed4:	00006465 6e61485f 52656c64 65757165     ed.._HandleReque
    1ee4:	20327473 6c696166 00006465 0000003f     st2 failed..?...
    1ef4:	534c4146 00000045 44626170 72637365     FALSE...pabDescr
    1f04:	21207069 554e203d 00004c4c 73627375     ip != NULL..usbs
    1f14:	65726474 00632e71 63736544 20782520     tdreq.c.Desc %x 
    1f24:	20746f6e 6e756f66 000a2164 00782544     not found!..D%x.
    1f34:	69766544 72206563 25207165 6f6e2064     Device req %d no
    1f44:	6d692074 6d656c70 65746e65 00000a64     t implemented...
    1f54:	656c6c49 206c6167 69766564 72206563     Illegal device r
    1f64:	25207165 00000a64 656c6c49 206c6167     eq %d...Illegal 
    1f74:	65746e69 63616672 65722065 64252071     interface req %d
    1f84:	0000000a 72205045 25207165 6f6e2064     ....EP req %d no
    1f94:	6d692074 6d656c70 65746e65 00000a64     t implemented...
    1fa4:	656c6c49 206c6167 72205045 25207165     Illegal EP req %
    1fb4:	00000a64 0000210a                       d....!..
