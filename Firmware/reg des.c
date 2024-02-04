
sbit LCD_RS at LATD2_bit;
sbit LCD_EN at LATD3_bit;
sbit LCD_D4 at LATD4_bit;
sbit LCD_D5 at LATD5_bit;
sbit LCD_D6 at LATD6_bit;
sbit LCD_D7 at LATD7_bit;

sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;

char keypadPort at PORTC;
unsigned int end; caca;
unsigned int pass;
unsigned int caminho;
unsigned short cana;
unsigned short fs;
unsigned short cs;
unsigned char kp; kp1; kp2; kp3; kp4; kp5; kp6; ocu;
char cliques = 0;
char clique1 = 0;
char tentativas = 0;
char *senha = "000000";
char *senha1 = "000000";
char *senha2 = "000000";
char *cod = "000000";
char *can = "00";
char *ecan = "00";
char *dend = "00";


char CompararSenha()
{
char i = 0;
   for(i=0; i < 6; i++)
   {
    if(senha[i] != Eeprom_Read(i+end)) return(0);
   }
   return (1);

}

void LerSenhaDaEeprom()
{
 char i=0;
 for (i=0; i<6; i++)
  {
   senha[i] = Eeprom_Read(i+end);
   Delay_ms(20);
  }
  pass = StrToInt(senha);

}

void GravarCanalNaEeprom()
{
char i=0;
 for(i=0; i < 2; i++)
 {
    Eeprom_Write(i, can[i]);
    Delay_ms(20);
 }
 Lcd_Out(1,2, " CANAL GRAVADO OK");
}

void LerCanalDaEeprom()
{
  char c=0;
 for ( c=0; c < 2; c++)
  {
   can[c] = Eeprom_Read(c);
   Delay_ms(20);
   }
  caca = StrToInt(can);
 }
 
void GravarSenhaNaEeprom()
{
char i;
 for(i=0; i < 6; i++)
 {
    Eeprom_Write(i+end, senha1[i]);
    Delay_ms(20);
 }

  Lcd_Out(1,1, "SENHA GRAVADA OK");
}

void GravarSenhaNaEeprom2()
{
char i;
 for(i=0; i < 6; i++)
 {
    Eeprom_Write(i+end, senha2[i]);
    Delay_ms(20);
 }

  Lcd_Out(1,1, "SENHA GRAVADA OK");
}

void LimparSenha()
{
 char i;
 for(i=0; i < 6; i++)
 {
   senha[i] = '0';
   cod[i] = '0';
 }
}

void LimparSenha1()
{
 char i;
 for(i=0; i < 6; i++)
 {
   senha1[i] = '0';
   cod[i] = '0';
 }
}

void LimparSenha2()
{
 char i;
 for(i=0; i < 6; i++)
 {
   senha2[i] = '0';
   cod[i] = '0';
 }
}

void LimparCanal()
{
 char i=0;
 for(i=0; i < 2; i++)
 {
   can[i] = '0';
   ecan[i] = '0';
 }
}

void ResetEeprom()
{
 char i=0;
 Lcd_Out(1, 2, " RESETANDO...");
 for (i = 0; i < 255; i++)
  {
   Eeprom_Write(i , 0xFF);
   Delay_ms(25);
  }
  Lcd_Out(1, 2, "   RESET OK   ");
  Lcd_Out(2, 2, "REMOVA O JUMPER");
  volta1:
  if (PORTD.F1 == 1){return;}
   else
    {
     goto volta1;
    }
}






/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *                            ROTINA PRINCIPAL                             *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

void main(void)
{

  char i;
  char c;
  end=2; caminho=0;
  ADCON1 = 0x0F;                  // Configura os pinos como digitais
  CMCON  = 0x07;                  // Desliga os comparadores
  TRISA=0b00000000;
  PORTA=0b11111111;                        // Inicializa o PORTA em zero
  TRISB=0b00000000;
  PORTB=0b00111111;
  TRISC=0b00000000;
  PORTC=0;
  TRISD=0b00000011;
  PORTD=0;
  TRISE=0b000;
  PORTE=0b111;

Keypad_Init();
Lcd_Init();
if ( PORTD.F1 == 0)
 {
  ResetEeprom();
 }
Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);

inicio:               //////////////////////////// ROTINA INICIAL  ////////////////////////////////
caminho =0;
LimparSenha();
LerCanalDaEeprom();
if(can[0] == 0xFF && can[1] == 0xFF)
  {
     goto rotina1;
   }

while(1)
{

 kp = Keypad_Key_Click();

 if(kp)
 {
    if(kp % 4 == 0)
    {
       //Faz Nada
    }
    else if(kp == 13) //Limpar
    {
       LimparSenha();
       cliques = 0;
    }
    else if(kp == 15) //Enter
    {
      cliques = 0; end=2; fs =0; c=0;

      if(senha[0]==57 && senha[1] == 57 && senha[2]  == 57 && senha[3] == 57 &&senha[4] ==57 && senha[5] == 57)  // verifica se senha é 999999 (cadastra/edita senhas de todos os canais)
       {
        caminho=1;
        goto rotina4;
       }
      if(senha[0]==57 && senha[1] == 57 && senha[2]  == 57 && senha[3] == 57 &&senha[4] ==57 && senha[5] == 49)  // verifica se senha é 999991 (cadastra/edita senha de canal especifico)
       {
        caminho=2;
        goto rotina4;
       }
      if(senha[0]==57 && senha[1] == 57 && senha[2]  == 57 && senha[3] == 57 &&senha[4] ==57 && senha[5] == 50)  // verifica se senha é 999992  (cadastra/edita senha de administrador)
       {
        caminho=3;
        goto rotina4;
       }
       LerCanalDaEeprom();
       for (c=0; c <= caca; c++)
       {

         if(CompararSenha()) //Sucesso
         {
          Lcd_Cmd(_LCD_CLEAR);
          Lcd_Out(1,6,"SENHA OK"  );
          if (end == 2 ){fs=1;PORTA=0b00000000; PORTB=0b00000000; PORTE=0b00000000; Delay_ms(1500);PORTA =0b00111111; PORTB =0b00111111; PORTE=0b11111111;}
          if (end == 8 ){fs=1;PORTA.F0 = 0;Delay_ms(1500);PORTA.F0 = 1;}
          if (end == 14){fs=1;PORTA.F1 = 0;Delay_ms(1500);PORTA.F1 = 1;}
          if (end == 20){fs=1;PORTA.F2 = 0;Delay_ms(1500);PORTA.F2 = 1;}
          if (end == 26){fs=1;PORTA.F3 = 0;Delay_ms(1500);PORTA.F3 = 1;}
          if (end == 32){fs=1;PORTA.F4 = 0;Delay_ms(1500);PORTA.F4 = 1;}
          if (end == 38){fs=1;PORTA.F5 = 0;Delay_ms(1500);PORTA.F5 = 1;}
          if (end == 44){fs=1;PORTB.F0 = 0;Delay_ms(1500);PORTB.F0 = 1;}
          if (end == 50){fs=1;PORTB.F1 = 0;Delay_ms(1500);PORTB.F1 = 1;}
          if (end == 56){fs=1;PORTB.F2 = 0;Delay_ms(1500);PORTB.F2 = 1;}
          if (end == 62){fs=1;PORTB.F3 = 0;Delay_ms(1500);PORTB.F3 = 1;}
          if (end == 68){fs=1;PORTB.F4 = 0;Delay_ms(1500);PORTB.F4 = 1;}
          if (end == 74){fs=1;PORTB.F5 = 0;Delay_ms(1500);PORTB.F5 = 1;}
          if (end == 80){fs=1;PORTE.F0 = 0;Delay_ms(1500);PORTE.F0 = 1;}
          if (end == 86){fs=1;PORTE.F1 = 0;Delay_ms(1500);PORTE.F1 = 1;}
          if (end == 92){fs=1;PORTE.F2 = 0;Delay_ms(1500);PORTE.F2 = 1;}
          Delay_ms(500);
          LimparSenha();
         }
          
          end=end+6;

       }
       if ( fs == 0 )
       {
         Lcd_Cmd(_LCD_CLEAR);
         Lcd_Out(1,3,"SENHA ERRADA");
         LimparSenha();

       }

      Delay_ms(500);

    }
    else  //Numeros
    {
       switch(kp)
       {
        case 1: kp = 49; ocu=42; break; //1
        case 2: kp = 50; ocu=42;break; //2
        case 3: kp = 51; ocu=42;break; //3
        case 5: kp = 52; ocu=42;break; //4
        case 6: kp = 53; ocu=42;break; //5
        case 7: kp = 54; ocu=42;break; //6
        case 9: kp = 55; ocu=42;break; //7
        case 10: kp = 56; ocu=42;break;//8
        case 11: kp = 57; ocu=42;break;//9
        case 14: kp = 48; ocu=42;break;//0
       }

       if(cliques < 6)
       {
           //Digitando a senha
           for(c=0; c < 6; c++)
            cod[c] = cod[c+1];
            cod[5] = ocu;
           for(i=0; i < 6; i++)
            senha[i] = senha[i+1];
            senha[5] = kp;

       }

     }
  }
  Lcd_Out(1,2, "DIGITE A SENHA");
  Lcd_Out(2,6, cod);
  Delay_ms(10);
 }    // WHILE ROTINA INICIAL





rotina1:                                       //////////////////////////// ROTINA 1  GRAVA QTY CANAL ////////////////////////////////
LimparCanal();

while(1)
{

 kp1 = Keypad_Key_Click();

 if(kp1)
 {
    if(kp1 % 4 == 0)
    {
       //Faz Nada
    }
    else if(kp1 == 13) //Limpar
    {
       LimparCanal();
       cliques = 0;
    }
    else if(kp1 == 15) //Enter
    {
      cliques = 0; end=2;fs =0;cs =0;
         if(can[0]==48 || can[0]==49 && can[1] <= 53)   //verifica se canal digitado é menor que 11
          {
            GravarCanalNaEeprom();
            Delay_ms(500);
            goto rotina2;

           }
          else
           {
            Lcd_Out(1,1, "CANAL NAO SUPORT");
            Delay_ms(500);
            LimparCanal();
            Lcd_Cmd(_LCD_CLEAR);
            goto rotina1;
           }

      Delay_ms(500);

    }
    else  //Numeros
    {
       switch(kp1)
       {
        case 1: kp1 = 49; break; //1
        case 2: kp1 = 50; break; //2
        case 3: kp1 = 51; break; //3
        case 5: kp1 = 52; break; //4
        case 6: kp1 = 53; break; //5
        case 7: kp1 = 54; break; //6
        case 9: kp1 = 55; break; //7
        case 10: kp1 = 56; break;//8
        case 11: kp1 = 57; break;//9
        case 14: kp1 = 48; break;//0
       }

       if(cliques < 3)
       {
           //Digitando a senha
           for(i=0; i < 2; i++)
            can[i] = can[i+1];
            can[1] = kp1;

       }

     }
  }
   Lcd_Out(1,2, "QUANTOS CANAIS?");
   Lcd_Out(2,8, can);
   Delay_ms(10);
 }    // WHILE ROTINA 1




 rotina2:                //////////////////////////// ROTINA 2  ROTINA GRAVAÇÃO DA SENHA ADM /////////////////////////////
 Lcd_Cmd(_LCD_CLEAR);
 while(1)
{
 kp2 = Keypad_Key_Click();
 if(kp2)
 {
    if(kp2 % 4 == 0)
    {
       //Faz Nada
    }
    else if(kp2 == 13) //Limpar
    {
       LimparSenha1();
       cliques = 0;
    }
    else if(kp2 == 15) //Enter
    {
      cliques = 0; end=2;fs =0;c =0;
      GravarSenhaNaEeprom();
      Delay_ms(1000);
      LimparSenha1();
      Lcd_Cmd(_LCD_CLEAR);
      goto inicio;

    }
    else  //Numeros
    {
       switch(kp2)
       {
        case 1: kp2 = 49; ocu=42; break; //1
        case 2: kp2 = 50; ocu=42;break; //2
        case 3: kp2 = 51; ocu=42;break; //3
        case 5: kp2 = 52; ocu=42;break; //4
        case 6: kp2 = 53; ocu=42;break; //5
        case 7: kp2 = 54; ocu=42;break; //6
        case 9: kp2 = 55; ocu=42;break; //7
        case 10: kp2 = 56; ocu=42;break;//8
        case 11: kp2 = 57; ocu=42;break;//9
        case 14: kp2 = 48; ocu=42;break;//0
       }

       if(cliques < 6)
       {
           //Digitando a senha
           for(c=0; c < 6; c++)

            cod[c] = cod[c+1];
            cod[5] = ocu;
           for(i=0; i < 6; i++)
            senha1[i] = senha1[i+1];
            senha1[5] = kp2;

       }

     }
  }
   Lcd_Out(1,2, "DIG.SENHA ADM");
   Lcd_Out(2,6, cod);
   Delay_ms(10);
 }    // WHILE ROTINA 2

 rotina3:                //////////////////////////// ROTINA 3  GRAVAÇÃO DE TODAS AS SENHAS DOS CANAIS/////////////////////////////
 Lcd_Cmd(_LCD_CLEAR);
 cana=1;
 cs=0;
 end=8;
 LerCanalDaEeprom();
volta2:

 while(1)
{
 kp3 = Keypad_Key_Click();

 if(kp3)
 {
    if(kp3 % 4 == 0)
    {
       //Faz Nada
    }
    else if(kp3 == 13) //Limpar
    {
       LimparSenha2();
       cliques = 0;
    }
    else if(kp3 == 15) //Enter
    {
      cliques = 0;
      if(cana <= caca)
       {
         GravarSenhaNaEeprom2();
         Delay_ms(500);
         end=end+6;
         cana++;
         cs++;
         LimparSenha2();
         Lcd_Cmd(_LCD_CLEAR);
         if(cana > caca)
          {
            Lcd_Cmd(_LCD_CLEAR);
            goto inicio;
          }
         else
         {
          goto volta2;
         }
       }
       else
       {
        goto volta2;
       }
    }
    else  //Numeros
    {
       switch(kp3)
       {
        case 1: kp3 = 49; ocu=42; break; //1
        case 2: kp3 = 50; ocu=42;break; //2
        case 3: kp3 = 51; ocu=42;break; //3
        case 5: kp3 = 52; ocu=42;break; //4
        case 6: kp3 = 53; ocu=42;break; //5
        case 7: kp3 = 54; ocu=42;break; //6
        case 9: kp3 = 55; ocu=42;break; //7
        case 10: kp3 = 56; ocu=42;break;//8
        case 11: kp3 = 57; ocu=42;break;//9
        case 14: kp3 = 48; ocu=42;break;//0
       }

       if(cliques < 6)
       {
           //Digitando a senha
           for(c=0; c < 6; c++)

            cod[c] = cod[c+1];
            cod[5] = ocu;
           for(i=0; i < 6; i++)
            senha2[i] = senha2[i+1];
            senha2[5] = kp3;

       }

     }
  }
   
   Lcd_Out(1,1, "SENHA CANAL:");
   ShortToStr(cana,dend);
   Lcd_Out(1,13,dend);
   Lcd_Out(2,6, cod);
   Delay_ms(10);
 }    //    WHILE ROTINA 3

 
 rotina4:      //////////////////////////// ROTINA 4  ROTINA DA VERIF DE ADM /////////////////////////////
 Lcd_Cmd(_LCD_CLEAR);
 LimparSenha();
 while(1)
{

 kp4 = Keypad_Key_Click();

 if(kp4)
 {
    if(kp4 % 4 == 0)
    {
       //Faz Nada
    }
    else if(kp4 == 13) //Limpar
    {
       LimparSenha();
       cliques = 0;
    }
    else if(kp4 == 15) //Enter
    {
      cliques = 0; end=2; fs =0;c =0;

         if(CompararSenha()) //Sucesso
         {
          Lcd_Cmd(_LCD_CLEAR);
          Lcd_Out(1,3,"SENHA ADM OK"  );
          Delay_ms(500);
          LimparSenha();
          fs=1;
          if(caminho == 1){goto rotina3;}
          if(caminho == 2){goto rotina5;}
          if(caminho == 3){goto rotina2;}
         }

       if ( fs == 0 )
       {
         Lcd_Cmd(_LCD_CLEAR);
         Lcd_Out(1,1,"SENHA ADM ERRADA");
         Delay_ms(3000);
         LimparSenha();
         Lcd_Cmd(_LCD_CLEAR);
         goto inicio;
       }

      Delay_ms(1000);

    }
    else  //Numeros
    {
       switch(kp4)
       {
        case 1: kp4 = 49; ocu=42; break; //1
        case 2: kp4 = 50; ocu=42;break; //2
        case 3: kp4 = 51; ocu=42;break; //3
        case 5: kp4 = 52; ocu=42;break; //4
        case 6: kp4 = 53; ocu=42;break; //5
        case 7: kp4 = 54; ocu=42;break; //6
        case 9: kp4 = 55; ocu=42;break; //7
        case 10: kp4 = 56; ocu=42;break;//8
        case 11: kp4 = 57; ocu=42;break;//9
        case 14: kp4 = 48; ocu=42;break;//0
       }

       if(cliques < 6)
       {
           //Digitando a senha
           for(c=0; c < 6; c++)

            cod[c] = cod[c+1];
            cod[5] = ocu;
           for(i=0; i < 6; i++)
            senha[i] = senha[i+1];
            senha[5] = kp4;

       }

     }
  }
  Lcd_Out(1,2, "DIG.SENHA ADM");
  Lcd_Out(2,6, cod);
  Delay_ms(10);
 }    //  WHILE ROTINA 4
 
 rotina5:                                       //////////////////////////// ROTINA 5  PEGA CANAL PARA EDITAR ////////////////////////////////
Lcd_Cmd(_LCD_CLEAR);
LimparCanal();

while(1)
{

 kp5 = Keypad_Key_Click();

 if(kp5)
 {
    if(kp5 % 4 == 0)
    {
       //Faz Nada
    }
    else if(kp5 == 13) //Limpar
    {
       LimparCanal();
       cliques = 0;
    }
    else if(kp5 == 15) //Enter
    {
      cliques = 0;
      LerCanalDaEeprom();
      cana = StrToShort(ecan);

      if(caca >= cana && cana != 0 )   //verifica se canal digitado é menor que o gravado ou diferente de zero
       {
         goto rotina6;
       }
      else
       {
         Lcd_Out(1,1, "CANAL NAO EXISTE");
         Delay_ms(1000);
         LimparCanal();
         Lcd_Cmd(_LCD_CLEAR);
         goto rotina5;
        }

      Delay_ms(500);

    }
    else  //Numeros
    {
       switch(kp5)
       {
        case 1: kp5 = 49; break; //1
        case 2: kp5 = 50; break; //2
        case 3: kp5 = 51; break; //3
        case 5: kp5 = 52; break; //4
        case 6: kp5 = 53; break; //5
        case 7: kp5 = 54; break; //6
        case 9: kp5 = 55; break; //7
        case 10: kp5 = 56; break;//8
        case 11: kp5 = 57; break;//9
        case 14: kp5 = 48; break;//0
       }

       if(cliques < 3)
       {
           //Digitando a senha
           for(i=0; i < 2; i++)
            ecan[i] = ecan[i+1];
            ecan[1] = kp5;

       }

     }
  }
   Lcd_Out(1,2, "QUAL CANAL EDT?");
   Lcd_Out(2,8, ecan);
   Delay_ms(10);
 }    // WHILE ROTINA 5
 
 
 
rotina6:                //////////////////////////// ROTINA 6  EDIÇÃO DAS SENHAS DOS CANAIS/////////////////////////////
Lcd_Cmd(_LCD_CLEAR);
volta3:

 while(1)
{
 kp6 = Keypad_Key_Click();

 if(kp6)
 {
    if(kp6 % 4 == 0)
    {
       //Faz Nada
    }
    else if(kp6 == 13) //Limpar
    {
       LimparSenha2();
       cliques = 0;
    }
    else if(kp6 == 15) //Enter
    {
      cliques = 0;
      if(cana==1){end=8;}
      if(cana==2){end=14;}
      if(cana==3){end=20;}
      if(cana==4){end=26;}
      if(cana==5){end=32;}
      if(cana==6){end=38;}
      if(cana==7){end=44;}
      if(cana==8){end=50;}
      if(cana==9){end=56;}
      if(cana==10){end=62;}
      if(cana==11){end=68;}
      if(cana==12){end=74;}
      if(cana==13){end=80;}
      if(cana==14){end=86;}
      if(cana==15){end=92;}
      GravarSenhaNaEeprom2();
      Delay_ms(500);
      LimparSenha2();
      Lcd_Cmd(_LCD_CLEAR);
      goto inicio;

    }
    else  //Numeros
    {
       switch(kp6)
       {
        case 1: kp6 = 49; ocu=42; break; //1
        case 2: kp6 = 50; ocu=42;break; //2
        case 3: kp6 = 51; ocu=42;break; //3
        case 5: kp6 = 52; ocu=42;break; //4
        case 6: kp6 = 53; ocu=42;break; //5
        case 7: kp6 = 54; ocu=42;break; //6
        case 9: kp6 = 55; ocu=42;break; //7
        case 10: kp6 = 56; ocu=42;break;//8
        case 11: kp6 = 57; ocu=42;break;//9
        case 14: kp6 = 48; ocu=42;break;//0
       }

       if(cliques < 6)
       {
           //Digitando a senha
           for(c=0; c < 6; c++)

            cod[c] = cod[c+1];
            cod[5] = ocu;
           for(i=0; i < 6; i++)
            senha2[i] = senha2[i+1];
            senha2[5] = kp6;

       }

     }
  }

   Lcd_Out(1,1, "EDITA CANAL:");
   ShortToStr(cana,dend);
   Lcd_Out(1,13,dend);
   Lcd_Out(2,6, cod);
   Delay_ms(10);
 }    // WHILE ROTINA 6

 } // void