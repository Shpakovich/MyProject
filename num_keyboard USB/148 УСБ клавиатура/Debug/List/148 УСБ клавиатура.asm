
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega8
;Program type           : Application
;Clock frequency        : 8,000000 MHz
;Memory model           : Small
;Optimize for           : Speed
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega8
	#pragma AVRPART MEMORY PROG_FLASH 8192
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	RCALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	RCALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _usbInputBufOffset=R5
	.DEF _usbDeviceAddr=R4
	.DEF _usbNewDeviceAddr=R7
	.DEF _usbCurrentTok=R6
	.DEF _button=R9

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	RJMP __RESET
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP _timer1_ovf_isr
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00

_usbDescriptorDevice:
	.DB  0x12,0x1,0x10,0x1,0x0,0x0,0x0,0x8
	.DB  0xC0,0x16,0xDF,0x5,0x0,0x1,0x1,0x2
	.DB  0x0,0x1
_usbDescriptorConfiguration:
	.DB  0x9,0x2,0x22,0x0,0x1,0x1,0x0,0x80
	.DB  0x32,0x9,0x4,0x0,0x0,0x1,0x3,0x0
	.DB  0x0,0x0,0x9,0x21,0x1,0x1,0x0,0x1
	.DB  0x22,0x16,0x0,0x7,0x5,0x81,0x3,0x8
	.DB  0x0,0x64
_usbDescriptorString0:
	.DB  0x4,0x3,0x9,0x4
_usbDescriptorStringVendor:
	.DB  0x2C,0x3,0x77,0x0,0x65,0x0,0x2E,0x0
	.DB  0x65,0x0,0x61,0x0,0x73,0x0,0x79,0x0
	.DB  0x65,0x0,0x6C,0x0,0x65,0x0,0x63,0x0
	.DB  0x74,0x0,0x72,0x0,0x6F,0x0,0x6E,0x0
	.DB  0x69,0x0,0x63,0x0,0x73,0x0,0x2E,0x0
	.DB  0x72,0x0,0x75,0x0
_usbDescriptorStringDevice:
	.DB  0x18,0x3,0x48,0x0,0x69,0x0,0x64,0x0
	.DB  0x20,0x0,0x65,0x0,0x78,0x0,0x61,0x0
	.DB  0x6D,0x0,0x70,0x0,0x6C,0x0,0x65,0x0
_usbDescriptorStringSerialNumber:
	.DB  0x1,0x0,0x1,0x0,0x3,0x0,0x4,0x0
	.DB  0x5,0x0,0x6,0x0,0x7,0x0,0x8,0x0
_usbDescriptorHidReport:
	.DB  0x6,0x0,0xFF,0x9,0x1,0xA1,0x1,0x15
	.DB  0x0,0x26,0xFF,0x0,0x75,0x8,0x95,0x1
	.DB  0x9,0x0,0xB2,0x2,0x1,0xC0
_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x5:
	.DB  0x5A
_0x6:
	.DB  0xFF

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  _usbTxLen
	.DW  _0x5*2

	.DW  0x01
	.DW  _usbMsgLen_G000
	.DW  _0x6*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;#include <io.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;//#include <avr/interrupt.h>
;//#include <util/delay.h>
;//#include <avr/pgmspace.h>   /* нужно для usbdrv.h */
;#include <stdio.h>
;#include "usbdrv.c"
;/* Name: usbdrv.c
; * Project: V-USB, virtual USB port for Atmel's(r) AVR(r) microcontrollers
; * Author: Christian Starkjohann
; * Creation Date: 2004-12-29
; * Tabsize: 4
; * Copyright: (c) 2005 by OBJECTIVE DEVELOPMENT Software GmbH
; * License: GNU GPL v2 (see License.txt), GNU GPL v3 or proprietary (CommercialLicense.txt)
; */
;
;#include "usbdrv.h"

	.CSEG
_usbFunctionDescriptor_G000:
; .FSTART _usbFunctionDescriptor_G000
	RET
; .FEND
_usbCrc16Append:
; .FSTART _usbCrc16Append
	ADIW R28,2
	RET
; .FEND
;#include "oddebug.h"
;
;flash char usbHidReportDescriptor[22] = { // USB report descriptor         // Дескриптор описывает структуру пакета данн ...
;    0x06, 0x00, 0xff,                       // USAGE_PAGE (Generic Desktop)
;    0x09, 0x01,                             // USAGE (Vendor Usage 1)
;    0xa1, 0x01,                             // COLLECTION (Application)
;    0x15, 0x00,                             //    LOGICAL_MINIMUM (0)        // min. значение для данных
;    0x26, 0xff, 0x00,                       //    LOGICAL_MAXIMUM (255)      // max. значение для данных, 255 тут не слу ...
;    0x75, 0x08,                             //    REPORT_SIZE (8)            // информация передается порциями, это разм ...
;    0x95, 1,    //    REPORT_COUNT               // количество порций (у нашем примере = 3, описанная выше структура пер ...
;    0x09, 0x00,                             //    USAGE (Undefined)
;    0xb2, 0x02, 0x01,                       //    FEATURE (Data,Var,Abs,Buf)
;    0xc0                                    // END_COLLECTION
;};
;/* Здесь мы описали только один report, из-за чего не нужно использовать report-ID (он должен быть первым байтом).
; * С его помощью передадим 3 байта данных (размер одного REPORT_SIZE = 8 бит = 1 байт, их количество REPORT_COUNT = 3).
; */
;
;/*
;General Description:
;This module implements the C-part of the USB driver. See usbdrv.h for a
;documentation of the entire driver.
;*/
;
;/* ------------------------------------------------------------------------- */
;
;/* raw USB registers / interface to assembler code: */
;uchar usbRxBuf[2*USB_BUFSIZE];  /* raw RX buffer: PID, 8 bytes data, 2 bytes CRC */
;uchar       usbInputBufOffset;  /* offset in usbRxBuf used for low level receiving */
;uchar       usbDeviceAddr;      /* assigned during enumeration, defaults to 0 */
;uchar       usbNewDeviceAddr;   /* device ID which should be set after status phase */
;uchar       usbConfiguration;   /* currently selected configuration. Administered by driver, but not used */
;volatile schar usbRxLen;        /* = 0; number of bytes in usbRxBuf; 0 means free, -1 for flow control */
;uchar       usbCurrentTok;      /* last token received or endpoint number for last OUT token if != 0 */
;uchar       usbRxToken;         /* token for data we received; or endpont number for last OUT */
;volatile uchar usbTxLen = USBPID_NAK;   /* number of bytes to transmit with next IN token or handshake token */

	.DSEG
;uchar       usbTxBuf[USB_BUFSIZE];/* data to transmit with next IN, free if usbTxLen contains handshake token */
;#if USB_COUNT_SOF
;volatile uchar  usbSofCount;    /* incremented by assembler module every SOF */
;#endif
;#if USB_CFG_HAVE_INTRIN_ENDPOINT && !USB_CFG_SUPPRESS_INTR_CODE
;usbTxStatus_t  usbTxStatus1;
;#   if USB_CFG_HAVE_INTRIN_ENDPOINT3
;usbTxStatus_t  usbTxStatus3;
;#   endif
;#endif
;#if USB_CFG_CHECK_DATA_TOGGLING
;uchar       usbCurrentDataToken;/* when we check data toggling to ignore duplicate packets */
;#endif
;
;/* USB status registers / not shared with asm code */
;usbMsgPtr_t         usbMsgPtr;      /* data to transmit next -- ROM or RAM address */
;static usbMsgLen_t  usbMsgLen = USB_NO_MSG; /* remaining number of bytes */
;static uchar        usbMsgFlags;    /* flag values see below */
;
;#define USB_FLG_MSGPTR_IS_ROM   (1<<6)
;#define USB_FLG_USE_USER_RW     (1<<7)
;
;/*
;optimizing hints:
;- do not post/pre inc/dec integer values in operations
;- assign value of USB_READ_FLASH() to register variables and don't use side effects in arg
;- use narrow scope for variables which should be in X/Y/Z register
;- assign char sized expressions to variables to force 8 bit arithmetics
;*/
;
;/* -------------------------- String Descriptors --------------------------- */
;
;#if USB_CFG_DESCR_PROPS_STRINGS == 0
;
;#if USB_CFG_DESCR_PROPS_STRING_0 == 0
;#undef USB_CFG_DESCR_PROPS_STRING_0
;#define USB_CFG_DESCR_PROPS_STRING_0    sizeof(usbDescriptorString0)
;PROGMEM const char usbDescriptorString0[] = { /* language descriptor */
;    4,          /* sizeof(usbDescriptorString0): length of descriptor in bytes */
;    3,          /* descriptor type */
;    0x09, 0x04, /* language index (0x0409 = US-English) */
;};
;#endif
;
;#if USB_CFG_DESCR_PROPS_STRING_VENDOR == 0 && USB_CFG_VENDOR_NAME_LEN
;#undef USB_CFG_DESCR_PROPS_STRING_VENDOR
;#define USB_CFG_DESCR_PROPS_STRING_VENDOR   sizeof(usbDescriptorStringVendor)
;PROGMEM const int  usbDescriptorStringVendor[] = {
;    USB_STRING_DESCRIPTOR_HEADER(USB_CFG_VENDOR_NAME_LEN),
;    USB_CFG_VENDOR_NAME
;};
;#endif
;
;#if USB_CFG_DESCR_PROPS_STRING_PRODUCT == 0 && USB_CFG_DEVICE_NAME_LEN
;#undef USB_CFG_DESCR_PROPS_STRING_PRODUCT
;#define USB_CFG_DESCR_PROPS_STRING_PRODUCT   sizeof(usbDescriptorStringDevice)
;PROGMEM const int  usbDescriptorStringDevice[] = {
;    USB_STRING_DESCRIPTOR_HEADER(USB_CFG_DEVICE_NAME_LEN),
;    USB_CFG_DEVICE_NAME
;};
;#endif
;
;#if USB_CFG_DESCR_PROPS_STRING_SERIAL_NUMBER == 0 && USB_CFG_SERIAL_NUMBER_LEN
;#undef USB_CFG_DESCR_PROPS_STRING_SERIAL_NUMBER
;#define USB_CFG_DESCR_PROPS_STRING_SERIAL_NUMBER    sizeof(usbDescriptorStringSerialNumber)
;PROGMEM const int usbDescriptorStringSerialNumber[] = {
;    USB_STRING_DESCRIPTOR_HEADER(USB_CFG_SERIAL_NUMBER_LEN),
;    USB_CFG_SERIAL_NUMBER
;};
;#endif
;
;#endif  /* USB_CFG_DESCR_PROPS_STRINGS == 0 */
;
;/* --------------------------- Device Descriptor --------------------------- */
;
;#if USB_CFG_DESCR_PROPS_DEVICE == 0
;#undef USB_CFG_DESCR_PROPS_DEVICE
;#define USB_CFG_DESCR_PROPS_DEVICE  sizeof(usbDescriptorDevice)
;PROGMEM const char usbDescriptorDevice[] = {    /* USB device descriptor */
;    18,         /* sizeof(usbDescriptorDevice): length of descriptor in bytes */
;    USBDESCR_DEVICE,        /* descriptor type */
;    0x10, 0x01,             /* USB version supported */
;    USB_CFG_DEVICE_CLASS,
;    USB_CFG_DEVICE_SUBCLASS,
;    0,                      /* protocol */
;    8,                      /* max packet size */
;    /* the following two casts affect the first byte of the constant only, but
;     * that's sufficient to avoid a warning with the default values.
;     */
;    (char)USB_CFG_VENDOR_ID,/* 2 bytes */
;    (char)USB_CFG_DEVICE_ID,/* 2 bytes */
;    USB_CFG_DEVICE_VERSION, /* 2 bytes */
;    USB_CFG_DESCR_PROPS_STRING_VENDOR != 0 ? 1 : 0,         /* manufacturer string index */
;    USB_CFG_DESCR_PROPS_STRING_PRODUCT != 0 ? 2 : 0,        /* product string index */
;    USB_CFG_DESCR_PROPS_STRING_SERIAL_NUMBER != 0 ? 3 : 0,  /* serial number string index */
;    1,          /* number of configurations */
;};
;#endif
;
;/* ----------------------- Configuration Descriptor ------------------------ */
;
;#if USB_CFG_DESCR_PROPS_HID_REPORT != 0 && USB_CFG_DESCR_PROPS_HID == 0
;#undef USB_CFG_DESCR_PROPS_HID
;#define USB_CFG_DESCR_PROPS_HID     9   /* length of HID descriptor in config descriptor below */
;#endif
;
;#if USB_CFG_DESCR_PROPS_CONFIGURATION == 0
;#undef USB_CFG_DESCR_PROPS_CONFIGURATION
;#define USB_CFG_DESCR_PROPS_CONFIGURATION   sizeof(usbDescriptorConfiguration)
;PROGMEM const char usbDescriptorConfiguration[] = {    /* USB configuration descriptor */
;    9,          /* sizeof(usbDescriptorConfiguration): length of descriptor in bytes */
;    USBDESCR_CONFIG,    /* descriptor type */
;    18 + 7 * USB_CFG_HAVE_INTRIN_ENDPOINT + 7 * USB_CFG_HAVE_INTRIN_ENDPOINT3 +
;                (USB_CFG_DESCR_PROPS_HID & 0xff), 0,
;                /* total length of data returned (including inlined descriptors) */
;    1,          /* number of interfaces in this configuration */
;    1,          /* index of this configuration */
;    0,          /* configuration name string index */
;#if USB_CFG_IS_SELF_POWERED
;    (1 << 7) | USBATTR_SELFPOWER,       /* attributes */
;#else
;    (1 << 7),                           /* attributes */
;#endif
;    USB_CFG_MAX_BUS_POWER/2,            /* max USB current in 2mA units */
;/* interface descriptor follows inline: */
;    9,          /* sizeof(usbDescrInterface): length of descriptor in bytes */
;    USBDESCR_INTERFACE, /* descriptor type */
;    0,          /* index of this interface */
;    0,          /* alternate setting for this interface */
;    USB_CFG_HAVE_INTRIN_ENDPOINT + USB_CFG_HAVE_INTRIN_ENDPOINT3, /* endpoints excl 0: number of endpoint descriptors to ...
;    USB_CFG_INTERFACE_CLASS,
;    USB_CFG_INTERFACE_SUBCLASS,
;    USB_CFG_INTERFACE_PROTOCOL,
;    0,          /* string index for interface */
;#if (USB_CFG_DESCR_PROPS_HID & 0xff)    /* HID descriptor */
;    9,          /* sizeof(usbDescrHID): length of descriptor in bytes */
;    USBDESCR_HID,   /* descriptor type: HID */
;    0x01, 0x01, /* BCD representation of HID version */
;    0x00,       /* target country code */
;    0x01,       /* number of HID Report (or other HID class) Descriptor infos to follow */
;    0x22,       /* descriptor type: report */
;    USB_CFG_HID_REPORT_DESCRIPTOR_LENGTH, 0,  /* total length of report descriptor */
;#endif
;#if USB_CFG_HAVE_INTRIN_ENDPOINT    /* endpoint descriptor for endpoint 1 */
;    7,          /* sizeof(usbDescrEndpoint) */
;    USBDESCR_ENDPOINT,  /* descriptor type = endpoint */
;    (char)0x81, /* IN endpoint number 1 */
;    0x03,       /* attrib: Interrupt endpoint */
;    8, 0,       /* maximum packet size */
;    USB_CFG_INTR_POLL_INTERVAL, /* in ms */
;#endif
;#if USB_CFG_HAVE_INTRIN_ENDPOINT3   /* endpoint descriptor for endpoint 3 */
;    7,          /* sizeof(usbDescrEndpoint) */
;    USBDESCR_ENDPOINT,  /* descriptor type = endpoint */
;    (char)(0x80 | USB_CFG_EP3_NUMBER), /* IN endpoint number 3 */
;    0x03,       /* attrib: Interrupt endpoint */
;    8, 0,       /* maximum packet size */
;    USB_CFG_INTR_POLL_INTERVAL, /* in ms */
;#endif
;};
;#endif
;
;/* ------------------------------------------------------------------------- */
;
;static inline void  usbResetDataToggling(void)
; 0000 0006 {
;#if USB_CFG_HAVE_INTRIN_ENDPOINT && !USB_CFG_SUPPRESS_INTR_CODE
;    USB_SET_DATATOKEN1(USB_INITIAL_DATATOKEN);  /* reset data toggling for interrupt endpoint */
;#   if USB_CFG_HAVE_INTRIN_ENDPOINT3
;    USB_SET_DATATOKEN3(USB_INITIAL_DATATOKEN);  /* reset data toggling for interrupt endpoint */
;#   endif
;#endif
;}
;
;static inline void  usbResetStall(void)
;{
;#if USB_CFG_IMPLEMENT_HALT && USB_CFG_HAVE_INTRIN_ENDPOINT
;        usbTxLen1 = USBPID_NAK;
;#if USB_CFG_HAVE_INTRIN_ENDPOINT3
;        usbTxLen3 = USBPID_NAK;
;#endif
;#endif
;}
;
;/* ------------------------------------------------------------------------- */
;
;#if !USB_CFG_SUPPRESS_INTR_CODE
;#if USB_CFG_HAVE_INTRIN_ENDPOINT
;static void usbGenericSetInterrupt(uchar *data, uchar len, usbTxStatus_t *txStatus)
;{

	.CSEG
;uchar   *p;
;char    i;
;
;#if USB_CFG_IMPLEMENT_HALT
;    if(usbTxLen1 == USBPID_STALL)
;        return;
;#endif
;    if(txStatus->len & 0x10){   /* packet buffer was empty */
;	*data -> Y+7
;	len -> Y+6
;	*txStatus -> Y+4
;	*p -> R16,R17
;	i -> R19
;        txStatus->buffer[0] ^= USBPID_DATA0 ^ USBPID_DATA1; /* toggle token */
;    }else{
;        txStatus->len = USBPID_NAK; /* avoid sending outdated (overwritten) interrupt data */
;    }
;    p = txStatus->buffer + 1;
;    i = len;
;    do{                         /* if len == 0, we still copy 1 byte, but that's no problem */
;        *p++ = *data++;
;    }while(--i > 0);            /* loop control at the end is 2 bytes shorter than at beginning */
;    usbCrc16Append(&txStatus->buffer[1], len);
;    txStatus->len = len + 4;    /* len must be given including sync byte */
;    DBG2(0x21 + (((int)txStatus >> 3) & 3), txStatus->buffer, len + 3);
;}
;
;USB_PUBLIC void usbSetInterrupt(uchar *data, uchar len)
;{
;    usbGenericSetInterrupt(data, len, &usbTxStatus1);
;	*data -> Y+1
;	len -> Y+0
;}
;#endif
;
;#if USB_CFG_HAVE_INTRIN_ENDPOINT3
;USB_PUBLIC void usbSetInterrupt3(uchar *data, uchar len)
;{
;    usbGenericSetInterrupt(data, len, &usbTxStatus3);
;}
;#endif
;#endif /* USB_CFG_SUPPRESS_INTR_CODE */
;
;/* ------------------ utilities for code following below ------------------- */
;
;/* Use defines for the switch statement so that we can choose between an
; * if()else if() and a switch/case based implementation. switch() is more
; * efficient for a LARGE set of sequential choices, if() is better in all other
; * cases.
; */
;#if USB_CFG_USE_SWITCH_STATEMENT
;#   define SWITCH_START(cmd)       switch(cmd){{
;#   define SWITCH_CASE(value)      }break; case (value):{
;#   define SWITCH_CASE2(v1,v2)     }break; case (v1): case(v2):{
;#   define SWITCH_CASE3(v1,v2,v3)  }break; case (v1): case(v2): case(v3):{
;#   define SWITCH_DEFAULT          }break; default:{
;#   define SWITCH_END              }}
;#else
;#   define SWITCH_START(cmd)       {uchar _cmd = cmd; if(0){
;#   define SWITCH_CASE(value)      }else if(_cmd == (value)){
;#   define SWITCH_CASE2(v1,v2)     }else if(_cmd == (v1) || _cmd == (v2)){
;#   define SWITCH_CASE3(v1,v2,v3)  }else if(_cmd == (v1) || _cmd == (v2) || (_cmd == v3)){
;#   define SWITCH_DEFAULT          }else{
;#   define SWITCH_END              }}
;#endif
;
;#ifndef USB_RX_USER_HOOK
;#define USB_RX_USER_HOOK(data, len)
;#endif
;#ifndef USB_SET_ADDRESS_HOOK
;#define USB_SET_ADDRESS_HOOK()
;#endif
;
;/* ------------------------------------------------------------------------- */
;
;/* We use if() instead of #if in the macro below because #if can't be used
; * in macros and the compiler optimizes constant conditions anyway.
; * This may cause problems with undefined symbols if compiled without
; * optimizing!
; */
;#define GET_DESCRIPTOR(cfgProp, staticName)         \
;    if(cfgProp){                                    \
;        if((cfgProp) & USB_PROP_IS_RAM)             \
;            flags = 0;                              \
;        if((cfgProp) & USB_PROP_IS_DYNAMIC){        \
;            len = usbFunctionDescriptor(rq);        \
;        }else{                                      \
;            len = USB_PROP_LENGTH(cfgProp);         \
;            usbMsgPtr = (usbMsgPtr_t)(staticName);  \
;        }                                           \
;    }
;
;/* usbDriverDescriptor() is similar to usbFunctionDescriptor(), but used
; * internally for all types of descriptors.
; */
;static inline usbMsgLen_t usbDriverDescriptor(usbRequest_t *rq)
;{
;usbMsgLen_t len = 0;
;uchar       flags = USB_FLG_MSGPTR_IS_ROM;
;
;    SWITCH_START(rq->wValue.bytes[1])
;	*rq -> Y+2
;	len -> R17
;	flags -> R16
;    SWITCH_CASE(USBDESCR_DEVICE)    /* 1 */
;        GET_DESCRIPTOR(USB_CFG_DESCR_PROPS_DEVICE, usbDescriptorDevice)
;    SWITCH_CASE(USBDESCR_CONFIG)    /* 2 */
;        GET_DESCRIPTOR(USB_CFG_DESCR_PROPS_CONFIGURATION, usbDescriptorConfiguration)
;    SWITCH_CASE(USBDESCR_STRING)    /* 3 */
;#if USB_CFG_DESCR_PROPS_STRINGS & USB_PROP_IS_DYNAMIC
;        if(USB_CFG_DESCR_PROPS_STRINGS & USB_PROP_IS_RAM)
;            flags = 0;
;        len = usbFunctionDescriptor(rq);
;#else   /* USB_CFG_DESCR_PROPS_STRINGS & USB_PROP_IS_DYNAMIC */
;        SWITCH_START(rq->wValue.bytes[0])
;        SWITCH_CASE(0)
;            GET_DESCRIPTOR(USB_CFG_DESCR_PROPS_STRING_0, usbDescriptorString0)
;        SWITCH_CASE(1)
;            GET_DESCRIPTOR(USB_CFG_DESCR_PROPS_STRING_VENDOR, usbDescriptorStringVendor)
;        SWITCH_CASE(2)
;            GET_DESCRIPTOR(USB_CFG_DESCR_PROPS_STRING_PRODUCT, usbDescriptorStringDevice)
;        SWITCH_CASE(3)
;            GET_DESCRIPTOR(USB_CFG_DESCR_PROPS_STRING_SERIAL_NUMBER, usbDescriptorStringSerialNumber)
;        SWITCH_DEFAULT
;            if(USB_CFG_DESCR_PROPS_UNKNOWN & USB_PROP_IS_DYNAMIC){
;                len = usbFunctionDescriptor(rq);
;            }
;        SWITCH_END
;#endif  /* USB_CFG_DESCR_PROPS_STRINGS & USB_PROP_IS_DYNAMIC */
;#if USB_CFG_DESCR_PROPS_HID_REPORT  /* only support HID descriptors if enabled */
;    SWITCH_CASE(USBDESCR_HID)       /* 0x21 */
;        GET_DESCRIPTOR(USB_CFG_DESCR_PROPS_HID, usbDescriptorConfiguration + 18)
;    SWITCH_CASE(USBDESCR_HID_REPORT)/* 0x22 */
;        GET_DESCRIPTOR(USB_CFG_DESCR_PROPS_HID_REPORT, usbDescriptorHidReport)
;#endif
;    SWITCH_DEFAULT
;        if(USB_CFG_DESCR_PROPS_UNKNOWN & USB_PROP_IS_DYNAMIC){
;            len = usbFunctionDescriptor(rq);
;        }
;    SWITCH_END
;    usbMsgFlags = flags;
;    return len;
;}
;
;/* ------------------------------------------------------------------------- */
;
;/* usbDriverSetup() is similar to usbFunctionSetup(), but it's used for
; * standard requests instead of class and custom requests.
; */
;static inline usbMsgLen_t usbDriverSetup(usbRequest_t *rq)
;{
;usbMsgLen_t len = 0;
;uchar   *dataPtr = usbTxBuf + 9;    /* there are 2 bytes free space at the end of the buffer */
;uchar   value = rq->wValue.bytes[0];
;#if USB_CFG_IMPLEMENT_HALT
;uchar   index = rq->wIndex.bytes[0];
;#endif
;
;    dataPtr[0] = 0; /* default reply common to USBRQ_GET_STATUS and USBRQ_GET_INTERFACE */
;	*rq -> Y+4
;	len -> R17
;	*dataPtr -> R18,R19
;	value -> R16
;    SWITCH_START(rq->bRequest)
;    SWITCH_CASE(USBRQ_GET_STATUS)           /* 0 */
;        uchar recipient = rq->bmRequestType & USBRQ_RCPT_MASK;  /* assign arith ops to variables to enforce byte size */
;        if(USB_CFG_IS_SELF_POWERED && recipient == USBRQ_RCPT_DEVICE)
;	*rq -> Y+5
;	recipient -> Y+0
;            dataPtr[0] =  USB_CFG_IS_SELF_POWERED;
;#if USB_CFG_IMPLEMENT_HALT
;        if(recipient == USBRQ_RCPT_ENDPOINT && index == 0x81)   /* request status for endpoint 1 */
;            dataPtr[0] = usbTxLen1 == USBPID_STALL;
;#endif
;        dataPtr[1] = 0;
;        len = 2;
;#if USB_CFG_IMPLEMENT_HALT
;    SWITCH_CASE2(USBRQ_CLEAR_FEATURE, USBRQ_SET_FEATURE)    /* 1, 3 */
;        if(value == 0 && index == 0x81){    /* feature 0 == HALT for endpoint == 1 */
;            usbTxLen1 = rq->bRequest == USBRQ_CLEAR_FEATURE ? USBPID_NAK : USBPID_STALL;
;            usbResetDataToggling();
;        }
;#endif
;    SWITCH_CASE(USBRQ_SET_ADDRESS)          /* 5 */
;        usbNewDeviceAddr = value;
;        USB_SET_ADDRESS_HOOK();
;    SWITCH_CASE(USBRQ_GET_DESCRIPTOR)       /* 6 */
;        len = usbDriverDescriptor(rq);
;        goto skipMsgPtrAssignment;
;    SWITCH_CASE(USBRQ_GET_CONFIGURATION)    /* 8 */
;        dataPtr = &usbConfiguration;  /* send current configuration value */
;        len = 1;
;    SWITCH_CASE(USBRQ_SET_CONFIGURATION)    /* 9 */
;        usbConfiguration = value;
;        usbResetStall();
;    SWITCH_CASE(USBRQ_GET_INTERFACE)        /* 10 */
;        len = 1;
;#if USB_CFG_HAVE_INTRIN_ENDPOINT && !USB_CFG_SUPPRESS_INTR_CODE
;    SWITCH_CASE(USBRQ_SET_INTERFACE)        /* 11 */
;        usbResetDataToggling();
;        usbResetStall();
;#endif
;    SWITCH_DEFAULT                          /* 7=SET_DESCRIPTOR, 12=SYNC_FRAME */
;        /* Should we add an optional hook here? */
;    SWITCH_END
;    usbMsgPtr = (usbMsgPtr_t)dataPtr;
;skipMsgPtrAssignment:
;    return len;
;}
;
;/* ------------------------------------------------------------------------- */
;
;/* usbProcessRx() is called for every message received by the interrupt
; * routine. It distinguishes between SETUP and DATA packets and processes
; * them accordingly.
; */
;static inline void usbProcessRx(uchar *data, uchar len)
;{
;usbRequest_t    *rq = (void *)data;
;
;/* usbRxToken can be:
; * 0x2d 00101101 (USBPID_SETUP for setup data)
; * 0xe1 11100001 (USBPID_OUT: data phase of setup transfer)
; * 0...0x0f for OUT on endpoint X
; */
;    DBG2(0x10 + (usbRxToken & 0xf), data, len + 2); /* SETUP=1d, SETUP-DATA=11, OUTx=1x */
;    USB_RX_USER_HOOK(data, len)
;#if USB_CFG_IMPLEMENT_FN_WRITEOUT
;    if(usbRxToken < 0x10){  /* OUT to endpoint != 0: endpoint number in usbRxToken */
;        usbFunctionWriteOut(data, len);
;        return;
;    }
;#endif
;    if(usbRxToken == (uchar)USBPID_SETUP){
;	*data -> Y+3
;	len -> Y+2
;	*rq -> R16,R17
;        usbMsgLen_t replyLen;
;        uchar type;
;        if(len != 8)    /* Setup size must be always 8 bytes. Ignore otherwise. */
;	*data -> Y+5
;	len -> Y+4
;	replyLen -> Y+1
;	type -> Y+0
;            return;
;        usbTxBuf[0] = USBPID_DATA0;         /* initialize data toggling */
;        usbTxLen = USBPID_NAK;              /* abort pending transmit */
;        usbMsgFlags = 0;
;        type = rq->bmRequestType & USBRQ_TYPE_MASK;
;        if(type != USBRQ_TYPE_STANDARD){    /* standard requests are handled by driver */
;            replyLen = usbFunctionSetup(data);
;        }else{
;            replyLen = usbDriverSetup(rq);
;        }
;#if USB_CFG_IMPLEMENT_FN_READ || USB_CFG_IMPLEMENT_FN_WRITE
;        if(replyLen == USB_NO_MSG){         /* use user-supplied read/write function */
;            /* do some conditioning on replyLen, but on IN transfers only */
;            if((rq->bmRequestType & USBRQ_DIR_MASK) != USBRQ_DIR_HOST_TO_DEVICE){
;                if(sizeof(replyLen) < sizeof(rq->wLength.word)){ /* help compiler with optimizing */
;                    replyLen = rq->wLength.bytes[0];
;                }else{
;                    replyLen = rq->wLength.word;
;                }
;            }
;            usbMsgFlags = USB_FLG_USE_USER_RW;
;        }else   /* The 'else' prevents that we limit a replyLen of USB_NO_MSG to the maximum transfer len. */
;#endif
;        if(sizeof(replyLen) < sizeof(rq->wLength.word)){ /* help compiler with optimizing */
;            if(!rq->wLength.bytes[1] && replyLen > rq->wLength.bytes[0])    /* limit length to max */
;                replyLen = rq->wLength.bytes[0];
;        }else{
;            if(replyLen > rq->wLength.word)     /* limit length to max */
;                replyLen = rq->wLength.word;
;        }
;        usbMsgLen = replyLen;
;    }else{  /* usbRxToken must be USBPID_OUT, which means data phase of setup (control-out) */
;#if USB_CFG_IMPLEMENT_FN_WRITE
;        if(usbMsgFlags & USB_FLG_USE_USER_RW){
;            uchar rval = usbFunctionWrite(data, len);
;            if(rval == 0xff){   /* an error occurred */
;	*data -> Y+4
;	len -> Y+3
;	rval -> Y+0
;                usbTxLen = USBPID_STALL;
;            }else if(rval != 0){    /* This was the final package */
;                usbMsgLen = 0;  /* answer with a zero-sized data packet */
;            }
;        }
;#endif
;    }
;}
;
;/* ------------------------------------------------------------------------- */
;
;/* This function is similar to usbFunctionRead(), but it's also called for
; * data handled automatically by the driver (e.g. descriptor reads).
; */
;static uchar usbDeviceRead(uchar *data, uchar len)
;{
_usbDeviceRead_G000:
; .FSTART _usbDeviceRead_G000
;    if(len > 0){    /* don't bother app with 0 sized reads */
	ST   -Y,R26
;	*data -> Y+1
;	len -> Y+0
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BRSH PC+2
	RJMP _0x68
;#if USB_CFG_IMPLEMENT_FN_READ
;        if(usbMsgFlags & USB_FLG_USE_USER_RW){
	LDS  R30,_usbMsgFlags_G000
	ANDI R30,LOW(0x80)
	BREQ _0x69
;            len = usbFunctionRead(data, len);
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R26,Y+2
	RCALL _usbFunctionRead_G000
	ST   Y,R30
;        }else
	RJMP _0x6A
_0x69:
;#endif
;        {
;            uchar i = len;
;            usbMsgPtr_t r = usbMsgPtr;
;            if(usbMsgFlags & USB_FLG_MSGPTR_IS_ROM){    /* ROM data */
	SBIW R28,3
;	*data -> Y+4
;	len -> Y+3
;	i -> Y+2
;	*r -> Y+0
	LDD  R30,Y+3
	STD  Y+2,R30
	LDS  R30,_usbMsgPtr
	LDS  R31,_usbMsgPtr+1
	ST   Y,R30
	STD  Y+1,R31
	LDS  R30,_usbMsgFlags_G000
	ANDI R30,LOW(0x40)
	BREQ _0x6B
;                do{
_0x6D:
;                    uchar c = USB_READ_FLASH(r);    /* assign to char size variable to enforce byte ops */
;                    *data++ = c;
	SBIW R28,1
;	*data -> Y+5
;	len -> Y+4
;	i -> Y+3
;	*r -> Y+1
;	c -> Y+0
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	LPM  R30,Z
	ST   Y,R30
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ADIW R30,1
	STD  Y+5,R30
	STD  Y+5+1,R31
	SBIW R30,1
	LD   R26,Y
	STD  Z+0,R26
;                    r++;
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,1
	STD  Y+1,R30
	STD  Y+1+1,R31
;                }while(--i);
	ADIW R28,1
	LDD  R30,Y+2
	SUBI R30,LOW(1)
	STD  Y+2,R30
	BRNE _0x6D
;            }else{  /* RAM data */
	RJMP _0x6F
_0x6B:
;                do{
_0x71:
;                    *data++ = *((uchar *)r);
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ADIW R30,1
	STD  Y+4,R30
	STD  Y+4+1,R31
	SBIW R30,1
	MOVW R0,R30
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X
	MOVW R26,R0
	ST   X,R30
;                    r++;
	LD   R30,Y
	LDD  R31,Y+1
	ADIW R30,1
	ST   Y,R30
	STD  Y+1,R31
;                }while(--i);
	LDD  R30,Y+2
	SUBI R30,LOW(1)
	STD  Y+2,R30
	BRNE _0x71
;            }
_0x6F:
;            usbMsgPtr = r;
	LD   R30,Y
	LDD  R31,Y+1
	STS  _usbMsgPtr,R30
	STS  _usbMsgPtr+1,R31
;        }
	ADIW R28,3
_0x6A:
;    }
;    return len;
_0x68:
	LD   R30,Y
	ADIW R28,3
	RET
;}
; .FEND
;
;/* ------------------------------------------------------------------------- */
;
;/* usbBuildTxBlock() is called when we have data to transmit and the
; * interrupt routine's transmit buffer is empty.
; */
;static inline void usbBuildTxBlock(void)
;{
;usbMsgLen_t wantLen;
;uchar       len;
;
;    wantLen = usbMsgLen;
;	wantLen -> R17
;	len -> R16
;    if(wantLen > 8)
;        wantLen = 8;
;    usbMsgLen -= wantLen;
;    usbTxBuf[0] ^= USBPID_DATA0 ^ USBPID_DATA1; /* DATA toggling */
;    len = usbDeviceRead(usbTxBuf + 1, wantLen);
;    if(len <= 8){           /* valid data packet */
;        usbCrc16Append(&usbTxBuf[1], len);
;        len += 4;           /* length including sync byte */
;        if(len < 12)        /* a partial package identifies end of message */
;            usbMsgLen = USB_NO_MSG;
;    }else{
;        len = USBPID_STALL;   /* stall the endpoint */
;        usbMsgLen = USB_NO_MSG;
;    }
;    usbTxLen = len;
;    DBG2(0x20, usbTxBuf, len-1);
;}
;
;/* ------------------------------------------------------------------------- */
;
;static inline void usbHandleResetHook(uchar notResetState)
;{
;#ifdef USB_RESET_HOOK
;static uchar    wasReset;
;uchar           isReset = !notResetState;
;
;    if(wasReset != isReset){
;        USB_RESET_HOOK(isReset);
;        wasReset = isReset;
;    }
;#else
;    notResetState = notResetState;  // avoid compiler warning
;	notResetState -> Y+0
;#endif
;}
;
;/* ------------------------------------------------------------------------- */
;
;USB_PUBLIC void usbPoll(void)
;{
_usbPoll_G000:
; .FSTART _usbPoll_G000
;schar   len;
;uchar   i;
;
;    len = usbRxLen - 3;
	RCALL __SAVELOCR2
;	len -> R17
;	i -> R16
	LDS  R30,_usbRxLen
	SUBI R30,LOW(3)
	MOV  R17,R30
;    if(len >= 0){
	CPI  R17,0
	BRGE PC+2
	RJMP _0x79
;/* We could check CRC16 here -- but ACK has already been sent anyway. If you
; * need data integrity checks with this driver, check the CRC in your app
; * code and report errors back to the host. Since the ACK was already sent,
; * retries must be handled on application level.
; * unsigned crc = usbCrc16(buffer + 1, usbRxLen - 3);
; */
;        usbProcessRx(usbRxBuf + USB_BUFSIZE + 1 - usbInputBufOffset, len);
	__POINTW2MN _usbRxBuf,12
	MOV  R30,R5
	LDI  R31,0
	SUB  R26,R30
	SBC  R27,R31
	ST   -Y,R27
	ST   -Y,R26
	MOV  R30,R17
	MOV  R26,R30
	ST   -Y,R26
	RCALL __SAVELOCR2
	__GETWRS 16,17,3
	LDS  R26,_usbRxToken
	CPI  R26,LOW(0x2D)
	BREQ PC+2
	RJMP _0x400A053
	SBIW R28,2
	LDD  R26,Y+4
	CPI  R26,LOW(0x8)
	BREQ _0x400A054
	ADIW R28,2
	RJMP _0x400A067
_0x400A054:
	LDI  R30,LOW(195)
	STS  _usbTxBuf,R30
	LDI  R30,LOW(90)
	STS  _usbTxLen,R30
	LDI  R30,LOW(0)
	STS  _usbMsgFlags_G000,R30
	MOVW R26,R16
	LD   R30,Z
	ANDI R30,LOW(0x60)
	ST   Y,R30
	CPI  R30,0
	BREQ _0x400A055
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	RCALL _usbFunctionSetup_G000
	RJMP _0xAE
_0x400A055:
	MOVW R26,R16
	ST   -Y,R27
	ST   -Y,R26
	RCALL __SAVELOCR4
	LDI  R17,0
	__POINTWRMN 18,19,_usbTxBuf,9
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	LDD  R16,Z+2
	MOVW R26,R18
	LDI  R30,LOW(0)
	ST   X,R30
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	LDD  R30,Z+1
	LDI  R31,0
	RJMP _0x8003045
_0xC00B02A:
_0xC00B01F:
	RJMP _0xC00B011
_0xC00B01C:
	CPI  R30,LOW(0x21)
	LDI  R26,HIGH(0x21)
	CPC  R31,R26
	BRNE _0xC00B036
	LDI  R17,LOW(9)
	__POINTW1FN _usbDescriptorConfiguration,18
	STS  _usbMsgPtr,R30
	STS  _usbMsgPtr+1,R31
	RJMP _0xC00B011
_0xC00B036:
	CPI  R30,LOW(0x22)
	LDI  R26,HIGH(0x22)
	CPC  R31,R26
	BRNE _0xC00B040
	LDI  R17,LOW(22)
	LDI  R30,LOW(_usbDescriptorHidReport*2)
	LDI  R31,HIGH(_usbDescriptorHidReport*2)
	STS  _usbMsgPtr,R30
	STS  _usbMsgPtr+1,R31
_0xC00B040:
_0xC00B011:
	STS  _usbMsgFlags_G000,R16
	MOV  R30,R17
	RCALL __LOADLOCR2
	ADIW R28,4
	MOV  R17,R30
	RJMP _0x800304C
_0x800304B:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x800304D
	__POINTWRM 18,19,_usbConfiguration
	LDI  R17,LOW(1)
	RJMP _0x8003045
_0x800304D:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0x800304E
	STS  _usbConfiguration,R16
	RJMP _0x8003045
_0x800304E:
	CPI  R30,LOW(0xA)
	LDI  R26,HIGH(0xA)
	CPC  R31,R26
	BRNE _0x800304F
	LDI  R17,LOW(1)
	RJMP _0x8003045
_0x800304F:
	SBIW R30,11
	BRNE _0x8003051
	LDI  R30,LOW(75)
	__PUTB1MN _usbTxStatus1,1
_0x8003051:
_0x8003045:
	__PUTWMRN _usbMsgPtr,0,18,19
_0x800304C:
	MOV  R30,R17
	RCALL __LOADLOCR4
	ADIW R28,6
_0xAE:
	STD  Y+1,R30
	LDD  R26,Y+1
	CPI  R26,LOW(0xFF)
	BRNE _0x400A057
	MOVW R26,R16
	LD   R30,Z
	ANDI R30,LOW(0x80)
	BREQ _0x400A058
_0xAF:
	MOVW R30,R16
	LDD  R30,Z+6
	STD  Y+1,R30
_0x400A058:
	LDI  R30,LOW(128)
	STS  _usbMsgFlags_G000,R30
	RJMP _0x400A05B
_0x400A057:
	MOVW R30,R16
	LDD  R30,Z+7
	CPI  R30,0
	BRNE _0x400A05E
	MOVW R30,R16
	LDD  R30,Z+6
	LDD  R26,Y+1
	CP   R30,R26
	BRLO _0x400A05F
_0x400A05E:
	RJMP _0x400A05D
_0x400A05F:
	MOVW R30,R16
	LDD  R30,Z+6
	STD  Y+1,R30
_0x400A05D:
_0x400A05B:
	LDD  R30,Y+1
	STS  _usbMsgLen_G000,R30
	ADIW R28,2
	RJMP _0x400A062
_0x400A053:
	LDS  R30,_usbMsgFlags_G000
	ANDI R30,LOW(0x80)
	BREQ _0x400A063
	SBIW R28,1
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R26,Y+5
	RCALL _usbFunctionWrite_G000
	ST   Y,R30
	LD   R26,Y
	CPI  R26,LOW(0xFF)
	BRNE _0x400A064
	LDI  R30,LOW(30)
	STS  _usbTxLen,R30
	RJMP _0x400A065
_0x400A064:
	LD   R30,Y
	CPI  R30,0
	BREQ _0x400A066
	LDI  R30,LOW(0)
	STS  _usbMsgLen_G000,R30
_0x400A066:
_0x400A065:
	ADIW R28,1
_0x400A063:
_0x400A062:
_0x400A067:
	RCALL __LOADLOCR2
	ADIW R28,5
;#if USB_CFG_HAVE_FLOWCONTROL
;        if(usbRxLen > 0)    /* only mark as available if not inactivated */
;            usbRxLen = 0;
;#else
;        usbRxLen = 0;       /* mark rx buffer as available */
	LDI  R30,LOW(0)
	STS  _usbRxLen,R30
;#endif
;    }
;    if(usbTxLen & 0x10){    /* transmit system idle */
_0x79:
	LDS  R30,_usbTxLen
	ANDI R30,LOW(0x10)
	BREQ _0x7A
;        if(usbMsgLen != USB_NO_MSG){    /* transmit data pending? */
	LDS  R26,_usbMsgLen_G000
	CPI  R26,LOW(0xFF)
	BREQ _0x7B
;            usbBuildTxBlock();
	RCALL __SAVELOCR2
	LDS  R17,_usbMsgLen_G000
	CPI  R17,9
	BRLO _0x400C074
	LDI  R17,LOW(8)
_0x400C074:
	LDS  R30,_usbMsgLen_G000
	SUB  R30,R17
	STS  _usbMsgLen_G000,R30
	LDS  R26,_usbTxBuf
	LDI  R30,LOW(136)
	EOR  R30,R26
	STS  _usbTxBuf,R30
	__POINTW1MN _usbTxBuf,1
	ST   -Y,R31
	ST   -Y,R30
	MOV  R26,R17
	RCALL _usbDeviceRead_G000
	MOV  R16,R30
	CPI  R16,9
	BRSH _0x400C075
	__POINTW1MN _usbTxBuf,1
	ST   -Y,R31
	ST   -Y,R30
	MOV  R26,R16
	RCALL _usbCrc16Append
	SUBI R16,-LOW(4)
	CPI  R16,12
	BRSH _0x400C076
	LDI  R30,LOW(255)
	STS  _usbMsgLen_G000,R30
_0x400C076:
	RJMP _0x400C077
_0x400C075:
	LDI  R16,LOW(30)
	LDI  R30,LOW(255)
	STS  _usbMsgLen_G000,R30
_0x400C077:
	STS  _usbTxLen,R16
	LD   R16,Y+
	LD   R17,Y+
;        }
;    }
_0x7B:
;    for(i = 20; i > 0; i--){
_0x7A:
	LDI  R16,LOW(20)
_0x7D:
	CPI  R16,1
	BRLO _0x7E
;        uchar usbLineStatus = USBIN & USBMASK;
;        if(usbLineStatus != 0){  /* SE0 has ended */
	SBIW R28,1
;	usbLineStatus -> Y+0
	IN   R30,0x10
	ANDI R30,LOW(0x14)
	ST   Y,R30
	CPI  R30,0
	BRNE _0x80
;            goto isNotReset;   }
;    }
	ADIW R28,1
	SUBI R16,1
	RJMP _0x7D
_0x7E:
;    /* RESET condition, called multiple times during reset */
;    usbNewDeviceAddr = 0;
	CLR  R7
;    usbDeviceAddr = 0;
	CLR  R4
;    usbResetStall();
;    DBG1(0xff, 0, 0);
;isNotReset:
_0x80:
;    usbHandleResetHook(i);
	MOV  R26,R16
	ST   -Y,R26
	LD   R30,Y
	ST   Y,R30
	ADIW R28,1
;}
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;
;/* ------------------------------------------------------------------------- */
;
;USB_PUBLIC void usbInit(void)
;{
_usbInit_G000:
; .FSTART _usbInit_G000
;#if USB_INTR_CFG_SET != 0
;    USB_INTR_CFG |= USB_INTR_CFG_SET;
	IN   R30,0x35
	ORI  R30,2
	OUT  0x35,R30
;#endif
;#if USB_INTR_CFG_CLR != 0
;    USB_INTR_CFG &= ~(USB_INTR_CFG_CLR);
;#endif
;    USB_INTR_ENABLE |= (1 << USB_INTR_ENABLE_BIT);
	IN   R30,0x3B
	ORI  R30,0x40
	OUT  0x3B,R30
;    usbResetDataToggling();
	LDI  R30,LOW(75)
	__PUTB1MN _usbTxStatus1,1
;#if USB_CFG_HAVE_INTRIN_ENDPOINT && !USB_CFG_SUPPRESS_INTR_CODE
;    usbTxLen1 = USBPID_NAK;
	LDI  R30,LOW(90)
	STS  _usbTxStatus1,R30
;#if USB_CFG_HAVE_INTRIN_ENDPOINT3
;    usbTxLen3 = USBPID_NAK;
;#endif
;#endif
;}
	RET
; .FEND
;
;/* ------------------------------------------------------------------------- */
;
;uchar button;
;
;interrupt [TIM1_OVF] void timer1_ovf_isr(void)
; 0000 000B {
_timer1_ovf_isr:
; .FSTART _timer1_ovf_isr
	ST   -Y,R30
; 0000 000C uchar T;
; 0000 000D #asm ("sei");
	ST   -Y,R17
;	T -> R17
	sei
; 0000 000E 
; 0000 000F TCNT1H=0x6D84 >> 8;
	LDI  R30,LOW(109)
	OUT  0x2D,R30
; 0000 0010 TCNT1L=0x6D84 & 0xff;
	LDI  R30,LOW(132)
	OUT  0x2C,R30
; 0000 0011 
; 0000 0012     DDRC  = 0b111;
	LDI  R30,LOW(7)
	OUT  0x14,R30
; 0000 0013     PORTC = 0b110;
	LDI  R30,LOW(6)
	OUT  0x15,R30
; 0000 0014     #asm ("NOP")
	NOP
; 0000 0015     T = PINB;
	IN   R17,22
; 0000 0016     if ((T & 0b00001000) == 0) button = '*';
	SBRC R17,3
	RJMP _0x81
	LDI  R30,LOW(42)
	RJMP _0xB0
; 0000 0017     else if ((T & 0b00000100) == 0) button = '7';
_0x81:
	SBRC R17,2
	RJMP _0x83
	LDI  R30,LOW(55)
	RJMP _0xB0
; 0000 0018     else if ((T & 0b00000010) == 0) button = '4';
_0x83:
	SBRC R17,1
	RJMP _0x85
	LDI  R30,LOW(52)
	RJMP _0xB0
; 0000 0019     else if ((T & 0b00000001) == 0) button = '1';
_0x85:
	SBRC R17,0
	RJMP _0x87
	LDI  R30,LOW(49)
_0xB0:
	MOV  R9,R30
; 0000 001A 
; 0000 001B     PORTC = 0b101;
_0x87:
	LDI  R30,LOW(5)
	OUT  0x15,R30
; 0000 001C     #asm ("NOP")
	NOP
; 0000 001D     T = PINB;
	IN   R17,22
; 0000 001E     if ((T & 0b00001000) == 0) button = '0';
	SBRC R17,3
	RJMP _0x88
	LDI  R30,LOW(48)
	RJMP _0xB1
; 0000 001F     else if ((T & 0b00000100) == 0) button = '8';
_0x88:
	SBRC R17,2
	RJMP _0x8A
	LDI  R30,LOW(56)
	RJMP _0xB1
; 0000 0020     else if ((T & 0b00000010) == 0) button = '5';
_0x8A:
	SBRC R17,1
	RJMP _0x8C
	LDI  R30,LOW(53)
	RJMP _0xB1
; 0000 0021     else if ((T & 0b00000001) == 0) button = '2';
_0x8C:
	SBRC R17,0
	RJMP _0x8E
	LDI  R30,LOW(50)
_0xB1:
	MOV  R9,R30
; 0000 0022 
; 0000 0023     PORTC = 0b011;
_0x8E:
	LDI  R30,LOW(3)
	OUT  0x15,R30
; 0000 0024     #asm ("NOP")
	NOP
; 0000 0025     T = PINB;
	IN   R17,22
; 0000 0026     if ((T & 0b00001000) == 0) button = '#';
	SBRC R17,3
	RJMP _0x8F
	LDI  R30,LOW(35)
	RJMP _0xB2
; 0000 0027     else if ((T & 0b00000100) == 0) button = '9';
_0x8F:
	SBRC R17,2
	RJMP _0x91
	LDI  R30,LOW(57)
	RJMP _0xB2
; 0000 0028     else if ((T & 0b00000010) == 0) button = '6';
_0x91:
	SBRC R17,1
	RJMP _0x93
	LDI  R30,LOW(54)
	RJMP _0xB2
; 0000 0029     else if ((T & 0b00000001) == 0) button = '3';
_0x93:
	SBRC R17,0
	RJMP _0x95
	LDI  R30,LOW(51)
_0xB2:
	MOV  R9,R30
; 0000 002A }
_0x95:
	LD   R17,Y+
	LD   R30,Y+
	RETI
; .FEND
;
;struct dataexchange_t       // Описание структуры для передачи данных
;{
;   uchar b1;        // Я решил для примера написать структуру на 3 байта.
;//   uchar b2;        // На каждый байт подцепим ногу из PORTB. Конечно это
;//   uchar b3;        // не рационально (всего то 3 бита нужно).
;};                  // Но в целях демонстрации в самый раз.
;                    // Для наглядности прикрутить по светодиоду и созерцать :)
;
;struct dataexchange_t pdata = {0};
;
;/* Эти переменные хранят статус текущей передачи */
;static uchar    currentAddress;
;static uchar    bytesRemaining;
;
;/* usbFunctionRead() вызывается когда хост запрашивает порцию данных от устройства
; * Для дополнительной информации см. документацию в usbdrv.h
; */
;uchar   usbFunctionRead(uchar *data, uchar len)
; 0000 003E {
_usbFunctionRead_G000:
; .FSTART _usbFunctionRead_G000
; 0000 003F     uchar j;
; 0000 0040     uchar *buffer;
; 0000 0041     if(len > bytesRemaining)
	ST   -Y,R26
	RCALL __SAVELOCR4
;	*data -> Y+5
;	len -> Y+4
;	j -> R17
;	*buffer -> R18,R19
	LDS  R30,_bytesRemaining_G000
	LDD  R26,Y+4
	CP   R30,R26
	BRSH _0x96
; 0000 0042         len = bytesRemaining;
	STD  Y+4,R30
; 0000 0043 
; 0000 0044     buffer = (uchar*)&pdata;
_0x96:
	__POINTWRM 18,19,_pdata
; 0000 0045 
; 0000 0046     if(!currentAddress)        // Ни один кусок данных еще не прочитан.
	LDS  R30,_currentAddress_G000
	CPI  R30,0
	BRNE _0x97
; 0000 0047     {                          // Заполним структуру для передачи
; 0000 0048         pdata.b1 = button;
	STS  _pdata,R9
; 0000 0049         button = 0xFF;
	LDI  R30,LOW(255)
	MOV  R9,R30
; 0000 004A     }
; 0000 004B 
; 0000 004C     for(j=0; j<len; j++)
_0x97:
	LDI  R17,LOW(0)
_0x99:
	LDD  R30,Y+4
	CP   R17,R30
	BRSH _0x9A
; 0000 004D         data[j] = buffer[j+currentAddress];
	MOV  R30,R17
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	MOVW R0,R30
	MOV  R26,R17
	CLR  R27
	LDS  R30,_currentAddress_G000
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	ADD  R30,R18
	ADC  R31,R19
	LD   R30,Z
	MOVW R26,R0
	ST   X,R30
	SUBI R17,-1
	RJMP _0x99
_0x9A:
; 0000 004F currentAddress += len;
	LDD  R30,Y+4
	LDS  R26,_currentAddress_G000
	ADD  R30,R26
	STS  _currentAddress_G000,R30
; 0000 0050     bytesRemaining -= len;
	LDD  R26,Y+4
	LDS  R30,_bytesRemaining_G000
	SUB  R30,R26
	STS  _bytesRemaining_G000,R30
; 0000 0051     return len;
	LDD  R30,Y+4
	RJMP _0x2060002
; 0000 0052 }
; .FEND
;
;
;/* usbFunctionWrite() вызывается когда хост отправляет порцию данных к устройству
; * Для дополнительной информации см. документацию в usbdrv.h
; */
;uchar   usbFunctionWrite(uchar *data, uchar len)
; 0000 0059 {
_usbFunctionWrite_G000:
; .FSTART _usbFunctionWrite_G000
; 0000 005A     uchar j;
; 0000 005B     uchar *buffer;
; 0000 005C     if(bytesRemaining == 0)
	ST   -Y,R26
	RCALL __SAVELOCR4
;	*data -> Y+5
;	len -> Y+4
;	j -> R17
;	*buffer -> R18,R19
	LDS  R30,_bytesRemaining_G000
	CPI  R30,0
	BRNE _0x9B
; 0000 005D         return 1;               /* конец передачи */
	LDI  R30,LOW(1)
	RJMP _0x2060002
; 0000 005E 
; 0000 005F     if(len > bytesRemaining)
_0x9B:
	LDS  R30,_bytesRemaining_G000
	LDD  R26,Y+4
	CP   R30,R26
	BRSH _0x9C
; 0000 0060         len = bytesRemaining;
	STD  Y+4,R30
; 0000 0061 
; 0000 0062     buffer = (uchar*)&pdata;
_0x9C:
	__POINTWRM 18,19,_pdata
; 0000 0063 
; 0000 0064     for(j=0; j<len; j++)
	LDI  R17,LOW(0)
_0x9E:
	LDD  R30,Y+4
	CP   R17,R30
	BRSH _0x9F
; 0000 0065         buffer[j+currentAddress] = data[j];
	MOV  R26,R17
	CLR  R27
	LDS  R30,_currentAddress_G000
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	ADD  R30,R18
	ADC  R31,R19
	MOVW R0,R30
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	CLR  R30
	ADD  R26,R17
	ADC  R27,R30
	LD   R30,X
	MOVW R26,R0
	ST   X,R30
	SUBI R17,-1
	RJMP _0x9E
_0x9F:
; 0000 0067 currentAddress += len;
	LDD  R30,Y+4
	LDS  R26,_currentAddress_G000
	ADD  R30,R26
	STS  _currentAddress_G000,R30
; 0000 0068     bytesRemaining -= len;
	LDD  R26,Y+4
	LDS  R30,_bytesRemaining_G000
	SUB  R30,R26
	STS  _bytesRemaining_G000,R30
; 0000 0069 
; 0000 006A //    if(bytesRemaining == 0)     // Все данные получены
; 0000 006B //    {                           // Выставим значения на PORTB
; 0000 006C //        if ( pdata.b1 )
; 0000 006D //            PORTB |= _BV(1);
; 0000 006E //        else
; 0000 006F //            PORTB &= ~_BV(1);
; 0000 0070 //
; 0000 0071 //
; 0000 0072 //        if ( pdata.b2 )
; 0000 0073 //            PORTB |= _BV(2);
; 0000 0074 //        else
; 0000 0075 //            PORTB &= ~_BV(2);
; 0000 0076 //
; 0000 0077 //
; 0000 0078 //        if ( pdata.b3 )
; 0000 0079 //            PORTB |= _BV(3);
; 0000 007A //        else
; 0000 007B //            PORTB &= ~_BV(3);
; 0000 007C //    }
; 0000 007D 
; 0000 007E     return bytesRemaining == 0; /* 0 означает, что есть еще данные */
	LDS  R26,_bytesRemaining_G000
	LDI  R30,LOW(0)
	RCALL __EQB12
_0x2060002:
	RCALL __LOADLOCR4
	ADIW R28,7
	RET
; 0000 007F }
; .FEND
;
;/* ------------------------------------------------------------------------- */
;
;usbMsgLen_t usbFunctionSetup(uchar data[8])
; 0000 0084 {
_usbFunctionSetup_G000:
; .FSTART _usbFunctionSetup_G000
; 0000 0085 usbRequest_t    *rq = (void *)data;
; 0000 0086 
; 0000 0087     if((rq->bmRequestType & USBRQ_TYPE_MASK) == USBRQ_TYPE_CLASS){    /* HID устройство */
	ST   -Y,R27
	ST   -Y,R26
	RCALL __SAVELOCR2
;	data -> Y+2
;	*rq -> R16,R17
	__GETWRS 16,17,2
	MOVW R26,R16
	LD   R30,X
	ANDI R30,LOW(0x60)
	CPI  R30,LOW(0x20)
	BRNE _0xA0
; 0000 0088         if(rq->bRequest == USBRQ_HID_GET_REPORT){  /* wValue: ReportType (highbyte), ReportID (lowbyte) */
	MOVW R30,R16
	LDD  R26,Z+1
	CPI  R26,LOW(0x1)
	BRNE _0xA1
; 0000 0089             // у нас только одна разновидность репорта, можем игнорировать report-ID
; 0000 008A             bytesRemaining = sizeof(struct dataexchange_t);
	LDI  R30,LOW(1)
	STS  _bytesRemaining_G000,R30
; 0000 008B             currentAddress = 0;
	LDI  R30,LOW(0)
	STS  _currentAddress_G000,R30
; 0000 008C             return USB_NO_MSG;  // используем usbFunctionRead() для отправки данных хосту
	LDI  R30,LOW(255)
	RJMP _0x2060001
; 0000 008D         }else if(rq->bRequest == USBRQ_HID_SET_REPORT){
_0xA1:
	MOVW R30,R16
	LDD  R26,Z+1
	CPI  R26,LOW(0x9)
	BRNE _0xA3
; 0000 008E             // у нас только одна разновидность репорта, можем игнорировать report-ID
; 0000 008F             bytesRemaining = sizeof(struct dataexchange_t);
	LDI  R30,LOW(1)
	STS  _bytesRemaining_G000,R30
; 0000 0090             currentAddress = 0;
	LDI  R30,LOW(0)
	STS  _currentAddress_G000,R30
; 0000 0091             return USB_NO_MSG;  // используем usbFunctionWrite() для получения данных от хоста
	LDI  R30,LOW(255)
	RJMP _0x2060001
; 0000 0092         }
; 0000 0093     }else{
_0xA3:
_0xA0:
; 0000 0094         /* остальные запросы мы просто игнорируем */
; 0000 0095     }
; 0000 0096     return 0;
	LDI  R30,LOW(0)
_0x2060001:
	RCALL __LOADLOCR2
	ADIW R28,4
	RET
; 0000 0097 }
; .FEND
;/* ------------------------------------------------------------------------- */
;
;void main(void)
; 0000 009B {
_main:
; .FSTART _main
; 0000 009C     uchar i = 0;
; 0000 009D // Port B initialization
; 0000 009E // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 009F DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
;	i -> R17
	LDI  R17,0
	LDI  R30,LOW(0)
	OUT  0x17,R30
; 0000 00A0 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=P Bit2=P Bit1=P Bit0=P
; 0000 00A1 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (1<<PORTB3) | (1<<PORTB2) | (1<<PORTB1) | (1<<PORTB0);
	LDI  R30,LOW(15)
	OUT  0x18,R30
; 0000 00A2 
; 0000 00A3 // Port C initialization
; 0000 00A4 DDRC=(0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
	LDI  R30,LOW(7)
	OUT  0x14,R30
; 0000 00A5 // State: Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 00A6 PORTC=(0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (1<<PORTC2) | (1<<PORTC1) | (1<<PORTC0);
	OUT  0x15,R30
; 0000 00A7 
; 0000 00A8 // Timer/Counter 1 initialization
; 0000 00A9 // Clock source: System Clock
; 0000 00AA // Clock value: 1000,000 kHz
; 0000 00AB // Mode: Normal top=0xFFFF
; 0000 00AC // OC1A output: Disconnected
; 0000 00AD // OC1B output: Disconnected
; 0000 00AE // Noise Canceler: Off
; 0000 00AF // Input Capture on Falling Edge
; 0000 00B0 // Timer Period: 25 ms
; 0000 00B1 // Timer1 Overflow Interrupt: On
; 0000 00B2 // Input Capture Interrupt: Off
; 0000 00B3 // Compare A Match Interrupt: Off
; 0000 00B4 // Compare B Match Interrupt: Off
; 0000 00B5 TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	LDI  R30,LOW(0)
	OUT  0x2F,R30
; 0000 00B6 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (1<<CS11) | (0<<CS10);
	LDI  R30,LOW(2)
	OUT  0x2E,R30
; 0000 00B7 TCNT1H=0x9E;
	LDI  R30,LOW(158)
	OUT  0x2D,R30
; 0000 00B8 TCNT1L=0x58;
	LDI  R30,LOW(88)
	OUT  0x2C,R30
; 0000 00B9 ICR1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x27,R30
; 0000 00BA ICR1L=0x00;
	OUT  0x26,R30
; 0000 00BB OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 00BC OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 00BD OCR1BH=0x00;
	OUT  0x29,R30
; 0000 00BE OCR1BL=0x00;
	OUT  0x28,R30
; 0000 00BF 
; 0000 00C0 // USART initialization
; 0000 00C1 // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 00C2 // USART Receiver: Off
; 0000 00C3 // USART Transmitter: On
; 0000 00C4 // USART Mode: Asynchronous
; 0000 00C5 // USART Baud Rate: 9600
; 0000 00C6 UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
	OUT  0xB,R30
; 0000 00C7 UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (1<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	LDI  R30,LOW(8)
	OUT  0xA,R30
; 0000 00C8 UCSRC=(1<<URSEL) | (0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0000 00C9 UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0000 00CA UBRRL=0x33;
	LDI  R30,LOW(51)
	OUT  0x9,R30
; 0000 00CB 
; 0000 00CC // Analog Comparator initialization
; 0000 00CD // Analog Comparator: Off
; 0000 00CE // The Analog Comparator's positive input is
; 0000 00CF // connected to the AIN0 pin
; 0000 00D0 // The Analog Comparator's negative input is
; 0000 00D1 // connected to the AIN1 pin
; 0000 00D2 ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 00D3 SFIOR=(0<<ACME);
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 00D4 
; 0000 00D5 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 00D6 TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (1<<TOIE1) | (0<<TOIE0);
	LDI  R30,LOW(4)
	OUT  0x39,R30
; 0000 00D7 
; 0000 00D8     usbInit();
	RCALL _usbInit_G000
; 0000 00D9     usbDeviceDisconnect();  // принудительно отключаемся от хоста, так делать можно только при выключенных прерываниях!
	SBI  0x11,4
; 0000 00DA 
; 0000 00DB     while(--i){             // пауза > 250 ms
_0xA5:
	SUBI R17,LOW(1)
	BREQ _0xA7
; 0000 00DC         _delay_ms(1);
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _delay_ms
; 0000 00DD     }
	RJMP _0xA5
_0xA7:
; 0000 00DE 
; 0000 00DF     usbDeviceConnect();     // подключаемся
	CBI  0x11,4
; 0000 00E0 
; 0000 00E1     #asm ("sei");                  // разрешаем прерывания
	sei
; 0000 00E2 
; 0000 00E3     while(1){                // главный цикл программы
_0xA8:
; 0000 00E4         usbPoll();          // эту функцию надо регулярно вызывать с главного цикла, максимальная задержка между вызовам ...
	RCALL _usbPoll_G000
; 0000 00E5         if (button != 0) putchar (button);
	TST  R9
	BREQ _0xAB
	MOV  R26,R9
	RCALL _putchar
; 0000 00E6         button = 0;
_0xAB:
	CLR  R9
; 0000 00E7         delay_ms (10);
	LDI  R26,LOW(10)
	LDI  R27,0
	RCALL _delay_ms
; 0000 00E8     }
	RJMP _0xA8
; 0000 00E9 }
_0xAC:
	RJMP _0xAC
; .FEND
;/* ------------------------------------------------------------------------- */
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_putchar:
; .FSTART _putchar
	ST   -Y,R26
putchar0:
     sbis usr,udre
     rjmp putchar0
     ld   r30,y
     out  udr,r30
	ADIW R28,1
	RET
; .FEND

	.CSEG

	.CSEG

	.DSEG
_usbMsgPtr:
	.BYTE 0x2
_usbRxToken:
	.BYTE 0x1
_usbConfiguration:
	.BYTE 0x1
_usbTxStatus1:
	.BYTE 0xC
_usbRxBuf:
	.BYTE 0x16
_usbRxLen:
	.BYTE 0x1
_usbTxLen:
	.BYTE 0x1
_usbTxBuf:
	.BYTE 0xB
_usbMsgLen_G000:
	.BYTE 0x1
_usbMsgFlags_G000:
	.BYTE 0x1
_pdata:
	.BYTE 0x1
_currentAddress_G000:
	.BYTE 0x1
_bytesRemaining_G000:
	.BYTE 0x1

	.CSEG

	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__EQB12:
	CP   R30,R26
	LDI  R30,1
	BREQ __EQB12T
	CLR  R30
__EQB12T:
	RET

__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
