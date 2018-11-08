#include <io.h>
//#include <avr/interrupt.h>
//#include <util/delay.h>
//#include <avr/pgmspace.h>   /* ����� ��� usbdrv.h */
#include <stdio.h>
#include "usbdrv.c"

uchar button;

interrupt [TIM1_OVF] void timer1_ovf_isr(void)
{
uchar T;
#asm ("sei");

TCNT1H=0x6D84 >> 8;
TCNT1L=0x6D84 & 0xff;

    DDRC  = 0b111;
    PORTC = 0b110;
    #asm ("NOP")
    T = PINB;    
    if ((T & 0b00001000) == 0) button = '*';
    else if ((T & 0b00000100) == 0) button = '7';
    else if ((T & 0b00000010) == 0) button = '4';
    else if ((T & 0b00000001) == 0) button = '1';   
    
    PORTC = 0b101;
    #asm ("NOP")
    T = PINB;    
    if ((T & 0b00001000) == 0) button = '0';
    else if ((T & 0b00000100) == 0) button = '8';
    else if ((T & 0b00000010) == 0) button = '5';
    else if ((T & 0b00000001) == 0) button = '2';                                                    
    
    PORTC = 0b011;
    #asm ("NOP")
    T = PINB;    
    if ((T & 0b00001000) == 0) button = '#';
    else if ((T & 0b00000100) == 0) button = '9';
    else if ((T & 0b00000010) == 0) button = '6';
    else if ((T & 0b00000001) == 0) button = '3'; 
}

struct dataexchange_t       // �������� ��������� ��� �������� ������
{
   uchar b1;        // � ����� ��� ������� �������� ��������� �� 3 �����.
//   uchar b2;        // �� ������ ���� �������� ���� �� PORTB. ������� ���
//   uchar b3;        // �� ����������� (����� �� 3 ���� �����).
};                  // �� � ����� ������������ � ����� ���.
                    // ��� ����������� ���������� �� ���������� � ��������� :)

struct dataexchange_t pdata = {0};

/* ��� ���������� ������ ������ ������� �������� */
static uchar    currentAddress;
static uchar    bytesRemaining;

/* usbFunctionRead() ���������� ����� ���� ����������� ������ ������ �� ����������
 * ��� �������������� ���������� ��. ������������ � usbdrv.h
 */
uchar   usbFunctionRead(uchar *data, uchar len)
{
    uchar j;
    uchar *buffer;
    if(len > bytesRemaining)
        len = bytesRemaining;

    buffer = (uchar*)&pdata;

    if(!currentAddress)        // �� ���� ����� ������ ��� �� ��������.
    {                          // �������� ��������� ��� ��������
        pdata.b1 = button;
        button = 0xFF;
    }

    for(j=0; j<len; j++)
        data[j] = buffer[j+currentAddress];

    currentAddress += len;
    bytesRemaining -= len;
    return len;
}


/* usbFunctionWrite() ���������� ����� ���� ���������� ������ ������ � ����������
 * ��� �������������� ���������� ��. ������������ � usbdrv.h
 */
uchar   usbFunctionWrite(uchar *data, uchar len)
{
    uchar j;
    uchar *buffer;
    if(bytesRemaining == 0)
        return 1;               /* ����� �������� */

    if(len > bytesRemaining)
        len = bytesRemaining;

    buffer = (uchar*)&pdata;
    
    for(j=0; j<len; j++)
        buffer[j+currentAddress] = data[j];

    currentAddress += len;
    bytesRemaining -= len;

//    if(bytesRemaining == 0)     // ��� ������ ��������
//    {                           // �������� �������� �� PORTB
//        if ( pdata.b1 )
//            PORTB |= _BV(1);
//        else
//            PORTB &= ~_BV(1);
//
//
//        if ( pdata.b2 )
//            PORTB |= _BV(2);
//        else
//            PORTB &= ~_BV(2);
//
//
//        if ( pdata.b3 )
//            PORTB |= _BV(3);
//        else
//            PORTB &= ~_BV(3);
//    }

    return bytesRemaining == 0; /* 0 ��������, ��� ���� ��� ������ */
}

/* ------------------------------------------------------------------------- */

usbMsgLen_t usbFunctionSetup(uchar data[8])
{
usbRequest_t    *rq = (void *)data;

    if((rq->bmRequestType & USBRQ_TYPE_MASK) == USBRQ_TYPE_CLASS){    /* HID ���������� */
        if(rq->bRequest == USBRQ_HID_GET_REPORT){  /* wValue: ReportType (highbyte), ReportID (lowbyte) */
            // � ��� ������ ���� ������������� �������, ����� ������������ report-ID
            bytesRemaining = sizeof(struct dataexchange_t);
            currentAddress = 0;
            return USB_NO_MSG;  // ���������� usbFunctionRead() ��� �������� ������ �����
        }else if(rq->bRequest == USBRQ_HID_SET_REPORT){
            // � ��� ������ ���� ������������� �������, ����� ������������ report-ID
            bytesRemaining = sizeof(struct dataexchange_t);
            currentAddress = 0;
            return USB_NO_MSG;  // ���������� usbFunctionWrite() ��� ��������� ������ �� �����
        }
    }else{
        /* ��������� ������� �� ������ ���������� */
    }
    return 0;
}
/* ------------------------------------------------------------------------- */

void main(void)
{     
    uchar i = 0;
// Port B initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=P Bit2=P Bit1=P Bit0=P 
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (1<<PORTB3) | (1<<PORTB2) | (1<<PORTB1) | (1<<PORTB0);

// Port C initialization
DDRC=(0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
// State: Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTC=(0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (1<<PORTC2) | (1<<PORTC1) | (1<<PORTC0);
  
// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: 1000,000 kHz
// Mode: Normal top=0xFFFF
// OC1A output: Disconnected
// OC1B output: Disconnected
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer Period: 25 ms
// Timer1 Overflow Interrupt: On
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (1<<CS11) | (0<<CS10);
TCNT1H=0x9E;
TCNT1L=0x58;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00; 

// USART initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART Receiver: Off
// USART Transmitter: On
// USART Mode: Asynchronous
// USART Baud Rate: 9600
UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (1<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
UCSRC=(1<<URSEL) | (0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
UBRRH=0x00;
UBRRL=0x33; 

// Analog Comparator initialization
// Analog Comparator: Off
// The Analog Comparator's positive input is
// connected to the AIN0 pin
// The Analog Comparator's negative input is
// connected to the AIN1 pin
ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
SFIOR=(0<<ACME); 

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (1<<TOIE1) | (0<<TOIE0);

    usbInit();
    usbDeviceDisconnect();  // ������������� ����������� �� �����, ��� ������ ����� ������ ��� ����������� �����������!
    
    while(--i){             // ����� > 250 ms
        _delay_ms(1);
    }
    
    usbDeviceConnect();     // ������������

    #asm ("sei");                  // ��������� ����������

    while(1){                // ������� ���� ���������
        usbPoll();          // ��� ������� ���� ��������� �������� � �������� �����, ������������ �������� ����� �������� - 50 ms  
        if (button != 0) putchar (button);
        button = 0;
        delay_ms (10);
    }
}
/* ------------------------------------------------------------------------- */ 
