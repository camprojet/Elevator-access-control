
_CompararSenha:

;reg des.c,36 :: 		char CompararSenha()
;reg des.c,38 :: 		char i = 0;
	CLRF        CompararSenha_i_L0+0 
;reg des.c,39 :: 		for(i=0; i < 6; i++)
	CLRF        CompararSenha_i_L0+0 
L_CompararSenha0:
	MOVLW       6
	SUBWF       CompararSenha_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_CompararSenha1
;reg des.c,41 :: 		if(senha[i] != Eeprom_Read(i+end)) return(0);
	MOVF        CompararSenha_i_L0+0, 0 
	ADDWF       _senha+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__CompararSenha+0 
	MOVF        _end+0, 0 
	ADDWF       CompararSenha_i_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        FLOC__CompararSenha+0, 0 
	XORWF       R0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_CompararSenha3
	CLRF        R0 
	GOTO        L_end_CompararSenha
L_CompararSenha3:
;reg des.c,39 :: 		for(i=0; i < 6; i++)
	INCF        CompararSenha_i_L0+0, 1 
;reg des.c,42 :: 		}
	GOTO        L_CompararSenha0
L_CompararSenha1:
;reg des.c,43 :: 		return (1);
	MOVLW       1
	MOVWF       R0 
;reg des.c,45 :: 		}
L_end_CompararSenha:
	RETURN      0
; end of _CompararSenha

_LerSenhaDaEeprom:

;reg des.c,47 :: 		void LerSenhaDaEeprom()
;reg des.c,49 :: 		char i=0;
	CLRF        LerSenhaDaEeprom_i_L0+0 
;reg des.c,50 :: 		for (i=0; i<6; i++)
	CLRF        LerSenhaDaEeprom_i_L0+0 
L_LerSenhaDaEeprom4:
	MOVLW       6
	SUBWF       LerSenhaDaEeprom_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LerSenhaDaEeprom5
;reg des.c,52 :: 		senha[i] = Eeprom_Read(i+end);
	MOVF        LerSenhaDaEeprom_i_L0+0, 0 
	ADDWF       _senha+0, 0 
	MOVWF       FLOC__LerSenhaDaEeprom+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FLOC__LerSenhaDaEeprom+1 
	MOVF        _end+0, 0 
	ADDWF       LerSenhaDaEeprom_i_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVFF       FLOC__LerSenhaDaEeprom+0, FSR1L+0
	MOVFF       FLOC__LerSenhaDaEeprom+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,53 :: 		Delay_ms(20);
	MOVLW       163
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_LerSenhaDaEeprom7:
	DECFSZ      R13, 1, 1
	BRA         L_LerSenhaDaEeprom7
	DECFSZ      R12, 1, 1
	BRA         L_LerSenhaDaEeprom7
;reg des.c,50 :: 		for (i=0; i<6; i++)
	INCF        LerSenhaDaEeprom_i_L0+0, 1 
;reg des.c,54 :: 		}
	GOTO        L_LerSenhaDaEeprom4
L_LerSenhaDaEeprom5:
;reg des.c,55 :: 		pass = StrToInt(senha);
	MOVF        _senha+0, 0 
	MOVWF       FARG_StrToInt_byte_in+0 
	MOVF        _senha+1, 0 
	MOVWF       FARG_StrToInt_byte_in+1 
	CALL        _StrToInt+0, 0
	MOVF        R0, 0 
	MOVWF       _pass+0 
	MOVF        R1, 0 
	MOVWF       _pass+1 
;reg des.c,57 :: 		}
L_end_LerSenhaDaEeprom:
	RETURN      0
; end of _LerSenhaDaEeprom

_GravarCanalNaEeprom:

;reg des.c,59 :: 		void GravarCanalNaEeprom()
;reg des.c,61 :: 		char i=0;
	CLRF        GravarCanalNaEeprom_i_L0+0 
;reg des.c,62 :: 		for(i=0; i < 2; i++)
	CLRF        GravarCanalNaEeprom_i_L0+0 
L_GravarCanalNaEeprom8:
	MOVLW       2
	SUBWF       GravarCanalNaEeprom_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GravarCanalNaEeprom9
;reg des.c,64 :: 		Eeprom_Write(i, can[i]);
	MOVF        GravarCanalNaEeprom_i_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        GravarCanalNaEeprom_i_L0+0, 0 
	ADDWF       _can+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _can+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;reg des.c,65 :: 		Delay_ms(20);
	MOVLW       163
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_GravarCanalNaEeprom11:
	DECFSZ      R13, 1, 1
	BRA         L_GravarCanalNaEeprom11
	DECFSZ      R12, 1, 1
	BRA         L_GravarCanalNaEeprom11
;reg des.c,62 :: 		for(i=0; i < 2; i++)
	INCF        GravarCanalNaEeprom_i_L0+0, 1 
;reg des.c,66 :: 		}
	GOTO        L_GravarCanalNaEeprom8
L_GravarCanalNaEeprom9:
;reg des.c,67 :: 		Lcd_Out(1,2, " CANAL GRAVADO OK");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_reg_32des+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_reg_32des+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,68 :: 		}
L_end_GravarCanalNaEeprom:
	RETURN      0
; end of _GravarCanalNaEeprom

_LerCanalDaEeprom:

;reg des.c,70 :: 		void LerCanalDaEeprom()
;reg des.c,72 :: 		char c=0;
	CLRF        LerCanalDaEeprom_c_L0+0 
;reg des.c,73 :: 		for ( c=0; c < 2; c++)
	CLRF        LerCanalDaEeprom_c_L0+0 
L_LerCanalDaEeprom12:
	MOVLW       2
	SUBWF       LerCanalDaEeprom_c_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LerCanalDaEeprom13
;reg des.c,75 :: 		can[c] = Eeprom_Read(c);
	MOVF        LerCanalDaEeprom_c_L0+0, 0 
	ADDWF       _can+0, 0 
	MOVWF       FLOC__LerCanalDaEeprom+0 
	MOVLW       0
	ADDWFC      _can+1, 0 
	MOVWF       FLOC__LerCanalDaEeprom+1 
	MOVF        LerCanalDaEeprom_c_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVFF       FLOC__LerCanalDaEeprom+0, FSR1L+0
	MOVFF       FLOC__LerCanalDaEeprom+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,76 :: 		Delay_ms(20);
	MOVLW       163
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_LerCanalDaEeprom15:
	DECFSZ      R13, 1, 1
	BRA         L_LerCanalDaEeprom15
	DECFSZ      R12, 1, 1
	BRA         L_LerCanalDaEeprom15
;reg des.c,73 :: 		for ( c=0; c < 2; c++)
	INCF        LerCanalDaEeprom_c_L0+0, 1 
;reg des.c,77 :: 		}
	GOTO        L_LerCanalDaEeprom12
L_LerCanalDaEeprom13:
;reg des.c,78 :: 		caca = StrToInt(can);
	MOVF        _can+0, 0 
	MOVWF       FARG_StrToInt_byte_in+0 
	MOVF        _can+1, 0 
	MOVWF       FARG_StrToInt_byte_in+1 
	CALL        _StrToInt+0, 0
	MOVF        R0, 0 
	MOVWF       _caca+0 
	MOVF        R1, 0 
	MOVWF       _caca+1 
;reg des.c,79 :: 		}
L_end_LerCanalDaEeprom:
	RETURN      0
; end of _LerCanalDaEeprom

_GravarSenhaNaEeprom:

;reg des.c,81 :: 		void GravarSenhaNaEeprom()
;reg des.c,84 :: 		for(i=0; i < 6; i++)
	CLRF        GravarSenhaNaEeprom_i_L0+0 
L_GravarSenhaNaEeprom16:
	MOVLW       6
	SUBWF       GravarSenhaNaEeprom_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GravarSenhaNaEeprom17
;reg des.c,86 :: 		Eeprom_Write(i+end, senha1[i]);
	MOVF        _end+0, 0 
	ADDWF       GravarSenhaNaEeprom_i_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        GravarSenhaNaEeprom_i_L0+0, 0 
	ADDWF       _senha1+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _senha1+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;reg des.c,87 :: 		Delay_ms(20);
	MOVLW       163
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_GravarSenhaNaEeprom19:
	DECFSZ      R13, 1, 1
	BRA         L_GravarSenhaNaEeprom19
	DECFSZ      R12, 1, 1
	BRA         L_GravarSenhaNaEeprom19
;reg des.c,84 :: 		for(i=0; i < 6; i++)
	INCF        GravarSenhaNaEeprom_i_L0+0, 1 
;reg des.c,88 :: 		}
	GOTO        L_GravarSenhaNaEeprom16
L_GravarSenhaNaEeprom17:
;reg des.c,90 :: 		Lcd_Out(1,1, "SENHA GRAVADA OK");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr9_reg_32des+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr9_reg_32des+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,91 :: 		}
L_end_GravarSenhaNaEeprom:
	RETURN      0
; end of _GravarSenhaNaEeprom

_GravarSenhaNaEeprom2:

;reg des.c,93 :: 		void GravarSenhaNaEeprom2()
;reg des.c,96 :: 		for(i=0; i < 6; i++)
	CLRF        GravarSenhaNaEeprom2_i_L0+0 
L_GravarSenhaNaEeprom220:
	MOVLW       6
	SUBWF       GravarSenhaNaEeprom2_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GravarSenhaNaEeprom221
;reg des.c,98 :: 		Eeprom_Write(i+end, senha2[i]);
	MOVF        _end+0, 0 
	ADDWF       GravarSenhaNaEeprom2_i_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        GravarSenhaNaEeprom2_i_L0+0, 0 
	ADDWF       _senha2+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _senha2+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;reg des.c,99 :: 		Delay_ms(20);
	MOVLW       163
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_GravarSenhaNaEeprom223:
	DECFSZ      R13, 1, 1
	BRA         L_GravarSenhaNaEeprom223
	DECFSZ      R12, 1, 1
	BRA         L_GravarSenhaNaEeprom223
;reg des.c,96 :: 		for(i=0; i < 6; i++)
	INCF        GravarSenhaNaEeprom2_i_L0+0, 1 
;reg des.c,100 :: 		}
	GOTO        L_GravarSenhaNaEeprom220
L_GravarSenhaNaEeprom221:
;reg des.c,102 :: 		Lcd_Out(1,1, "SENHA GRAVADA OK");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_reg_32des+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_reg_32des+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,103 :: 		}
L_end_GravarSenhaNaEeprom2:
	RETURN      0
; end of _GravarSenhaNaEeprom2

_LimparSenha:

;reg des.c,105 :: 		void LimparSenha()
;reg des.c,108 :: 		for(i=0; i < 6; i++)
	CLRF        R1 
L_LimparSenha24:
	MOVLW       6
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LimparSenha25
;reg des.c,110 :: 		senha[i] = '0';
	MOVF        R1, 0 
	ADDWF       _senha+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       48
	MOVWF       POSTINC1+0 
;reg des.c,111 :: 		cod[i] = '0';
	MOVF        R1, 0 
	ADDWF       _cod+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _cod+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       48
	MOVWF       POSTINC1+0 
;reg des.c,108 :: 		for(i=0; i < 6; i++)
	INCF        R1, 1 
;reg des.c,112 :: 		}
	GOTO        L_LimparSenha24
L_LimparSenha25:
;reg des.c,113 :: 		}
L_end_LimparSenha:
	RETURN      0
; end of _LimparSenha

_LimparSenha1:

;reg des.c,115 :: 		void LimparSenha1()
;reg des.c,118 :: 		for(i=0; i < 6; i++)
	CLRF        R1 
L_LimparSenha127:
	MOVLW       6
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LimparSenha128
;reg des.c,120 :: 		senha1[i] = '0';
	MOVF        R1, 0 
	ADDWF       _senha1+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _senha1+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       48
	MOVWF       POSTINC1+0 
;reg des.c,121 :: 		cod[i] = '0';
	MOVF        R1, 0 
	ADDWF       _cod+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _cod+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       48
	MOVWF       POSTINC1+0 
;reg des.c,118 :: 		for(i=0; i < 6; i++)
	INCF        R1, 1 
;reg des.c,122 :: 		}
	GOTO        L_LimparSenha127
L_LimparSenha128:
;reg des.c,123 :: 		}
L_end_LimparSenha1:
	RETURN      0
; end of _LimparSenha1

_LimparSenha2:

;reg des.c,125 :: 		void LimparSenha2()
;reg des.c,128 :: 		for(i=0; i < 6; i++)
	CLRF        R1 
L_LimparSenha230:
	MOVLW       6
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LimparSenha231
;reg des.c,130 :: 		senha2[i] = '0';
	MOVF        R1, 0 
	ADDWF       _senha2+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _senha2+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       48
	MOVWF       POSTINC1+0 
;reg des.c,131 :: 		cod[i] = '0';
	MOVF        R1, 0 
	ADDWF       _cod+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _cod+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       48
	MOVWF       POSTINC1+0 
;reg des.c,128 :: 		for(i=0; i < 6; i++)
	INCF        R1, 1 
;reg des.c,132 :: 		}
	GOTO        L_LimparSenha230
L_LimparSenha231:
;reg des.c,133 :: 		}
L_end_LimparSenha2:
	RETURN      0
; end of _LimparSenha2

_LimparCanal:

;reg des.c,135 :: 		void LimparCanal()
;reg des.c,137 :: 		char i=0;
	CLRF        LimparCanal_i_L0+0 
;reg des.c,138 :: 		for(i=0; i < 2; i++)
	CLRF        LimparCanal_i_L0+0 
L_LimparCanal33:
	MOVLW       2
	SUBWF       LimparCanal_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LimparCanal34
;reg des.c,140 :: 		can[i] = '0';
	MOVF        LimparCanal_i_L0+0, 0 
	ADDWF       _can+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _can+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       48
	MOVWF       POSTINC1+0 
;reg des.c,141 :: 		ecan[i] = '0';
	MOVF        LimparCanal_i_L0+0, 0 
	ADDWF       _ecan+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _ecan+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       48
	MOVWF       POSTINC1+0 
;reg des.c,138 :: 		for(i=0; i < 2; i++)
	INCF        LimparCanal_i_L0+0, 1 
;reg des.c,142 :: 		}
	GOTO        L_LimparCanal33
L_LimparCanal34:
;reg des.c,143 :: 		}
L_end_LimparCanal:
	RETURN      0
; end of _LimparCanal

_ResetEeprom:

;reg des.c,145 :: 		void ResetEeprom()
;reg des.c,147 :: 		char i=0;
	CLRF        ResetEeprom_i_L0+0 
;reg des.c,148 :: 		Lcd_Out(1, 2, " RESETANDO...");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr11_reg_32des+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr11_reg_32des+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,149 :: 		for (i = 0; i < 255; i++)
	CLRF        ResetEeprom_i_L0+0 
L_ResetEeprom36:
	MOVLW       255
	SUBWF       ResetEeprom_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ResetEeprom37
;reg des.c,151 :: 		Eeprom_Write(i , 0xFF);
	MOVF        ResetEeprom_i_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       255
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;reg des.c,152 :: 		Delay_ms(25);
	MOVLW       203
	MOVWF       R12, 0
	MOVLW       235
	MOVWF       R13, 0
L_ResetEeprom39:
	DECFSZ      R13, 1, 1
	BRA         L_ResetEeprom39
	DECFSZ      R12, 1, 1
	BRA         L_ResetEeprom39
;reg des.c,149 :: 		for (i = 0; i < 255; i++)
	INCF        ResetEeprom_i_L0+0, 1 
;reg des.c,153 :: 		}
	GOTO        L_ResetEeprom36
L_ResetEeprom37:
;reg des.c,154 :: 		Lcd_Out(1, 2, "   RESET OK   ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr12_reg_32des+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr12_reg_32des+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,155 :: 		Lcd_Out(2, 2, "REMOVA O JUMPER");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr13_reg_32des+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr13_reg_32des+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,156 :: 		volta1:
___ResetEeprom_volta1:
;reg des.c,157 :: 		if (PORTD.F1 == 1){return;}
	BTFSS       PORTD+0, 1 
	GOTO        L_ResetEeprom40
	GOTO        L_end_ResetEeprom
L_ResetEeprom40:
;reg des.c,160 :: 		goto volta1;
	GOTO        ___ResetEeprom_volta1
;reg des.c,162 :: 		}
L_end_ResetEeprom:
	RETURN      0
; end of _ResetEeprom

_main:

;reg des.c,173 :: 		void main(void)
;reg des.c,178 :: 		end=2; caminho=0;
	MOVLW       2
	MOVWF       _end+0 
	MOVLW       0
	MOVWF       _end+1 
	CLRF        _caminho+0 
	CLRF        _caminho+1 
;reg des.c,179 :: 		ADCON1 = 0x0F;                  // Configura os pinos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;reg des.c,180 :: 		CMCON  = 0x07;                  // Desliga os comparadores
	MOVLW       7
	MOVWF       CMCON+0 
;reg des.c,181 :: 		TRISA=0b00000000;
	CLRF        TRISA+0 
;reg des.c,182 :: 		PORTA=0b11111111;                        // Inicializa o PORTA em zero
	MOVLW       255
	MOVWF       PORTA+0 
;reg des.c,183 :: 		TRISB=0b00000000;
	CLRF        TRISB+0 
;reg des.c,184 :: 		PORTB=0b00111111;
	MOVLW       63
	MOVWF       PORTB+0 
;reg des.c,185 :: 		TRISC=0b00000000;
	CLRF        TRISC+0 
;reg des.c,186 :: 		PORTC=0;
	CLRF        PORTC+0 
;reg des.c,187 :: 		TRISD=0b00000011;
	MOVLW       3
	MOVWF       TRISD+0 
;reg des.c,188 :: 		PORTD=0;
	CLRF        PORTD+0 
;reg des.c,189 :: 		TRISE=0b000;
	CLRF        TRISE+0 
;reg des.c,190 :: 		PORTE=0b111;
	MOVLW       7
	MOVWF       PORTE+0 
;reg des.c,192 :: 		Keypad_Init();
	CALL        _Keypad_Init+0, 0
;reg des.c,193 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;reg des.c,194 :: 		if ( PORTD.F1 == 0)
	BTFSC       PORTD+0, 1 
	GOTO        L_main42
;reg des.c,196 :: 		ResetEeprom();
	CALL        _ResetEeprom+0, 0
;reg des.c,197 :: 		}
L_main42:
;reg des.c,198 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;reg des.c,199 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;reg des.c,201 :: 		inicio:               //////////////////////////// ROTINA INICIAL  ////////////////////////////////
___main_inicio:
;reg des.c,202 :: 		caminho =0;
	CLRF        _caminho+0 
	CLRF        _caminho+1 
;reg des.c,203 :: 		LimparSenha();
	CALL        _LimparSenha+0, 0
;reg des.c,204 :: 		LerCanalDaEeprom();
	CALL        _LerCanalDaEeprom+0, 0
;reg des.c,205 :: 		if(can[0] == 0xFF && can[1] == 0xFF)
	MOVFF       _can+0, FSR0L+0
	MOVFF       _can+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_main45
	MOVLW       1
	ADDWF       _can+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _can+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_main45
L__main342:
;reg des.c,207 :: 		goto rotina1;
	GOTO        ___main_rotina1
;reg des.c,208 :: 		}
L_main45:
;reg des.c,210 :: 		while(1)
L_main46:
;reg des.c,213 :: 		kp = Keypad_Key_Click();
	CALL        _Keypad_Key_Click+0, 0
	MOVF        R0, 0 
	MOVWF       _kp+0 
;reg des.c,215 :: 		if(kp)
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main48
;reg des.c,217 :: 		if(kp % 4 == 0)
	MOVLW       3
	ANDWF       _kp+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main49
;reg des.c,220 :: 		}
	GOTO        L_main50
L_main49:
;reg des.c,221 :: 		else if(kp == 13) //Limpar
	MOVF        _kp+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_main51
;reg des.c,223 :: 		LimparSenha();
	CALL        _LimparSenha+0, 0
;reg des.c,224 :: 		cliques = 0;
	CLRF        _cliques+0 
;reg des.c,225 :: 		}
	GOTO        L_main52
L_main51:
;reg des.c,226 :: 		else if(kp == 15) //Enter
	MOVF        _kp+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_main53
;reg des.c,228 :: 		cliques = 0; end=2; fs =0; c=0;
	CLRF        _cliques+0 
	MOVLW       2
	MOVWF       _end+0 
	MOVLW       0
	MOVWF       _end+1 
	CLRF        _fs+0 
	CLRF        main_c_L0+0 
;reg des.c,230 :: 		if(senha[0]==57 && senha[1] == 57 && senha[2]  == 57 && senha[3] == 57 &&senha[4] ==57 && senha[5] == 57)  // verifica se senha é 999999 (cadastra/edita senhas de todos os canais)
	MOVFF       _senha+0, FSR0L+0
	MOVFF       _senha+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       57
	BTFSS       STATUS+0, 2 
	GOTO        L_main56
	MOVLW       1
	ADDWF       _senha+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       57
	BTFSS       STATUS+0, 2 
	GOTO        L_main56
	MOVLW       2
	ADDWF       _senha+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       57
	BTFSS       STATUS+0, 2 
	GOTO        L_main56
	MOVLW       3
	ADDWF       _senha+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       57
	BTFSS       STATUS+0, 2 
	GOTO        L_main56
	MOVLW       4
	ADDWF       _senha+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       57
	BTFSS       STATUS+0, 2 
	GOTO        L_main56
	MOVLW       5
	ADDWF       _senha+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       57
	BTFSS       STATUS+0, 2 
	GOTO        L_main56
L__main341:
;reg des.c,232 :: 		caminho=1;
	MOVLW       1
	MOVWF       _caminho+0 
	MOVLW       0
	MOVWF       _caminho+1 
;reg des.c,233 :: 		goto rotina4;
	GOTO        ___main_rotina4
;reg des.c,234 :: 		}
L_main56:
;reg des.c,235 :: 		if(senha[0]==57 && senha[1] == 57 && senha[2]  == 57 && senha[3] == 57 &&senha[4] ==57 && senha[5] == 49)  // verifica se senha é 999991 (cadastra/edita senha de canal especifico)
	MOVFF       _senha+0, FSR0L+0
	MOVFF       _senha+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       57
	BTFSS       STATUS+0, 2 
	GOTO        L_main59
	MOVLW       1
	ADDWF       _senha+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       57
	BTFSS       STATUS+0, 2 
	GOTO        L_main59
	MOVLW       2
	ADDWF       _senha+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       57
	BTFSS       STATUS+0, 2 
	GOTO        L_main59
	MOVLW       3
	ADDWF       _senha+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       57
	BTFSS       STATUS+0, 2 
	GOTO        L_main59
	MOVLW       4
	ADDWF       _senha+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       57
	BTFSS       STATUS+0, 2 
	GOTO        L_main59
	MOVLW       5
	ADDWF       _senha+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L_main59
L__main340:
;reg des.c,237 :: 		caminho=2;
	MOVLW       2
	MOVWF       _caminho+0 
	MOVLW       0
	MOVWF       _caminho+1 
;reg des.c,238 :: 		goto rotina4;
	GOTO        ___main_rotina4
;reg des.c,239 :: 		}
L_main59:
;reg des.c,240 :: 		if(senha[0]==57 && senha[1] == 57 && senha[2]  == 57 && senha[3] == 57 &&senha[4] ==57 && senha[5] == 50)  // verifica se senha é 999992  (cadastra/edita senha de administrador)
	MOVFF       _senha+0, FSR0L+0
	MOVFF       _senha+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       57
	BTFSS       STATUS+0, 2 
	GOTO        L_main62
	MOVLW       1
	ADDWF       _senha+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       57
	BTFSS       STATUS+0, 2 
	GOTO        L_main62
	MOVLW       2
	ADDWF       _senha+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       57
	BTFSS       STATUS+0, 2 
	GOTO        L_main62
	MOVLW       3
	ADDWF       _senha+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       57
	BTFSS       STATUS+0, 2 
	GOTO        L_main62
	MOVLW       4
	ADDWF       _senha+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       57
	BTFSS       STATUS+0, 2 
	GOTO        L_main62
	MOVLW       5
	ADDWF       _senha+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L_main62
L__main339:
;reg des.c,242 :: 		caminho=3;
	MOVLW       3
	MOVWF       _caminho+0 
	MOVLW       0
	MOVWF       _caminho+1 
;reg des.c,243 :: 		goto rotina4;
	GOTO        ___main_rotina4
;reg des.c,244 :: 		}
L_main62:
;reg des.c,245 :: 		LerCanalDaEeprom();
	CALL        _LerCanalDaEeprom+0, 0
;reg des.c,246 :: 		for (c=0; c <= caca; c++)
	CLRF        main_c_L0+0 
L_main63:
	MOVLW       128
	XORWF       _caca+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main355
	MOVF        main_c_L0+0, 0 
	SUBWF       _caca+0, 0 
L__main355:
	BTFSS       STATUS+0, 0 
	GOTO        L_main64
;reg des.c,249 :: 		if(CompararSenha()) //Sucesso
	CALL        _CompararSenha+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main66
;reg des.c,251 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;reg des.c,252 :: 		Lcd_Out(1,6,"SENHA OK"  );
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr14_reg_32des+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr14_reg_32des+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,253 :: 		if (end == 2 ){fs=1;PORTA=0b00000000; PORTB=0b00000000; PORTE=0b00000000; Delay_ms(1500);PORTA =0b00111111; PORTB =0b00111111; PORTE=0b11111111;}
	MOVLW       0
	XORWF       _end+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main356
	MOVLW       2
	XORWF       _end+0, 0 
L__main356:
	BTFSS       STATUS+0, 2 
	GOTO        L_main67
	MOVLW       1
	MOVWF       _fs+0 
	CLRF        PORTA+0 
	CLRF        PORTB+0 
	CLRF        PORTE+0 
	MOVLW       48
	MOVWF       R11, 0
	MOVLW       144
	MOVWF       R12, 0
	MOVLW       49
	MOVWF       R13, 0
L_main68:
	DECFSZ      R13, 1, 1
	BRA         L_main68
	DECFSZ      R12, 1, 1
	BRA         L_main68
	DECFSZ      R11, 1, 1
	BRA         L_main68
	MOVLW       63
	MOVWF       PORTA+0 
	MOVLW       63
	MOVWF       PORTB+0 
	MOVLW       255
	MOVWF       PORTE+0 
L_main67:
;reg des.c,254 :: 		if (end == 8 ){fs=1;PORTA.F0 = 0;Delay_ms(1500);PORTA.F0 = 1;}
	MOVLW       0
	XORWF       _end+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main357
	MOVLW       8
	XORWF       _end+0, 0 
L__main357:
	BTFSS       STATUS+0, 2 
	GOTO        L_main69
	MOVLW       1
	MOVWF       _fs+0 
	BCF         PORTA+0, 0 
	MOVLW       48
	MOVWF       R11, 0
	MOVLW       144
	MOVWF       R12, 0
	MOVLW       49
	MOVWF       R13, 0
L_main70:
	DECFSZ      R13, 1, 1
	BRA         L_main70
	DECFSZ      R12, 1, 1
	BRA         L_main70
	DECFSZ      R11, 1, 1
	BRA         L_main70
	BSF         PORTA+0, 0 
L_main69:
;reg des.c,255 :: 		if (end == 14){fs=1;PORTA.F1 = 0;Delay_ms(1500);PORTA.F1 = 1;}
	MOVLW       0
	XORWF       _end+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main358
	MOVLW       14
	XORWF       _end+0, 0 
L__main358:
	BTFSS       STATUS+0, 2 
	GOTO        L_main71
	MOVLW       1
	MOVWF       _fs+0 
	BCF         PORTA+0, 1 
	MOVLW       48
	MOVWF       R11, 0
	MOVLW       144
	MOVWF       R12, 0
	MOVLW       49
	MOVWF       R13, 0
L_main72:
	DECFSZ      R13, 1, 1
	BRA         L_main72
	DECFSZ      R12, 1, 1
	BRA         L_main72
	DECFSZ      R11, 1, 1
	BRA         L_main72
	BSF         PORTA+0, 1 
L_main71:
;reg des.c,256 :: 		if (end == 20){fs=1;PORTA.F2 = 0;Delay_ms(1500);PORTA.F2 = 1;}
	MOVLW       0
	XORWF       _end+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main359
	MOVLW       20
	XORWF       _end+0, 0 
L__main359:
	BTFSS       STATUS+0, 2 
	GOTO        L_main73
	MOVLW       1
	MOVWF       _fs+0 
	BCF         PORTA+0, 2 
	MOVLW       48
	MOVWF       R11, 0
	MOVLW       144
	MOVWF       R12, 0
	MOVLW       49
	MOVWF       R13, 0
L_main74:
	DECFSZ      R13, 1, 1
	BRA         L_main74
	DECFSZ      R12, 1, 1
	BRA         L_main74
	DECFSZ      R11, 1, 1
	BRA         L_main74
	BSF         PORTA+0, 2 
L_main73:
;reg des.c,257 :: 		if (end == 26){fs=1;PORTA.F3 = 0;Delay_ms(1500);PORTA.F3 = 1;}
	MOVLW       0
	XORWF       _end+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main360
	MOVLW       26
	XORWF       _end+0, 0 
L__main360:
	BTFSS       STATUS+0, 2 
	GOTO        L_main75
	MOVLW       1
	MOVWF       _fs+0 
	BCF         PORTA+0, 3 
	MOVLW       48
	MOVWF       R11, 0
	MOVLW       144
	MOVWF       R12, 0
	MOVLW       49
	MOVWF       R13, 0
L_main76:
	DECFSZ      R13, 1, 1
	BRA         L_main76
	DECFSZ      R12, 1, 1
	BRA         L_main76
	DECFSZ      R11, 1, 1
	BRA         L_main76
	BSF         PORTA+0, 3 
L_main75:
;reg des.c,258 :: 		if (end == 32){fs=1;PORTA.F4 = 0;Delay_ms(1500);PORTA.F4 = 1;}
	MOVLW       0
	XORWF       _end+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main361
	MOVLW       32
	XORWF       _end+0, 0 
L__main361:
	BTFSS       STATUS+0, 2 
	GOTO        L_main77
	MOVLW       1
	MOVWF       _fs+0 
	BCF         PORTA+0, 4 
	MOVLW       48
	MOVWF       R11, 0
	MOVLW       144
	MOVWF       R12, 0
	MOVLW       49
	MOVWF       R13, 0
L_main78:
	DECFSZ      R13, 1, 1
	BRA         L_main78
	DECFSZ      R12, 1, 1
	BRA         L_main78
	DECFSZ      R11, 1, 1
	BRA         L_main78
	BSF         PORTA+0, 4 
L_main77:
;reg des.c,259 :: 		if (end == 38){fs=1;PORTA.F5 = 0;Delay_ms(1500);PORTA.F5 = 1;}
	MOVLW       0
	XORWF       _end+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main362
	MOVLW       38
	XORWF       _end+0, 0 
L__main362:
	BTFSS       STATUS+0, 2 
	GOTO        L_main79
	MOVLW       1
	MOVWF       _fs+0 
	BCF         PORTA+0, 5 
	MOVLW       48
	MOVWF       R11, 0
	MOVLW       144
	MOVWF       R12, 0
	MOVLW       49
	MOVWF       R13, 0
L_main80:
	DECFSZ      R13, 1, 1
	BRA         L_main80
	DECFSZ      R12, 1, 1
	BRA         L_main80
	DECFSZ      R11, 1, 1
	BRA         L_main80
	BSF         PORTA+0, 5 
L_main79:
;reg des.c,260 :: 		if (end == 44){fs=1;PORTB.F0 = 0;Delay_ms(1500);PORTB.F0 = 1;}
	MOVLW       0
	XORWF       _end+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main363
	MOVLW       44
	XORWF       _end+0, 0 
L__main363:
	BTFSS       STATUS+0, 2 
	GOTO        L_main81
	MOVLW       1
	MOVWF       _fs+0 
	BCF         PORTB+0, 0 
	MOVLW       48
	MOVWF       R11, 0
	MOVLW       144
	MOVWF       R12, 0
	MOVLW       49
	MOVWF       R13, 0
L_main82:
	DECFSZ      R13, 1, 1
	BRA         L_main82
	DECFSZ      R12, 1, 1
	BRA         L_main82
	DECFSZ      R11, 1, 1
	BRA         L_main82
	BSF         PORTB+0, 0 
L_main81:
;reg des.c,261 :: 		if (end == 50){fs=1;PORTB.F1 = 0;Delay_ms(1500);PORTB.F1 = 1;}
	MOVLW       0
	XORWF       _end+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main364
	MOVLW       50
	XORWF       _end+0, 0 
L__main364:
	BTFSS       STATUS+0, 2 
	GOTO        L_main83
	MOVLW       1
	MOVWF       _fs+0 
	BCF         PORTB+0, 1 
	MOVLW       48
	MOVWF       R11, 0
	MOVLW       144
	MOVWF       R12, 0
	MOVLW       49
	MOVWF       R13, 0
L_main84:
	DECFSZ      R13, 1, 1
	BRA         L_main84
	DECFSZ      R12, 1, 1
	BRA         L_main84
	DECFSZ      R11, 1, 1
	BRA         L_main84
	BSF         PORTB+0, 1 
L_main83:
;reg des.c,262 :: 		if (end == 56){fs=1;PORTB.F2 = 0;Delay_ms(1500);PORTB.F2 = 1;}
	MOVLW       0
	XORWF       _end+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main365
	MOVLW       56
	XORWF       _end+0, 0 
L__main365:
	BTFSS       STATUS+0, 2 
	GOTO        L_main85
	MOVLW       1
	MOVWF       _fs+0 
	BCF         PORTB+0, 2 
	MOVLW       48
	MOVWF       R11, 0
	MOVLW       144
	MOVWF       R12, 0
	MOVLW       49
	MOVWF       R13, 0
L_main86:
	DECFSZ      R13, 1, 1
	BRA         L_main86
	DECFSZ      R12, 1, 1
	BRA         L_main86
	DECFSZ      R11, 1, 1
	BRA         L_main86
	BSF         PORTB+0, 2 
L_main85:
;reg des.c,263 :: 		if (end == 62){fs=1;PORTB.F3 = 0;Delay_ms(1500);PORTB.F3 = 1;}
	MOVLW       0
	XORWF       _end+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main366
	MOVLW       62
	XORWF       _end+0, 0 
L__main366:
	BTFSS       STATUS+0, 2 
	GOTO        L_main87
	MOVLW       1
	MOVWF       _fs+0 
	BCF         PORTB+0, 3 
	MOVLW       48
	MOVWF       R11, 0
	MOVLW       144
	MOVWF       R12, 0
	MOVLW       49
	MOVWF       R13, 0
L_main88:
	DECFSZ      R13, 1, 1
	BRA         L_main88
	DECFSZ      R12, 1, 1
	BRA         L_main88
	DECFSZ      R11, 1, 1
	BRA         L_main88
	BSF         PORTB+0, 3 
L_main87:
;reg des.c,264 :: 		if (end == 68){fs=1;PORTB.F4 = 0;Delay_ms(1500);PORTB.F4 = 1;}
	MOVLW       0
	XORWF       _end+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main367
	MOVLW       68
	XORWF       _end+0, 0 
L__main367:
	BTFSS       STATUS+0, 2 
	GOTO        L_main89
	MOVLW       1
	MOVWF       _fs+0 
	BCF         PORTB+0, 4 
	MOVLW       48
	MOVWF       R11, 0
	MOVLW       144
	MOVWF       R12, 0
	MOVLW       49
	MOVWF       R13, 0
L_main90:
	DECFSZ      R13, 1, 1
	BRA         L_main90
	DECFSZ      R12, 1, 1
	BRA         L_main90
	DECFSZ      R11, 1, 1
	BRA         L_main90
	BSF         PORTB+0, 4 
L_main89:
;reg des.c,265 :: 		if (end == 74){fs=1;PORTB.F5 = 0;Delay_ms(1500);PORTB.F5 = 1;}
	MOVLW       0
	XORWF       _end+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main368
	MOVLW       74
	XORWF       _end+0, 0 
L__main368:
	BTFSS       STATUS+0, 2 
	GOTO        L_main91
	MOVLW       1
	MOVWF       _fs+0 
	BCF         PORTB+0, 5 
	MOVLW       48
	MOVWF       R11, 0
	MOVLW       144
	MOVWF       R12, 0
	MOVLW       49
	MOVWF       R13, 0
L_main92:
	DECFSZ      R13, 1, 1
	BRA         L_main92
	DECFSZ      R12, 1, 1
	BRA         L_main92
	DECFSZ      R11, 1, 1
	BRA         L_main92
	BSF         PORTB+0, 5 
L_main91:
;reg des.c,266 :: 		if (end == 80){fs=1;PORTE.F0 = 0;Delay_ms(1500);PORTE.F0 = 1;}
	MOVLW       0
	XORWF       _end+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main369
	MOVLW       80
	XORWF       _end+0, 0 
L__main369:
	BTFSS       STATUS+0, 2 
	GOTO        L_main93
	MOVLW       1
	MOVWF       _fs+0 
	BCF         PORTE+0, 0 
	MOVLW       48
	MOVWF       R11, 0
	MOVLW       144
	MOVWF       R12, 0
	MOVLW       49
	MOVWF       R13, 0
L_main94:
	DECFSZ      R13, 1, 1
	BRA         L_main94
	DECFSZ      R12, 1, 1
	BRA         L_main94
	DECFSZ      R11, 1, 1
	BRA         L_main94
	BSF         PORTE+0, 0 
L_main93:
;reg des.c,267 :: 		if (end == 86){fs=1;PORTE.F1 = 0;Delay_ms(1500);PORTE.F1 = 1;}
	MOVLW       0
	XORWF       _end+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main370
	MOVLW       86
	XORWF       _end+0, 0 
L__main370:
	BTFSS       STATUS+0, 2 
	GOTO        L_main95
	MOVLW       1
	MOVWF       _fs+0 
	BCF         PORTE+0, 1 
	MOVLW       48
	MOVWF       R11, 0
	MOVLW       144
	MOVWF       R12, 0
	MOVLW       49
	MOVWF       R13, 0
L_main96:
	DECFSZ      R13, 1, 1
	BRA         L_main96
	DECFSZ      R12, 1, 1
	BRA         L_main96
	DECFSZ      R11, 1, 1
	BRA         L_main96
	BSF         PORTE+0, 1 
L_main95:
;reg des.c,268 :: 		if (end == 92){fs=1;PORTE.F2 = 0;Delay_ms(1500);PORTE.F2 = 1;}
	MOVLW       0
	XORWF       _end+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main371
	MOVLW       92
	XORWF       _end+0, 0 
L__main371:
	BTFSS       STATUS+0, 2 
	GOTO        L_main97
	MOVLW       1
	MOVWF       _fs+0 
	BCF         PORTE+0, 2 
	MOVLW       48
	MOVWF       R11, 0
	MOVLW       144
	MOVWF       R12, 0
	MOVLW       49
	MOVWF       R13, 0
L_main98:
	DECFSZ      R13, 1, 1
	BRA         L_main98
	DECFSZ      R12, 1, 1
	BRA         L_main98
	DECFSZ      R11, 1, 1
	BRA         L_main98
	BSF         PORTE+0, 2 
L_main97:
;reg des.c,269 :: 		Delay_ms(500);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       219
	MOVWF       R12, 0
	MOVLW       100
	MOVWF       R13, 0
L_main99:
	DECFSZ      R13, 1, 1
	BRA         L_main99
	DECFSZ      R12, 1, 1
	BRA         L_main99
	DECFSZ      R11, 1, 1
	BRA         L_main99
	NOP
;reg des.c,270 :: 		LimparSenha();
	CALL        _LimparSenha+0, 0
;reg des.c,271 :: 		}
L_main66:
;reg des.c,273 :: 		end=end+6;
	MOVLW       6
	ADDWF       _end+0, 1 
	MOVLW       0
	ADDWFC      _end+1, 1 
;reg des.c,246 :: 		for (c=0; c <= caca; c++)
	INCF        main_c_L0+0, 1 
;reg des.c,275 :: 		}
	GOTO        L_main63
L_main64:
;reg des.c,276 :: 		if ( fs == 0 )
	MOVF        _fs+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main100
;reg des.c,278 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;reg des.c,279 :: 		Lcd_Out(1,3,"SENHA ERRADA");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr15_reg_32des+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr15_reg_32des+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,280 :: 		LimparSenha();
	CALL        _LimparSenha+0, 0
;reg des.c,282 :: 		}
L_main100:
;reg des.c,284 :: 		Delay_ms(500);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       219
	MOVWF       R12, 0
	MOVLW       100
	MOVWF       R13, 0
L_main101:
	DECFSZ      R13, 1, 1
	BRA         L_main101
	DECFSZ      R12, 1, 1
	BRA         L_main101
	DECFSZ      R11, 1, 1
	BRA         L_main101
	NOP
;reg des.c,286 :: 		}
	GOTO        L_main102
L_main53:
;reg des.c,289 :: 		switch(kp)
	GOTO        L_main103
;reg des.c,291 :: 		case 1: kp = 49; ocu=42; break; //1
L_main105:
	MOVLW       49
	MOVWF       _kp+0 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main104
;reg des.c,292 :: 		case 2: kp = 50; ocu=42;break; //2
L_main106:
	MOVLW       50
	MOVWF       _kp+0 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main104
;reg des.c,293 :: 		case 3: kp = 51; ocu=42;break; //3
L_main107:
	MOVLW       51
	MOVWF       _kp+0 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main104
;reg des.c,294 :: 		case 5: kp = 52; ocu=42;break; //4
L_main108:
	MOVLW       52
	MOVWF       _kp+0 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main104
;reg des.c,295 :: 		case 6: kp = 53; ocu=42;break; //5
L_main109:
	MOVLW       53
	MOVWF       _kp+0 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main104
;reg des.c,296 :: 		case 7: kp = 54; ocu=42;break; //6
L_main110:
	MOVLW       54
	MOVWF       _kp+0 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main104
;reg des.c,297 :: 		case 9: kp = 55; ocu=42;break; //7
L_main111:
	MOVLW       55
	MOVWF       _kp+0 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main104
;reg des.c,298 :: 		case 10: kp = 56; ocu=42;break;//8
L_main112:
	MOVLW       56
	MOVWF       _kp+0 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main104
;reg des.c,299 :: 		case 11: kp = 57; ocu=42;break;//9
L_main113:
	MOVLW       57
	MOVWF       _kp+0 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main104
;reg des.c,300 :: 		case 14: kp = 48; ocu=42;break;//0
L_main114:
	MOVLW       48
	MOVWF       _kp+0 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main104
;reg des.c,301 :: 		}
L_main103:
	MOVF        _kp+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main105
	MOVF        _kp+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main106
	MOVF        _kp+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main107
	MOVF        _kp+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_main108
	MOVF        _kp+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_main109
	MOVF        _kp+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_main110
	MOVF        _kp+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_main111
	MOVF        _kp+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_main112
	MOVF        _kp+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_main113
	MOVF        _kp+0, 0 
	XORLW       14
	BTFSC       STATUS+0, 2 
	GOTO        L_main114
L_main104:
;reg des.c,303 :: 		if(cliques < 6)
	MOVLW       6
	SUBWF       _cliques+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main115
;reg des.c,306 :: 		for(c=0; c < 6; c++)
	CLRF        main_c_L0+0 
L_main116:
	MOVLW       6
	SUBWF       main_c_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main117
;reg des.c,307 :: 		cod[c] = cod[c+1];
	MOVF        main_c_L0+0, 0 
	ADDWF       _cod+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _cod+1, 0 
	MOVWF       FSR1L+1 
	MOVF        main_c_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	ADDWF       _cod+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      _cod+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,306 :: 		for(c=0; c < 6; c++)
	INCF        main_c_L0+0, 1 
;reg des.c,307 :: 		cod[c] = cod[c+1];
	GOTO        L_main116
L_main117:
;reg des.c,308 :: 		cod[5] = ocu;
	MOVLW       5
	ADDWF       _cod+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _cod+1, 0 
	MOVWF       FSR1L+1 
	MOVF        _ocu+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,309 :: 		for(i=0; i < 6; i++)
	CLRF        main_i_L0+0 
L_main119:
	MOVLW       6
	SUBWF       main_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main120
;reg des.c,310 :: 		senha[i] = senha[i+1];
	MOVF        main_i_L0+0, 0 
	ADDWF       _senha+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FSR1L+1 
	MOVF        main_i_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	ADDWF       _senha+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      _senha+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,309 :: 		for(i=0; i < 6; i++)
	INCF        main_i_L0+0, 1 
;reg des.c,310 :: 		senha[i] = senha[i+1];
	GOTO        L_main119
L_main120:
;reg des.c,311 :: 		senha[5] = kp;
	MOVLW       5
	ADDWF       _senha+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FSR1L+1 
	MOVF        _kp+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,313 :: 		}
L_main115:
;reg des.c,315 :: 		}
L_main102:
L_main52:
L_main50:
;reg des.c,316 :: 		}
L_main48:
;reg des.c,317 :: 		Lcd_Out(1,2, "DIGITE A SENHA");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr16_reg_32des+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr16_reg_32des+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,318 :: 		Lcd_Out(2,6, cod);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _cod+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _cod+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,319 :: 		Delay_ms(10);
	MOVLW       82
	MOVWF       R12, 0
	MOVLW       41
	MOVWF       R13, 0
L_main122:
	DECFSZ      R13, 1, 1
	BRA         L_main122
	DECFSZ      R12, 1, 1
	BRA         L_main122
	NOP
	NOP
;reg des.c,320 :: 		}    // WHILE ROTINA INICIAL
	GOTO        L_main46
;reg des.c,326 :: 		rotina1:                                       //////////////////////////// ROTINA 1  GRAVA QTY CANAL ////////////////////////////////
___main_rotina1:
;reg des.c,327 :: 		LimparCanal();
	CALL        _LimparCanal+0, 0
;reg des.c,329 :: 		while(1)
L_main123:
;reg des.c,332 :: 		kp1 = Keypad_Key_Click();
	CALL        _Keypad_Key_Click+0, 0
	MOVF        R0, 0 
	MOVWF       _kp1+0 
	MOVLW       0
	MOVWF       _kp1+1 
;reg des.c,334 :: 		if(kp1)
	MOVF        _kp1+0, 0 
	IORWF       _kp1+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main125
;reg des.c,336 :: 		if(kp1 % 4 == 0)
	MOVLW       4
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _kp1+0, 0 
	MOVWF       R0 
	MOVF        _kp1+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main372
	MOVLW       0
	XORWF       R0, 0 
L__main372:
	BTFSS       STATUS+0, 2 
	GOTO        L_main126
;reg des.c,339 :: 		}
	GOTO        L_main127
L_main126:
;reg des.c,340 :: 		else if(kp1 == 13) //Limpar
	MOVLW       0
	XORWF       _kp1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main373
	MOVLW       13
	XORWF       _kp1+0, 0 
L__main373:
	BTFSS       STATUS+0, 2 
	GOTO        L_main128
;reg des.c,342 :: 		LimparCanal();
	CALL        _LimparCanal+0, 0
;reg des.c,343 :: 		cliques = 0;
	CLRF        _cliques+0 
;reg des.c,344 :: 		}
	GOTO        L_main129
L_main128:
;reg des.c,345 :: 		else if(kp1 == 15) //Enter
	MOVLW       0
	XORWF       _kp1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main374
	MOVLW       15
	XORWF       _kp1+0, 0 
L__main374:
	BTFSS       STATUS+0, 2 
	GOTO        L_main130
;reg des.c,347 :: 		cliques = 0; end=2;fs =0;cs =0;
	CLRF        _cliques+0 
	MOVLW       2
	MOVWF       _end+0 
	MOVLW       0
	MOVWF       _end+1 
	CLRF        _fs+0 
	CLRF        _cs+0 
;reg des.c,348 :: 		if(can[0]==48 || can[0]==49 && can[1] <= 53)   //verifica se canal digitado é menor que 11
	MOVFF       _can+0, FSR0L+0
	MOVFF       _can+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L__main337
	MOVFF       _can+0, FSR0L+0
	MOVFF       _can+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L__main338
	MOVLW       1
	ADDWF       _can+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _can+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	SUBLW       53
	BTFSS       STATUS+0, 0 
	GOTO        L__main338
	GOTO        L__main337
L__main338:
	GOTO        L_main135
L__main337:
;reg des.c,350 :: 		GravarCanalNaEeprom();
	CALL        _GravarCanalNaEeprom+0, 0
;reg des.c,351 :: 		Delay_ms(500);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       219
	MOVWF       R12, 0
	MOVLW       100
	MOVWF       R13, 0
L_main136:
	DECFSZ      R13, 1, 1
	BRA         L_main136
	DECFSZ      R12, 1, 1
	BRA         L_main136
	DECFSZ      R11, 1, 1
	BRA         L_main136
	NOP
;reg des.c,352 :: 		goto rotina2;
	GOTO        ___main_rotina2
;reg des.c,354 :: 		}
L_main135:
;reg des.c,357 :: 		Lcd_Out(1,1, "CANAL NAO SUPORT");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr17_reg_32des+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr17_reg_32des+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,358 :: 		Delay_ms(500);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       219
	MOVWF       R12, 0
	MOVLW       100
	MOVWF       R13, 0
L_main138:
	DECFSZ      R13, 1, 1
	BRA         L_main138
	DECFSZ      R12, 1, 1
	BRA         L_main138
	DECFSZ      R11, 1, 1
	BRA         L_main138
	NOP
;reg des.c,359 :: 		LimparCanal();
	CALL        _LimparCanal+0, 0
;reg des.c,360 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;reg des.c,361 :: 		goto rotina1;
	GOTO        ___main_rotina1
;reg des.c,364 :: 		Delay_ms(500);
L_main139:
	DECFSZ      R13, 1, 1
	BRA         L_main139
	DECFSZ      R12, 1, 1
	BRA         L_main139
	DECFSZ      R11, 1, 1
	BRA         L_main139
	NOP
;reg des.c,366 :: 		}
	GOTO        L_main140
L_main130:
;reg des.c,369 :: 		switch(kp1)
	GOTO        L_main141
;reg des.c,371 :: 		case 1: kp1 = 49; break; //1
L_main143:
	MOVLW       49
	MOVWF       _kp1+0 
	MOVLW       0
	MOVWF       _kp1+1 
	GOTO        L_main142
;reg des.c,372 :: 		case 2: kp1 = 50; break; //2
L_main144:
	MOVLW       50
	MOVWF       _kp1+0 
	MOVLW       0
	MOVWF       _kp1+1 
	GOTO        L_main142
;reg des.c,373 :: 		case 3: kp1 = 51; break; //3
L_main145:
	MOVLW       51
	MOVWF       _kp1+0 
	MOVLW       0
	MOVWF       _kp1+1 
	GOTO        L_main142
;reg des.c,374 :: 		case 5: kp1 = 52; break; //4
L_main146:
	MOVLW       52
	MOVWF       _kp1+0 
	MOVLW       0
	MOVWF       _kp1+1 
	GOTO        L_main142
;reg des.c,375 :: 		case 6: kp1 = 53; break; //5
L_main147:
	MOVLW       53
	MOVWF       _kp1+0 
	MOVLW       0
	MOVWF       _kp1+1 
	GOTO        L_main142
;reg des.c,376 :: 		case 7: kp1 = 54; break; //6
L_main148:
	MOVLW       54
	MOVWF       _kp1+0 
	MOVLW       0
	MOVWF       _kp1+1 
	GOTO        L_main142
;reg des.c,377 :: 		case 9: kp1 = 55; break; //7
L_main149:
	MOVLW       55
	MOVWF       _kp1+0 
	MOVLW       0
	MOVWF       _kp1+1 
	GOTO        L_main142
;reg des.c,378 :: 		case 10: kp1 = 56; break;//8
L_main150:
	MOVLW       56
	MOVWF       _kp1+0 
	MOVLW       0
	MOVWF       _kp1+1 
	GOTO        L_main142
;reg des.c,379 :: 		case 11: kp1 = 57; break;//9
L_main151:
	MOVLW       57
	MOVWF       _kp1+0 
	MOVLW       0
	MOVWF       _kp1+1 
	GOTO        L_main142
;reg des.c,380 :: 		case 14: kp1 = 48; break;//0
L_main152:
	MOVLW       48
	MOVWF       _kp1+0 
	MOVLW       0
	MOVWF       _kp1+1 
	GOTO        L_main142
;reg des.c,381 :: 		}
L_main141:
	MOVLW       0
	XORWF       _kp1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main375
	MOVLW       1
	XORWF       _kp1+0, 0 
L__main375:
	BTFSC       STATUS+0, 2 
	GOTO        L_main143
	MOVLW       0
	XORWF       _kp1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main376
	MOVLW       2
	XORWF       _kp1+0, 0 
L__main376:
	BTFSC       STATUS+0, 2 
	GOTO        L_main144
	MOVLW       0
	XORWF       _kp1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main377
	MOVLW       3
	XORWF       _kp1+0, 0 
L__main377:
	BTFSC       STATUS+0, 2 
	GOTO        L_main145
	MOVLW       0
	XORWF       _kp1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main378
	MOVLW       5
	XORWF       _kp1+0, 0 
L__main378:
	BTFSC       STATUS+0, 2 
	GOTO        L_main146
	MOVLW       0
	XORWF       _kp1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main379
	MOVLW       6
	XORWF       _kp1+0, 0 
L__main379:
	BTFSC       STATUS+0, 2 
	GOTO        L_main147
	MOVLW       0
	XORWF       _kp1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main380
	MOVLW       7
	XORWF       _kp1+0, 0 
L__main380:
	BTFSC       STATUS+0, 2 
	GOTO        L_main148
	MOVLW       0
	XORWF       _kp1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main381
	MOVLW       9
	XORWF       _kp1+0, 0 
L__main381:
	BTFSC       STATUS+0, 2 
	GOTO        L_main149
	MOVLW       0
	XORWF       _kp1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main382
	MOVLW       10
	XORWF       _kp1+0, 0 
L__main382:
	BTFSC       STATUS+0, 2 
	GOTO        L_main150
	MOVLW       0
	XORWF       _kp1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main383
	MOVLW       11
	XORWF       _kp1+0, 0 
L__main383:
	BTFSC       STATUS+0, 2 
	GOTO        L_main151
	MOVLW       0
	XORWF       _kp1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main384
	MOVLW       14
	XORWF       _kp1+0, 0 
L__main384:
	BTFSC       STATUS+0, 2 
	GOTO        L_main152
L_main142:
;reg des.c,383 :: 		if(cliques < 3)
	MOVLW       3
	SUBWF       _cliques+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main153
;reg des.c,386 :: 		for(i=0; i < 2; i++)
	CLRF        main_i_L0+0 
L_main154:
	MOVLW       2
	SUBWF       main_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main155
;reg des.c,387 :: 		can[i] = can[i+1];
	MOVF        main_i_L0+0, 0 
	ADDWF       _can+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _can+1, 0 
	MOVWF       FSR1L+1 
	MOVF        main_i_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	ADDWF       _can+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      _can+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,386 :: 		for(i=0; i < 2; i++)
	INCF        main_i_L0+0, 1 
;reg des.c,387 :: 		can[i] = can[i+1];
	GOTO        L_main154
L_main155:
;reg des.c,388 :: 		can[1] = kp1;
	MOVLW       1
	ADDWF       _can+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _can+1, 0 
	MOVWF       FSR1L+1 
	MOVF        _kp1+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,390 :: 		}
L_main153:
;reg des.c,392 :: 		}
L_main140:
L_main129:
L_main127:
;reg des.c,393 :: 		}
L_main125:
;reg des.c,394 :: 		Lcd_Out(1,2, "QUANTOS CANAIS?");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr18_reg_32des+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr18_reg_32des+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,395 :: 		Lcd_Out(2,8, can);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _can+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _can+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,396 :: 		Delay_ms(10);
	MOVLW       82
	MOVWF       R12, 0
	MOVLW       41
	MOVWF       R13, 0
L_main157:
	DECFSZ      R13, 1, 1
	BRA         L_main157
	DECFSZ      R12, 1, 1
	BRA         L_main157
	NOP
	NOP
;reg des.c,397 :: 		}    // WHILE ROTINA 1
	GOTO        L_main123
;reg des.c,402 :: 		rotina2:                //////////////////////////// ROTINA 2  ROTINA GRAVAÇÃO DA SENHA ADM /////////////////////////////
___main_rotina2:
;reg des.c,403 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;reg des.c,404 :: 		while(1)
L_main158:
;reg des.c,406 :: 		kp2 = Keypad_Key_Click();
	CALL        _Keypad_Key_Click+0, 0
	MOVF        R0, 0 
	MOVWF       _kp2+0 
	MOVLW       0
	MOVWF       _kp2+1 
;reg des.c,407 :: 		if(kp2)
	MOVF        _kp2+0, 0 
	IORWF       _kp2+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main160
;reg des.c,409 :: 		if(kp2 % 4 == 0)
	MOVLW       4
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _kp2+0, 0 
	MOVWF       R0 
	MOVF        _kp2+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main385
	MOVLW       0
	XORWF       R0, 0 
L__main385:
	BTFSS       STATUS+0, 2 
	GOTO        L_main161
;reg des.c,412 :: 		}
	GOTO        L_main162
L_main161:
;reg des.c,413 :: 		else if(kp2 == 13) //Limpar
	MOVLW       0
	XORWF       _kp2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main386
	MOVLW       13
	XORWF       _kp2+0, 0 
L__main386:
	BTFSS       STATUS+0, 2 
	GOTO        L_main163
;reg des.c,415 :: 		LimparSenha1();
	CALL        _LimparSenha1+0, 0
;reg des.c,416 :: 		cliques = 0;
	CLRF        _cliques+0 
;reg des.c,417 :: 		}
	GOTO        L_main164
L_main163:
;reg des.c,418 :: 		else if(kp2 == 15) //Enter
	MOVLW       0
	XORWF       _kp2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main387
	MOVLW       15
	XORWF       _kp2+0, 0 
L__main387:
	BTFSS       STATUS+0, 2 
	GOTO        L_main165
;reg des.c,420 :: 		cliques = 0; end=2;fs =0;c =0;
	CLRF        _cliques+0 
	MOVLW       2
	MOVWF       _end+0 
	MOVLW       0
	MOVWF       _end+1 
	CLRF        _fs+0 
	CLRF        main_c_L0+0 
;reg des.c,421 :: 		GravarSenhaNaEeprom();
	CALL        _GravarSenhaNaEeprom+0, 0
;reg des.c,422 :: 		Delay_ms(1000);
	MOVLW       32
	MOVWF       R11, 0
	MOVLW       181
	MOVWF       R12, 0
	MOVLW       203
	MOVWF       R13, 0
L_main166:
	DECFSZ      R13, 1, 1
	BRA         L_main166
	DECFSZ      R12, 1, 1
	BRA         L_main166
	DECFSZ      R11, 1, 1
	BRA         L_main166
;reg des.c,423 :: 		LimparSenha1();
	CALL        _LimparSenha1+0, 0
;reg des.c,424 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;reg des.c,425 :: 		goto inicio;
	GOTO        ___main_inicio
;reg des.c,427 :: 		}
L_main165:
;reg des.c,430 :: 		switch(kp2)
	GOTO        L_main168
;reg des.c,432 :: 		case 1: kp2 = 49; ocu=42; break; //1
L_main170:
	MOVLW       49
	MOVWF       _kp2+0 
	MOVLW       0
	MOVWF       _kp2+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main169
;reg des.c,433 :: 		case 2: kp2 = 50; ocu=42;break; //2
L_main171:
	MOVLW       50
	MOVWF       _kp2+0 
	MOVLW       0
	MOVWF       _kp2+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main169
;reg des.c,434 :: 		case 3: kp2 = 51; ocu=42;break; //3
L_main172:
	MOVLW       51
	MOVWF       _kp2+0 
	MOVLW       0
	MOVWF       _kp2+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main169
;reg des.c,435 :: 		case 5: kp2 = 52; ocu=42;break; //4
L_main173:
	MOVLW       52
	MOVWF       _kp2+0 
	MOVLW       0
	MOVWF       _kp2+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main169
;reg des.c,436 :: 		case 6: kp2 = 53; ocu=42;break; //5
L_main174:
	MOVLW       53
	MOVWF       _kp2+0 
	MOVLW       0
	MOVWF       _kp2+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main169
;reg des.c,437 :: 		case 7: kp2 = 54; ocu=42;break; //6
L_main175:
	MOVLW       54
	MOVWF       _kp2+0 
	MOVLW       0
	MOVWF       _kp2+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main169
;reg des.c,438 :: 		case 9: kp2 = 55; ocu=42;break; //7
L_main176:
	MOVLW       55
	MOVWF       _kp2+0 
	MOVLW       0
	MOVWF       _kp2+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main169
;reg des.c,439 :: 		case 10: kp2 = 56; ocu=42;break;//8
L_main177:
	MOVLW       56
	MOVWF       _kp2+0 
	MOVLW       0
	MOVWF       _kp2+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main169
;reg des.c,440 :: 		case 11: kp2 = 57; ocu=42;break;//9
L_main178:
	MOVLW       57
	MOVWF       _kp2+0 
	MOVLW       0
	MOVWF       _kp2+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main169
;reg des.c,441 :: 		case 14: kp2 = 48; ocu=42;break;//0
L_main179:
	MOVLW       48
	MOVWF       _kp2+0 
	MOVLW       0
	MOVWF       _kp2+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main169
;reg des.c,442 :: 		}
L_main168:
	MOVLW       0
	XORWF       _kp2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main388
	MOVLW       1
	XORWF       _kp2+0, 0 
L__main388:
	BTFSC       STATUS+0, 2 
	GOTO        L_main170
	MOVLW       0
	XORWF       _kp2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main389
	MOVLW       2
	XORWF       _kp2+0, 0 
L__main389:
	BTFSC       STATUS+0, 2 
	GOTO        L_main171
	MOVLW       0
	XORWF       _kp2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main390
	MOVLW       3
	XORWF       _kp2+0, 0 
L__main390:
	BTFSC       STATUS+0, 2 
	GOTO        L_main172
	MOVLW       0
	XORWF       _kp2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main391
	MOVLW       5
	XORWF       _kp2+0, 0 
L__main391:
	BTFSC       STATUS+0, 2 
	GOTO        L_main173
	MOVLW       0
	XORWF       _kp2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main392
	MOVLW       6
	XORWF       _kp2+0, 0 
L__main392:
	BTFSC       STATUS+0, 2 
	GOTO        L_main174
	MOVLW       0
	XORWF       _kp2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main393
	MOVLW       7
	XORWF       _kp2+0, 0 
L__main393:
	BTFSC       STATUS+0, 2 
	GOTO        L_main175
	MOVLW       0
	XORWF       _kp2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main394
	MOVLW       9
	XORWF       _kp2+0, 0 
L__main394:
	BTFSC       STATUS+0, 2 
	GOTO        L_main176
	MOVLW       0
	XORWF       _kp2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main395
	MOVLW       10
	XORWF       _kp2+0, 0 
L__main395:
	BTFSC       STATUS+0, 2 
	GOTO        L_main177
	MOVLW       0
	XORWF       _kp2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main396
	MOVLW       11
	XORWF       _kp2+0, 0 
L__main396:
	BTFSC       STATUS+0, 2 
	GOTO        L_main178
	MOVLW       0
	XORWF       _kp2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main397
	MOVLW       14
	XORWF       _kp2+0, 0 
L__main397:
	BTFSC       STATUS+0, 2 
	GOTO        L_main179
L_main169:
;reg des.c,444 :: 		if(cliques < 6)
	MOVLW       6
	SUBWF       _cliques+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main180
;reg des.c,447 :: 		for(c=0; c < 6; c++)
	CLRF        main_c_L0+0 
L_main181:
	MOVLW       6
	SUBWF       main_c_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main182
;reg des.c,449 :: 		cod[c] = cod[c+1];
	MOVF        main_c_L0+0, 0 
	ADDWF       _cod+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _cod+1, 0 
	MOVWF       FSR1L+1 
	MOVF        main_c_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	ADDWF       _cod+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      _cod+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,447 :: 		for(c=0; c < 6; c++)
	INCF        main_c_L0+0, 1 
;reg des.c,449 :: 		cod[c] = cod[c+1];
	GOTO        L_main181
L_main182:
;reg des.c,450 :: 		cod[5] = ocu;
	MOVLW       5
	ADDWF       _cod+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _cod+1, 0 
	MOVWF       FSR1L+1 
	MOVF        _ocu+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,451 :: 		for(i=0; i < 6; i++)
	CLRF        main_i_L0+0 
L_main184:
	MOVLW       6
	SUBWF       main_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main185
;reg des.c,452 :: 		senha1[i] = senha1[i+1];
	MOVF        main_i_L0+0, 0 
	ADDWF       _senha1+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _senha1+1, 0 
	MOVWF       FSR1L+1 
	MOVF        main_i_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	ADDWF       _senha1+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      _senha1+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,451 :: 		for(i=0; i < 6; i++)
	INCF        main_i_L0+0, 1 
;reg des.c,452 :: 		senha1[i] = senha1[i+1];
	GOTO        L_main184
L_main185:
;reg des.c,453 :: 		senha1[5] = kp2;
	MOVLW       5
	ADDWF       _senha1+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _senha1+1, 0 
	MOVWF       FSR1L+1 
	MOVF        _kp2+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,455 :: 		}
L_main180:
;reg des.c,457 :: 		}
L_main164:
L_main162:
;reg des.c,458 :: 		}
L_main160:
;reg des.c,459 :: 		Lcd_Out(1,2, "DIG.SENHA ADM");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr19_reg_32des+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr19_reg_32des+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,460 :: 		Lcd_Out(2,6, cod);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _cod+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _cod+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,461 :: 		Delay_ms(10);
	MOVLW       82
	MOVWF       R12, 0
	MOVLW       41
	MOVWF       R13, 0
L_main187:
	DECFSZ      R13, 1, 1
	BRA         L_main187
	DECFSZ      R12, 1, 1
	BRA         L_main187
	NOP
	NOP
;reg des.c,462 :: 		}    // WHILE ROTINA 2
	GOTO        L_main158
;reg des.c,464 :: 		rotina3:                //////////////////////////// ROTINA 3  GRAVAÇÃO DE TODAS AS SENHAS DOS CANAIS/////////////////////////////
___main_rotina3:
;reg des.c,465 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;reg des.c,466 :: 		cana=1;
	MOVLW       1
	MOVWF       _cana+0 
;reg des.c,467 :: 		cs=0;
	CLRF        _cs+0 
;reg des.c,468 :: 		end=8;
	MOVLW       8
	MOVWF       _end+0 
	MOVLW       0
	MOVWF       _end+1 
;reg des.c,469 :: 		LerCanalDaEeprom();
	CALL        _LerCanalDaEeprom+0, 0
;reg des.c,470 :: 		volta2:
___main_volta2:
;reg des.c,472 :: 		while(1)
L_main188:
;reg des.c,474 :: 		kp3 = Keypad_Key_Click();
	CALL        _Keypad_Key_Click+0, 0
	MOVF        R0, 0 
	MOVWF       _kp3+0 
	MOVLW       0
	MOVWF       _kp3+1 
;reg des.c,476 :: 		if(kp3)
	MOVF        _kp3+0, 0 
	IORWF       _kp3+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main190
;reg des.c,478 :: 		if(kp3 % 4 == 0)
	MOVLW       4
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _kp3+0, 0 
	MOVWF       R0 
	MOVF        _kp3+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main398
	MOVLW       0
	XORWF       R0, 0 
L__main398:
	BTFSS       STATUS+0, 2 
	GOTO        L_main191
;reg des.c,481 :: 		}
	GOTO        L_main192
L_main191:
;reg des.c,482 :: 		else if(kp3 == 13) //Limpar
	MOVLW       0
	XORWF       _kp3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main399
	MOVLW       13
	XORWF       _kp3+0, 0 
L__main399:
	BTFSS       STATUS+0, 2 
	GOTO        L_main193
;reg des.c,484 :: 		LimparSenha2();
	CALL        _LimparSenha2+0, 0
;reg des.c,485 :: 		cliques = 0;
	CLRF        _cliques+0 
;reg des.c,486 :: 		}
	GOTO        L_main194
L_main193:
;reg des.c,487 :: 		else if(kp3 == 15) //Enter
	MOVLW       0
	XORWF       _kp3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main400
	MOVLW       15
	XORWF       _kp3+0, 0 
L__main400:
	BTFSS       STATUS+0, 2 
	GOTO        L_main195
;reg des.c,489 :: 		cliques = 0;
	CLRF        _cliques+0 
;reg des.c,490 :: 		if(cana <= caca)
	MOVLW       128
	XORWF       _caca+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main401
	MOVF        _cana+0, 0 
	SUBWF       _caca+0, 0 
L__main401:
	BTFSS       STATUS+0, 0 
	GOTO        L_main196
;reg des.c,492 :: 		GravarSenhaNaEeprom2();
	CALL        _GravarSenhaNaEeprom2+0, 0
;reg des.c,493 :: 		Delay_ms(500);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       219
	MOVWF       R12, 0
	MOVLW       100
	MOVWF       R13, 0
L_main197:
	DECFSZ      R13, 1, 1
	BRA         L_main197
	DECFSZ      R12, 1, 1
	BRA         L_main197
	DECFSZ      R11, 1, 1
	BRA         L_main197
	NOP
;reg des.c,494 :: 		end=end+6;
	MOVLW       6
	ADDWF       _end+0, 1 
	MOVLW       0
	ADDWFC      _end+1, 1 
;reg des.c,495 :: 		cana++;
	INCF        _cana+0, 1 
;reg des.c,496 :: 		cs++;
	INCF        _cs+0, 1 
;reg des.c,497 :: 		LimparSenha2();
	CALL        _LimparSenha2+0, 0
;reg des.c,498 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;reg des.c,499 :: 		if(cana > caca)
	MOVLW       128
	XORWF       _caca+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main402
	MOVF        _cana+0, 0 
	SUBWF       _caca+0, 0 
L__main402:
	BTFSC       STATUS+0, 0 
	GOTO        L_main198
;reg des.c,501 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;reg des.c,502 :: 		goto inicio;
	GOTO        ___main_inicio
;reg des.c,503 :: 		}
L_main198:
;reg des.c,506 :: 		goto volta2;
	GOTO        ___main_volta2
;reg des.c,508 :: 		}
L_main196:
;reg des.c,511 :: 		goto volta2;
	GOTO        ___main_volta2
;reg des.c,513 :: 		}
L_main195:
;reg des.c,516 :: 		switch(kp3)
	GOTO        L_main202
;reg des.c,518 :: 		case 1: kp3 = 49; ocu=42; break; //1
L_main204:
	MOVLW       49
	MOVWF       _kp3+0 
	MOVLW       0
	MOVWF       _kp3+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main203
;reg des.c,519 :: 		case 2: kp3 = 50; ocu=42;break; //2
L_main205:
	MOVLW       50
	MOVWF       _kp3+0 
	MOVLW       0
	MOVWF       _kp3+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main203
;reg des.c,520 :: 		case 3: kp3 = 51; ocu=42;break; //3
L_main206:
	MOVLW       51
	MOVWF       _kp3+0 
	MOVLW       0
	MOVWF       _kp3+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main203
;reg des.c,521 :: 		case 5: kp3 = 52; ocu=42;break; //4
L_main207:
	MOVLW       52
	MOVWF       _kp3+0 
	MOVLW       0
	MOVWF       _kp3+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main203
;reg des.c,522 :: 		case 6: kp3 = 53; ocu=42;break; //5
L_main208:
	MOVLW       53
	MOVWF       _kp3+0 
	MOVLW       0
	MOVWF       _kp3+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main203
;reg des.c,523 :: 		case 7: kp3 = 54; ocu=42;break; //6
L_main209:
	MOVLW       54
	MOVWF       _kp3+0 
	MOVLW       0
	MOVWF       _kp3+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main203
;reg des.c,524 :: 		case 9: kp3 = 55; ocu=42;break; //7
L_main210:
	MOVLW       55
	MOVWF       _kp3+0 
	MOVLW       0
	MOVWF       _kp3+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main203
;reg des.c,525 :: 		case 10: kp3 = 56; ocu=42;break;//8
L_main211:
	MOVLW       56
	MOVWF       _kp3+0 
	MOVLW       0
	MOVWF       _kp3+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main203
;reg des.c,526 :: 		case 11: kp3 = 57; ocu=42;break;//9
L_main212:
	MOVLW       57
	MOVWF       _kp3+0 
	MOVLW       0
	MOVWF       _kp3+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main203
;reg des.c,527 :: 		case 14: kp3 = 48; ocu=42;break;//0
L_main213:
	MOVLW       48
	MOVWF       _kp3+0 
	MOVLW       0
	MOVWF       _kp3+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main203
;reg des.c,528 :: 		}
L_main202:
	MOVLW       0
	XORWF       _kp3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main403
	MOVLW       1
	XORWF       _kp3+0, 0 
L__main403:
	BTFSC       STATUS+0, 2 
	GOTO        L_main204
	MOVLW       0
	XORWF       _kp3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main404
	MOVLW       2
	XORWF       _kp3+0, 0 
L__main404:
	BTFSC       STATUS+0, 2 
	GOTO        L_main205
	MOVLW       0
	XORWF       _kp3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main405
	MOVLW       3
	XORWF       _kp3+0, 0 
L__main405:
	BTFSC       STATUS+0, 2 
	GOTO        L_main206
	MOVLW       0
	XORWF       _kp3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main406
	MOVLW       5
	XORWF       _kp3+0, 0 
L__main406:
	BTFSC       STATUS+0, 2 
	GOTO        L_main207
	MOVLW       0
	XORWF       _kp3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main407
	MOVLW       6
	XORWF       _kp3+0, 0 
L__main407:
	BTFSC       STATUS+0, 2 
	GOTO        L_main208
	MOVLW       0
	XORWF       _kp3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main408
	MOVLW       7
	XORWF       _kp3+0, 0 
L__main408:
	BTFSC       STATUS+0, 2 
	GOTO        L_main209
	MOVLW       0
	XORWF       _kp3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main409
	MOVLW       9
	XORWF       _kp3+0, 0 
L__main409:
	BTFSC       STATUS+0, 2 
	GOTO        L_main210
	MOVLW       0
	XORWF       _kp3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main410
	MOVLW       10
	XORWF       _kp3+0, 0 
L__main410:
	BTFSC       STATUS+0, 2 
	GOTO        L_main211
	MOVLW       0
	XORWF       _kp3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main411
	MOVLW       11
	XORWF       _kp3+0, 0 
L__main411:
	BTFSC       STATUS+0, 2 
	GOTO        L_main212
	MOVLW       0
	XORWF       _kp3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main412
	MOVLW       14
	XORWF       _kp3+0, 0 
L__main412:
	BTFSC       STATUS+0, 2 
	GOTO        L_main213
L_main203:
;reg des.c,530 :: 		if(cliques < 6)
	MOVLW       6
	SUBWF       _cliques+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main214
;reg des.c,533 :: 		for(c=0; c < 6; c++)
	CLRF        main_c_L0+0 
L_main215:
	MOVLW       6
	SUBWF       main_c_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main216
;reg des.c,535 :: 		cod[c] = cod[c+1];
	MOVF        main_c_L0+0, 0 
	ADDWF       _cod+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _cod+1, 0 
	MOVWF       FSR1L+1 
	MOVF        main_c_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	ADDWF       _cod+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      _cod+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,533 :: 		for(c=0; c < 6; c++)
	INCF        main_c_L0+0, 1 
;reg des.c,535 :: 		cod[c] = cod[c+1];
	GOTO        L_main215
L_main216:
;reg des.c,536 :: 		cod[5] = ocu;
	MOVLW       5
	ADDWF       _cod+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _cod+1, 0 
	MOVWF       FSR1L+1 
	MOVF        _ocu+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,537 :: 		for(i=0; i < 6; i++)
	CLRF        main_i_L0+0 
L_main218:
	MOVLW       6
	SUBWF       main_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main219
;reg des.c,538 :: 		senha2[i] = senha2[i+1];
	MOVF        main_i_L0+0, 0 
	ADDWF       _senha2+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _senha2+1, 0 
	MOVWF       FSR1L+1 
	MOVF        main_i_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	ADDWF       _senha2+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      _senha2+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,537 :: 		for(i=0; i < 6; i++)
	INCF        main_i_L0+0, 1 
;reg des.c,538 :: 		senha2[i] = senha2[i+1];
	GOTO        L_main218
L_main219:
;reg des.c,539 :: 		senha2[5] = kp3;
	MOVLW       5
	ADDWF       _senha2+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _senha2+1, 0 
	MOVWF       FSR1L+1 
	MOVF        _kp3+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,541 :: 		}
L_main214:
;reg des.c,543 :: 		}
L_main194:
L_main192:
;reg des.c,544 :: 		}
L_main190:
;reg des.c,546 :: 		Lcd_Out(1,1, "SENHA CANAL:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr20_reg_32des+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr20_reg_32des+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,547 :: 		ShortToStr(cana,dend);
	MOVF        _cana+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVF        _dend+0, 0 
	MOVWF       FARG_ShortToStr_output+0 
	MOVF        _dend+1, 0 
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
;reg des.c,548 :: 		Lcd_Out(1,13,dend);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       13
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _dend+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _dend+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,549 :: 		Lcd_Out(2,6, cod);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _cod+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _cod+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,550 :: 		Delay_ms(10);
	MOVLW       82
	MOVWF       R12, 0
	MOVLW       41
	MOVWF       R13, 0
L_main221:
	DECFSZ      R13, 1, 1
	BRA         L_main221
	DECFSZ      R12, 1, 1
	BRA         L_main221
	NOP
	NOP
;reg des.c,551 :: 		}    //    WHILE ROTINA 3
	GOTO        L_main188
;reg des.c,554 :: 		rotina4:      //////////////////////////// ROTINA 4  ROTINA DA VERIF DE ADM /////////////////////////////
___main_rotina4:
;reg des.c,555 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;reg des.c,556 :: 		LimparSenha();
	CALL        _LimparSenha+0, 0
;reg des.c,557 :: 		while(1)
L_main222:
;reg des.c,560 :: 		kp4 = Keypad_Key_Click();
	CALL        _Keypad_Key_Click+0, 0
	MOVF        R0, 0 
	MOVWF       _kp4+0 
	MOVLW       0
	MOVWF       _kp4+1 
;reg des.c,562 :: 		if(kp4)
	MOVF        _kp4+0, 0 
	IORWF       _kp4+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main224
;reg des.c,564 :: 		if(kp4 % 4 == 0)
	MOVLW       4
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _kp4+0, 0 
	MOVWF       R0 
	MOVF        _kp4+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main413
	MOVLW       0
	XORWF       R0, 0 
L__main413:
	BTFSS       STATUS+0, 2 
	GOTO        L_main225
;reg des.c,567 :: 		}
	GOTO        L_main226
L_main225:
;reg des.c,568 :: 		else if(kp4 == 13) //Limpar
	MOVLW       0
	XORWF       _kp4+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main414
	MOVLW       13
	XORWF       _kp4+0, 0 
L__main414:
	BTFSS       STATUS+0, 2 
	GOTO        L_main227
;reg des.c,570 :: 		LimparSenha();
	CALL        _LimparSenha+0, 0
;reg des.c,571 :: 		cliques = 0;
	CLRF        _cliques+0 
;reg des.c,572 :: 		}
	GOTO        L_main228
L_main227:
;reg des.c,573 :: 		else if(kp4 == 15) //Enter
	MOVLW       0
	XORWF       _kp4+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main415
	MOVLW       15
	XORWF       _kp4+0, 0 
L__main415:
	BTFSS       STATUS+0, 2 
	GOTO        L_main229
;reg des.c,575 :: 		cliques = 0; end=2; fs =0;c =0;
	CLRF        _cliques+0 
	MOVLW       2
	MOVWF       _end+0 
	MOVLW       0
	MOVWF       _end+1 
	CLRF        _fs+0 
	CLRF        main_c_L0+0 
;reg des.c,577 :: 		if(CompararSenha()) //Sucesso
	CALL        _CompararSenha+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main230
;reg des.c,579 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;reg des.c,580 :: 		Lcd_Out(1,3,"SENHA ADM OK"  );
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr21_reg_32des+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr21_reg_32des+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,581 :: 		Delay_ms(500);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       219
	MOVWF       R12, 0
	MOVLW       100
	MOVWF       R13, 0
L_main231:
	DECFSZ      R13, 1, 1
	BRA         L_main231
	DECFSZ      R12, 1, 1
	BRA         L_main231
	DECFSZ      R11, 1, 1
	BRA         L_main231
	NOP
;reg des.c,582 :: 		LimparSenha();
	CALL        _LimparSenha+0, 0
;reg des.c,583 :: 		fs=1;
	MOVLW       1
	MOVWF       _fs+0 
;reg des.c,584 :: 		if(caminho == 1){goto rotina3;}
	MOVLW       0
	XORWF       _caminho+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main416
	MOVLW       1
	XORWF       _caminho+0, 0 
L__main416:
	BTFSS       STATUS+0, 2 
	GOTO        L_main232
	GOTO        ___main_rotina3
L_main232:
;reg des.c,585 :: 		if(caminho == 2){goto rotina5;}
	MOVLW       0
	XORWF       _caminho+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main417
	MOVLW       2
	XORWF       _caminho+0, 0 
L__main417:
	BTFSS       STATUS+0, 2 
	GOTO        L_main233
	GOTO        ___main_rotina5
L_main233:
;reg des.c,586 :: 		if(caminho == 3){goto rotina2;}
	MOVLW       0
	XORWF       _caminho+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main418
	MOVLW       3
	XORWF       _caminho+0, 0 
L__main418:
	BTFSS       STATUS+0, 2 
	GOTO        L_main234
	GOTO        ___main_rotina2
L_main234:
;reg des.c,587 :: 		}
L_main230:
;reg des.c,589 :: 		if ( fs == 0 )
	MOVF        _fs+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main235
;reg des.c,591 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;reg des.c,592 :: 		Lcd_Out(1,1,"SENHA ADM ERRADA");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr22_reg_32des+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr22_reg_32des+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,593 :: 		Delay_ms(3000);
	MOVLW       96
	MOVWF       R11, 0
	MOVLW       31
	MOVWF       R12, 0
	MOVLW       100
	MOVWF       R13, 0
L_main236:
	DECFSZ      R13, 1, 1
	BRA         L_main236
	DECFSZ      R12, 1, 1
	BRA         L_main236
	DECFSZ      R11, 1, 1
	BRA         L_main236
	NOP
;reg des.c,594 :: 		LimparSenha();
	CALL        _LimparSenha+0, 0
;reg des.c,595 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;reg des.c,596 :: 		goto inicio;
	GOTO        ___main_inicio
;reg des.c,597 :: 		}
L_main235:
;reg des.c,599 :: 		Delay_ms(1000);
	MOVLW       32
	MOVWF       R11, 0
	MOVLW       181
	MOVWF       R12, 0
	MOVLW       203
	MOVWF       R13, 0
L_main237:
	DECFSZ      R13, 1, 1
	BRA         L_main237
	DECFSZ      R12, 1, 1
	BRA         L_main237
	DECFSZ      R11, 1, 1
	BRA         L_main237
;reg des.c,601 :: 		}
	GOTO        L_main238
L_main229:
;reg des.c,604 :: 		switch(kp4)
	GOTO        L_main239
;reg des.c,606 :: 		case 1: kp4 = 49; ocu=42; break; //1
L_main241:
	MOVLW       49
	MOVWF       _kp4+0 
	MOVLW       0
	MOVWF       _kp4+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main240
;reg des.c,607 :: 		case 2: kp4 = 50; ocu=42;break; //2
L_main242:
	MOVLW       50
	MOVWF       _kp4+0 
	MOVLW       0
	MOVWF       _kp4+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main240
;reg des.c,608 :: 		case 3: kp4 = 51; ocu=42;break; //3
L_main243:
	MOVLW       51
	MOVWF       _kp4+0 
	MOVLW       0
	MOVWF       _kp4+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main240
;reg des.c,609 :: 		case 5: kp4 = 52; ocu=42;break; //4
L_main244:
	MOVLW       52
	MOVWF       _kp4+0 
	MOVLW       0
	MOVWF       _kp4+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main240
;reg des.c,610 :: 		case 6: kp4 = 53; ocu=42;break; //5
L_main245:
	MOVLW       53
	MOVWF       _kp4+0 
	MOVLW       0
	MOVWF       _kp4+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main240
;reg des.c,611 :: 		case 7: kp4 = 54; ocu=42;break; //6
L_main246:
	MOVLW       54
	MOVWF       _kp4+0 
	MOVLW       0
	MOVWF       _kp4+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main240
;reg des.c,612 :: 		case 9: kp4 = 55; ocu=42;break; //7
L_main247:
	MOVLW       55
	MOVWF       _kp4+0 
	MOVLW       0
	MOVWF       _kp4+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main240
;reg des.c,613 :: 		case 10: kp4 = 56; ocu=42;break;//8
L_main248:
	MOVLW       56
	MOVWF       _kp4+0 
	MOVLW       0
	MOVWF       _kp4+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main240
;reg des.c,614 :: 		case 11: kp4 = 57; ocu=42;break;//9
L_main249:
	MOVLW       57
	MOVWF       _kp4+0 
	MOVLW       0
	MOVWF       _kp4+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main240
;reg des.c,615 :: 		case 14: kp4 = 48; ocu=42;break;//0
L_main250:
	MOVLW       48
	MOVWF       _kp4+0 
	MOVLW       0
	MOVWF       _kp4+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main240
;reg des.c,616 :: 		}
L_main239:
	MOVLW       0
	XORWF       _kp4+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main419
	MOVLW       1
	XORWF       _kp4+0, 0 
L__main419:
	BTFSC       STATUS+0, 2 
	GOTO        L_main241
	MOVLW       0
	XORWF       _kp4+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main420
	MOVLW       2
	XORWF       _kp4+0, 0 
L__main420:
	BTFSC       STATUS+0, 2 
	GOTO        L_main242
	MOVLW       0
	XORWF       _kp4+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main421
	MOVLW       3
	XORWF       _kp4+0, 0 
L__main421:
	BTFSC       STATUS+0, 2 
	GOTO        L_main243
	MOVLW       0
	XORWF       _kp4+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main422
	MOVLW       5
	XORWF       _kp4+0, 0 
L__main422:
	BTFSC       STATUS+0, 2 
	GOTO        L_main244
	MOVLW       0
	XORWF       _kp4+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main423
	MOVLW       6
	XORWF       _kp4+0, 0 
L__main423:
	BTFSC       STATUS+0, 2 
	GOTO        L_main245
	MOVLW       0
	XORWF       _kp4+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main424
	MOVLW       7
	XORWF       _kp4+0, 0 
L__main424:
	BTFSC       STATUS+0, 2 
	GOTO        L_main246
	MOVLW       0
	XORWF       _kp4+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main425
	MOVLW       9
	XORWF       _kp4+0, 0 
L__main425:
	BTFSC       STATUS+0, 2 
	GOTO        L_main247
	MOVLW       0
	XORWF       _kp4+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main426
	MOVLW       10
	XORWF       _kp4+0, 0 
L__main426:
	BTFSC       STATUS+0, 2 
	GOTO        L_main248
	MOVLW       0
	XORWF       _kp4+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main427
	MOVLW       11
	XORWF       _kp4+0, 0 
L__main427:
	BTFSC       STATUS+0, 2 
	GOTO        L_main249
	MOVLW       0
	XORWF       _kp4+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main428
	MOVLW       14
	XORWF       _kp4+0, 0 
L__main428:
	BTFSC       STATUS+0, 2 
	GOTO        L_main250
L_main240:
;reg des.c,618 :: 		if(cliques < 6)
	MOVLW       6
	SUBWF       _cliques+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main251
;reg des.c,621 :: 		for(c=0; c < 6; c++)
	CLRF        main_c_L0+0 
L_main252:
	MOVLW       6
	SUBWF       main_c_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main253
;reg des.c,623 :: 		cod[c] = cod[c+1];
	MOVF        main_c_L0+0, 0 
	ADDWF       _cod+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _cod+1, 0 
	MOVWF       FSR1L+1 
	MOVF        main_c_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	ADDWF       _cod+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      _cod+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,621 :: 		for(c=0; c < 6; c++)
	INCF        main_c_L0+0, 1 
;reg des.c,623 :: 		cod[c] = cod[c+1];
	GOTO        L_main252
L_main253:
;reg des.c,624 :: 		cod[5] = ocu;
	MOVLW       5
	ADDWF       _cod+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _cod+1, 0 
	MOVWF       FSR1L+1 
	MOVF        _ocu+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,625 :: 		for(i=0; i < 6; i++)
	CLRF        main_i_L0+0 
L_main255:
	MOVLW       6
	SUBWF       main_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main256
;reg des.c,626 :: 		senha[i] = senha[i+1];
	MOVF        main_i_L0+0, 0 
	ADDWF       _senha+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FSR1L+1 
	MOVF        main_i_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	ADDWF       _senha+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      _senha+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,625 :: 		for(i=0; i < 6; i++)
	INCF        main_i_L0+0, 1 
;reg des.c,626 :: 		senha[i] = senha[i+1];
	GOTO        L_main255
L_main256:
;reg des.c,627 :: 		senha[5] = kp4;
	MOVLW       5
	ADDWF       _senha+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _senha+1, 0 
	MOVWF       FSR1L+1 
	MOVF        _kp4+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,629 :: 		}
L_main251:
;reg des.c,631 :: 		}
L_main238:
L_main228:
L_main226:
;reg des.c,632 :: 		}
L_main224:
;reg des.c,633 :: 		Lcd_Out(1,2, "DIG.SENHA ADM");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr23_reg_32des+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr23_reg_32des+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,634 :: 		Lcd_Out(2,6, cod);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _cod+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _cod+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,635 :: 		Delay_ms(10);
	MOVLW       82
	MOVWF       R12, 0
	MOVLW       41
	MOVWF       R13, 0
L_main258:
	DECFSZ      R13, 1, 1
	BRA         L_main258
	DECFSZ      R12, 1, 1
	BRA         L_main258
	NOP
	NOP
;reg des.c,636 :: 		}    //  WHILE ROTINA 4
	GOTO        L_main222
;reg des.c,638 :: 		rotina5:                                       //////////////////////////// ROTINA 5  PEGA CANAL PARA EDITAR ////////////////////////////////
___main_rotina5:
;reg des.c,639 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;reg des.c,640 :: 		LimparCanal();
	CALL        _LimparCanal+0, 0
;reg des.c,642 :: 		while(1)
L_main259:
;reg des.c,645 :: 		kp5 = Keypad_Key_Click();
	CALL        _Keypad_Key_Click+0, 0
	MOVF        R0, 0 
	MOVWF       _kp5+0 
	MOVLW       0
	MOVWF       _kp5+1 
;reg des.c,647 :: 		if(kp5)
	MOVF        _kp5+0, 0 
	IORWF       _kp5+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main261
;reg des.c,649 :: 		if(kp5 % 4 == 0)
	MOVLW       4
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _kp5+0, 0 
	MOVWF       R0 
	MOVF        _kp5+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main429
	MOVLW       0
	XORWF       R0, 0 
L__main429:
	BTFSS       STATUS+0, 2 
	GOTO        L_main262
;reg des.c,652 :: 		}
	GOTO        L_main263
L_main262:
;reg des.c,653 :: 		else if(kp5 == 13) //Limpar
	MOVLW       0
	XORWF       _kp5+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main430
	MOVLW       13
	XORWF       _kp5+0, 0 
L__main430:
	BTFSS       STATUS+0, 2 
	GOTO        L_main264
;reg des.c,655 :: 		LimparCanal();
	CALL        _LimparCanal+0, 0
;reg des.c,656 :: 		cliques = 0;
	CLRF        _cliques+0 
;reg des.c,657 :: 		}
	GOTO        L_main265
L_main264:
;reg des.c,658 :: 		else if(kp5 == 15) //Enter
	MOVLW       0
	XORWF       _kp5+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main431
	MOVLW       15
	XORWF       _kp5+0, 0 
L__main431:
	BTFSS       STATUS+0, 2 
	GOTO        L_main266
;reg des.c,660 :: 		cliques = 0;
	CLRF        _cliques+0 
;reg des.c,661 :: 		LerCanalDaEeprom();
	CALL        _LerCanalDaEeprom+0, 0
;reg des.c,662 :: 		cana = StrToShort(ecan);
	MOVF        _ecan+0, 0 
	MOVWF       FARG_StrToShort_byte_in+0 
	MOVF        _ecan+1, 0 
	MOVWF       FARG_StrToShort_byte_in+1 
	CALL        _StrToShort+0, 0
	MOVF        R0, 0 
	MOVWF       _cana+0 
;reg des.c,664 :: 		if(caca >= cana && cana != 0 )   //verifica se canal digitado é menor que o gravado ou diferente de zero
	MOVLW       128
	XORWF       _caca+1, 0 
	MOVWF       R1 
	MOVLW       128
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main432
	MOVF        R0, 0 
	SUBWF       _caca+0, 0 
L__main432:
	BTFSS       STATUS+0, 0 
	GOTO        L_main269
	MOVF        _cana+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main269
L__main336:
;reg des.c,666 :: 		goto rotina6;
	GOTO        ___main_rotina6
;reg des.c,667 :: 		}
L_main269:
;reg des.c,670 :: 		Lcd_Out(1,1, "CANAL NAO EXISTE");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr24_reg_32des+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr24_reg_32des+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,671 :: 		Delay_ms(1000);
	MOVLW       32
	MOVWF       R11, 0
	MOVLW       181
	MOVWF       R12, 0
	MOVLW       203
	MOVWF       R13, 0
L_main271:
	DECFSZ      R13, 1, 1
	BRA         L_main271
	DECFSZ      R12, 1, 1
	BRA         L_main271
	DECFSZ      R11, 1, 1
	BRA         L_main271
;reg des.c,672 :: 		LimparCanal();
	CALL        _LimparCanal+0, 0
;reg des.c,673 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;reg des.c,674 :: 		goto rotina5;
	GOTO        ___main_rotina5
;reg des.c,677 :: 		Delay_ms(500);
L_main272:
	DECFSZ      R13, 1, 1
	BRA         L_main272
	DECFSZ      R12, 1, 1
	BRA         L_main272
	DECFSZ      R11, 1, 1
	BRA         L_main272
	NOP
;reg des.c,679 :: 		}
	GOTO        L_main273
L_main266:
;reg des.c,682 :: 		switch(kp5)
	GOTO        L_main274
;reg des.c,684 :: 		case 1: kp5 = 49; break; //1
L_main276:
	MOVLW       49
	MOVWF       _kp5+0 
	MOVLW       0
	MOVWF       _kp5+1 
	GOTO        L_main275
;reg des.c,685 :: 		case 2: kp5 = 50; break; //2
L_main277:
	MOVLW       50
	MOVWF       _kp5+0 
	MOVLW       0
	MOVWF       _kp5+1 
	GOTO        L_main275
;reg des.c,686 :: 		case 3: kp5 = 51; break; //3
L_main278:
	MOVLW       51
	MOVWF       _kp5+0 
	MOVLW       0
	MOVWF       _kp5+1 
	GOTO        L_main275
;reg des.c,687 :: 		case 5: kp5 = 52; break; //4
L_main279:
	MOVLW       52
	MOVWF       _kp5+0 
	MOVLW       0
	MOVWF       _kp5+1 
	GOTO        L_main275
;reg des.c,688 :: 		case 6: kp5 = 53; break; //5
L_main280:
	MOVLW       53
	MOVWF       _kp5+0 
	MOVLW       0
	MOVWF       _kp5+1 
	GOTO        L_main275
;reg des.c,689 :: 		case 7: kp5 = 54; break; //6
L_main281:
	MOVLW       54
	MOVWF       _kp5+0 
	MOVLW       0
	MOVWF       _kp5+1 
	GOTO        L_main275
;reg des.c,690 :: 		case 9: kp5 = 55; break; //7
L_main282:
	MOVLW       55
	MOVWF       _kp5+0 
	MOVLW       0
	MOVWF       _kp5+1 
	GOTO        L_main275
;reg des.c,691 :: 		case 10: kp5 = 56; break;//8
L_main283:
	MOVLW       56
	MOVWF       _kp5+0 
	MOVLW       0
	MOVWF       _kp5+1 
	GOTO        L_main275
;reg des.c,692 :: 		case 11: kp5 = 57; break;//9
L_main284:
	MOVLW       57
	MOVWF       _kp5+0 
	MOVLW       0
	MOVWF       _kp5+1 
	GOTO        L_main275
;reg des.c,693 :: 		case 14: kp5 = 48; break;//0
L_main285:
	MOVLW       48
	MOVWF       _kp5+0 
	MOVLW       0
	MOVWF       _kp5+1 
	GOTO        L_main275
;reg des.c,694 :: 		}
L_main274:
	MOVLW       0
	XORWF       _kp5+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main433
	MOVLW       1
	XORWF       _kp5+0, 0 
L__main433:
	BTFSC       STATUS+0, 2 
	GOTO        L_main276
	MOVLW       0
	XORWF       _kp5+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main434
	MOVLW       2
	XORWF       _kp5+0, 0 
L__main434:
	BTFSC       STATUS+0, 2 
	GOTO        L_main277
	MOVLW       0
	XORWF       _kp5+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main435
	MOVLW       3
	XORWF       _kp5+0, 0 
L__main435:
	BTFSC       STATUS+0, 2 
	GOTO        L_main278
	MOVLW       0
	XORWF       _kp5+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main436
	MOVLW       5
	XORWF       _kp5+0, 0 
L__main436:
	BTFSC       STATUS+0, 2 
	GOTO        L_main279
	MOVLW       0
	XORWF       _kp5+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main437
	MOVLW       6
	XORWF       _kp5+0, 0 
L__main437:
	BTFSC       STATUS+0, 2 
	GOTO        L_main280
	MOVLW       0
	XORWF       _kp5+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main438
	MOVLW       7
	XORWF       _kp5+0, 0 
L__main438:
	BTFSC       STATUS+0, 2 
	GOTO        L_main281
	MOVLW       0
	XORWF       _kp5+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main439
	MOVLW       9
	XORWF       _kp5+0, 0 
L__main439:
	BTFSC       STATUS+0, 2 
	GOTO        L_main282
	MOVLW       0
	XORWF       _kp5+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main440
	MOVLW       10
	XORWF       _kp5+0, 0 
L__main440:
	BTFSC       STATUS+0, 2 
	GOTO        L_main283
	MOVLW       0
	XORWF       _kp5+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main441
	MOVLW       11
	XORWF       _kp5+0, 0 
L__main441:
	BTFSC       STATUS+0, 2 
	GOTO        L_main284
	MOVLW       0
	XORWF       _kp5+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main442
	MOVLW       14
	XORWF       _kp5+0, 0 
L__main442:
	BTFSC       STATUS+0, 2 
	GOTO        L_main285
L_main275:
;reg des.c,696 :: 		if(cliques < 3)
	MOVLW       3
	SUBWF       _cliques+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main286
;reg des.c,699 :: 		for(i=0; i < 2; i++)
	CLRF        main_i_L0+0 
L_main287:
	MOVLW       2
	SUBWF       main_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main288
;reg des.c,700 :: 		ecan[i] = ecan[i+1];
	MOVF        main_i_L0+0, 0 
	ADDWF       _ecan+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _ecan+1, 0 
	MOVWF       FSR1L+1 
	MOVF        main_i_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	ADDWF       _ecan+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      _ecan+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,699 :: 		for(i=0; i < 2; i++)
	INCF        main_i_L0+0, 1 
;reg des.c,700 :: 		ecan[i] = ecan[i+1];
	GOTO        L_main287
L_main288:
;reg des.c,701 :: 		ecan[1] = kp5;
	MOVLW       1
	ADDWF       _ecan+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _ecan+1, 0 
	MOVWF       FSR1L+1 
	MOVF        _kp5+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,703 :: 		}
L_main286:
;reg des.c,705 :: 		}
L_main273:
L_main265:
L_main263:
;reg des.c,706 :: 		}
L_main261:
;reg des.c,707 :: 		Lcd_Out(1,2, "QUAL CANAL EDT?");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr25_reg_32des+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr25_reg_32des+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,708 :: 		Lcd_Out(2,8, ecan);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _ecan+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _ecan+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,709 :: 		Delay_ms(10);
	MOVLW       82
	MOVWF       R12, 0
	MOVLW       41
	MOVWF       R13, 0
L_main290:
	DECFSZ      R13, 1, 1
	BRA         L_main290
	DECFSZ      R12, 1, 1
	BRA         L_main290
	NOP
	NOP
;reg des.c,710 :: 		}    // WHILE ROTINA 5
	GOTO        L_main259
;reg des.c,714 :: 		rotina6:                //////////////////////////// ROTINA 6  EDIÇÃO DAS SENHAS DOS CANAIS/////////////////////////////
___main_rotina6:
;reg des.c,715 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;reg des.c,718 :: 		while(1)
L_main291:
;reg des.c,720 :: 		kp6 = Keypad_Key_Click();
	CALL        _Keypad_Key_Click+0, 0
	MOVF        R0, 0 
	MOVWF       _kp6+0 
	MOVLW       0
	MOVWF       _kp6+1 
;reg des.c,722 :: 		if(kp6)
	MOVF        _kp6+0, 0 
	IORWF       _kp6+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main293
;reg des.c,724 :: 		if(kp6 % 4 == 0)
	MOVLW       4
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _kp6+0, 0 
	MOVWF       R0 
	MOVF        _kp6+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main443
	MOVLW       0
	XORWF       R0, 0 
L__main443:
	BTFSS       STATUS+0, 2 
	GOTO        L_main294
;reg des.c,727 :: 		}
	GOTO        L_main295
L_main294:
;reg des.c,728 :: 		else if(kp6 == 13) //Limpar
	MOVLW       0
	XORWF       _kp6+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main444
	MOVLW       13
	XORWF       _kp6+0, 0 
L__main444:
	BTFSS       STATUS+0, 2 
	GOTO        L_main296
;reg des.c,730 :: 		LimparSenha2();
	CALL        _LimparSenha2+0, 0
;reg des.c,731 :: 		cliques = 0;
	CLRF        _cliques+0 
;reg des.c,732 :: 		}
	GOTO        L_main297
L_main296:
;reg des.c,733 :: 		else if(kp6 == 15) //Enter
	MOVLW       0
	XORWF       _kp6+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main445
	MOVLW       15
	XORWF       _kp6+0, 0 
L__main445:
	BTFSS       STATUS+0, 2 
	GOTO        L_main298
;reg des.c,735 :: 		cliques = 0;
	CLRF        _cliques+0 
;reg des.c,736 :: 		if(cana==1){end=8;}
	MOVF        _cana+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main299
	MOVLW       8
	MOVWF       _end+0 
	MOVLW       0
	MOVWF       _end+1 
L_main299:
;reg des.c,737 :: 		if(cana==2){end=14;}
	MOVF        _cana+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main300
	MOVLW       14
	MOVWF       _end+0 
	MOVLW       0
	MOVWF       _end+1 
L_main300:
;reg des.c,738 :: 		if(cana==3){end=20;}
	MOVF        _cana+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main301
	MOVLW       20
	MOVWF       _end+0 
	MOVLW       0
	MOVWF       _end+1 
L_main301:
;reg des.c,739 :: 		if(cana==4){end=26;}
	MOVF        _cana+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_main302
	MOVLW       26
	MOVWF       _end+0 
	MOVLW       0
	MOVWF       _end+1 
L_main302:
;reg des.c,740 :: 		if(cana==5){end=32;}
	MOVF        _cana+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_main303
	MOVLW       32
	MOVWF       _end+0 
	MOVLW       0
	MOVWF       _end+1 
L_main303:
;reg des.c,741 :: 		if(cana==6){end=38;}
	MOVF        _cana+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_main304
	MOVLW       38
	MOVWF       _end+0 
	MOVLW       0
	MOVWF       _end+1 
L_main304:
;reg des.c,742 :: 		if(cana==7){end=44;}
	MOVF        _cana+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_main305
	MOVLW       44
	MOVWF       _end+0 
	MOVLW       0
	MOVWF       _end+1 
L_main305:
;reg des.c,743 :: 		if(cana==8){end=50;}
	MOVF        _cana+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_main306
	MOVLW       50
	MOVWF       _end+0 
	MOVLW       0
	MOVWF       _end+1 
L_main306:
;reg des.c,744 :: 		if(cana==9){end=56;}
	MOVF        _cana+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_main307
	MOVLW       56
	MOVWF       _end+0 
	MOVLW       0
	MOVWF       _end+1 
L_main307:
;reg des.c,745 :: 		if(cana==10){end=62;}
	MOVF        _cana+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_main308
	MOVLW       62
	MOVWF       _end+0 
	MOVLW       0
	MOVWF       _end+1 
L_main308:
;reg des.c,746 :: 		if(cana==11){end=68;}
	MOVF        _cana+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_main309
	MOVLW       68
	MOVWF       _end+0 
	MOVLW       0
	MOVWF       _end+1 
L_main309:
;reg des.c,747 :: 		if(cana==12){end=74;}
	MOVF        _cana+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_main310
	MOVLW       74
	MOVWF       _end+0 
	MOVLW       0
	MOVWF       _end+1 
L_main310:
;reg des.c,748 :: 		if(cana==13){end=80;}
	MOVF        _cana+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_main311
	MOVLW       80
	MOVWF       _end+0 
	MOVLW       0
	MOVWF       _end+1 
L_main311:
;reg des.c,749 :: 		if(cana==14){end=86;}
	MOVF        _cana+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_main312
	MOVLW       86
	MOVWF       _end+0 
	MOVLW       0
	MOVWF       _end+1 
L_main312:
;reg des.c,750 :: 		if(cana==15){end=92;}
	MOVF        _cana+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_main313
	MOVLW       92
	MOVWF       _end+0 
	MOVLW       0
	MOVWF       _end+1 
L_main313:
;reg des.c,751 :: 		GravarSenhaNaEeprom2();
	CALL        _GravarSenhaNaEeprom2+0, 0
;reg des.c,752 :: 		Delay_ms(500);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       219
	MOVWF       R12, 0
	MOVLW       100
	MOVWF       R13, 0
L_main314:
	DECFSZ      R13, 1, 1
	BRA         L_main314
	DECFSZ      R12, 1, 1
	BRA         L_main314
	DECFSZ      R11, 1, 1
	BRA         L_main314
	NOP
;reg des.c,753 :: 		LimparSenha2();
	CALL        _LimparSenha2+0, 0
;reg des.c,754 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;reg des.c,755 :: 		goto inicio;
	GOTO        ___main_inicio
;reg des.c,757 :: 		}
L_main298:
;reg des.c,760 :: 		switch(kp6)
	GOTO        L_main316
;reg des.c,762 :: 		case 1: kp6 = 49; ocu=42; break; //1
L_main318:
	MOVLW       49
	MOVWF       _kp6+0 
	MOVLW       0
	MOVWF       _kp6+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main317
;reg des.c,763 :: 		case 2: kp6 = 50; ocu=42;break; //2
L_main319:
	MOVLW       50
	MOVWF       _kp6+0 
	MOVLW       0
	MOVWF       _kp6+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main317
;reg des.c,764 :: 		case 3: kp6 = 51; ocu=42;break; //3
L_main320:
	MOVLW       51
	MOVWF       _kp6+0 
	MOVLW       0
	MOVWF       _kp6+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main317
;reg des.c,765 :: 		case 5: kp6 = 52; ocu=42;break; //4
L_main321:
	MOVLW       52
	MOVWF       _kp6+0 
	MOVLW       0
	MOVWF       _kp6+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main317
;reg des.c,766 :: 		case 6: kp6 = 53; ocu=42;break; //5
L_main322:
	MOVLW       53
	MOVWF       _kp6+0 
	MOVLW       0
	MOVWF       _kp6+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main317
;reg des.c,767 :: 		case 7: kp6 = 54; ocu=42;break; //6
L_main323:
	MOVLW       54
	MOVWF       _kp6+0 
	MOVLW       0
	MOVWF       _kp6+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main317
;reg des.c,768 :: 		case 9: kp6 = 55; ocu=42;break; //7
L_main324:
	MOVLW       55
	MOVWF       _kp6+0 
	MOVLW       0
	MOVWF       _kp6+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main317
;reg des.c,769 :: 		case 10: kp6 = 56; ocu=42;break;//8
L_main325:
	MOVLW       56
	MOVWF       _kp6+0 
	MOVLW       0
	MOVWF       _kp6+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main317
;reg des.c,770 :: 		case 11: kp6 = 57; ocu=42;break;//9
L_main326:
	MOVLW       57
	MOVWF       _kp6+0 
	MOVLW       0
	MOVWF       _kp6+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main317
;reg des.c,771 :: 		case 14: kp6 = 48; ocu=42;break;//0
L_main327:
	MOVLW       48
	MOVWF       _kp6+0 
	MOVLW       0
	MOVWF       _kp6+1 
	MOVLW       42
	MOVWF       _ocu+0 
	MOVLW       0
	MOVWF       _ocu+1 
	GOTO        L_main317
;reg des.c,772 :: 		}
L_main316:
	MOVLW       0
	XORWF       _kp6+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main446
	MOVLW       1
	XORWF       _kp6+0, 0 
L__main446:
	BTFSC       STATUS+0, 2 
	GOTO        L_main318
	MOVLW       0
	XORWF       _kp6+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main447
	MOVLW       2
	XORWF       _kp6+0, 0 
L__main447:
	BTFSC       STATUS+0, 2 
	GOTO        L_main319
	MOVLW       0
	XORWF       _kp6+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main448
	MOVLW       3
	XORWF       _kp6+0, 0 
L__main448:
	BTFSC       STATUS+0, 2 
	GOTO        L_main320
	MOVLW       0
	XORWF       _kp6+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main449
	MOVLW       5
	XORWF       _kp6+0, 0 
L__main449:
	BTFSC       STATUS+0, 2 
	GOTO        L_main321
	MOVLW       0
	XORWF       _kp6+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main450
	MOVLW       6
	XORWF       _kp6+0, 0 
L__main450:
	BTFSC       STATUS+0, 2 
	GOTO        L_main322
	MOVLW       0
	XORWF       _kp6+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main451
	MOVLW       7
	XORWF       _kp6+0, 0 
L__main451:
	BTFSC       STATUS+0, 2 
	GOTO        L_main323
	MOVLW       0
	XORWF       _kp6+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main452
	MOVLW       9
	XORWF       _kp6+0, 0 
L__main452:
	BTFSC       STATUS+0, 2 
	GOTO        L_main324
	MOVLW       0
	XORWF       _kp6+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main453
	MOVLW       10
	XORWF       _kp6+0, 0 
L__main453:
	BTFSC       STATUS+0, 2 
	GOTO        L_main325
	MOVLW       0
	XORWF       _kp6+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main454
	MOVLW       11
	XORWF       _kp6+0, 0 
L__main454:
	BTFSC       STATUS+0, 2 
	GOTO        L_main326
	MOVLW       0
	XORWF       _kp6+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main455
	MOVLW       14
	XORWF       _kp6+0, 0 
L__main455:
	BTFSC       STATUS+0, 2 
	GOTO        L_main327
L_main317:
;reg des.c,774 :: 		if(cliques < 6)
	MOVLW       6
	SUBWF       _cliques+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main328
;reg des.c,777 :: 		for(c=0; c < 6; c++)
	CLRF        main_c_L0+0 
L_main329:
	MOVLW       6
	SUBWF       main_c_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main330
;reg des.c,779 :: 		cod[c] = cod[c+1];
	MOVF        main_c_L0+0, 0 
	ADDWF       _cod+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _cod+1, 0 
	MOVWF       FSR1L+1 
	MOVF        main_c_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	ADDWF       _cod+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      _cod+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,777 :: 		for(c=0; c < 6; c++)
	INCF        main_c_L0+0, 1 
;reg des.c,779 :: 		cod[c] = cod[c+1];
	GOTO        L_main329
L_main330:
;reg des.c,780 :: 		cod[5] = ocu;
	MOVLW       5
	ADDWF       _cod+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _cod+1, 0 
	MOVWF       FSR1L+1 
	MOVF        _ocu+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,781 :: 		for(i=0; i < 6; i++)
	CLRF        main_i_L0+0 
L_main332:
	MOVLW       6
	SUBWF       main_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main333
;reg des.c,782 :: 		senha2[i] = senha2[i+1];
	MOVF        main_i_L0+0, 0 
	ADDWF       _senha2+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _senha2+1, 0 
	MOVWF       FSR1L+1 
	MOVF        main_i_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	ADDWF       _senha2+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      _senha2+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,781 :: 		for(i=0; i < 6; i++)
	INCF        main_i_L0+0, 1 
;reg des.c,782 :: 		senha2[i] = senha2[i+1];
	GOTO        L_main332
L_main333:
;reg des.c,783 :: 		senha2[5] = kp6;
	MOVLW       5
	ADDWF       _senha2+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _senha2+1, 0 
	MOVWF       FSR1L+1 
	MOVF        _kp6+0, 0 
	MOVWF       POSTINC1+0 
;reg des.c,785 :: 		}
L_main328:
;reg des.c,787 :: 		}
L_main297:
L_main295:
;reg des.c,788 :: 		}
L_main293:
;reg des.c,790 :: 		Lcd_Out(1,1, "EDITA CANAL:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr26_reg_32des+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr26_reg_32des+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,791 :: 		ShortToStr(cana,dend);
	MOVF        _cana+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVF        _dend+0, 0 
	MOVWF       FARG_ShortToStr_output+0 
	MOVF        _dend+1, 0 
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
;reg des.c,792 :: 		Lcd_Out(1,13,dend);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       13
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _dend+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _dend+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,793 :: 		Lcd_Out(2,6, cod);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _cod+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _cod+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;reg des.c,794 :: 		Delay_ms(10);
	MOVLW       82
	MOVWF       R12, 0
	MOVLW       41
	MOVWF       R13, 0
L_main335:
	DECFSZ      R13, 1, 1
	BRA         L_main335
	DECFSZ      R12, 1, 1
	BRA         L_main335
	NOP
	NOP
;reg des.c,795 :: 		}    // WHILE ROTINA 6
	GOTO        L_main291
;reg des.c,797 :: 		} // void
L_end_main:
	GOTO        $+0
; end of _main
