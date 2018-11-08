#include <Wire.h>
#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd(0x3F,16,2);  //инициализируем 
byte load[8] =
{
  B11111,
  B11111,
  B11111,
  B11111,
  B11111,
  B11111,
  B11111,
  B11111,
};


int m=0; 
int p1=0; 
int p2=0; 
int p3=0; 
int p4=0;
int p5=0;
int backlight = 9;
int brightness = 200;

#define nextPin 6 
#define prevPin 5 
#define upPin 7 
#define downPin 8
#define ledPinRed 4 
#define ledPinBlue1 10
#define ledPinBlue2 11
#define ledPinBlue3 12

boolean buttonnextWasUp = true;
boolean buttonprevWasUp = true;
boolean buttonupWasUp = true;
boolean buttondownWasUp = true;

boolean ledEnabled1 = false;
boolean ledEnabled2 = false;

void setup(){
// Установка пинов как входов
lcd.createChar(1, load);
pinMode(nextPin, INPUT);
pinMode(prevPin, INPUT);
pinMode(upPin, INPUT);
pinMode(downPin, INPUT);

pinMode(ledPinRed, OUTPUT);
pinMode(ledPinBlue1, OUTPUT);
pinMode(ledPinBlue2, OUTPUT);
pinMode(ledPinBlue3, OUTPUT);
pinMode(backlight, OUTPUT); 

lcd.init();                       // Инициализация lcd             
lcd.backlight();       // Включаем подсветку на максимальное значение
analogWrite(backlight,brightness);  // PWM values from 0 to 255
 

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
delay(250);
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
  lcd.print("Nakhimovsky d/21 ");
lcd.setCursor(4, 1);
  lcd.print("MPT MENU");
  delay (3500);//Задержка приветствия
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
if (m>8)
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
m=8;
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
if (p2<-9)
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
  ledEnabled1 = !ledEnabled1;
  digitalWrite(ledPinRed, ledEnabled1);
  p3 = ledEnabled1;
}
}


// Обработка нажатия для р3 -
if (buttondownWasUp && !buttondownIsUp)
{
delay(10);
buttondownIsUp = digitalRead(downPin);
if (!buttondownIsUp && m==3)
{
  ledEnabled1 = !ledEnabled1;
  digitalWrite(ledPinRed, ledEnabled1);
  p3 = ledEnabled1;
}
}

// Обработка нажатия для р4 +
if (buttonupWasUp && !buttonupIsUp)
{
delay(10);
buttonupIsUp = digitalRead(upPin);
if (!buttonupIsUp && m==4)
{
  ledEnabled2 = !ledEnabled2;
  digitalWrite(ledPinBlue1, ledEnabled2);
  digitalWrite(ledPinBlue2, ledEnabled2);
  digitalWrite(ledPinBlue3, ledEnabled2);
  p4 = ledEnabled2;
}
}
// Обработка нажатия для р4 -
if (buttondownWasUp && !buttondownIsUp)
{
delay(10);
buttondownIsUp = digitalRead(downPin);
if (!buttondownIsUp && m==4)
{
  ledEnabled2 = !ledEnabled2;
  digitalWrite(ledPinBlue1, ledEnabled2);
  digitalWrite(ledPinBlue2, ledEnabled2);
  digitalWrite(ledPinBlue3, ledEnabled2);
  p4 = ledEnabled2;
}
}

// Обработка нажатия яркости +
analogWrite(backlight,brightness);  // PWM values from 0 to 255

if (buttonupWasUp && !buttonupIsUp)
{
delay(10);
buttonupIsUp = digitalRead(upPin);
if (!buttonupIsUp && m==5)
{
brightness = brightness + 50;
if (brightness>256)
{
brightness=100;
}
delay (100);
lcd.setCursor(10, 1);
lcd.print("  ");
}
}
// Обработка нажатия для яркости -
if (buttondownWasUp && !buttondownIsUp)
{
delay(10);
buttondownIsUp = digitalRead(downPin);
if (!buttondownIsUp && m==5)
{
brightness = brightness - 50;
if (brightness<100)
{
brightness=250;
}
delay (100);
lcd.setCursor(10, 1);
lcd.print("  ");
}
}

// Обработка нажатия для р5 +
if (buttonupWasUp && !buttonupIsUp)
{
delay(10);
buttonupIsUp = digitalRead(upPin);
if (!buttonupIsUp && m==6)
{
p5++;
if (p5>60)
{
p5=0;
}
delay (100);
lcd.setCursor(13, 1);
lcd.print("  ");
}
}
// Обработка нажатия для р5 -
if (buttondownWasUp && !buttondownIsUp)
{
delay(10);
buttondownIsUp = digitalRead(downPin);
if (!buttondownIsUp && m==6)
{
p5--;
if (p5<0)
{
p5=60;
}
delay (100);
lcd.setCursor(13, 1);
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
lcd.print( "Outer Diode" );
lcd.setCursor(0, 1);
lcd.print( "LED = " );
lcd.print(p3);
}
else if (m==4)
{
lcd.setCursor(0, 0);
lcd.print( "Blue Backlight" );
lcd.setCursor(0, 1);
lcd.print( "LED = " );
lcd.print(p4);
}
else if (m==5)
{
lcd.setCursor(1, 0);
lcd.print( "Display" );
lcd.setCursor(0, 1);
lcd.print( "Brightness" );
lcd.setCursor(10, 1);
lcd.print( "  " );
lcd.print(brightness);
}
else if (m==6)
{
lcd.setCursor(0, 0);
lcd.print( "I left for lunch" );
lcd.setCursor(0, 1);
lcd.print( "be through" );
lcd.setCursor(13, 1);
lcd.print( "Min" );
lcd.setCursor(9, 1);
lcd.print( "  " );
lcd.print(p5);
delay(100);
switch(p5 > 0 ){
  case 1:
  delay (60000);
  p5--;
  break;
}
}
else if (m==7)
{
lcd.setCursor(0,0);
lcd.print("Seconds of ");
lcd.setCursor(0,1);
lcd.print("work:");
lcd.setCursor(6,1);
lcd.print( millis()/1000 , DEC);  
lcd.print(" s");
if (buttonupWasUp && !buttonupIsUp) 
{
delay(10);
buttonupIsUp = digitalRead(upPin);
switch(!buttonupIsUp && m==7){
case 1:
{
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
while (!digitalRead(upPin)) {
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
  break;
}
}
lcd.clear();
}
}
}

else if (m==8)
{
lcd.setCursor(0,0);
lcd.print("  Shmakov Denis");
lcd.setCursor(0,1);
lcd.print(" Diplom Project ");
if (buttonupWasUp && !buttonupIsUp) 
{
delay(10);
buttonupIsUp = digitalRead(upPin);
switch(!buttonupIsUp && m==8){
case 1:
for (int positionCounter = 0; positionCounter < 13; positionCounter++) {
  lcd.scrollDisplayLeft(); 
  delay(300);
  }
  for (int positionCounter = 0; positionCounter < 26; positionCounter++) {
    lcd.scrollDisplayRight();
    delay(300);
  }
  for (int positionCounter = 0; positionCounter < 13; positionCounter++) {
    lcd.scrollDisplayLeft();
    delay(300);
    }
     delay(50);
     break;
}
}
}

buttonupWasUp = buttonupIsUp;
buttondownWasUp = buttondownIsUp;
buttonnextWasUp = buttonnextIsUp;
buttonprevWasUp = buttonprevIsUp;
}

