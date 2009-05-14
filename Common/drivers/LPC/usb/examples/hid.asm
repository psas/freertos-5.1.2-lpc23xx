
hid.elf:     file format elf32-littlearm

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
      c4:	00001f24 	andeq	r1, r0, r4, lsr #30
      c8:	40000200 	andmi	r0, r0, r0, lsl #4
      cc:	40000255 	andmi	r0, r0, r5, asr r2
      d0:	40000258 	andmi	r0, r0, r8, asr r2
      d4:	400002f8 	strmid	r0, [r0], -r8

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
     394:	eb0005d0 	bl	1adc <__umodsi3>
     398:	e1a03000 	mov	r3, r0
     39c:	e3530009 	cmp	r3, #9	; 0x9
     3a0:	c083300a 	addgt	r3, r3, sl
     3a4:	e2833030 	add	r3, r3, #48	; 0x30
     3a8:	e1a00004 	mov	r0, r4
     3ac:	e5653001 	strb	r3, [r5, #-1]!
     3b0:	e1a01006 	mov	r1, r6
     3b4:	eb000584 	bl	19cc <__aeabi_uidiv>
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
     614:	00001c94 	muleq	r0, r4, ip

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
     76c:	e59f0050 	ldr	r0, [pc, #80]	; 7c4 <.text+0x7c4>
     770:	ebffffec 	bl	728 <puts>
     774:	eb000474 	bl	194c <USBInit>
     778:	e59f0048 	ldr	r0, [pc, #72]	; 7c8 <.text+0x7c8>
     77c:	eb000368 	bl	1524 <USBRegisterDescriptors>
     780:	e59f0044 	ldr	r0, [pc, #68]	; 7cc <.text+0x7cc>
     784:	eb00036a 	bl	1534 <USBRegisterCustomReqHandler>
     788:	e59f2040 	ldr	r2, [pc, #64]	; 7d0 <.text+0x7d0>
     78c:	e3a00001 	mov	r0, #1	; 0x1
     790:	e59f103c 	ldr	r1, [pc, #60]	; 7d4 <.text+0x7d4>
     794:	eb00028e 	bl	11d4 <USBRegisterRequestHandler>
     798:	e3a01000 	mov	r1, #0	; 0x0
     79c:	e3a00081 	mov	r0, #129	; 0x81
     7a0:	eb000263 	bl	1134 <USBHwRegisterEPIntHandler>
     7a4:	e59f002c 	ldr	r0, [pc, #44]	; 7d8 <.text+0x7d8>
     7a8:	eb00024b 	bl	10dc <USBHwRegisterFrameHandler>
     7ac:	e59f0028 	ldr	r0, [pc, #40]	; 7dc <.text+0x7dc>
     7b0:	ebffffdc 	bl	728 <puts>
     7b4:	e3a00001 	mov	r0, #1	; 0x1
     7b8:	eb0000b3 	bl	a8c <USBHwConnect>
     7bc:	eb000148 	bl	ce4 <USBHwISR>
     7c0:	eafffffd 	b	7bc <main+0x60>
     7c4:	00001c9c 	muleq	r0, ip, ip
     7c8:	00001bac 	andeq	r1, r0, ip, lsr #23
     7cc:	000008f8 	streqd	r0, [r0], -r8
     7d0:	40000264 	andmi	r0, r0, r4, ror #4
     7d4:	00000844 	andeq	r0, r0, r4, asr #16
     7d8:	000007e0 	andeq	r0, r0, r0, ror #15
     7dc:	00001cb4 	streqh	r1, [r0], -r4

000007e0 <HandleFrame>:
     7e0:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
     7e4:	e59f604c 	ldr	r6, [pc, #76]	; 838 <.text+0x838>
     7e8:	e5963000 	ldr	r3, [r6]
     7ec:	e2833001 	add	r3, r3, #1	; 0x1
     7f0:	e3530ffa 	cmp	r3, #1000	; 0x3e8
     7f4:	e5863000 	str	r3, [r6]
     7f8:	d8bd8070 	ldmleia	sp!, {r4, r5, r6, pc}
     7fc:	e59f5038 	ldr	r5, [pc, #56]	; 83c <.text+0x83c>
     800:	e59fc038 	ldr	ip, [pc, #56]	; 840 <.text+0x840>
     804:	e5953000 	ldr	r3, [r5]
     808:	e1a0100c 	mov	r1, ip
     80c:	e283e001 	add	lr, r3, #1	; 0x1
     810:	e1a04443 	mov	r4, r3, asr #8
     814:	e3a00081 	mov	r0, #129	; 0x81
     818:	e3a02004 	mov	r2, #4	; 0x4
     81c:	e5cc3001 	strb	r3, [ip, #1]
     820:	e585e000 	str	lr, [r5]
     824:	e5cc4000 	strb	r4, [ip]
     828:	eb0000b6 	bl	b08 <USBHwEPWrite>
     82c:	e3a03000 	mov	r3, #0	; 0x0
     830:	e5863000 	str	r3, [r6]
     834:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
     838:	40000258 	andmi	r0, r0, r8, asr r2
     83c:	4000025c 	andmi	r0, r0, ip, asr r2
     840:	40000200 	andmi	r0, r0, r0, lsl #4

00000844 <HandleClassRequest>:
     844:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
     848:	e5d03001 	ldrb	r3, [r0, #1]
     84c:	e3530002 	cmp	r3, #2	; 0x2
     850:	e1a04000 	mov	r4, r0
     854:	e1a06001 	mov	r6, r1
     858:	e5925000 	ldr	r5, [r2]
     85c:	0a000002 	beq	86c <HandleClassRequest+0x28>
     860:	e353000a 	cmp	r3, #10	; 0xa
     864:	1a00001a 	bne	8d4 <HandleClassRequest+0x90>
     868:	ea00000e 	b	8a8 <HandleClassRequest+0x64>
     86c:	e1d020b4 	ldrh	r2, [r0, #4]
     870:	e1d410b2 	ldrh	r1, [r4, #2]
     874:	e59f006c 	ldr	r0, [pc, #108]	; 8e8 <.text+0x8e8>
     878:	ebffff74 	bl	650 <printf>
     87c:	e59f3068 	ldr	r3, [pc, #104]	; 8ec <.text+0x8ec>
     880:	e5933000 	ldr	r3, [r3]
     884:	e2832003 	add	r2, r3, #3	; 0x3
     888:	e3530000 	cmp	r3, #0	; 0x0
     88c:	b1a03002 	movlt	r3, r2
     890:	e3a02001 	mov	r2, #1	; 0x1
     894:	e1a03143 	mov	r3, r3, asr #2
     898:	e1a00002 	mov	r0, r2
     89c:	e5c53000 	strb	r3, [r5]
     8a0:	e5862000 	str	r2, [r6]
     8a4:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
     8a8:	e1d420b4 	ldrh	r2, [r4, #4]
     8ac:	e59f003c 	ldr	r0, [pc, #60]	; 8f0 <.text+0x8f0>
     8b0:	e1d410b2 	ldrh	r1, [r4, #2]
     8b4:	ebffff65 	bl	650 <printf>
     8b8:	e1d430b2 	ldrh	r3, [r4, #2]
     8bc:	e59f2028 	ldr	r2, [pc, #40]	; 8ec <.text+0x8ec>
     8c0:	e1a03423 	mov	r3, r3, lsr #8
     8c4:	e1a03103 	mov	r3, r3, lsl #2
     8c8:	e3a00001 	mov	r0, #1	; 0x1
     8cc:	e5823000 	str	r3, [r2]
     8d0:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
     8d4:	e1a01003 	mov	r1, r3
     8d8:	e59f0014 	ldr	r0, [pc, #20]	; 8f4 <.text+0x8f4>
     8dc:	ebffff5b 	bl	650 <printf>
     8e0:	e3a00000 	mov	r0, #0	; 0x0
     8e4:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
     8e8:	00001cd0 	ldreqd	r1, [r0], -r0
     8ec:	40000260 	andmi	r0, r0, r0, ror #4
     8f0:	00001cec 	andeq	r1, r0, ip, ror #25
     8f4:	00001d08 	andeq	r1, r0, r8, lsl #26

000008f8 <HIDHandleStdReq>:
     8f8:	e92d4010 	stmdb	sp!, {r4, lr}
     8fc:	e1a0c000 	mov	ip, r0
     900:	e59f3050 	ldr	r3, [pc, #80]	; 958 <.text+0x958>
     904:	e1d000b0 	ldrh	r0, [r0]
     908:	e1500003 	cmp	r0, r3
     90c:	e1a04001 	mov	r4, r1
     910:	e1a0e002 	mov	lr, r2
     914:	13a00000 	movne	r0, #0	; 0x0
     918:	18bd8010 	ldmneia	sp!, {r4, pc}
     91c:	e1dc00b2 	ldrh	r0, [ip, #2]
     920:	e1a03420 	mov	r3, r0, lsr #8
     924:	e3530022 	cmp	r3, #34	; 0x22
     928:	1a000005 	bne	944 <HIDHandleStdReq+0x4c>
     92c:	e59f3028 	ldr	r3, [pc, #40]	; 95c <.text+0x95c>
     930:	e3a00001 	mov	r0, #1	; 0x1
     934:	e5823000 	str	r3, [r2]
     938:	e3a0304d 	mov	r3, #77	; 0x4d
     93c:	e5813000 	str	r3, [r1]
     940:	e8bd8010 	ldmia	sp!, {r4, pc}
     944:	e1dc10b4 	ldrh	r1, [ip, #4]
     948:	e1a02004 	mov	r2, r4
     94c:	e1a0300e 	mov	r3, lr
     950:	e8bd4010 	ldmia	sp!, {r4, lr}
     954:	ea0002fa 	b	1544 <USBGetDescriptor>
     958:	00000681 	andeq	r0, r0, r1, lsl #13
     95c:	40000208 	andmi	r0, r0, r8, lsl #4

00000960 <USBHwCmd>:
     960:	e1a00800 	mov	r0, r0, lsl #16
     964:	e59f2028 	ldr	r2, [pc, #40]	; 994 <.text+0x994>
     968:	e20008ff 	and	r0, r0, #16711680	; 0xff0000
     96c:	e3800c05 	orr	r0, r0, #1280	; 0x500
     970:	e3a03030 	mov	r3, #48	; 0x30
     974:	e5023df7 	str	r3, [r2, #-3575]
     978:	e5020def 	str	r0, [r2, #-3567]
     97c:	e5123dff 	ldr	r3, [r2, #-3583]
     980:	e2033010 	and	r3, r3, #16	; 0x10
     984:	e3530010 	cmp	r3, #16	; 0x10
     988:	1afffffb 	bne	97c <USBHwCmd+0x1c>
     98c:	e5023df7 	str	r3, [r2, #-3575]
     990:	e12fff1e 	bx	lr
     994:	ffe0cfff 	undefined instruction 0xffe0cfff

00000998 <USBHwCmdWrite>:
     998:	e92d4010 	stmdb	sp!, {r4, lr}
     99c:	e1a04801 	mov	r4, r1, lsl #16
     9a0:	e20000ff 	and	r0, r0, #255	; 0xff
     9a4:	e1a04824 	mov	r4, r4, lsr #16
     9a8:	ebffffec 	bl	960 <USBHwCmd>
     9ac:	e1a04804 	mov	r4, r4, lsl #16
     9b0:	e59f3020 	ldr	r3, [pc, #32]	; 9d8 <.text+0x9d8>
     9b4:	e3844c01 	orr	r4, r4, #256	; 0x100
     9b8:	e5034def 	str	r4, [r3, #-3567]
     9bc:	e1a02003 	mov	r2, r3
     9c0:	e5123dff 	ldr	r3, [r2, #-3583]
     9c4:	e2033010 	and	r3, r3, #16	; 0x10
     9c8:	e3530010 	cmp	r3, #16	; 0x10
     9cc:	1afffffb 	bne	9c0 <USBHwCmdWrite+0x28>
     9d0:	e5023df7 	str	r3, [r2, #-3575]
     9d4:	e8bd8010 	ldmia	sp!, {r4, pc}
     9d8:	ffe0cfff 	undefined instruction 0xffe0cfff

000009dc <USBHwCmdRead>:
     9dc:	e92d4010 	stmdb	sp!, {r4, lr}
     9e0:	e20040ff 	and	r4, r0, #255	; 0xff
     9e4:	e1a00004 	mov	r0, r4
     9e8:	ebffffdc 	bl	960 <USBHwCmd>
     9ec:	e1a04804 	mov	r4, r4, lsl #16
     9f0:	e59f3028 	ldr	r3, [pc, #40]	; a20 <.text+0xa20>
     9f4:	e3844c02 	orr	r4, r4, #512	; 0x200
     9f8:	e5034def 	str	r4, [r3, #-3567]
     9fc:	e1a02003 	mov	r2, r3
     a00:	e5123dff 	ldr	r3, [r2, #-3583]
     a04:	e2033020 	and	r3, r3, #32	; 0x20
     a08:	e3530020 	cmp	r3, #32	; 0x20
     a0c:	1afffffb 	bne	a00 <USBHwCmdRead+0x24>
     a10:	e5023df7 	str	r3, [r2, #-3575]
     a14:	e5120deb 	ldr	r0, [r2, #-3563]
     a18:	e20000ff 	and	r0, r0, #255	; 0xff
     a1c:	e8bd8010 	ldmia	sp!, {r4, pc}
     a20:	ffe0cfff 	undefined instruction 0xffe0cfff

00000a24 <USBHwEPConfig>:
     a24:	e59fc04c 	ldr	ip, [pc, #76]	; a78 <.text+0xa78>
     a28:	e200300f 	and	r3, r0, #15	; 0xf
     a2c:	e51c2dbb 	ldr	r2, [ip, #-3515]
     a30:	e1a03083 	mov	r3, r3, lsl #1
     a34:	e2000080 	and	r0, r0, #128	; 0x80
     a38:	e18303a0 	orr	r0, r3, r0, lsr #7
     a3c:	e3a03001 	mov	r3, #1	; 0x1
     a40:	e1822013 	orr	r2, r2, r3, lsl r0
     a44:	e1a01801 	mov	r1, r1, lsl #16
     a48:	e1a01821 	mov	r1, r1, lsr #16
     a4c:	e50c2dbb 	str	r2, [ip, #-3515]
     a50:	e50c0db7 	str	r0, [ip, #-3511]
     a54:	e50c1db3 	str	r1, [ip, #-3507]
     a58:	e51c3dff 	ldr	r3, [ip, #-3583]
     a5c:	e2033c01 	and	r3, r3, #256	; 0x100
     a60:	e3530c01 	cmp	r3, #256	; 0x100
     a64:	1afffffb 	bne	a58 <USBHwEPConfig+0x34>
     a68:	e3800040 	orr	r0, r0, #64	; 0x40
     a6c:	e3a01000 	mov	r1, #0	; 0x0
     a70:	e50c3df7 	str	r3, [ip, #-3575]
     a74:	eaffffc7 	b	998 <USBHwCmdWrite>
     a78:	ffe0cfff 	undefined instruction 0xffe0cfff

00000a7c <USBHwSetAddress>:
     a7c:	e200107f 	and	r1, r0, #127	; 0x7f
     a80:	e3811080 	orr	r1, r1, #128	; 0x80
     a84:	e3a000d0 	mov	r0, #208	; 0xd0
     a88:	eaffffc2 	b	998 <USBHwCmdWrite>

00000a8c <USBHwConnect>:
     a8c:	e3500000 	cmp	r0, #0	; 0x0
     a90:	159f3020 	ldrne	r3, [pc, #32]	; ab8 <.text+0xab8>
     a94:	059f301c 	ldreq	r3, [pc, #28]	; ab8 <.text+0xab8>
     a98:	13a02901 	movne	r2, #16384	; 0x4000
     a9c:	03a02901 	moveq	r2, #16384	; 0x4000
     aa0:	15032fe3 	strne	r2, [r3, #-4067]
     aa4:	05032fe7 	streq	r2, [r3, #-4071]
     aa8:	e2501000 	subs	r1, r0, #0	; 0x0
     aac:	13a01001 	movne	r1, #1	; 0x1
     ab0:	e3a000fe 	mov	r0, #254	; 0xfe
     ab4:	eaffffb7 	b	998 <USBHwCmdWrite>
     ab8:	3fffcfff 	svccc	0x00ffcfff

00000abc <USBHwNakIntEnable>:
     abc:	e20010ff 	and	r1, r0, #255	; 0xff
     ac0:	e3a000f3 	mov	r0, #243	; 0xf3
     ac4:	eaffffb3 	b	998 <USBHwCmdWrite>

00000ac8 <USBHwEPGetStatus>:
     ac8:	e1a03000 	mov	r3, r0
     acc:	e200000f 	and	r0, r0, #15	; 0xf
     ad0:	e2033080 	and	r3, r3, #128	; 0x80
     ad4:	e1a00080 	mov	r0, r0, lsl #1
     ad8:	e52de004 	str	lr, [sp, #-4]!
     adc:	e18003a3 	orr	r0, r0, r3, lsr #7
     ae0:	ebffffbd 	bl	9dc <USBHwCmdRead>
     ae4:	e49df004 	ldr	pc, [sp], #4

00000ae8 <USBHwEPStall>:
     ae8:	e200300f 	and	r3, r0, #15	; 0xf
     aec:	e1a03083 	mov	r3, r3, lsl #1
     af0:	e2000080 	and	r0, r0, #128	; 0x80
     af4:	e18333a0 	orr	r3, r3, r0, lsr #7
     af8:	e2511000 	subs	r1, r1, #0	; 0x0
     afc:	13a01001 	movne	r1, #1	; 0x1
     b00:	e3830040 	orr	r0, r3, #64	; 0x40
     b04:	eaffffa3 	b	998 <USBHwCmdWrite>

00000b08 <USBHwEPWrite>:
     b08:	e92d40f0 	stmdb	sp!, {r4, r5, r6, r7, lr}
     b0c:	e59fc07c 	ldr	ip, [pc, #124]	; b90 <.text+0xb90>
     b10:	e200500f 	and	r5, r0, #15	; 0xf
     b14:	e1a03105 	mov	r3, r5, lsl #2
     b18:	e3833002 	orr	r3, r3, #2	; 0x2
     b1c:	e1a06002 	mov	r6, r2
     b20:	e1a0e001 	mov	lr, r1
     b24:	e1a0400c 	mov	r4, ip
     b28:	e20070ff 	and	r7, r0, #255	; 0xff
     b2c:	e50c3dd7 	str	r3, [ip, #-3543]
     b30:	e50c2ddb 	str	r2, [ip, #-3547]
     b34:	ea000008 	b	b5c <USBHwEPWrite+0x54>
     b38:	e55e3002 	ldrb	r3, [lr, #-2]
     b3c:	e55e2001 	ldrb	r2, [lr, #-1]
     b40:	e55e1004 	ldrb	r1, [lr, #-4]
     b44:	e1a03803 	mov	r3, r3, lsl #16
     b48:	e1833c02 	orr	r3, r3, r2, lsl #24
     b4c:	e55e2003 	ldrb	r2, [lr, #-3]
     b50:	e1833001 	orr	r3, r3, r1
     b54:	e1833402 	orr	r3, r3, r2, lsl #8
     b58:	e5003de3 	str	r3, [r0, #-3555]
     b5c:	e5143dd7 	ldr	r3, [r4, #-3543]
     b60:	e2133002 	ands	r3, r3, #2	; 0x2
     b64:	e28ee004 	add	lr, lr, #4	; 0x4
     b68:	e1a00004 	mov	r0, r4
     b6c:	1afffff1 	bne	b38 <USBHwEPWrite+0x30>
     b70:	e1a00085 	mov	r0, r5, lsl #1
     b74:	e18003a7 	orr	r0, r0, r7, lsr #7
     b78:	e5043dd7 	str	r3, [r4, #-3543]
     b7c:	ebffff77 	bl	960 <USBHwCmd>
     b80:	e3a000fa 	mov	r0, #250	; 0xfa
     b84:	ebffff75 	bl	960 <USBHwCmd>
     b88:	e1a00006 	mov	r0, r6
     b8c:	e8bd80f0 	ldmia	sp!, {r4, r5, r6, r7, pc}
     b90:	ffe0cfff 	undefined instruction 0xffe0cfff

00000b94 <USBHwEPRead>:
     b94:	e92d4030 	stmdb	sp!, {r4, r5, lr}
     b98:	e200e00f 	and	lr, r0, #15	; 0xf
     b9c:	e59fc088 	ldr	ip, [pc, #136]	; c2c <.text+0xc2c>
     ba0:	e1a0310e 	mov	r3, lr, lsl #2
     ba4:	e3833001 	orr	r3, r3, #1	; 0x1
     ba8:	e50c3dd7 	str	r3, [ip, #-3543]
     bac:	e20050ff 	and	r5, r0, #255	; 0xff
     bb0:	e51c3ddf 	ldr	r3, [ip, #-3551]
     bb4:	e3130b02 	tst	r3, #2048	; 0x800
     bb8:	0afffffc 	beq	bb0 <USBHwEPRead+0x1c>
     bbc:	e3130b01 	tst	r3, #1024	; 0x400
     bc0:	03e04000 	mvneq	r4, #0	; 0x0
     bc4:	0a000016 	beq	c24 <USBHwEPRead+0x90>
     bc8:	e1a03b03 	mov	r3, r3, lsl #22
     bcc:	e3a04000 	mov	r4, #0	; 0x0
     bd0:	e59fc054 	ldr	ip, [pc, #84]	; c2c <.text+0xc2c>
     bd4:	e1a03b23 	mov	r3, r3, lsr #22
     bd8:	e1a00004 	mov	r0, r4
     bdc:	ea000006 	b	bfc <USBHwEPRead+0x68>
     be0:	e3140003 	tst	r4, #3	; 0x3
     be4:	051c0de7 	ldreq	r0, [ip, #-3559]
     be8:	e3510000 	cmp	r1, #0	; 0x0
     bec:	11540002 	cmpne	r4, r2
     bf0:	b7c40001 	strltb	r0, [r4, r1]
     bf4:	e2844001 	add	r4, r4, #1	; 0x1
     bf8:	e1a00420 	mov	r0, r0, lsr #8
     bfc:	e1540003 	cmp	r4, r3
     c00:	1afffff6 	bne	be0 <USBHwEPRead+0x4c>
     c04:	e59f3020 	ldr	r3, [pc, #32]	; c2c <.text+0xc2c>
     c08:	e1a0008e 	mov	r0, lr, lsl #1
     c0c:	e3a02000 	mov	r2, #0	; 0x0
     c10:	e18003a5 	orr	r0, r0, r5, lsr #7
     c14:	e5032dd7 	str	r2, [r3, #-3543]
     c18:	ebffff50 	bl	960 <USBHwCmd>
     c1c:	e3a000f2 	mov	r0, #242	; 0xf2
     c20:	ebffff4e 	bl	960 <USBHwCmd>
     c24:	e1a00004 	mov	r0, r4
     c28:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
     c2c:	ffe0cfff 	undefined instruction 0xffe0cfff

00000c30 <USBHwISOCEPRead>:
     c30:	e92d4030 	stmdb	sp!, {r4, r5, lr}
     c34:	e200e00f 	and	lr, r0, #15	; 0xf
     c38:	e1a0310e 	mov	r3, lr, lsl #2
     c3c:	e59fc08c 	ldr	ip, [pc, #140]	; cd0 <.text+0xcd0>
     c40:	e3833001 	orr	r3, r3, #1	; 0x1
     c44:	e50c3dd7 	str	r3, [ip, #-3543]
     c48:	e20050ff 	and	r5, r0, #255	; 0xff
     c4c:	e1a00000 	nop			(mov r0,r0)
     c50:	e51c3ddf 	ldr	r3, [ip, #-3551]
     c54:	e2130b02 	ands	r0, r3, #2048	; 0x800
     c58:	0a000001 	beq	c64 <USBHwISOCEPRead+0x34>
     c5c:	e2130b01 	ands	r0, r3, #1024	; 0x400
     c60:	1a000002 	bne	c70 <USBHwISOCEPRead+0x40>
     c64:	e3e04000 	mvn	r4, #0	; 0x0
     c68:	e50c0dd7 	str	r0, [ip, #-3543]
     c6c:	ea000015 	b	cc8 <USBHwISOCEPRead+0x98>
     c70:	e1a03b03 	mov	r3, r3, lsl #22
     c74:	e3a04000 	mov	r4, #0	; 0x0
     c78:	e1a03b23 	mov	r3, r3, lsr #22
     c7c:	e1a00004 	mov	r0, r4
     c80:	ea000006 	b	ca0 <USBHwISOCEPRead+0x70>
     c84:	e3140003 	tst	r4, #3	; 0x3
     c88:	051c0de7 	ldreq	r0, [ip, #-3559]
     c8c:	e3510000 	cmp	r1, #0	; 0x0
     c90:	11540002 	cmpne	r4, r2
     c94:	b7c40001 	strltb	r0, [r4, r1]
     c98:	e2844001 	add	r4, r4, #1	; 0x1
     c9c:	e1a00420 	mov	r0, r0, lsr #8
     ca0:	e1540003 	cmp	r4, r3
     ca4:	1afffff6 	bne	c84 <USBHwISOCEPRead+0x54>
     ca8:	e59f3020 	ldr	r3, [pc, #32]	; cd0 <.text+0xcd0>
     cac:	e1a0008e 	mov	r0, lr, lsl #1
     cb0:	e3a02000 	mov	r2, #0	; 0x0
     cb4:	e18003a5 	orr	r0, r0, r5, lsr #7
     cb8:	e5032dd7 	str	r2, [r3, #-3543]
     cbc:	ebffff27 	bl	960 <USBHwCmd>
     cc0:	e3a000f2 	mov	r0, #242	; 0xf2
     cc4:	ebffff25 	bl	960 <USBHwCmd>
     cc8:	e1a00004 	mov	r0, r4
     ccc:	e8bd8030 	ldmia	sp!, {r4, r5, pc}
     cd0:	ffe0cfff 	undefined instruction 0xffe0cfff

00000cd4 <USBHwConfigDevice>:
     cd4:	e2501000 	subs	r1, r0, #0	; 0x0
     cd8:	13a01001 	movne	r1, #1	; 0x1
     cdc:	e3a000d8 	mov	r0, #216	; 0xd8
     ce0:	eaffff2c 	b	998 <USBHwCmdWrite>

00000ce4 <USBHwISR>:
     ce4:	e59f3144 	ldr	r3, [pc, #324]	; e30 <.text+0xe30>
     ce8:	e3a02002 	mov	r2, #2	; 0x2
     cec:	e5032fa7 	str	r2, [r3, #-4007]
     cf0:	e59f213c 	ldr	r2, [pc, #316]	; e34 <.text+0xe34>
     cf4:	e92d45f0 	stmdb	sp!, {r4, r5, r6, r7, r8, sl, lr}
     cf8:	e5126dff 	ldr	r6, [r2, #-3583]
     cfc:	e3160001 	tst	r6, #1	; 0x1
     d00:	0a00000b 	beq	d34 <USBHwISR+0x50>
     d04:	e59f312c 	ldr	r3, [pc, #300]	; e38 <.text+0xe38>
     d08:	e5934000 	ldr	r4, [r3]
     d0c:	e3a03001 	mov	r3, #1	; 0x1
     d10:	e3540000 	cmp	r4, #0	; 0x0
     d14:	e5023df7 	str	r3, [r2, #-3575]
     d18:	0a000005 	beq	d34 <USBHwISR+0x50>
     d1c:	e3a000f5 	mov	r0, #245	; 0xf5
     d20:	ebffff2d 	bl	9dc <USBHwCmdRead>
     d24:	e1a00800 	mov	r0, r0, lsl #16
     d28:	e1a00820 	mov	r0, r0, lsr #16
     d2c:	e1a0e00f 	mov	lr, pc
     d30:	e12fff14 	bx	r4
     d34:	e3160008 	tst	r6, #8	; 0x8
     d38:	0a000011 	beq	d84 <USBHwISR+0xa0>
     d3c:	e59f30f0 	ldr	r3, [pc, #240]	; e34 <.text+0xe34>
     d40:	e3a02008 	mov	r2, #8	; 0x8
     d44:	e3a000fe 	mov	r0, #254	; 0xfe
     d48:	e5032df7 	str	r2, [r3, #-3575]
     d4c:	ebffff22 	bl	9dc <USBHwCmdRead>
     d50:	e310001a 	tst	r0, #26	; 0x1a
     d54:	0a00000a 	beq	d84 <USBHwISR+0xa0>
     d58:	e59f30dc 	ldr	r3, [pc, #220]	; e3c <.text+0xe3c>
     d5c:	e5933000 	ldr	r3, [r3]
     d60:	e3530000 	cmp	r3, #0	; 0x0
     d64:	0a000006 	beq	d84 <USBHwISR+0xa0>
     d68:	e59f50c0 	ldr	r5, [pc, #192]	; e30 <.text+0xe30>
     d6c:	e3a04001 	mov	r4, #1	; 0x1
     d70:	e5054fa7 	str	r4, [r5, #-4007]
     d74:	e2000015 	and	r0, r0, #21	; 0x15
     d78:	e1a0e00f 	mov	lr, pc
     d7c:	e12fff13 	bx	r3
     d80:	e5054fa3 	str	r4, [r5, #-4003]
     d84:	e3160004 	tst	r6, #4	; 0x4
     d88:	0a000024 	beq	e20 <USBHwISR+0x13c>
     d8c:	e59f30a0 	ldr	r3, [pc, #160]	; e34 <.text+0xe34>
     d90:	e3a02004 	mov	r2, #4	; 0x4
     d94:	e5032df7 	str	r2, [r3, #-3575]
     d98:	e59fa0a0 	ldr	sl, [pc, #160]	; e40 <.text+0xe40>
     d9c:	e59f708c 	ldr	r7, [pc, #140]	; e30 <.text+0xe30>
     da0:	e1a05003 	mov	r5, r3
     da4:	e1a06002 	mov	r6, r2
     da8:	e3a04000 	mov	r4, #0	; 0x0
     dac:	e3a08001 	mov	r8, #1	; 0x1
     db0:	e1a02418 	mov	r2, r8, lsl r4
     db4:	e5153dcf 	ldr	r3, [r5, #-3535]
     db8:	e1120003 	tst	r2, r3
     dbc:	0a000014 	beq	e14 <USBHwISR+0x130>
     dc0:	e5052dc7 	str	r2, [r5, #-3527]
     dc4:	e5153dff 	ldr	r3, [r5, #-3583]
     dc8:	e2032020 	and	r2, r3, #32	; 0x20
     dcc:	e3520020 	cmp	r2, #32	; 0x20
     dd0:	1afffffb 	bne	dc4 <USBHwISR+0xe0>
     dd4:	e0843fa4 	add	r3, r4, r4, lsr #31
     dd8:	e1a030c3 	mov	r3, r3, asr #1
     ddc:	e79a3103 	ldr	r3, [sl, r3, lsl #2]
     de0:	e5052df7 	str	r2, [r5, #-3575]
     de4:	e3530000 	cmp	r3, #0	; 0x0
     de8:	e5151deb 	ldr	r1, [r5, #-3563]
     dec:	0a000008 	beq	e14 <USBHwISR+0x130>
     df0:	e1a000c4 	mov	r0, r4, asr #1
     df4:	e200000f 	and	r0, r0, #15	; 0xf
     df8:	e1800384 	orr	r0, r0, r4, lsl #7
     dfc:	e5076fa7 	str	r6, [r7, #-4007]
     e00:	e200008f 	and	r0, r0, #143	; 0x8f
     e04:	e201101f 	and	r1, r1, #31	; 0x1f
     e08:	e1a0e00f 	mov	lr, pc
     e0c:	e12fff13 	bx	r3
     e10:	e5076fa3 	str	r6, [r7, #-4003]
     e14:	e2844001 	add	r4, r4, #1	; 0x1
     e18:	e3540020 	cmp	r4, #32	; 0x20
     e1c:	1affffe3 	bne	db0 <USBHwISR+0xcc>
     e20:	e59f3008 	ldr	r3, [pc, #8]	; e30 <.text+0xe30>
     e24:	e3a02002 	mov	r2, #2	; 0x2
     e28:	e5032fa3 	str	r2, [r3, #-4003]
     e2c:	e8bd85f0 	ldmia	sp!, {r4, r5, r6, r7, r8, sl, pc}
     e30:	3fffcfff 	svccc	0x00ffcfff
     e34:	ffe0cfff 	undefined instruction 0xffe0cfff
     e38:	40000268 	andmi	r0, r0, r8, ror #4
     e3c:	4000026c 	andmi	r0, r0, ip, ror #4
     e40:	40000270 	andmi	r0, r0, r0, ror r2

00000e44 <USBHwInit>:
     e44:	e59f2124 	ldr	r2, [pc, #292]	; f70 <.text+0xf70>
     e48:	e5923004 	ldr	r3, [r2, #4]
     e4c:	e3c33103 	bic	r3, r3, #-1073741824	; 0xc0000000
     e50:	e3833101 	orr	r3, r3, #1073741824	; 0x40000000
     e54:	e5823004 	str	r3, [r2, #4]
     e58:	e592300c 	ldr	r3, [r2, #12]
     e5c:	e3c33203 	bic	r3, r3, #805306368	; 0x30000000
     e60:	e3833202 	orr	r3, r3, #536870912	; 0x20000000
     e64:	e582300c 	str	r3, [r2, #12]
     e68:	e5923000 	ldr	r3, [r2]
     e6c:	e3c3330f 	bic	r3, r3, #1006632960	; 0x3c000000
     e70:	e3833301 	orr	r3, r3, #67108864	; 0x4000000
     e74:	e5823000 	str	r3, [r2]
     e78:	e59f20f4 	ldr	r2, [pc, #244]	; f74 <.text+0xf74>
     e7c:	e5123fff 	ldr	r3, [r2, #-4095]
     e80:	e3833901 	orr	r3, r3, #16384	; 0x4000
     e84:	e5023fff 	str	r3, [r2, #-4095]
     e88:	e3a03901 	mov	r3, #16384	; 0x4000
     e8c:	e5023fe7 	str	r3, [r2, #-4071]
     e90:	e59f20e0 	ldr	r2, [pc, #224]	; f78 <.text+0xf78>
     e94:	e59230c4 	ldr	r3, [r2, #196]
     e98:	e92d4010 	stmdb	sp!, {r4, lr}
     e9c:	e3833102 	orr	r3, r3, #-2147483648	; 0x80000000
     ea0:	e58230c4 	str	r3, [r2, #196]
     ea4:	e59f10d0 	ldr	r1, [pc, #208]	; f7c <.text+0xf7c>
     ea8:	e3a03005 	mov	r3, #5	; 0x5
     eac:	e5823108 	str	r3, [r2, #264]
     eb0:	e2833015 	add	r3, r3, #21	; 0x15
     eb4:	e501300b 	str	r3, [r1, #-11]
     eb8:	e5113007 	ldr	r3, [r1, #-7]
     ebc:	e313001a 	tst	r3, #26	; 0x1a
     ec0:	0afffffc 	beq	eb8 <USBHwInit+0x74>
     ec4:	e3a04000 	mov	r4, #0	; 0x0
     ec8:	e3e02000 	mvn	r2, #0	; 0x0
     ecc:	e3a03003 	mov	r3, #3	; 0x3
     ed0:	e5013eef 	str	r3, [r1, #-3823]
     ed4:	e1a00004 	mov	r0, r4
     ed8:	e5014dfb 	str	r4, [r1, #-3579]
     edc:	e5012df7 	str	r2, [r1, #-3575]
     ee0:	e5014dd3 	str	r4, [r1, #-3539]
     ee4:	e5014dcb 	str	r4, [r1, #-3531]
     ee8:	e5012dc7 	str	r2, [r1, #-3527]
     eec:	e5014dbf 	str	r4, [r1, #-3519]
     ef0:	ebfffef1 	bl	abc <USBHwNakIntEnable>
     ef4:	e59f107c 	ldr	r1, [pc, #124]	; f78 <.text+0xf78>
     ef8:	e59131a0 	ldr	r3, [r1, #416]
     efc:	e59fc06c 	ldr	ip, [pc, #108]	; f70 <.text+0xf70>
     f00:	e3833001 	orr	r3, r3, #1	; 0x1
     f04:	e58131a0 	str	r3, [r1, #416]
     f08:	e59f2064 	ldr	r2, [pc, #100]	; f74 <.text+0xf74>
     f0c:	e58c4028 	str	r4, [ip, #40]
     f10:	e5123fbf 	ldr	r3, [r2, #-4031]
     f14:	e3a00001 	mov	r0, #1	; 0x1
     f18:	e3833001 	orr	r3, r3, #1	; 0x1
     f1c:	e5023fbf 	str	r3, [r2, #-4031]
     f20:	e5020fa3 	str	r0, [r2, #-4003]
     f24:	e59131a0 	ldr	r3, [r1, #416]
     f28:	e1833000 	orr	r3, r3, r0
     f2c:	e58131a0 	str	r3, [r1, #416]
     f30:	e58c4028 	str	r4, [ip, #40]
     f34:	e5123fbf 	ldr	r3, [r2, #-4031]
     f38:	e3833002 	orr	r3, r3, #2	; 0x2
     f3c:	e5023fbf 	str	r3, [r2, #-4031]
     f40:	e3a03002 	mov	r3, #2	; 0x2
     f44:	e5023fa3 	str	r3, [r2, #-4003]
     f48:	e59131a0 	ldr	r3, [r1, #416]
     f4c:	e1833000 	orr	r3, r3, r0
     f50:	e58131a0 	str	r3, [r1, #416]
     f54:	e58c4028 	str	r4, [ip, #40]
     f58:	e5123fbf 	ldr	r3, [r2, #-4031]
     f5c:	e3833004 	orr	r3, r3, #4	; 0x4
     f60:	e5023fbf 	str	r3, [r2, #-4031]
     f64:	e3a03004 	mov	r3, #4	; 0x4
     f68:	e5023fa3 	str	r3, [r2, #-4003]
     f6c:	e8bd8010 	ldmia	sp!, {r4, pc}
     f70:	e002c000 	and	ip, r2, r0
     f74:	3fffcfff 	svccc	0x00ffcfff
     f78:	e01fc000 	ands	ip, pc, r0
     f7c:	ffe0cfff 	undefined instruction 0xffe0cfff

00000f80 <USBSetupDMADescriptor>:
     f80:	e52de004 	str	lr, [sp, #-4]!
     f84:	e3a0e000 	mov	lr, #0	; 0x0
     f88:	e580e004 	str	lr, [r0, #4]
     f8c:	e5801000 	str	r1, [r0]
     f90:	e1a0c001 	mov	ip, r1
     f94:	e1a03b03 	mov	r3, r3, lsl #22
     f98:	e5901004 	ldr	r1, [r0, #4]
     f9c:	e1a03b23 	mov	r3, r3, lsr #22
     fa0:	e1811283 	orr	r1, r1, r3, lsl #5
     fa4:	e5801004 	str	r1, [r0, #4]
     fa8:	e1dd10b4 	ldrh	r1, [sp, #4]
     fac:	e5903004 	ldr	r3, [r0, #4]
     fb0:	e1833801 	orr	r3, r3, r1, lsl #16
     fb4:	e5803004 	str	r3, [r0, #4]
     fb8:	e21220ff 	ands	r2, r2, #255	; 0xff
     fbc:	15903004 	ldrne	r3, [r0, #4]
     fc0:	13833010 	orrne	r3, r3, #16	; 0x10
     fc4:	15803004 	strne	r3, [r0, #4]
     fc8:	e35c0000 	cmp	ip, #0	; 0x0
     fcc:	15903004 	ldrne	r3, [r0, #4]
     fd0:	e59d100c 	ldr	r1, [sp, #12]
     fd4:	13833004 	orrne	r3, r3, #4	; 0x4
     fd8:	15803004 	strne	r3, [r0, #4]
     fdc:	e59d3008 	ldr	r3, [sp, #8]
     fe0:	e3520000 	cmp	r2, #0	; 0x0
     fe4:	13510000 	cmpne	r1, #0	; 0x0
     fe8:	e5803008 	str	r3, [r0, #8]
     fec:	15801010 	strne	r1, [r0, #16]
     ff0:	e580e00c 	str	lr, [r0, #12]
     ff4:	e49df004 	ldr	pc, [sp], #4

00000ff8 <USBDisableDMAForEndpoint>:
     ff8:	e200200f 	and	r2, r0, #15	; 0xf
     ffc:	e1a02082 	mov	r2, r2, lsl #1
    1000:	e2000080 	and	r0, r0, #128	; 0x80
    1004:	e18223a0 	orr	r2, r2, r0, lsr #7
    1008:	e3a03001 	mov	r3, #1	; 0x1
    100c:	e1a03213 	mov	r3, r3, lsl r2
    1010:	e59f2004 	ldr	r2, [pc, #4]	; 101c <.text+0x101c>
    1014:	e5023d73 	str	r3, [r2, #-3443]
    1018:	e12fff1e 	bx	lr
    101c:	ffe0cfff 	undefined instruction 0xffe0cfff

00001020 <USBEnableDMAForEndpoint>:
    1020:	e200200f 	and	r2, r0, #15	; 0xf
    1024:	e1a02082 	mov	r2, r2, lsl #1
    1028:	e2000080 	and	r0, r0, #128	; 0x80
    102c:	e18223a0 	orr	r2, r2, r0, lsr #7
    1030:	e3a03001 	mov	r3, #1	; 0x1
    1034:	e1a03213 	mov	r3, r3, lsl r2
    1038:	e59f2004 	ldr	r2, [pc, #4]	; 1044 <.text+0x1044>
    103c:	e5023d77 	str	r3, [r2, #-3447]
    1040:	e12fff1e 	bx	lr
    1044:	ffe0cfff 	undefined instruction 0xffe0cfff

00001048 <USBInitializeISOCFrameArray>:
    1048:	e92d4030 	stmdb	sp!, {r4, r5, lr}
    104c:	e1a03b03 	mov	r3, r3, lsl #22
    1050:	e1a02802 	mov	r2, r2, lsl #16
    1054:	e1a03b23 	mov	r3, r3, lsr #22
    1058:	e1a05000 	mov	r5, r0
    105c:	e1a04001 	mov	r4, r1
    1060:	e1a0c822 	mov	ip, r2, lsr #16
    1064:	e3830902 	orr	r0, r3, #32768	; 0x8000
    1068:	e3a0e000 	mov	lr, #0	; 0x0
    106c:	ea000000 	b	1074 <USBInitializeISOCFrameArray+0x2c>
    1070:	e7851102 	str	r1, [r5, r2, lsl #2]
    1074:	e1a0280e 	mov	r2, lr, lsl #16
    1078:	e28c3001 	add	r3, ip, #1	; 0x1
    107c:	e1a02822 	mov	r2, r2, lsr #16
    1080:	e1a03803 	mov	r3, r3, lsl #16
    1084:	e1520004 	cmp	r2, r4
    1088:	e180180c 	orr	r1, r0, ip, lsl #16
    108c:	e28ee001 	add	lr, lr, #1	; 0x1
    1090:	e1a0c823 	mov	ip, r3, lsr #16
    1094:	3afffff5 	bcc	1070 <USBInitializeISOCFrameArray+0x28>
    1098:	e8bd8030 	ldmia	sp!, {r4, r5, pc}

0000109c <USBSetHeadDDForDMA>:
    109c:	e200300f 	and	r3, r0, #15	; 0xf
    10a0:	e1a03083 	mov	r3, r3, lsl #1
    10a4:	e2000080 	and	r0, r0, #128	; 0x80
    10a8:	e18333a0 	orr	r3, r3, r0, lsr #7
    10ac:	e7812103 	str	r2, [r1, r3, lsl #2]
    10b0:	e12fff1e 	bx	lr

000010b4 <USBInitializeUSBDMA>:
    10b4:	e3a03000 	mov	r3, #0	; 0x0
    10b8:	e1a02003 	mov	r2, r3
    10bc:	e7832000 	str	r2, [r3, r0]
    10c0:	e2833004 	add	r3, r3, #4	; 0x4
    10c4:	e3530080 	cmp	r3, #128	; 0x80
    10c8:	1afffffb 	bne	10bc <USBInitializeUSBDMA+0x8>
    10cc:	e59f3004 	ldr	r3, [pc, #4]	; 10d8 <.text+0x10d8>
    10d0:	e5030d7f 	str	r0, [r3, #-3455]
    10d4:	e12fff1e 	bx	lr
    10d8:	ffe0cfff 	undefined instruction 0xffe0cfff

000010dc <USBHwRegisterFrameHandler>:
    10dc:	e59f1018 	ldr	r1, [pc, #24]	; 10fc <.text+0x10fc>
    10e0:	e59f3018 	ldr	r3, [pc, #24]	; 1100 <.text+0x1100>
    10e4:	e5112dfb 	ldr	r2, [r1, #-3579]
    10e8:	e5830000 	str	r0, [r3]
    10ec:	e59f0010 	ldr	r0, [pc, #16]	; 1104 <.text+0x1104>
    10f0:	e3822001 	orr	r2, r2, #1	; 0x1
    10f4:	e5012dfb 	str	r2, [r1, #-3579]
    10f8:	eafffd8a 	b	728 <puts>
    10fc:	ffe0cfff 	undefined instruction 0xffe0cfff
    1100:	40000268 	andmi	r0, r0, r8, ror #4
    1104:	00001d1c 	andeq	r1, r0, ip, lsl sp

00001108 <USBHwRegisterDevIntHandler>:
    1108:	e59f1018 	ldr	r1, [pc, #24]	; 1128 <.text+0x1128>
    110c:	e59f3018 	ldr	r3, [pc, #24]	; 112c <.text+0x112c>
    1110:	e5112dfb 	ldr	r2, [r1, #-3579]
    1114:	e5830000 	str	r0, [r3]
    1118:	e59f0010 	ldr	r0, [pc, #16]	; 1130 <.text+0x1130>
    111c:	e3822008 	orr	r2, r2, #8	; 0x8
    1120:	e5012dfb 	str	r2, [r1, #-3579]
    1124:	eafffd7f 	b	728 <puts>
    1128:	ffe0cfff 	undefined instruction 0xffe0cfff
    112c:	4000026c 	andmi	r0, r0, ip, ror #4
    1130:	00001d3c 	andeq	r1, r0, ip, lsr sp

00001134 <USBHwRegisterEPIntHandler>:
    1134:	e92d4010 	stmdb	sp!, {r4, lr}
    1138:	e200300f 	and	r3, r0, #15	; 0xf
    113c:	e1a03083 	mov	r3, r3, lsl #1
    1140:	e2002080 	and	r2, r0, #128	; 0x80
    1144:	e183e3a2 	orr	lr, r3, r2, lsr #7
    1148:	e35e001f 	cmp	lr, #31	; 0x1f
    114c:	e1a04001 	mov	r4, r1
    1150:	e24dd004 	sub	sp, sp, #4	; 0x4
    1154:	e20010ff 	and	r1, r0, #255	; 0xff
    1158:	da000007 	ble	117c <USBHwRegisterEPIntHandler+0x48>
    115c:	e3a0c0d2 	mov	ip, #210	; 0xd2
    1160:	e59f0050 	ldr	r0, [pc, #80]	; 11b8 <.text+0x11b8>
    1164:	e59f1050 	ldr	r1, [pc, #80]	; 11bc <.text+0x11bc>
    1168:	e59f2050 	ldr	r2, [pc, #80]	; 11c0 <.text+0x11c0>
    116c:	e59f3050 	ldr	r3, [pc, #80]	; 11c4 <.text+0x11c4>
    1170:	e58dc000 	str	ip, [sp]
    1174:	ebfffd35 	bl	650 <printf>
    1178:	eafffffe 	b	1178 <USBHwRegisterEPIntHandler+0x44>
    117c:	e59fc044 	ldr	ip, [pc, #68]	; 11c8 <.text+0x11c8>
    1180:	e51c3dcb 	ldr	r3, [ip, #-3531]
    1184:	e3a02001 	mov	r2, #1	; 0x1
    1188:	e1833e12 	orr	r3, r3, r2, lsl lr
    118c:	e50c3dcb 	str	r3, [ip, #-3531]
    1190:	e51c2dfb 	ldr	r2, [ip, #-3579]
    1194:	e59f3030 	ldr	r3, [pc, #48]	; 11cc <.text+0x11cc>
    1198:	e59f0030 	ldr	r0, [pc, #48]	; 11d0 <.text+0x11d0>
    119c:	e3822004 	orr	r2, r2, #4	; 0x4
    11a0:	e1a0e0ae 	mov	lr, lr, lsr #1
    11a4:	e783410e 	str	r4, [r3, lr, lsl #2]
    11a8:	e50c2dfb 	str	r2, [ip, #-3579]
    11ac:	e28dd004 	add	sp, sp, #4	; 0x4
    11b0:	e8bd4010 	ldmia	sp!, {r4, lr}
    11b4:	eafffd25 	b	650 <printf>
    11b8:	00001d64 	andeq	r1, r0, r4, ror #26
    11bc:	00001d8c 	andeq	r1, r0, ip, lsl #27
    11c0:	00001d94 	muleq	r0, r4, sp
    11c4:	00001c18 	andeq	r1, r0, r8, lsl ip
    11c8:	ffe0cfff 	undefined instruction 0xffe0cfff
    11cc:	40000270 	andmi	r0, r0, r0, ror r2
    11d0:	00001da0 	andeq	r1, r0, r0, lsr #27

000011d4 <USBRegisterRequestHandler>:
    11d4:	e52de004 	str	lr, [sp, #-4]!
    11d8:	e3500000 	cmp	r0, #0	; 0x0
    11dc:	e24dd004 	sub	sp, sp, #4	; 0x4
    11e0:	aa000007 	bge	1204 <USBRegisterRequestHandler+0x30>
    11e4:	e3a0c0e2 	mov	ip, #226	; 0xe2
    11e8:	e59f0054 	ldr	r0, [pc, #84]	; 1244 <.text+0x1244>
    11ec:	e59f1054 	ldr	r1, [pc, #84]	; 1248 <.text+0x1248>
    11f0:	e59f2054 	ldr	r2, [pc, #84]	; 124c <.text+0x124c>
    11f4:	e59f3054 	ldr	r3, [pc, #84]	; 1250 <.text+0x1250>
    11f8:	e58dc000 	str	ip, [sp]
    11fc:	ebfffd13 	bl	650 <printf>
    1200:	eafffffe 	b	1200 <USBRegisterRequestHandler+0x2c>
    1204:	e3500003 	cmp	r0, #3	; 0x3
    1208:	da000007 	ble	122c <USBRegisterRequestHandler+0x58>
    120c:	e3a0c0e3 	mov	ip, #227	; 0xe3
    1210:	e59f002c 	ldr	r0, [pc, #44]	; 1244 <.text+0x1244>
    1214:	e59f1038 	ldr	r1, [pc, #56]	; 1254 <.text+0x1254>
    1218:	e59f202c 	ldr	r2, [pc, #44]	; 124c <.text+0x124c>
    121c:	e59f302c 	ldr	r3, [pc, #44]	; 1250 <.text+0x1250>
    1220:	e58dc000 	str	ip, [sp]
    1224:	ebfffd09 	bl	650 <printf>
    1228:	eafffffe 	b	1228 <USBRegisterRequestHandler+0x54>
    122c:	e59f3024 	ldr	r3, [pc, #36]	; 1258 <.text+0x1258>
    1230:	e7832100 	str	r2, [r3, r0, lsl #2]
    1234:	e59f3020 	ldr	r3, [pc, #32]	; 125c <.text+0x125c>
    1238:	e7831100 	str	r1, [r3, r0, lsl #2]
    123c:	e28dd004 	add	sp, sp, #4	; 0x4
    1240:	e8bd8000 	ldmia	sp!, {pc}
    1244:	00001d64 	andeq	r1, r0, r4, ror #26
    1248:	00001dc0 	andeq	r1, r0, r0, asr #27
    124c:	00001dcc 	andeq	r1, r0, ip, asr #27
    1250:	00001c34 	andeq	r1, r0, r4, lsr ip
    1254:	00001ddc 	ldreqd	r1, [r0], -ip
    1258:	400002c0 	andmi	r0, r0, r0, asr #5
    125c:	400002b0 	strmih	r0, [r0], -r0

00001260 <_HandleRequest>:
    1260:	e92d4010 	stmdb	sp!, {r4, lr}
    1264:	e5d03000 	ldrb	r3, [r0]
    1268:	e1a032a3 	mov	r3, r3, lsr #5
    126c:	e203c003 	and	ip, r3, #3	; 0x3
    1270:	e59f3028 	ldr	r3, [pc, #40]	; 12a0 <.text+0x12a0>
    1274:	e793410c 	ldr	r4, [r3, ip, lsl #2]
    1278:	e3540000 	cmp	r4, #0	; 0x0
    127c:	1a000004 	bne	1294 <_HandleRequest+0x34>
    1280:	e1a0100c 	mov	r1, ip
    1284:	e59f0018 	ldr	r0, [pc, #24]	; 12a4 <.text+0x12a4>
    1288:	ebfffcf0 	bl	650 <printf>
    128c:	e1a00004 	mov	r0, r4
    1290:	e8bd8010 	ldmia	sp!, {r4, pc}
    1294:	e1a0e00f 	mov	lr, pc
    1298:	e12fff14 	bx	r4
    129c:	e8bd8010 	ldmia	sp!, {r4, pc}
    12a0:	400002b0 	strmih	r0, [r0], -r0
    12a4:	00001de8 	andeq	r1, r0, r8, ror #27

000012a8 <StallControlPipe>:
    12a8:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
    12ac:	e1a03000 	mov	r3, r0
    12b0:	e3a01001 	mov	r1, #1	; 0x1
    12b4:	e3a00080 	mov	r0, #128	; 0x80
    12b8:	e20350ff 	and	r5, r3, #255	; 0xff
    12bc:	ebfffe09 	bl	ae8 <USBHwEPStall>
    12c0:	e59f0030 	ldr	r0, [pc, #48]	; 12f8 <.text+0x12f8>
    12c4:	ebfffce1 	bl	650 <printf>
    12c8:	e59f602c 	ldr	r6, [pc, #44]	; 12fc <.text+0x12fc>
    12cc:	e3a04000 	mov	r4, #0	; 0x0
    12d0:	e7d41006 	ldrb	r1, [r4, r6]
    12d4:	e59f0024 	ldr	r0, [pc, #36]	; 1300 <.text+0x1300>
    12d8:	e2844001 	add	r4, r4, #1	; 0x1
    12dc:	ebfffcdb 	bl	650 <printf>
    12e0:	e3540008 	cmp	r4, #8	; 0x8
    12e4:	1afffff9 	bne	12d0 <StallControlPipe+0x28>
    12e8:	e59f0014 	ldr	r0, [pc, #20]	; 1304 <.text+0x1304>
    12ec:	e1a01005 	mov	r1, r5
    12f0:	e8bd4070 	ldmia	sp!, {r4, r5, r6, lr}
    12f4:	eafffcd5 	b	650 <printf>
    12f8:	00001e04 	andeq	r1, r0, r4, lsl #28
    12fc:	400002d0 	ldrmid	r0, [r0], -r0
    1300:	00001e10 	andeq	r1, r0, r0, lsl lr
    1304:	00001e18 	andeq	r1, r0, r8, lsl lr

00001308 <DataIn>:
    1308:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
    130c:	e59f6038 	ldr	r6, [pc, #56]	; 134c <.text+0x134c>
    1310:	e5964000 	ldr	r4, [r6]
    1314:	e59f5034 	ldr	r5, [pc, #52]	; 1350 <.text+0x1350>
    1318:	e3540040 	cmp	r4, #64	; 0x40
    131c:	a3a04040 	movge	r4, #64	; 0x40
    1320:	e1a02004 	mov	r2, r4
    1324:	e3a00080 	mov	r0, #128	; 0x80
    1328:	e5951000 	ldr	r1, [r5]
    132c:	ebfffdf5 	bl	b08 <USBHwEPWrite>
    1330:	e5953000 	ldr	r3, [r5]
    1334:	e5962000 	ldr	r2, [r6]
    1338:	e0833004 	add	r3, r3, r4
    133c:	e0642002 	rsb	r2, r4, r2
    1340:	e5853000 	str	r3, [r5]
    1344:	e5862000 	str	r2, [r6]
    1348:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
    134c:	400002dc 	ldrmid	r0, [r0], -ip
    1350:	400002d8 	ldrmid	r0, [r0], -r8

00001354 <USBHandleControlTransfer>:
    1354:	e92d40f0 	stmdb	sp!, {r4, r5, r6, r7, lr}
    1358:	e21000ff 	ands	r0, r0, #255	; 0xff
    135c:	e24dd004 	sub	sp, sp, #4	; 0x4
    1360:	e20170ff 	and	r7, r1, #255	; 0xff
    1364:	1a000051 	bne	14b0 <USBHandleControlTransfer+0x15c>
    1368:	e3110004 	tst	r1, #4	; 0x4
    136c:	e59f6178 	ldr	r6, [pc, #376]	; 14ec <.text+0x14ec>
    1370:	0a000021 	beq	13fc <USBHandleControlTransfer+0xa8>
    1374:	e59f5174 	ldr	r5, [pc, #372]	; 14f0 <.text+0x14f0>
    1378:	e3a02008 	mov	r2, #8	; 0x8
    137c:	e1a01005 	mov	r1, r5
    1380:	ebfffe03 	bl	b94 <USBHwEPRead>
    1384:	e5d51001 	ldrb	r1, [r5, #1]
    1388:	e59f0164 	ldr	r0, [pc, #356]	; 14f4 <.text+0x14f4>
    138c:	ebfffcaf 	bl	650 <printf>
    1390:	e5d50000 	ldrb	r0, [r5]
    1394:	e59f215c 	ldr	r2, [pc, #348]	; 14f8 <.text+0x14f8>
    1398:	e1a032a0 	mov	r3, r0, lsr #5
    139c:	e1d510b6 	ldrh	r1, [r5, #6]
    13a0:	e2033003 	and	r3, r3, #3	; 0x3
    13a4:	e7923103 	ldr	r3, [r2, r3, lsl #2]
    13a8:	e59f414c 	ldr	r4, [pc, #332]	; 14fc <.text+0x14fc>
    13ac:	e59f214c 	ldr	r2, [pc, #332]	; 1500 <.text+0x1500>
    13b0:	e3510000 	cmp	r1, #0	; 0x0
    13b4:	e5823000 	str	r3, [r2]
    13b8:	e5861000 	str	r1, [r6]
    13bc:	e5841000 	str	r1, [r4]
    13c0:	0a000001 	beq	13cc <USBHandleControlTransfer+0x78>
    13c4:	e1b003a0 	movs	r0, r0, lsr #7
    13c8:	0a000045 	beq	14e4 <USBHandleControlTransfer+0x190>
    13cc:	e1a00005 	mov	r0, r5
    13d0:	e1a01004 	mov	r1, r4
    13d4:	ebffffa1 	bl	1260 <_HandleRequest>
    13d8:	e3500000 	cmp	r0, #0	; 0x0
    13dc:	059f0120 	ldreq	r0, [pc, #288]	; 1504 <.text+0x1504>
    13e0:	0a000022 	beq	1470 <USBHandleControlTransfer+0x11c>
    13e4:	e1d520b6 	ldrh	r2, [r5, #6]
    13e8:	e5943000 	ldr	r3, [r4]
    13ec:	e1520003 	cmp	r2, r3
    13f0:	d5862000 	strle	r2, [r6]
    13f4:	c5863000 	strgt	r3, [r6]
    13f8:	ea00002e 	b	14b8 <USBHandleControlTransfer+0x164>
    13fc:	e5962000 	ldr	r2, [r6]
    1400:	e3520000 	cmp	r2, #0	; 0x0
    1404:	da00001e 	ble	1484 <USBHandleControlTransfer+0x130>
    1408:	e59f40f0 	ldr	r4, [pc, #240]	; 1500 <.text+0x1500>
    140c:	e5941000 	ldr	r1, [r4]
    1410:	ebfffddf 	bl	b94 <USBHwEPRead>
    1414:	e3500000 	cmp	r0, #0	; 0x0
    1418:	ba000015 	blt	1474 <USBHandleControlTransfer+0x120>
    141c:	e5962000 	ldr	r2, [r6]
    1420:	e5943000 	ldr	r3, [r4]
    1424:	e0602002 	rsb	r2, r0, r2
    1428:	e0833000 	add	r3, r3, r0
    142c:	e3520000 	cmp	r2, #0	; 0x0
    1430:	e5843000 	str	r3, [r4]
    1434:	e5862000 	str	r2, [r6]
    1438:	1a000029 	bne	14e4 <USBHandleControlTransfer+0x190>
    143c:	e59f00ac 	ldr	r0, [pc, #172]	; 14f0 <.text+0x14f0>
    1440:	e5d03000 	ldrb	r3, [r0]
    1444:	e59f20ac 	ldr	r2, [pc, #172]	; 14f8 <.text+0x14f8>
    1448:	e1a032a3 	mov	r3, r3, lsr #5
    144c:	e2033003 	and	r3, r3, #3	; 0x3
    1450:	e7923103 	ldr	r3, [r2, r3, lsl #2]
    1454:	e59f10a0 	ldr	r1, [pc, #160]	; 14fc <.text+0x14fc>
    1458:	e1a02004 	mov	r2, r4
    145c:	e5843000 	str	r3, [r4]
    1460:	ebffff7e 	bl	1260 <_HandleRequest>
    1464:	e3500000 	cmp	r0, #0	; 0x0
    1468:	1a000012 	bne	14b8 <USBHandleControlTransfer+0x164>
    146c:	e59f0094 	ldr	r0, [pc, #148]	; 1508 <.text+0x1508>
    1470:	ebfffcac 	bl	728 <puts>
    1474:	e1a00007 	mov	r0, r7
    1478:	e28dd004 	add	sp, sp, #4	; 0x4
    147c:	e8bd40f0 	ldmia	sp!, {r4, r5, r6, r7, lr}
    1480:	eaffff88 	b	12a8 <StallControlPipe>
    1484:	e1a01000 	mov	r1, r0
    1488:	e1a02000 	mov	r2, r0
    148c:	ebfffdc0 	bl	b94 <USBHwEPRead>
    1490:	e59f2074 	ldr	r2, [pc, #116]	; 150c <.text+0x150c>
    1494:	e59f3074 	ldr	r3, [pc, #116]	; 1510 <.text+0x1510>
    1498:	e3500000 	cmp	r0, #0	; 0x0
    149c:	d1a00002 	movle	r0, r2
    14a0:	c1a00003 	movgt	r0, r3
    14a4:	e28dd004 	add	sp, sp, #4	; 0x4
    14a8:	e8bd40f0 	ldmia	sp!, {r4, r5, r6, r7, lr}
    14ac:	eafffc67 	b	650 <printf>
    14b0:	e3500080 	cmp	r0, #128	; 0x80
    14b4:	1a000002 	bne	14c4 <USBHandleControlTransfer+0x170>
    14b8:	e28dd004 	add	sp, sp, #4	; 0x4
    14bc:	e8bd40f0 	ldmia	sp!, {r4, r5, r6, r7, lr}
    14c0:	eaffff90 	b	1308 <DataIn>
    14c4:	e3a0c0d4 	mov	ip, #212	; 0xd4
    14c8:	e59f0044 	ldr	r0, [pc, #68]	; 1514 <.text+0x1514>
    14cc:	e59f1044 	ldr	r1, [pc, #68]	; 1518 <.text+0x1518>
    14d0:	e59f2044 	ldr	r2, [pc, #68]	; 151c <.text+0x151c>
    14d4:	e59f3044 	ldr	r3, [pc, #68]	; 1520 <.text+0x1520>
    14d8:	e58dc000 	str	ip, [sp]
    14dc:	ebfffc5b 	bl	650 <printf>
    14e0:	eafffffe 	b	14e0 <USBHandleControlTransfer+0x18c>
    14e4:	e28dd004 	add	sp, sp, #4	; 0x4
    14e8:	e8bd80f0 	ldmia	sp!, {r4, r5, r6, r7, pc}
    14ec:	400002dc 	ldrmid	r0, [r0], -ip
    14f0:	400002d0 	ldrmid	r0, [r0], -r0
    14f4:	00001e24 	andeq	r1, r0, r4, lsr #28
    14f8:	400002c0 	andmi	r0, r0, r0, asr #5
    14fc:	400002e0 	andmi	r0, r0, r0, ror #5
    1500:	400002d8 	ldrmid	r0, [r0], -r8
    1504:	00001e28 	andeq	r1, r0, r8, lsr #28
    1508:	00001e40 	andeq	r1, r0, r0, asr #28
    150c:	00001d88 	andeq	r1, r0, r8, lsl #27
    1510:	00001e58 	andeq	r1, r0, r8, asr lr
    1514:	00001d64 	andeq	r1, r0, r4, ror #26
    1518:	00001e5c 	andeq	r1, r0, ip, asr lr
    151c:	00001dcc 	andeq	r1, r0, ip, asr #27
    1520:	00001c50 	andeq	r1, r0, r0, asr ip

00001524 <USBRegisterDescriptors>:
    1524:	e59f3004 	ldr	r3, [pc, #4]	; 1530 <.text+0x1530>
    1528:	e5830000 	str	r0, [r3]
    152c:	e12fff1e 	bx	lr
    1530:	400002ec 	andmi	r0, r0, ip, ror #5

00001534 <USBRegisterCustomReqHandler>:
    1534:	e59f3004 	ldr	r3, [pc, #4]	; 1540 <.text+0x1540>
    1538:	e5830000 	str	r0, [r3]
    153c:	e12fff1e 	bx	lr
    1540:	400002e4 	andmi	r0, r0, r4, ror #5

00001544 <USBGetDescriptor>:
    1544:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
    1548:	e59f10ac 	ldr	r1, [pc, #172]	; 15fc <.text+0x15fc>
    154c:	e5911000 	ldr	r1, [r1]
    1550:	e1a00800 	mov	r0, r0, lsl #16
    1554:	e3510000 	cmp	r1, #0	; 0x0
    1558:	e1a0c820 	mov	ip, r0, lsr #16
    155c:	e1a05002 	mov	r5, r2
    1560:	e24dd004 	sub	sp, sp, #4	; 0x4
    1564:	e1a06003 	mov	r6, r3
    1568:	11a00c20 	movne	r0, r0, lsr #24
    156c:	120ce0ff 	andne	lr, ip, #255	; 0xff
    1570:	13a02000 	movne	r2, #0	; 0x0
    1574:	1a000017 	bne	15d8 <USBGetDescriptor+0x94>
    1578:	e3a0c06e 	mov	ip, #110	; 0x6e
    157c:	e59f007c 	ldr	r0, [pc, #124]	; 1600 <.text+0x1600>
    1580:	e59f107c 	ldr	r1, [pc, #124]	; 1604 <.text+0x1604>
    1584:	e59f207c 	ldr	r2, [pc, #124]	; 1608 <.text+0x1608>
    1588:	e59f307c 	ldr	r3, [pc, #124]	; 160c <.text+0x160c>
    158c:	e58dc000 	str	ip, [sp]
    1590:	ebfffc2e 	bl	650 <printf>
    1594:	eafffffe 	b	1594 <USBGetDescriptor+0x50>
    1598:	e5d13001 	ldrb	r3, [r1, #1]
    159c:	e1530000 	cmp	r3, r0
    15a0:	1a00000b 	bne	15d4 <USBGetDescriptor+0x90>
    15a4:	e152000e 	cmp	r2, lr
    15a8:	1a000008 	bne	15d0 <USBGetDescriptor+0x8c>
    15ac:	e5861000 	str	r1, [r6]
    15b0:	e3500002 	cmp	r0, #2	; 0x2
    15b4:	05d13002 	ldreqb	r3, [r1, #2]
    15b8:	05d12003 	ldreqb	r2, [r1, #3]
    15bc:	15d13000 	ldrneb	r3, [r1]
    15c0:	01833402 	orreq	r3, r3, r2, lsl #8
    15c4:	e3a00001 	mov	r0, #1	; 0x1
    15c8:	e5853000 	str	r3, [r5]
    15cc:	ea000008 	b	15f4 <USBGetDescriptor+0xb0>
    15d0:	e2822001 	add	r2, r2, #1	; 0x1
    15d4:	e0811004 	add	r1, r1, r4
    15d8:	e5d14000 	ldrb	r4, [r1]
    15dc:	e3540000 	cmp	r4, #0	; 0x0
    15e0:	1affffec 	bne	1598 <USBGetDescriptor+0x54>
    15e4:	e1a0100c 	mov	r1, ip
    15e8:	e59f0020 	ldr	r0, [pc, #32]	; 1610 <.text+0x1610>
    15ec:	ebfffc17 	bl	650 <printf>
    15f0:	e1a00004 	mov	r0, r4
    15f4:	e28dd004 	add	sp, sp, #4	; 0x4
    15f8:	e8bd8070 	ldmia	sp!, {r4, r5, r6, pc}
    15fc:	400002ec 	andmi	r0, r0, ip, ror #5
    1600:	00001d64 	andeq	r1, r0, r4, ror #26
    1604:	00001e64 	andeq	r1, r0, r4, ror #28
    1608:	00001e78 	andeq	r1, r0, r8, ror lr
    160c:	00001c80 	andeq	r1, r0, r0, lsl #25
    1610:	00001e84 	andeq	r1, r0, r4, lsl #29

00001614 <USBHandleStandardRequest>:
    1614:	e92d41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
    1618:	e59f32f8 	ldr	r3, [pc, #760]	; 1918 <.text+0x1918>
    161c:	e5933000 	ldr	r3, [r3]
    1620:	e3530000 	cmp	r3, #0	; 0x0
    1624:	e24dd004 	sub	sp, sp, #4	; 0x4
    1628:	e1a05000 	mov	r5, r0
    162c:	e1a06001 	mov	r6, r1
    1630:	e1a04002 	mov	r4, r2
    1634:	0a000003 	beq	1648 <USBHandleStandardRequest+0x34>
    1638:	e1a0e00f 	mov	lr, pc
    163c:	e12fff13 	bx	r3
    1640:	e3500000 	cmp	r0, #0	; 0x0
    1644:	1a0000a9 	bne	18f0 <.text+0x18f0>
    1648:	e5d53000 	ldrb	r3, [r5]
    164c:	e203301f 	and	r3, r3, #31	; 0x1f
    1650:	e3530001 	cmp	r3, #1	; 0x1
    1654:	0a000059 	beq	17c0 <.text+0x17c0>
    1658:	e3530002 	cmp	r3, #2	; 0x2
    165c:	0a00007b 	beq	1850 <.text+0x1850>
    1660:	e3530000 	cmp	r3, #0	; 0x0
    1664:	1a0000a7 	bne	1908 <.text+0x1908>
    1668:	e5d51001 	ldrb	r1, [r5, #1]
    166c:	e5940000 	ldr	r0, [r4]
    1670:	e3510009 	cmp	r1, #9	; 0x9
    1674:	979ff101 	ldrls	pc, [pc, r1, lsl #2]
    1678:	ea00004e 	b	17b8 <.text+0x17b8>
    167c:	00001804 	andeq	r1, r0, r4, lsl #16
    1680:	00001908 	andeq	r1, r0, r8, lsl #18
    1684:	000017b8 	streqh	r1, [r0], -r8
    1688:	00001908 	andeq	r1, r0, r8, lsl #18
    168c:	000017b8 	streqh	r1, [r0], -r8
    1690:	000016a4 	andeq	r1, r0, r4, lsr #13
    1694:	000016b0 	streqh	r1, [r0], -r0
    1698:	000017b0 	streqh	r1, [r0], -r0
    169c:	000016d8 	ldreqd	r1, [r0], -r8
    16a0:	000016f0 	streqd	r1, [r0], -r0
    16a4:	e5d50002 	ldrb	r0, [r5, #2]
    16a8:	ebfffcf3 	bl	a7c <USBHwSetAddress>
    16ac:	ea00008f 	b	18f0 <.text+0x18f0>
    16b0:	e1d510b2 	ldrh	r1, [r5, #2]
    16b4:	e59f0260 	ldr	r0, [pc, #608]	; 191c <.text+0x191c>
    16b8:	ebfffbe4 	bl	650 <printf>
    16bc:	e1d510b4 	ldrh	r1, [r5, #4]
    16c0:	e1d500b2 	ldrh	r0, [r5, #2]
    16c4:	e1a02006 	mov	r2, r6
    16c8:	e1a03004 	mov	r3, r4
    16cc:	e28dd004 	add	sp, sp, #4	; 0x4
    16d0:	e8bd41f0 	ldmia	sp!, {r4, r5, r6, r7, r8, lr}
    16d4:	eaffff9a 	b	1544 <USBGetDescriptor>
    16d8:	e59f3240 	ldr	r3, [pc, #576]	; 1920 <.text+0x1920>
    16dc:	e5d32000 	ldrb	r2, [r3]
    16e0:	e3a03001 	mov	r3, #1	; 0x1
    16e4:	e1a01003 	mov	r1, r3
    16e8:	e5c02000 	strb	r2, [r0]
    16ec:	ea000072 	b	18bc <.text+0x18bc>
    16f0:	e59f322c 	ldr	r3, [pc, #556]	; 1924 <.text+0x1924>
    16f4:	e5933000 	ldr	r3, [r3]
    16f8:	e3530000 	cmp	r3, #0	; 0x0
    16fc:	e1d520b2 	ldrh	r2, [r5, #2]
    1700:	1a000007 	bne	1724 <.text+0x1724>
    1704:	e3a0c0a5 	mov	ip, #165	; 0xa5
    1708:	e59f0218 	ldr	r0, [pc, #536]	; 1928 <.text+0x1928>
    170c:	e59f1218 	ldr	r1, [pc, #536]	; 192c <.text+0x192c>
    1710:	e59f2218 	ldr	r2, [pc, #536]	; 1930 <.text+0x1930>
    1714:	e59f3218 	ldr	r3, [pc, #536]	; 1934 <.text+0x1934>
    1718:	e58dc000 	str	ip, [sp]
    171c:	ebfffbcb 	bl	650 <printf>
    1720:	eafffffe 	b	1720 <.text+0x1720>
    1724:	e21270ff 	ands	r7, r2, #255	; 0xff
    1728:	13a060ff 	movne	r6, #255	; 0xff
    172c:	01a00007 	moveq	r0, r7
    1730:	11a04003 	movne	r4, r3
    1734:	11a08006 	movne	r8, r6
    1738:	1a000012 	bne	1788 <.text+0x1788>
    173c:	ea000015 	b	1798 <.text+0x1798>
    1740:	e5d43001 	ldrb	r3, [r4, #1]
    1744:	e3530004 	cmp	r3, #4	; 0x4
    1748:	05d46003 	ldreqb	r6, [r4, #3]
    174c:	0a00000b 	beq	1780 <.text+0x1780>
    1750:	e3530005 	cmp	r3, #5	; 0x5
    1754:	0a000002 	beq	1764 <.text+0x1764>
    1758:	e3530002 	cmp	r3, #2	; 0x2
    175c:	05d48005 	ldreqb	r8, [r4, #5]
    1760:	ea000006 	b	1780 <.text+0x1780>
    1764:	e1580007 	cmp	r8, r7
    1768:	03560000 	cmpeq	r6, #0	; 0x0
    176c:	05d43005 	ldreqb	r3, [r4, #5]
    1770:	05d41004 	ldreqb	r1, [r4, #4]
    1774:	05d40002 	ldreqb	r0, [r4, #2]
    1778:	01811403 	orreq	r1, r1, r3, lsl #8
    177c:	0bfffca8 	bleq	a24 <USBHwEPConfig>
    1780:	e5d43000 	ldrb	r3, [r4]
    1784:	e0844003 	add	r4, r4, r3
    1788:	e5d43000 	ldrb	r3, [r4]
    178c:	e3530000 	cmp	r3, #0	; 0x0
    1790:	1affffea 	bne	1740 <.text+0x1740>
    1794:	e3a00001 	mov	r0, #1	; 0x1
    1798:	ebfffd4d 	bl	cd4 <USBHwConfigDevice>
    179c:	e1d520b2 	ldrh	r2, [r5, #2]
    17a0:	e59f3178 	ldr	r3, [pc, #376]	; 1920 <.text+0x1920>
    17a4:	e3a01001 	mov	r1, #1	; 0x1
    17a8:	e5c32000 	strb	r2, [r3]
    17ac:	ea000056 	b	190c <.text+0x190c>
    17b0:	e59f0180 	ldr	r0, [pc, #384]	; 1938 <.text+0x1938>
    17b4:	ea000052 	b	1904 <.text+0x1904>
    17b8:	e59f017c 	ldr	r0, [pc, #380]	; 193c <.text+0x193c>
    17bc:	ea000050 	b	1904 <.text+0x1904>
    17c0:	e5d51001 	ldrb	r1, [r5, #1]
    17c4:	e5940000 	ldr	r0, [r4]
    17c8:	e351000b 	cmp	r1, #11	; 0xb
    17cc:	979ff101 	ldrls	pc, [pc, r1, lsl #2]
    17d0:	ea00001c 	b	1848 <.text+0x1848>
    17d4:	00001804 	andeq	r1, r0, r4, lsl #16
    17d8:	00001908 	andeq	r1, r0, r8, lsl #18
    17dc:	00001848 	andeq	r1, r0, r8, asr #16
    17e0:	00001908 	andeq	r1, r0, r8, lsl #18
    17e4:	00001848 	andeq	r1, r0, r8, asr #16
    17e8:	00001848 	andeq	r1, r0, r8, asr #16
    17ec:	00001848 	andeq	r1, r0, r8, asr #16
    17f0:	00001848 	andeq	r1, r0, r8, asr #16
    17f4:	00001848 	andeq	r1, r0, r8, asr #16
    17f8:	00001848 	andeq	r1, r0, r8, asr #16
    17fc:	00001818 	andeq	r1, r0, r8, lsl r8
    1800:	00001830 	andeq	r1, r0, r0, lsr r8
    1804:	e3a03000 	mov	r3, #0	; 0x0
    1808:	e3a01001 	mov	r1, #1	; 0x1
    180c:	e5c03001 	strb	r3, [r0, #1]
    1810:	e5c03000 	strb	r3, [r0]
    1814:	ea000027 	b	18b8 <.text+0x18b8>
    1818:	e3a02001 	mov	r2, #1	; 0x1
    181c:	e3a03000 	mov	r3, #0	; 0x0
    1820:	e1a01002 	mov	r1, r2
    1824:	e5c03000 	strb	r3, [r0]
    1828:	e5862000 	str	r2, [r6]
    182c:	ea000036 	b	190c <.text+0x190c>
    1830:	e1d500b2 	ldrh	r0, [r5, #2]
    1834:	e3500000 	cmp	r0, #0	; 0x0
    1838:	03a01001 	moveq	r1, #1	; 0x1
    183c:	05860000 	streq	r0, [r6]
    1840:	0a000031 	beq	190c <.text+0x190c>
    1844:	ea00002f 	b	1908 <.text+0x1908>
    1848:	e59f00f0 	ldr	r0, [pc, #240]	; 1940 <.text+0x1940>
    184c:	ea00002c 	b	1904 <.text+0x1904>
    1850:	e5d51001 	ldrb	r1, [r5, #1]
    1854:	e5944000 	ldr	r4, [r4]
    1858:	e351000c 	cmp	r1, #12	; 0xc
    185c:	979ff101 	ldrls	pc, [pc, r1, lsl #2]
    1860:	ea000026 	b	1900 <.text+0x1900>
    1864:	00001898 	muleq	r0, r8, r8
    1868:	000018c4 	andeq	r1, r0, r4, asr #17
    186c:	00001900 	andeq	r1, r0, r0, lsl #18
    1870:	000018d8 	ldreqd	r1, [r0], -r8
    1874:	00001900 	andeq	r1, r0, r0, lsl #18
    1878:	00001900 	andeq	r1, r0, r0, lsl #18
    187c:	00001900 	andeq	r1, r0, r0, lsl #18
    1880:	00001900 	andeq	r1, r0, r0, lsl #18
    1884:	00001900 	andeq	r1, r0, r0, lsl #18
    1888:	00001900 	andeq	r1, r0, r0, lsl #18
    188c:	00001900 	andeq	r1, r0, r0, lsl #18
    1890:	00001900 	andeq	r1, r0, r0, lsl #18
    1894:	000018f8 	streqd	r1, [r0], -r8
    1898:	e5d50004 	ldrb	r0, [r5, #4]
    189c:	ebfffc89 	bl	ac8 <USBHwEPGetStatus>
    18a0:	e1a000a0 	mov	r0, r0, lsr #1
    18a4:	e2000001 	and	r0, r0, #1	; 0x1
    18a8:	e3a03000 	mov	r3, #0	; 0x0
    18ac:	e5c43001 	strb	r3, [r4, #1]
    18b0:	e5c40000 	strb	r0, [r4]
    18b4:	e3a01001 	mov	r1, #1	; 0x1
    18b8:	e2833002 	add	r3, r3, #2	; 0x2
    18bc:	e5863000 	str	r3, [r6]
    18c0:	ea000011 	b	190c <.text+0x190c>
    18c4:	e1d510b2 	ldrh	r1, [r5, #2]
    18c8:	e3510000 	cmp	r1, #0	; 0x0
    18cc:	05d50004 	ldreqb	r0, [r5, #4]
    18d0:	0a000005 	beq	18ec <.text+0x18ec>
    18d4:	ea00000b 	b	1908 <.text+0x1908>
    18d8:	e1d530b2 	ldrh	r3, [r5, #2]
    18dc:	e3530000 	cmp	r3, #0	; 0x0
    18e0:	1a000008 	bne	1908 <.text+0x1908>
    18e4:	e5d50004 	ldrb	r0, [r5, #4]
    18e8:	e3a01001 	mov	r1, #1	; 0x1
    18ec:	ebfffc7d 	bl	ae8 <USBHwEPStall>
    18f0:	e3a01001 	mov	r1, #1	; 0x1
    18f4:	ea000004 	b	190c <.text+0x190c>
    18f8:	e59f0044 	ldr	r0, [pc, #68]	; 1944 <.text+0x1944>
    18fc:	ea000000 	b	1904 <.text+0x1904>
    1900:	e59f0040 	ldr	r0, [pc, #64]	; 1948 <.text+0x1948>
    1904:	ebfffb51 	bl	650 <printf>
    1908:	e3a01000 	mov	r1, #0	; 0x0
    190c:	e1a00001 	mov	r0, r1
    1910:	e28dd004 	add	sp, sp, #4	; 0x4
    1914:	e8bd81f0 	ldmia	sp!, {r4, r5, r6, r7, r8, pc}
    1918:	400002e4 	andmi	r0, r0, r4, ror #5
    191c:	00001e98 	muleq	r0, r8, lr
    1920:	400002e8 	andmi	r0, r0, r8, ror #5
    1924:	400002ec 	andmi	r0, r0, ip, ror #5
    1928:	00001d64 	andeq	r1, r0, r4, ror #26
    192c:	00001e64 	andeq	r1, r0, r4, ror #28
    1930:	00001e78 	andeq	r1, r0, r8, ror lr
    1934:	00001c6c 	andeq	r1, r0, ip, ror #24
    1938:	00001e9c 	muleq	r0, ip, lr
    193c:	00001ebc 	streqh	r1, [r0], -ip
    1940:	00001ed4 	ldreqd	r1, [r0], -r4
    1944:	00001ef0 	streqd	r1, [r0], -r0
    1948:	00001f0c 	andeq	r1, r0, ip, lsl #30

0000194c <USBInit>:
    194c:	e92d4010 	stmdb	sp!, {r4, lr}
    1950:	e59f4050 	ldr	r4, [pc, #80]	; 19a8 <.text+0x19a8>
    1954:	ebfffd3a 	bl	e44 <USBHwInit>
    1958:	e59f004c 	ldr	r0, [pc, #76]	; 19ac <.text+0x19ac>
    195c:	ebfffde9 	bl	1108 <USBHwRegisterDevIntHandler>
    1960:	e1a01004 	mov	r1, r4
    1964:	e3a00000 	mov	r0, #0	; 0x0
    1968:	ebfffdf1 	bl	1134 <USBHwRegisterEPIntHandler>
    196c:	e1a01004 	mov	r1, r4
    1970:	e3a00080 	mov	r0, #128	; 0x80
    1974:	ebfffdee 	bl	1134 <USBHwRegisterEPIntHandler>
    1978:	e3a00000 	mov	r0, #0	; 0x0
    197c:	e3a01040 	mov	r1, #64	; 0x40
    1980:	ebfffc27 	bl	a24 <USBHwEPConfig>
    1984:	e3a00080 	mov	r0, #128	; 0x80
    1988:	e3a01040 	mov	r1, #64	; 0x40
    198c:	ebfffc24 	bl	a24 <USBHwEPConfig>
    1990:	e3a00000 	mov	r0, #0	; 0x0
    1994:	e59f1014 	ldr	r1, [pc, #20]	; 19b0 <.text+0x19b0>
    1998:	e59f2014 	ldr	r2, [pc, #20]	; 19b4 <.text+0x19b4>
    199c:	ebfffe0c 	bl	11d4 <USBRegisterRequestHandler>
    19a0:	e3a00001 	mov	r0, #1	; 0x1
    19a4:	e8bd8010 	ldmia	sp!, {r4, pc}
    19a8:	00001354 	andeq	r1, r0, r4, asr r3
    19ac:	000019b8 	streqh	r1, [r0], -r8
    19b0:	00001614 	andeq	r1, r0, r4, lsl r6
    19b4:	400002f0 	strmid	r0, [r0], -r0

000019b8 <HandleUsbReset>:
    19b8:	e3100010 	tst	r0, #16	; 0x10
    19bc:	012fff1e 	bxeq	lr
    19c0:	e59f0000 	ldr	r0, [pc, #0]	; 19c8 <.text+0x19c8>
    19c4:	eafffb21 	b	650 <printf>
    19c8:	00001f20 	andeq	r1, r0, r0, lsr #30

000019cc <__aeabi_uidiv>:
    19cc:	e2512001 	subs	r2, r1, #1	; 0x1
    19d0:	012fff1e 	bxeq	lr
    19d4:	3a000036 	bcc	1ab4 <__aeabi_uidiv+0xe8>
    19d8:	e1500001 	cmp	r0, r1
    19dc:	9a000022 	bls	1a6c <__aeabi_uidiv+0xa0>
    19e0:	e1110002 	tst	r1, r2
    19e4:	0a000023 	beq	1a78 <__aeabi_uidiv+0xac>
    19e8:	e311020e 	tst	r1, #-536870912	; 0xe0000000
    19ec:	01a01181 	moveq	r1, r1, lsl #3
    19f0:	03a03008 	moveq	r3, #8	; 0x8
    19f4:	13a03001 	movne	r3, #1	; 0x1
    19f8:	e3510201 	cmp	r1, #268435456	; 0x10000000
    19fc:	31510000 	cmpcc	r1, r0
    1a00:	31a01201 	movcc	r1, r1, lsl #4
    1a04:	31a03203 	movcc	r3, r3, lsl #4
    1a08:	3afffffa 	bcc	19f8 <__aeabi_uidiv+0x2c>
    1a0c:	e3510102 	cmp	r1, #-2147483648	; 0x80000000
    1a10:	31510000 	cmpcc	r1, r0
    1a14:	31a01081 	movcc	r1, r1, lsl #1
    1a18:	31a03083 	movcc	r3, r3, lsl #1
    1a1c:	3afffffa 	bcc	1a0c <__aeabi_uidiv+0x40>
    1a20:	e3a02000 	mov	r2, #0	; 0x0
    1a24:	e1500001 	cmp	r0, r1
    1a28:	20400001 	subcs	r0, r0, r1
    1a2c:	21822003 	orrcs	r2, r2, r3
    1a30:	e15000a1 	cmp	r0, r1, lsr #1
    1a34:	204000a1 	subcs	r0, r0, r1, lsr #1
    1a38:	218220a3 	orrcs	r2, r2, r3, lsr #1
    1a3c:	e1500121 	cmp	r0, r1, lsr #2
    1a40:	20400121 	subcs	r0, r0, r1, lsr #2
    1a44:	21822123 	orrcs	r2, r2, r3, lsr #2
    1a48:	e15001a1 	cmp	r0, r1, lsr #3
    1a4c:	204001a1 	subcs	r0, r0, r1, lsr #3
    1a50:	218221a3 	orrcs	r2, r2, r3, lsr #3
    1a54:	e3500000 	cmp	r0, #0	; 0x0
    1a58:	11b03223 	movnes	r3, r3, lsr #4
    1a5c:	11a01221 	movne	r1, r1, lsr #4
    1a60:	1affffef 	bne	1a24 <__aeabi_uidiv+0x58>
    1a64:	e1a00002 	mov	r0, r2
    1a68:	e12fff1e 	bx	lr
    1a6c:	03a00001 	moveq	r0, #1	; 0x1
    1a70:	13a00000 	movne	r0, #0	; 0x0
    1a74:	e12fff1e 	bx	lr
    1a78:	e3510801 	cmp	r1, #65536	; 0x10000
    1a7c:	21a01821 	movcs	r1, r1, lsr #16
    1a80:	23a02010 	movcs	r2, #16	; 0x10
    1a84:	33a02000 	movcc	r2, #0	; 0x0
    1a88:	e3510c01 	cmp	r1, #256	; 0x100
    1a8c:	21a01421 	movcs	r1, r1, lsr #8
    1a90:	22822008 	addcs	r2, r2, #8	; 0x8
    1a94:	e3510010 	cmp	r1, #16	; 0x10
    1a98:	21a01221 	movcs	r1, r1, lsr #4
    1a9c:	22822004 	addcs	r2, r2, #4	; 0x4
    1aa0:	e3510004 	cmp	r1, #4	; 0x4
    1aa4:	82822003 	addhi	r2, r2, #3	; 0x3
    1aa8:	908220a1 	addls	r2, r2, r1, lsr #1
    1aac:	e1a00230 	mov	r0, r0, lsr r2
    1ab0:	e12fff1e 	bx	lr
    1ab4:	e52de008 	str	lr, [sp, #-8]!
    1ab8:	eb00003a 	bl	1ba8 <__aeabi_idiv0>
    1abc:	e3a00000 	mov	r0, #0	; 0x0
    1ac0:	e49df008 	ldr	pc, [sp], #8

00001ac4 <__aeabi_uidivmod>:
    1ac4:	e92d4003 	stmdb	sp!, {r0, r1, lr}
    1ac8:	ebffffbf 	bl	19cc <__aeabi_uidiv>
    1acc:	e8bd4006 	ldmia	sp!, {r1, r2, lr}
    1ad0:	e0030092 	mul	r3, r2, r0
    1ad4:	e0411003 	sub	r1, r1, r3
    1ad8:	e12fff1e 	bx	lr

00001adc <__umodsi3>:
    1adc:	e2512001 	subs	r2, r1, #1	; 0x1
    1ae0:	3a00002c 	bcc	1b98 <__umodsi3+0xbc>
    1ae4:	11500001 	cmpne	r0, r1
    1ae8:	03a00000 	moveq	r0, #0	; 0x0
    1aec:	81110002 	tsthi	r1, r2
    1af0:	00000002 	andeq	r0, r0, r2
    1af4:	912fff1e 	bxls	lr
    1af8:	e3a02000 	mov	r2, #0	; 0x0
    1afc:	e3510201 	cmp	r1, #268435456	; 0x10000000
    1b00:	31510000 	cmpcc	r1, r0
    1b04:	31a01201 	movcc	r1, r1, lsl #4
    1b08:	32822004 	addcc	r2, r2, #4	; 0x4
    1b0c:	3afffffa 	bcc	1afc <__umodsi3+0x20>
    1b10:	e3510102 	cmp	r1, #-2147483648	; 0x80000000
    1b14:	31510000 	cmpcc	r1, r0
    1b18:	31a01081 	movcc	r1, r1, lsl #1
    1b1c:	32822001 	addcc	r2, r2, #1	; 0x1
    1b20:	3afffffa 	bcc	1b10 <__umodsi3+0x34>
    1b24:	e2522003 	subs	r2, r2, #3	; 0x3
    1b28:	ba00000e 	blt	1b68 <__umodsi3+0x8c>
    1b2c:	e1500001 	cmp	r0, r1
    1b30:	20400001 	subcs	r0, r0, r1
    1b34:	e15000a1 	cmp	r0, r1, lsr #1
    1b38:	204000a1 	subcs	r0, r0, r1, lsr #1
    1b3c:	e1500121 	cmp	r0, r1, lsr #2
    1b40:	20400121 	subcs	r0, r0, r1, lsr #2
    1b44:	e15001a1 	cmp	r0, r1, lsr #3
    1b48:	204001a1 	subcs	r0, r0, r1, lsr #3
    1b4c:	e3500001 	cmp	r0, #1	; 0x1
    1b50:	e1a01221 	mov	r1, r1, lsr #4
    1b54:	a2522004 	subges	r2, r2, #4	; 0x4
    1b58:	aafffff3 	bge	1b2c <__umodsi3+0x50>
    1b5c:	e3120003 	tst	r2, #3	; 0x3
    1b60:	13300000 	teqne	r0, #0	; 0x0
    1b64:	0a00000a 	beq	1b94 <__umodsi3+0xb8>
    1b68:	e3720002 	cmn	r2, #2	; 0x2
    1b6c:	ba000006 	blt	1b8c <__umodsi3+0xb0>
    1b70:	0a000002 	beq	1b80 <__umodsi3+0xa4>
    1b74:	e1500001 	cmp	r0, r1
    1b78:	20400001 	subcs	r0, r0, r1
    1b7c:	e1a010a1 	mov	r1, r1, lsr #1
    1b80:	e1500001 	cmp	r0, r1
    1b84:	20400001 	subcs	r0, r0, r1
    1b88:	e1a010a1 	mov	r1, r1, lsr #1
    1b8c:	e1500001 	cmp	r0, r1
    1b90:	20400001 	subcs	r0, r0, r1
    1b94:	e12fff1e 	bx	lr
    1b98:	e52de008 	str	lr, [sp, #-8]!
    1b9c:	eb000001 	bl	1ba8 <__aeabi_idiv0>
    1ba0:	e3a00000 	mov	r0, #0	; 0x0
    1ba4:	e49df008 	ldr	pc, [sp], #8

00001ba8 <__aeabi_idiv0>:
    1ba8:	e12fff1e 	bx	lr

00001bac <abDescriptors>:
    1bac:	01100112 40000000 0001ffff 02010100     .......@........
    1bbc:	02090103 01010022 09328000 01000004     ....".....2.....
    1bcc:	00000003 01102109 4d220100 81050700     .....!...."M....
    1bdc:	0a004003 04090304 004c030e 00430050     .@........L.P.C.
    1bec:	00530055 03120042 00720050 0064006f     U.S.B...P.r.o.d.
    1bfc:	00630075 00580074 00440312 00410045     u.c.t.X...D.E.A.
    1c0c:	00430044 00440030 00000045              D.C.0.D.E...

00001c18 <__FUNCTION__.1660>:
    1c18:	48425355 67655277 65747369 49504572     USBHwRegisterEPI
    1c28:	6148746e 656c646e 00000072              ntHandler...

00001c34 <__FUNCTION__.1651>:
    1c34:	52425355 73696765 52726574 65757165     USBRegisterReque
    1c44:	61487473 656c646e 00000072              stHandler...

00001c50 <__FUNCTION__.1613>:
    1c50:	48425355 6c646e61 6e6f4365 6c6f7274     USBHandleControl
    1c60:	6e617254 72656673 00000000              Transfer....

00001c6c <__FUNCTION__.1627>:
    1c6c:	53425355 6f437465 6769666e 74617275     USBSetConfigurat
    1c7c:	006e6f69                                ion.

00001c80 <__FUNCTION__.1594>:
    1c80:	47425355 65447465 69726373 726f7470     USBGetDescriptor
    1c90:	00000000 6c756e28 0000296c 74696e49     ....(null)..Init
    1ca0:	696c6169 676e6973 42535520 61747320     ialising USB sta
    1cb0:	00006b63 72617453 676e6974 42535520     ck..Starting USB
    1cc0:	6d6f6320 696e756d 69746163 00006e6f      communication..
    1cd0:	20544547 454c4449 6176202c 58253d6c     GET IDLE, val=%X
    1ce0:	6469202c 58253d78 0000000a 20544553     , idx=%X....SET 
    1cf0:	454c4449 6176202c 58253d6c 6469202c     IDLE, val=%X, id
    1d00:	58253d78 0000000a 61686e55 656c646e     x=%X....Unhandle
    1d10:	6c632064 20737361 000a5825 69676552     d class %X..Regi
    1d20:	72657473 68206465 6c646e61 66207265     stered handler f
    1d30:	6620726f 656d6172 00000000 69676552     or frame....Regi
    1d40:	72657473 68206465 6c646e61 66207265     stered handler f
    1d50:	6420726f 63697665 74732065 73757461     or device status
    1d60:	00000000 7373410a 69747265 27206e6f     .....Assertion '
    1d70:	20277325 6c696166 69206465 7325206e     %s' failed in %s
    1d80:	2373253a 0a216425 00000000 3c786469     :%s#%d!.....idx<
    1d90:	00003233 68627375 706c5f77 00632e63     32..usbhw_lpc.c.
    1da0:	69676552 72657473 68206465 6c646e61     Registered handl
    1db0:	66207265 4520726f 78302050 000a7825     er for EP 0x%x..
    1dc0:	70795469 3d3e2065 00003020 63627375     iType >= 0..usbc
    1dd0:	72746e6f 632e6c6f 00000000 70795469     ontrol.c....iTyp
    1de0:	203c2065 00000034 68206f4e 6c646e61     e < 4...No handl
    1df0:	66207265 7220726f 79747165 25206570     er for reqtype %
    1e00:	00000a64 4c415453 6e6f204c 00005b20     d...STALL on [..
    1e10:	32302520 00000078 7473205d 253d7461      %02x...] stat=%
    1e20:	00000a78 00782553 6e61485f 52656c64     x...S%x._HandleR
    1e30:	65757165 20317473 6c696166 00006465     equest1 failed..
    1e40:	6e61485f 52656c64 65757165 20327473     _HandleRequest2 
    1e50:	6c696166 00006465 0000003f 534c4146     failed..?...FALS
    1e60:	00000045 44626170 72637365 21207069     E...pabDescrip !
    1e70:	554e203d 00004c4c 73627375 65726474     = NULL..usbstdre
    1e80:	00632e71 63736544 20782520 20746f6e     q.c.Desc %x not 
    1e90:	6e756f66 000a2164 00782544 69766544     found!..D%x.Devi
    1ea0:	72206563 25207165 6f6e2064 6d692074     ce req %d not im
    1eb0:	6d656c70 65746e65 00000a64 656c6c49     plemented...Ille
    1ec0:	206c6167 69766564 72206563 25207165     gal device req %
    1ed0:	00000a64 656c6c49 206c6167 65746e69     d...Illegal inte
    1ee0:	63616672 65722065 64252071 0000000a     rface req %d....
    1ef0:	72205045 25207165 6f6e2064 6d692074     EP req %d not im
    1f00:	6d656c70 65746e65 00000a64 656c6c49     plemented...Ille
    1f10:	206c6167 72205045 25207165 00000a64     gal EP req %d...
    1f20:	0000210a                                .!..
