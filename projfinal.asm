
_main:

;projfinal.c,85 :: 		void main() {
;projfinal.c,86 :: 		TRISB = 0;                        // Define PORTB como saida.
	CLRF        TRISB+0 
;projfinal.c,87 :: 		TRISD = 0;                        // Define PORTD como saida.
	CLRF        TRISD+0 
;projfinal.c,88 :: 		TRISC.RC5 = 0;                    // Define PORTC.RC5 como saida.
	BCF         TRISC+0, 5 
;projfinal.c,89 :: 		TRISC.RC1 = 0;                    // Define PORTC.RC1 como saida.
	BCF         TRISC+0, 1 
;projfinal.c,90 :: 		TRISE = 0;                        // Define PORTE como saida.
	CLRF        TRISE+0 
;projfinal.c,92 :: 		ADCON0 = 0b00000001;              // Configura conversor A/D Canal 0, conversão desligada, A/D ligado.
	MOVLW       1
	MOVWF       ADCON0+0 
;projfinal.c,93 :: 		ADCON1 = 0b00001100;              // Configura todos canais como Digital menos AN0,AN1 E AN2 e REF Interna.
	MOVLW       12
	MOVWF       ADCON1+0 
;projfinal.c,94 :: 		ADCON2 = 0b10111110;              // Configura conversor A/D para resultado justificado a direita, clock de 20 TAD, clock de Fosc/64.
	MOVLW       190
	MOVWF       ADCON2+0 
;projfinal.c,96 :: 		Lcd_Init();                               // Inicializa LCD.
	CALL        _Lcd_Init+0, 0
;projfinal.c,98 :: 		TRISB.RB0=0;        // Define o pino RB0 do PORTB como saida(Coluna1).
	BCF         TRISB+0, 0 
;projfinal.c,99 :: 		TRISB.RB1=0;        // Define o pino RB1 do PORTB como saida(Coluna2).
	BCF         TRISB+0, 1 
;projfinal.c,100 :: 		TRISB.RB2=0;        // Define o pino RB2 do PORTB como saida(Coluna3).
	BCF         TRISB+0, 2 
;projfinal.c,101 :: 		TRISA.RA3=0;        // Define O Pino RA3 Do PORTA Como Saida(Seleção Display 2).
	BCF         TRISA+0, 3 
;projfinal.c,102 :: 		TRISA.RA4=0;        // Define O Pino RA4 Do PORTA Como Saida(Seleção Display 3).
	BCF         TRISA+0, 4 
;projfinal.c,104 :: 		Menu();
	CALL        _Menu+0, 0
;projfinal.c,105 :: 		PORTC.RC5 = 1; //liga o aquecimento
	BSF         PORTC+0, 5 
;projfinal.c,109 :: 		T0CON.T0CS = 0;          // Timer0 operando como temporizador.
	BCF         T0CON+0, 5 
;projfinal.c,110 :: 		T0CON.PSA = 0;           // Prescaler ativado.
	BCF         T0CON+0, 3 
;projfinal.c,111 :: 		T0CON.T0PS2 = 1;         // Define prescaler 1:256.
	BSF         T0CON+0, 2 
;projfinal.c,112 :: 		T0CON.T0PS1 = 1;         // Define prescaler 1:256.
	BSF         T0CON+0, 1 
;projfinal.c,113 :: 		T0CON.T0PS0 = 1;         // Define prescaler 1:256.
	BSF         T0CON+0, 0 
;projfinal.c,114 :: 		T0CON.T08BIT = 0;        // Define contagem no modo 16 bits.
	BCF         T0CON+0, 6 
;projfinal.c,116 :: 		TMR0H = 0xE1;            // Carrega o valor alto do número 57723.
	MOVLW       225
	MOVWF       TMR0H+0 
;projfinal.c,117 :: 		TMR0L = 0x7B;            // Carrega o valor baixo do numero 57723.
	MOVLW       123
	MOVWF       TMR0L+0 
;projfinal.c,119 :: 		INTCON.TMR0IF = 0;       // Apaga flag de estouro do timer0, pois é fundamental para a sinalização do estouro.
	BCF         INTCON+0, 2 
;projfinal.c,120 :: 		T0CON.TMR0ON = 1;        // Liga timer0.
	BSF         T0CON+0, 7 
;projfinal.c,125 :: 		TRISC.RC0 = 1;                    // Define PORTC.RC0 como entrada.
	BSF         TRISC+0, 0 
;projfinal.c,126 :: 		TRISC.RC2 = 0;                    // Define PORTC.RC2 como saida.
	BCF         TRISC+0, 2 
;projfinal.c,129 :: 		TRISE.RE0 = 0;      // Define o pino RE0 do TRISE como saida.
	BCF         TRISE+0, 0 
;projfinal.c,133 :: 		temperaturaAlarme = EEPROM_read(0);
	CLRF        FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _temperaturaAlarme+0 
	MOVLW       0
	MOVWF       _temperaturaAlarme+1 
;projfinal.c,134 :: 		statusAlarme = EEPROM_read(1);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _statusAlarme+0 
	MOVLW       0
	MOVWF       _statusAlarme+1 
;projfinal.c,136 :: 		while(1){
L_main0:
;projfinal.c,137 :: 		temperaturaAlarme = EEPROM_read(0);
	CLRF        FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _temperaturaAlarme+0 
	MOVLW       0
	MOVWF       _temperaturaAlarme+1 
;projfinal.c,138 :: 		statusAlarme = EEPROM_read(1);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _statusAlarme+0 
	MOVLW       0
	MOVWF       _statusAlarme+1 
;projfinal.c,139 :: 		if (Button(&PORTB, 5, 100, 0)) {
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       5
	MOVWF       FARG_Button_pin+0 
	MOVLW       100
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main2
;projfinal.c,140 :: 		editaPos(0);
	CLRF        FARG_editaPos_b+0 
	CLRF        FARG_editaPos_b+1 
	CALL        _editaPos+0, 0
;projfinal.c,141 :: 		Menu();
	CALL        _Menu+0, 0
;projfinal.c,142 :: 		}
L_main2:
;projfinal.c,143 :: 		if (Button(&PORTB, 4, 100, 0)) {
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       4
	MOVWF       FARG_Button_pin+0 
	MOVLW       100
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main3
;projfinal.c,144 :: 		editaPos(1);
	MOVLW       1
	MOVWF       FARG_editaPos_b+0 
	MOVLW       0
	MOVWF       FARG_editaPos_b+1 
	CALL        _editaPos+0, 0
;projfinal.c,145 :: 		Menu();
	CALL        _Menu+0, 0
;projfinal.c,146 :: 		}
L_main3:
;projfinal.c,147 :: 		alteraStatus();
	CALL        _alteraStatus+0, 0
;projfinal.c,150 :: 		if(INTCON.TMR0IF==1){   // Incrementa somente quando existir o overflow do timer 0.
	BTFSS       INTCON+0, 2 
	GOTO        L_main4
;projfinal.c,152 :: 		TMR0H = 0xE1 ;           // Carrega o valor alto do número 57723.
	MOVLW       225
	MOVWF       TMR0H+0 
;projfinal.c,153 :: 		TMR0L = 0x7B;            // Carrega o valor baixo do numero 57723.
	MOVLW       123
	MOVWF       TMR0L+0 
;projfinal.c,155 :: 		INTCON.TMR0IF = 0;       // Limpa o flag de estouro do timer0 para uma nova contagem de tempo.
	BCF         INTCON+0, 2 
;projfinal.c,157 :: 		iLeituraAD= ADC_Read(2);          // Lê Canal AD 2
	MOVLW       2
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _iLeituraAD+0 
	MOVF        R1, 0 
	MOVWF       _iLeituraAD+1 
;projfinal.c,158 :: 		iLeituraAD/=2;                    // Converte valor do sensor LM35
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+1 
	RRCF        FLOC__main+1, 1 
	RRCF        FLOC__main+0, 1 
	BCF         FLOC__main+1, 7 
	MOVF        FLOC__main+0, 0 
	MOVWF       _iLeituraAD+0 
	MOVF        FLOC__main+1, 0 
	MOVWF       _iLeituraAD+1 
;projfinal.c,159 :: 		temperaturaLida = iLeituraAD;
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       _temperaturaLida+0 
	MOVF        R1, 0 
	MOVWF       _temperaturaLida+1 
	MOVF        R2, 0 
	MOVWF       _temperaturaLida+2 
	MOVF        R3, 0 
	MOVWF       _temperaturaLida+3 
;projfinal.c,160 :: 		pos1 = iLeituraAD%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _pos1+0 
	MOVF        R1, 0 
	MOVWF       _pos1+1 
;projfinal.c,161 :: 		iLeituraAD = iLeituraAD/10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _iLeituraAD+0 
	MOVF        R1, 0 
	MOVWF       _iLeituraAD+1 
;projfinal.c,162 :: 		pos2 = iLeituraAD;
	MOVF        R0, 0 
	MOVWF       _pos2+0 
	MOVF        R1, 0 
	MOVWF       _pos2+1 
;projfinal.c,163 :: 		}
L_main4:
;projfinal.c,165 :: 		imprimeDisplay(pos2,pos1);
	MOVF        _pos2+0, 0 
	MOVWF       FARG_imprimeDisplay_a+0 
	MOVF        _pos2+1, 0 
	MOVWF       FARG_imprimeDisplay_a+1 
	MOVF        _pos1+0, 0 
	MOVWF       FARG_imprimeDisplay_b+0 
	MOVF        _pos1+1, 0 
	MOVWF       FARG_imprimeDisplay_b+1 
	CALL        _imprimeDisplay+0, 0
;projfinal.c,168 :: 		if ((temperaturaLida >= temperaturaAlarme) && (statusAlarme == 1)){
	MOVF        _temperaturaAlarme+0, 0 
	MOVWF       R0 
	MOVF        _temperaturaAlarme+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        _temperaturaLida+0, 0 
	MOVWF       R0 
	MOVF        _temperaturaLida+1, 0 
	MOVWF       R1 
	MOVF        _temperaturaLida+2, 0 
	MOVWF       R2 
	MOVF        _temperaturaLida+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
	MOVLW       0
	XORWF       _statusAlarme+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main33
	MOVLW       1
	XORWF       _statusAlarme+0, 0 
L__main33:
	BTFSS       STATUS+0, 2 
	GOTO        L_main7
L__main31:
;projfinal.c,169 :: 		ligaAlarme();
	CALL        _ligaAlarme+0, 0
;projfinal.c,170 :: 		}else{
	GOTO        L_main8
L_main7:
;projfinal.c,171 :: 		desligaAlarme();
	CALL        _desligaAlarme+0, 0
;projfinal.c,172 :: 		}
L_main8:
;projfinal.c,175 :: 		}
	GOTO        L_main0
;projfinal.c,176 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_ligaAlarme:

;projfinal.c,178 :: 		void ligaAlarme(){
;projfinal.c,179 :: 		PORTC.RC1 = 0; //liga o buzzer
	BCF         PORTC+0, 1 
;projfinal.c,180 :: 		PWM1_Init(5000);                  // Inicializa módulo PWM com 5Khz
	BSF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       99
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;projfinal.c,182 :: 		vel = (ADC_read(0));
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       _vel+0 
	MOVF        R1, 0 
	MOVWF       _vel+1 
	MOVF        R2, 0 
	MOVWF       _vel+2 
	MOVF        R3, 0 
	MOVWF       _vel+3 
;projfinal.c,183 :: 		PWM1_Set_Duty(vel);               // Seta o Duty-cycle do PWM
	CALL        _double2byte+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;projfinal.c,184 :: 		PWM1_Start();                     // Inicia PWM.
	CALL        _PWM1_Start+0, 0
;projfinal.c,186 :: 		PORTE.RE0 = 0;   // liga o rele
	BCF         PORTE+0, 0 
;projfinal.c,188 :: 		}
L_end_ligaAlarme:
	RETURN      0
; end of _ligaAlarme

_desligaAlarme:

;projfinal.c,189 :: 		void desligaAlarme(){
;projfinal.c,190 :: 		PORTC.RC1 = 1; //desliga o buzzer
	BSF         PORTC+0, 1 
;projfinal.c,191 :: 		PWM1_Init(5000);
	BSF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       99
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;projfinal.c,192 :: 		PWM1_Set_Duty(0);               // Seta o Duty-cycle do PWM em 100%.
	CLRF        FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;projfinal.c,193 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;projfinal.c,194 :: 		PORTE.RE0 = 1; // desliga o rele
	BSF         PORTE+0, 0 
;projfinal.c,195 :: 		}
L_end_desligaAlarme:
	RETURN      0
; end of _desligaAlarme

_imprimeDisplay:

;projfinal.c,197 :: 		void imprimeDisplay(int a, int b){
;projfinal.c,199 :: 		unsigned char ucMask[] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F,0x21,0x03,0x40};
	MOVLW       63
	MOVWF       imprimeDisplay_ucMask_L0+0 
	MOVLW       6
	MOVWF       imprimeDisplay_ucMask_L0+1 
	MOVLW       91
	MOVWF       imprimeDisplay_ucMask_L0+2 
	MOVLW       79
	MOVWF       imprimeDisplay_ucMask_L0+3 
	MOVLW       102
	MOVWF       imprimeDisplay_ucMask_L0+4 
	MOVLW       109
	MOVWF       imprimeDisplay_ucMask_L0+5 
	MOVLW       125
	MOVWF       imprimeDisplay_ucMask_L0+6 
	MOVLW       7
	MOVWF       imprimeDisplay_ucMask_L0+7 
	MOVLW       127
	MOVWF       imprimeDisplay_ucMask_L0+8 
	MOVLW       111
	MOVWF       imprimeDisplay_ucMask_L0+9 
	MOVLW       33
	MOVWF       imprimeDisplay_ucMask_L0+10 
	MOVLW       3
	MOVWF       imprimeDisplay_ucMask_L0+11 
	MOVLW       64
	MOVWF       imprimeDisplay_ucMask_L0+12 
;projfinal.c,201 :: 		PORTD = ucMask[a];
	MOVLW       imprimeDisplay_ucMask_L0+0
	ADDWF       FARG_imprimeDisplay_a+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(imprimeDisplay_ucMask_L0+0)
	ADDWFC      FARG_imprimeDisplay_a+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTD+0 
;projfinal.c,202 :: 		PORTA.RA3 = 1;
	BSF         PORTA+0, 3 
;projfinal.c,203 :: 		Delay_ms(2);
	MOVLW       6
	MOVWF       R12, 0
	MOVLW       48
	MOVWF       R13, 0
L_imprimeDisplay9:
	DECFSZ      R13, 1, 1
	BRA         L_imprimeDisplay9
	DECFSZ      R12, 1, 1
	BRA         L_imprimeDisplay9
	NOP
;projfinal.c,204 :: 		PORTA.RA3 = 0;
	BCF         PORTA+0, 3 
;projfinal.c,205 :: 		PORTD = ucMask[b];
	MOVLW       imprimeDisplay_ucMask_L0+0
	ADDWF       FARG_imprimeDisplay_b+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(imprimeDisplay_ucMask_L0+0)
	ADDWFC      FARG_imprimeDisplay_b+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTD+0 
;projfinal.c,206 :: 		PORTA.RA4 = 1;
	BSF         PORTA+0, 4 
;projfinal.c,207 :: 		Delay_ms(2);
	MOVLW       6
	MOVWF       R12, 0
	MOVLW       48
	MOVWF       R13, 0
L_imprimeDisplay10:
	DECFSZ      R13, 1, 1
	BRA         L_imprimeDisplay10
	DECFSZ      R12, 1, 1
	BRA         L_imprimeDisplay10
	NOP
;projfinal.c,208 :: 		PORTA.RA4 = 0;
	BCF         PORTA+0, 4 
;projfinal.c,209 :: 		}
L_end_imprimeDisplay:
	RETURN      0
; end of _imprimeDisplay

_editaPos:

;projfinal.c,211 :: 		void editaPos(int b){
;projfinal.c,212 :: 		if(posMenu == 0){
	MOVLW       0
	XORWF       _posMenu+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__editaPos38
	MOVLW       0
	XORWF       _posMenu+0, 0 
L__editaPos38:
	BTFSS       STATUS+0, 2 
	GOTO        L_editaPos11
;projfinal.c,213 :: 		if(pos == 1)
	MOVLW       0
	XORWF       _pos+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__editaPos39
	MOVLW       1
	XORWF       _pos+0, 0 
L__editaPos39:
	BTFSS       STATUS+0, 2 
	GOTO        L_editaPos12
;projfinal.c,214 :: 		pos = 2;
	MOVLW       2
	MOVWF       _pos+0 
	MOVLW       0
	MOVWF       _pos+1 
	GOTO        L_editaPos13
L_editaPos12:
;projfinal.c,216 :: 		pos = 1;
	MOVLW       1
	MOVWF       _pos+0 
	MOVLW       0
	MOVWF       _pos+1 
L_editaPos13:
;projfinal.c,217 :: 		}
L_editaPos11:
;projfinal.c,218 :: 		if(posMenu == 1){
	MOVLW       0
	XORWF       _posMenu+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__editaPos40
	MOVLW       1
	XORWF       _posMenu+0, 0 
L__editaPos40:
	BTFSS       STATUS+0, 2 
	GOTO        L_editaPos14
;projfinal.c,219 :: 		if(b == 0){
	MOVLW       0
	XORWF       FARG_editaPos_b+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__editaPos41
	MOVLW       0
	XORWF       FARG_editaPos_b+0, 0 
L__editaPos41:
	BTFSS       STATUS+0, 2 
	GOTO        L_editaPos15
;projfinal.c,220 :: 		temperaturaAlarme--;
	MOVLW       1
	SUBWF       _temperaturaAlarme+0, 1 
	MOVLW       0
	SUBWFB      _temperaturaAlarme+1, 1 
;projfinal.c,221 :: 		EEPROM_write(0,temperaturaAlarme);
	CLRF        FARG_EEPROM_Write_address+0 
	MOVF        _temperaturaAlarme+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;projfinal.c,222 :: 		imprimeTemp();
	CALL        _imprimeTemp+0, 0
;projfinal.c,223 :: 		}
	GOTO        L_editaPos16
L_editaPos15:
;projfinal.c,225 :: 		temperaturaAlarme++;
	INFSNZ      _temperaturaAlarme+0, 1 
	INCF        _temperaturaAlarme+1, 1 
;projfinal.c,226 :: 		EEPROM_write(0,temperaturaAlarme);
	CLRF        FARG_EEPROM_Write_address+0 
	MOVF        _temperaturaAlarme+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;projfinal.c,227 :: 		imprimeTemp();
	CALL        _imprimeTemp+0, 0
;projfinal.c,228 :: 		}
L_editaPos16:
;projfinal.c,229 :: 		}
L_editaPos14:
;projfinal.c,231 :: 		}
L_end_editaPos:
	RETURN      0
; end of _editaPos

_Menu:

;projfinal.c,233 :: 		void Menu(){
;projfinal.c,234 :: 		Lcd_Cmd(_LCD_CLEAR);                      // Apaga display.
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;projfinal.c,235 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                 // Desliga cursor.
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;projfinal.c,236 :: 		if(posMenu == 0){//menu inicial
	MOVLW       0
	XORWF       _posMenu+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu43
	MOVLW       0
	XORWF       _posMenu+0, 0 
L__Menu43:
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu17
;projfinal.c,237 :: 		Lcd_Out(1,1,"Setar Alarme");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_projfinal+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_projfinal+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;projfinal.c,238 :: 		Lcd_Out(2,1,"Alarme:");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_projfinal+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_projfinal+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;projfinal.c,239 :: 		digitaStatus();
	CALL        _digitaStatus+0, 0
;projfinal.c,240 :: 		Lcd_Out(pos,15,"<-");
	MOVF        _pos+0, 0 
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_projfinal+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_projfinal+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;projfinal.c,241 :: 		}
	GOTO        L_Menu18
L_Menu17:
;projfinal.c,242 :: 		else if(posMenu == 1){
	MOVLW       0
	XORWF       _posMenu+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu44
	MOVLW       1
	XORWF       _posMenu+0, 0 
L__Menu44:
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu19
;projfinal.c,244 :: 		Lcd_Out(1,1,"Selecione:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_projfinal+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_projfinal+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;projfinal.c,245 :: 		imprimeTemp();
	CALL        _imprimeTemp+0, 0
;projfinal.c,246 :: 		}
L_Menu19:
L_Menu18:
;projfinal.c,247 :: 		}
L_end_Menu:
	RETURN      0
; end of _Menu

_imprimeTemp:

;projfinal.c,249 :: 		void imprimeTemp(){
;projfinal.c,250 :: 		IntToStr(temperaturaAlarme, valor);
	MOVF        _temperaturaAlarme+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _temperaturaAlarme+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _valor+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_valor+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;projfinal.c,251 :: 		Lcd_Out(2,-2,valor);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       254
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _valor+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_valor+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;projfinal.c,252 :: 		Lcd_Out(2,5,"C");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_projfinal+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_projfinal+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;projfinal.c,253 :: 		}
L_end_imprimeTemp:
	RETURN      0
; end of _imprimeTemp

_alteraStatus:

;projfinal.c,254 :: 		void alteraStatus(){
;projfinal.c,255 :: 		if(posMenu == 0){
	MOVLW       0
	XORWF       _posMenu+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__alteraStatus47
	MOVLW       0
	XORWF       _posMenu+0, 0 
L__alteraStatus47:
	BTFSS       STATUS+0, 2 
	GOTO        L_alteraStatus20
;projfinal.c,256 :: 		if(pos == 2)
	MOVLW       0
	XORWF       _pos+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__alteraStatus48
	MOVLW       2
	XORWF       _pos+0, 0 
L__alteraStatus48:
	BTFSS       STATUS+0, 2 
	GOTO        L_alteraStatus21
;projfinal.c,257 :: 		if (Button(&PORTB, 0, 100, 0)) {
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	CLRF        FARG_Button_pin+0 
	MOVLW       100
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_alteraStatus22
;projfinal.c,258 :: 		if(statusAlarme == 0){
	MOVLW       0
	XORWF       _statusAlarme+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__alteraStatus49
	MOVLW       0
	XORWF       _statusAlarme+0, 0 
L__alteraStatus49:
	BTFSS       STATUS+0, 2 
	GOTO        L_alteraStatus23
;projfinal.c,259 :: 		statusAlarme = 1;
	MOVLW       1
	MOVWF       _statusAlarme+0 
	MOVLW       0
	MOVWF       _statusAlarme+1 
;projfinal.c,260 :: 		EEPROM_write(1,statusAlarme);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;projfinal.c,261 :: 		}
	GOTO        L_alteraStatus24
L_alteraStatus23:
;projfinal.c,263 :: 		statusAlarme = 0;
	CLRF        _statusAlarme+0 
	CLRF        _statusAlarme+1 
;projfinal.c,264 :: 		EEPROM_write(1,statusAlarme);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;projfinal.c,265 :: 		}
L_alteraStatus24:
;projfinal.c,266 :: 		Menu();
	CALL        _Menu+0, 0
;projfinal.c,267 :: 		}
L_alteraStatus22:
L_alteraStatus21:
;projfinal.c,268 :: 		if(pos == 1)
	MOVLW       0
	XORWF       _pos+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__alteraStatus50
	MOVLW       1
	XORWF       _pos+0, 0 
L__alteraStatus50:
	BTFSS       STATUS+0, 2 
	GOTO        L_alteraStatus25
;projfinal.c,269 :: 		if (Button(&PORTB, 0, 100, 0)) {
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	CLRF        FARG_Button_pin+0 
	MOVLW       100
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_alteraStatus26
;projfinal.c,270 :: 		posMenu = 1;
	MOVLW       1
	MOVWF       _posMenu+0 
	MOVLW       0
	MOVWF       _posMenu+1 
;projfinal.c,271 :: 		Menu();
	CALL        _Menu+0, 0
;projfinal.c,272 :: 		}
L_alteraStatus26:
L_alteraStatus25:
;projfinal.c,273 :: 		}
L_alteraStatus20:
;projfinal.c,274 :: 		if(posMenu == 1){
	MOVLW       0
	XORWF       _posMenu+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__alteraStatus51
	MOVLW       1
	XORWF       _posMenu+0, 0 
L__alteraStatus51:
	BTFSS       STATUS+0, 2 
	GOTO        L_alteraStatus27
;projfinal.c,275 :: 		if (Button(&PORTB, 0, 100, 0)) {
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	CLRF        FARG_Button_pin+0 
	MOVLW       100
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_alteraStatus28
;projfinal.c,276 :: 		pos = 1;
	MOVLW       1
	MOVWF       _pos+0 
	MOVLW       0
	MOVWF       _pos+1 
;projfinal.c,277 :: 		posMenu = 0;
	CLRF        _posMenu+0 
	CLRF        _posMenu+1 
;projfinal.c,278 :: 		Menu();
	CALL        _Menu+0, 0
;projfinal.c,279 :: 		}
L_alteraStatus28:
;projfinal.c,280 :: 		}
L_alteraStatus27:
;projfinal.c,281 :: 		}
L_end_alteraStatus:
	RETURN      0
; end of _alteraStatus

_digitaStatus:

;projfinal.c,282 :: 		void digitaStatus(){
;projfinal.c,284 :: 		if(EEPROM_read(1) == 0){
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_digitaStatus29
;projfinal.c,285 :: 		Lcd_Out(2,9, "Off");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_projfinal+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_projfinal+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;projfinal.c,286 :: 		}
	GOTO        L_digitaStatus30
L_digitaStatus29:
;projfinal.c,288 :: 		Lcd_Out(2,9, "On");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_projfinal+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_projfinal+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;projfinal.c,289 :: 		}
L_digitaStatus30:
;projfinal.c,290 :: 		}
L_end_digitaStatus:
	RETURN      0
; end of _digitaStatus
