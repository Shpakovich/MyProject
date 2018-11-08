#include <Wire.h>
#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd(0x3F,16,2);  //инициализируем 

int m=0; 
int p1=0; 
int p2=0; 
int p3=0; 
int p4=0; 

#define nextPin 7 
#define prevPin 8 
#define upPin 5 
#define downPin 6 
#define ledPin 13 

boolean buttonnextWasUp = true;
boolean buttonprevWasUp = true;
boolean buttonupWasUp = true;
boolean buttondownWasUp = true;

boolean ledEnabled = false;
byte load100[8] =
{
  B00000,
  B00000,
  B00000,
  B00000,
  B11110,
  B11110,
  B11110,
  B11110,
};

void setup(){
// Установка пинов как входов
lcd.createChar(1,load100);
pinMode(nextPin, INPUT);
pinMode(prevPin, INPUT);
pinMode(upPin, INPUT);
pinMode(downPin, INPUT);

pinMode(ledPin, OUTPUT);
lcd.init();         // инициализация LCD
lcd.backlight();        // включаем подсветку

lcd.print("    Loading.    ");
lcd.setCursor(0, 1);
lcd.write(byte(1));
delay(200);
lcd.write(byte(1));
delay(200);
lcd.write(byte(1));
delay(100);
lcd.write(byte(1));
delay(210);
lcd.write(byte(1));
delay(250);
lcd.write(byte(1));
delay(200);
lcd.write(byte(1));
delay(200);
lcd.write(byte(1));
delay(200);
lcd.write(byte(1));
delay(250);
lcd.write(byte(1));
delay(280);
lcd.write(byte(1));
delay(300);
lcd.write(byte(1));
delay(300);
lcd.write(byte(1));
delay(200);
lcd.write(byte(1));
delay(200);
lcd.write(byte(1));
delay(200);
lcd.write(byte(1));
delay(500);
lcd.clear();

lcd.setCursor(0, 0);
lcd.print("    Welcome!    ");
delay(2500);
lcd.clear();

lcd.setCursor(0, 0);
  lcd.print(" Nakhimovsky d/21 ");
lcd.setCursor(4, 1);
  lcd.print("MPT MENU");
  delay (2000);//Задержка приветствия
}

void loop ()
{
  boolean buttonnextIsUp = digitalRead(nextPin);
  boolean buttonprevIsUp = digitalRead(prevPin);
  boolean buttonupIsUp = digitalRead(upPin);
  boolean buttondownIsUp = digitalRead(downPin);   

//Обработка нажатия кнопки меню
if (buttonnextWasUp && !buttonnextIsUp)
{
delay(10);
buttonnextIsUp = digitalRead(nextPin);
if (!buttonnextIsUp)
{
m++;
if (m>6)
{
m=0;
}
delay(100);
lcd.clear();
}
}
//Обработка нажатия кнопки назад
if (buttonprevWasUp && !buttonprevIsUp)
{
delay(10);
buttonprevIsUp = digitalRead(prevPin);
if (!buttonprevIsUp)
{
m--;
if (m<0)
{
m=6;
}
delay(100);
lcd.clear();
}
}
// Обработка нажатия для р1 +
if (buttonupWasUp && !buttonupIsUp)
{
delay(10);
buttonupIsUp = digitalRead(upPin);
if (!buttonupIsUp && m==1)
{
p1++;
if (p1>10)
{
p1=0;
}
delay (100);
lcd.setCursor(5, 1);
lcd.print("  ");
}
}

// Обработка нажатия для р1 -
if (buttondownWasUp && !buttondownIsUp)
{
delay(10);
buttondownIsUp = digitalRead(downPin);
if (!buttondownIsUp && m==1)
{
p1--;
if (p1<0)
{
p1=10;
}
delay (100);
lcd.setCursor(5, 1);
lcd.print("  ");
}
}

// Обработка нажатия для р2 +
if (buttonupWasUp && !buttonupIsUp)
{
delay(10);
buttonupIsUp = digitalRead(upPin);
if (!buttonupIsUp && m==2)
{
p2++;
if (p2>10)
{
p2=0;
}
delay (100);
lcd.setCursor(5, 1);
lcd.print("  ");
}
}

// Обработка нажатия для р2 -
if (buttondownWasUp && !buttondownIsUp)
{
delay(10);
buttondownIsUp = digitalRead(downPin);
if (!buttondownIsUp && m==2)
{
p2--;
if (p2<0)
{
p2=10;
}
delay (100);
lcd.setCursor(5, 1);
lcd.print("  ");
}
}

// Обработка нажатия для р3 +
if (buttonupWasUp && !buttonupIsUp)
{
delay(10);
buttonupIsUp = digitalRead(upPin);
if (!buttonupIsUp && m==3)
{
  ledEnabled = !ledEnabled;
  digitalWrite(ledPin, ledEnabled);
  p3 = ledEnabled;
}
}


// Обработка нажатия для р3 -
if (buttondownWasUp && !buttondownIsUp)
{
delay(10);
buttondownIsUp = digitalRead(downPin);
if (!buttondownIsUp && m==3)
{
  ledEnabled = !ledEnabled;
  digitalWrite(ledPin, ledEnabled);
  p3 = ledEnabled;
}
}

// Обработка нажатия для р4 +
if (buttonupWasUp && !buttonupIsUp)
{
delay(10);
buttonupIsUp = digitalRead(upPin);
if (!buttonupIsUp && m==4)
{
p4++;
if (p4>60)
{
p4=0;
}
delay (100);
lcd.setCursor(11, 1);
lcd.print("  ");
}
}
// Обработка нажатия для р4 -
if (buttondownWasUp && !buttondownIsUp)
{
delay(10);
buttondownIsUp = digitalRead(downPin);
if (!buttondownIsUp && m==4)
{
p4--;
if (p4<0)
{
p4=60;
}
delay (100);
lcd.setCursor(11, 1);
lcd.print("  ");
}
}

//вывод меню
if (m==0)
{
lcd.setCursor(0, 0);
lcd.print( "Main Menu       " );
lcd.setCursor(0, 1);
lcd.print( "P1=" );
lcd.print(p1);
lcd.print( " P2=" );
lcd.print(p2);
lcd.print( " LED=" );
lcd.print(p3);
}
else if (m==1)
{
lcd.setCursor(0, 0);
lcd.print( "Parametr-1" );
lcd.setCursor(0, 1);
lcd.print( "P1 = " );
lcd.print(p1);
}
else if (m==2)
{
lcd.setCursor(0, 0);
lcd.print( "Parametr-2" );
lcd.setCursor(0, 1);
lcd.print( "P2 = " );
lcd.print(p2);
}
else if (m==3)
{
lcd.setCursor(0, 0);
lcd.print( "LED Control" );
lcd.setCursor(0, 1);
lcd.print( "LED = " );
lcd.print(p3);
}
else if (m==4)
{
lcd.setCursor(0, 0);
lcd.print( "I left for lunch" );
lcd.setCursor(0, 1);
lcd.print( "be through" );
lcd.setCursor(13, 1);
lcd.print( "Min" );
lcd.setCursor(11, 1);
lcd.print( "" );
lcd.print(p4);
}
else if (m==5)
{
lcd.setCursor(0,0);
lcd.print("Seconds of ");
lcd.setCursor(0,1);
lcd.print("work:");
lcd.setCursor(6,1);
lcd.print( millis()/1000 , DEC);  
lcd.print(" s");
}
else if (m==6)
{
lcd.setCursor(0,0);
lcd.print("  Shmakov Denis");
lcd.setCursor(0,1);
lcd.print(" Diplom Project ");
}

buttonupWasUp = buttonupIsUp;
buttondownWasUp = buttondownIsUp;
buttonnextWasUp = buttonnextIsUp;
buttonprevWasUp = buttonprevIsUp;
}

void Feo() {
  const byte a[2][15][8] = {
  {{0b00000,0b00000,0b00000,0b00000,0b00000,0b00000,0b00000,0b00000},
   {0b00000,0b00000,0b00000,0b00000,0b00000,0b00000,0b00000,0b00000},   
   {0b00000,0b00000,0b00000,0b00000,0b00000,0b00000,0b00000,0b00000},
   {0b00000,0b00000,0b00010,0b00010,0b00111,0b01111,0b11111,0b11111},
   {0b00000,0b00000,0b00000,0b00001,0b00001,0b00011,0b00011,0b00111},
   {0b00000,0b01000,0b11000,0b11000,0b11000,0b11100,0b11100,0b11100},
   {0b00000,0b00000,0b00000,0b00000,0b00000,0b00000,0b00000,0b00000},
   {0b00000,0b00000,0b00000,0b00001,0b00011,0b00111,0b00111,0b01110},
   {0b00000,0b00000,0b00000,0b11111,0b11111,0b11111,0b00000,0b00000},
   {0b00000,0b00000,0b00000,0b11111,0b11111,0b11111,0b00111,0b01110},
   {0b00000,0b00000,0b00000,0b11001,0b10011,0b10000,0b00000,0b00000},  
   {0b00000,0b00000,0b11111,0b11111,0b11111,0b01110,0b01110,0b11100},
   {0b00000,0b00000,0b11111,0b11100,0b11000,0b00000,0b00000,0b00000},
   {0b00000,0b00000,0b00000,0b00000,0b00000,0b00000,0b00000,0b00000},
   {0b00000,0b00000,0b00000,0b00000,0b00000,0b00000,0b00000,0b00000}},
  {{0b00000,0b00000,0b00000,0b00000,0b00000,0b00000,0b00000,0b00000},
   {0b00000,0b00000,0b00000,0b00000,0b00000,0b00000,0b00001,0b00011},   
   {0b00001,0b00011,0b00011,0b00111,0b01111,0b11110,0b11100,0b11100},
   {0b11111,0b11111,0b11111,0b10011,0b00011,0b00001,0b00001,0b00000},
   {0b00111,0b01110,0b11110,0b11100,0b11100,0b11100,0b11000,0b11000},
   {0b11100,0b11110,0b11110,0b01111,0b01111,0b01111,0b00111,0b00111},
   {0b00000,0b00000,0b00000,0b00000,0b00001,0b00001,0b10001,0b11011},
   {0b01110,0b01110,0b11100,0b11100,0b11000,0b11000,0b11000,0b11000},
   {0b00000,0b00000,0b00000,0b00000,0b00000,0b00001,0b00001,0b00011},
   {0b01110,0b11100,0b11100,0b11100,0b11100,0b11000,0b11000,0b10000},
   {0b00000,0b00000,0b00001,0b00001,0b00001,0b00011,0b00011,0b00011},  
   {0b11100,0b11100,0b11000,0b11000,0b11000,0b10000,0b10000,0b10000},
   {0b00000,0b00000,0b00000,0b00000,0b00000,0b00000,0b00000,0b00000},
   {0b00000,0b00000,0b00000,0b00000,0b00000,0b00000,0b00000,0b00000}},   
  };
  byte b[2][15][8];
  int k,i,j;
while (!digitalRead(downPin)) 
{
  lcd.setCursor(12,0);
  lcd.write(1);
  lcd.write(2);
  lcd.write(3);
  lcd.write(4);
  lcd.setCursor(12,1);
  lcd.write(5);
  lcd.write(6);
  lcd.write(7);
  lcd.write(8);
  for (k=0; k<2; k++)
  for (i=0; i<15; i++)
  for (j=0; j<8; j++)
    b[k][i][j]=a[k][i][j];
  for (j=0; j<55; j++) {
  lcd.createChar(1,  b[0][0]);
  lcd.createChar(2,  b[0][1]);
  lcd.createChar(3,  b[0][2]);
  lcd.createChar(4,  b[0][3]);
  lcd.createChar(5,  b[1][0]);
  lcd.createChar(6,  b[1][1]);
  lcd.createChar(7,  b[1][2]);
  lcd.createChar(8,  b[1][3]);
  for (i=0; i<15; i++) {
  for (k=0; k<8; k++) {
  b[0][i][k]=(b[0][i][k]<<1) + ((b[0][i+1][k]>>4)&(1));
  }
  }
  for (i=0; i<15; i++) {
  for (k=0; k<8; k++) {
  b[1][i][k]=(b[1][i][k]<<1) + ((b[1][i+1][k]>>4)&(1));
  }
  }
  delay(15);
  }
}
lcd.clear();
}

