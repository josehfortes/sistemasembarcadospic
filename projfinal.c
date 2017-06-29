/*

*/
// CONFIGURAÇÃO DOS PINOS DO LCD.
sbit LCD_RS at RE2_bit;
sbit LCD_EN at RE1_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;

// DIREÇÃO DOS PINOS.
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
unsigned char ucTexto[10];   // Matriz para armazenamento de texto.
unsigned int iLeituraAD = 0; // Define variável para armazenamento da leitura AD.


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
   TRISB = 0;                        // Define PORTB como saida.
   TRISD = 0;                        // Define PORTD como saida.
   TRISC.RC5 = 0;                    // Define PORTC.RC5 como saida.
   TRISC.RC1 = 0;                    // Define PORTC.RC1 como saida.
   TRISE = 0;                        // Define PORTE como saida.

   ADCON0 = 0b00000001;              // Configura conversor A/D Canal 0, conversão desligada, A/D ligado.
   ADCON1 = 0b00001100;              // Configura todos canais como Digital menos AN0,AN1 E AN2 e REF Interna.
   ADCON2 = 0b10111110;              // Configura conversor A/D para resultado justificado a direita, clock de 20 TAD, clock de Fosc/64.

   Lcd_Init();                               // Inicializa LCD.

   TRISB.RB0=0;        // Define o pino RB0 do PORTB como saida(Coluna1).
   TRISB.RB1=0;        // Define o pino RB1 do PORTB como saida(Coluna2).
   TRISB.RB2=0;        // Define o pino RB2 do PORTB como saida(Coluna3).
   TRISA.RA3=0;        // Define O Pino RA3 Do PORTA Como Saida(Seleção Display 2).
   TRISA.RA4=0;        // Define O Pino RA4 Do PORTA Como Saida(Seleção Display 3).

   Menu();
   PORTC.RC5 = 1; //liga o aquecimento

   // Configuração do Timer0.
                            // Cristal de 8Mhz, ciclo de máquina: 8MHz / 4 = 2Mhz --> 1/2Mhz = 0,5us.
   T0CON.T0CS = 0;          // Timer0 operando como temporizador.
   T0CON.PSA = 0;           // Prescaler ativado.
   T0CON.T0PS2 = 1;         // Define prescaler 1:256.
   T0CON.T0PS1 = 1;         // Define prescaler 1:256.
   T0CON.T0PS0 = 1;         // Define prescaler 1:256.
   T0CON.T08BIT = 0;        // Define contagem no modo 16 bits.
   // Valor para 1 segundo.
   TMR0H = 0xE1;            // Carrega o valor alto do número 57723.
   TMR0L = 0x7B;            // Carrega o valor baixo do numero 57723.

   INTCON.TMR0IF = 0;       // Apaga flag de estouro do timer0, pois é fundamental para a sinalização do estouro.
   T0CON.TMR0ON = 1;        // Liga timer0.



   //pwm
   TRISC.RC0 = 1;                    // Define PORTC.RC0 como entrada.
   TRISC.RC2 = 0;                    // Define PORTC.RC2 como saida.

   //rele
   TRISE.RE0 = 0;      // Define o pino RE0 do TRISE como saida.
   //EEPROM_write(0,23);
   //EEPROM_write(1,1);

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

       // Incrementa Contador.
      if(INTCON.TMR0IF==1){   // Incrementa somente quando existir o overflow do timer 0.
         // Recarrega o timer0.
         TMR0H = 0xE1 ;           // Carrega o valor alto do número 57723.
         TMR0L = 0x7B;            // Carrega o valor baixo do numero 57723.

         INTCON.TMR0IF = 0;       // Limpa o flag de estouro do timer0 para uma nova contagem de tempo.

         iLeituraAD= ADC_Read(2);          // Lê Canal AD 2
         iLeituraAD/=2;                    // Converte valor do sensor LM35
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
   PORTC.RC1 = 0; //liga o buzzer
   PWM1_Init(5000);                  // Inicializa módulo PWM com 5Khz
   //vel = (float) temperaturaLida;
   vel = (ADC_read(0));
   PWM1_Set_Duty(vel);               // Seta o Duty-cycle do PWM
   PWM1_Start();                     // Inicia PWM.

   PORTE.RE0 = 0;   // liga o rele

}
void desligaAlarme(){
   PORTC.RC1 = 1; //desliga o buzzer
   PWM1_Init(5000);
   PWM1_Set_Duty(0);               // Seta o Duty-cycle do PWM em 100%.
   PWM1_Start();
   PORTE.RE0 = 1; // desliga o rele
}

void imprimeDisplay(int a, int b){
                           //  "0"  "1"  "2"  "3"  "4"  "5"  "6"  "7"  "8"  "9"  "<"  ">"  "-"
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
   Lcd_Cmd(_LCD_CLEAR);                      // Apaga display.
   Lcd_Cmd(_LCD_CURSOR_OFF);                 // Desliga cursor.
   if(posMenu == 0){//menu inicial
     Lcd_Out(1,1,"Setar Alarme");
     Lcd_Out(2,1,"Alarme:");
     digitaStatus();
     Lcd_Out(pos,15,"<-");
   }
   else if(posMenu == 1){
      //menu setar alarme
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