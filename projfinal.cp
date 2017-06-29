#line 1 "C:/Users/aluno/Desktop/COISAS PICgenios/JH/projfinal.c"

sbit LCD_RS at RE2_bit;
sbit LCD_EN at RE1_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;


sbit LCD_RS_Direction at TRISE2_bit;
sbit LCD_EN_Direction at TRISE1_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;

int pos = 1;
int posMenu = 0;
int statusAlarme = 1;
int temperaturaAlarme = 23;
char var2;
char valor[10];
int pos1 = 12;
int pos2 = 12;
float temperaturaLida = 0;
float vel;
unsigned char ucTexto[10];
unsigned int iLeituraAD = 0;


void GRAUS();

void Menu();
void editaPos(int b);
void digitaStatus();
void alteraStatus();
void imprimeTemp();
void imprimeDisplay(int a, int b);

void ligaAlarme();
void desligaAlarme();

void main() {
 TRISB = 0;
 TRISD = 0;
 TRISC.RC5 = 0;
 TRISC.RC1 = 0;
 TRISE = 0;

 ADCON0 = 0b00000001;
 ADCON1 = 0b00001100;
 ADCON2 = 0b10111110;

 Lcd_Init();

 TRISB.RB0=0;
 TRISB.RB1=0;
 TRISB.RB2=0;
 TRISA.RA3=0;
 TRISA.RA4=0;

 Menu();
 PORTC.RC5 = 1;



 T0CON.T0CS = 0;
 T0CON.PSA = 0;
 T0CON.T0PS2 = 1;
 T0CON.T0PS1 = 1;
 T0CON.T0PS0 = 1;
 T0CON.T08BIT = 0;

 TMR0H = 0xE1;
 TMR0L = 0x7B;

 INTCON.TMR0IF = 0;
 T0CON.TMR0ON = 1;




 TRISC.RC0 = 1;
 TRISC.RC2 = 0;


 TRISE.RE0 = 0;



 temperaturaAlarme = EEPROM_read(0);
 statusAlarme = EEPROM_read(1);

 while(1){
 temperaturaAlarme = EEPROM_read(0);
 statusAlarme = EEPROM_read(1);
 if (Button(&PORTB, 5, 100, 0)) {
 editaPos(0);
 Menu();
 }
 if (Button(&PORTB, 4, 100, 0)) {
 editaPos(1);
 Menu();
 }
 alteraStatus();


 if(INTCON.TMR0IF==1){

 TMR0H = 0xE1 ;
 TMR0L = 0x7B;

 INTCON.TMR0IF = 0;

 iLeituraAD= ADC_Read(2);
 iLeituraAD/=2;
 temperaturaLida = iLeituraAD;
 pos1 = iLeituraAD%10;
 iLeituraAD = iLeituraAD/10;
 pos2 = iLeituraAD;
 }

 imprimeDisplay(pos2,pos1);


 if ((temperaturaLida >= temperaturaAlarme) && (statusAlarme == 1)){
 ligaAlarme();
 }else{
 desligaAlarme();
 }


 }
}

void ligaAlarme(){
 PORTC.RC1 = 0;
 PWM1_Init(5000);

 vel = (ADC_read(0));
 PWM1_Set_Duty(vel);
 PWM1_Start();

 PORTE.RE0 = 0;

}
void desligaAlarme(){
 PORTC.RC1 = 1;
 PWM1_Init(5000);
 PWM1_Set_Duty(0);
 PWM1_Start();
 PORTE.RE0 = 1;
}

void imprimeDisplay(int a, int b){

 unsigned char ucMask[] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F,0x21,0x03,0x40};

 PORTD = ucMask[a];
 PORTA.RA3 = 1;
 Delay_ms(2);
 PORTA.RA3 = 0;
 PORTD = ucMask[b];
 PORTA.RA4 = 1;
 Delay_ms(2);
 PORTA.RA4 = 0;
}

void editaPos(int b){
 if(posMenu == 0){
 if(pos == 1)
 pos = 2;
 else
 pos = 1;
 }
 if(posMenu == 1){
 if(b == 0){
 temperaturaAlarme--;
 EEPROM_write(0,temperaturaAlarme);
 imprimeTemp();
 }
 else{
 temperaturaAlarme++;
 EEPROM_write(0,temperaturaAlarme);
 imprimeTemp();
 }
 }

}

void Menu(){
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 if(posMenu == 0){
 Lcd_Out(1,1,"Setar Alarme");
 Lcd_Out(2,1,"Alarme:");
 digitaStatus();
 Lcd_Out(pos,15,"<-");
 }
 else if(posMenu == 1){

 Lcd_Out(1,1,"Selecione:");
 imprimeTemp();
 }
}

void imprimeTemp(){
 IntToStr(temperaturaAlarme, valor);
 Lcd_Out(2,-2,valor);
 Lcd_Out(2,5,"C");
}
void alteraStatus(){
 if(posMenu == 0){
 if(pos == 2)
 if (Button(&PORTB, 0, 100, 0)) {
 if(statusAlarme == 0){
 statusAlarme = 1;
 EEPROM_write(1,statusAlarme);
 }
 else{
 statusAlarme = 0;
 EEPROM_write(1,statusAlarme);
 }
 Menu();
 }
 if(pos == 1)
 if (Button(&PORTB, 0, 100, 0)) {
 posMenu = 1;
 Menu();
 }
 }
 if(posMenu == 1){
 if (Button(&PORTB, 0, 100, 0)) {
 pos = 1;
 posMenu = 0;
 Menu();
 }
 }
}
void digitaStatus(){

 if(EEPROM_read(1) == 0){
 Lcd_Out(2,9, "Off");
 }
 else{
 Lcd_Out(2,9, "On");
 }
}
