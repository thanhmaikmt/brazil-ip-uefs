`include "ovm.svh"
//`include "sdi.svh"

class AACHuffmanDecoder extends ovm_object;
		 
	int codebook;
	int indexOffset = -60;

//	function new();
  //    codebook = 0;
   //endfunction
	
	function new(int codebookNumber);
		//$display("Instanciou HuffmanDecoder para codebook %d", codebookNumber );
      codebook = codebookNumber;
   endfunction

   function bit is_unsigned_codebook(int codebook);
	if(codebook == 1 || codebook == 2 || codebook == 5 || codebook == 6)
		return 1'b0;
		
	return 1'b1;
   endfunction
   
	function int decode(int codeword);

		//LIVROS DE CÓDIGO NO ANEXO A DA ISO IEC 13818-7
		case (codebook)
		   12:  //livro dos fatores de escala TABLE A.1 
		   begin
		   //TODO mais um case com as entradas do livro de código correspondente
				case(codeword)
					
					32'h0003ffe8 : decode = 0 + indexOffset;
					32'h0003ffe6 : decode = 1 + indexOffset;
					32'h0003ffe7 : decode = 2 + indexOffset;
					32'h0003ffe5 : decode = 3 + indexOffset;
					32'h0007fff5 : decode = 4 + indexOffset;
					32'h0003fff1 : decode = 5 + indexOffset;
					32'h0007ffed : decode = 6 + indexOffset;
					32'h0007fff6 : decode = 7 + indexOffset;
					32'h0007ffee : decode = 8 + indexOffset;
					32'h0007ffef : decode = 9 + indexOffset;
					32'h0007fff0 : decode = 10 + indexOffset;
					
					32'h0007fffc : decode = 11 + indexOffset; 
					32'h0007fffd : decode = 12 + indexOffset; 
					32'h0007ffff : decode = 13 + indexOffset;
					32'h0007fffe : decode = 14 + indexOffset;
					32'h0007fff7 : decode = 15 + indexOffset;
					32'h0007fff8 : decode = 16 + indexOffset;
					32'h0007fffb : decode = 17 + indexOffset;
					32'h0007fff9 : decode = 18 + indexOffset;
					32'h0003ffe4 : decode = 19 + indexOffset;
					32'h0007fffa : decode = 20 + indexOffset;
					
					32'h0003ffe3 : decode = 21 + indexOffset;
					32'h0001ffef : decode = 22 + indexOffset;
					32'h0001fff0 : decode = 23 + indexOffset;
					32'h0000fff5 : decode = 24 + indexOffset;
					32'h0001ffee : decode = 25 + indexOffset;
					32'h0000fff2 : decode = 26 + indexOffset;
					32'h0000fff3 : decode = 27 + indexOffset;
					32'h0000fff4 : decode = 28 + indexOffset;
					32'h0000fff1 : decode = 29 + indexOffset;
					32'h00007ff6 : decode = 30 + indexOffset;
					
					32'h00007ff7 : decode = 31 + indexOffset;
					32'h00003ff9 : decode = 32 + indexOffset;
					32'h00003ff5 : decode = 33 + indexOffset;
					32'h00003ff7 : decode = 34 + indexOffset;
					32'h00003ff3 : decode = 35 + indexOffset;
					32'h00003ff6 : decode = 36 + indexOffset;
					32'h00003ff2 : decode = 37 + indexOffset;
					32'h00001ff7 : decode = 38 + indexOffset;
					32'h00001ff5 : decode = 39 + indexOffset;
					32'h00000ff9 : decode = 40 + indexOffset;
					
					32'h00000ff7 : decode = 41 + indexOffset;
					32'h00000ff6 : decode = 42 + indexOffset;
					32'h000007f9 : decode = 43 + indexOffset;
					32'h00000ff4 : decode = 44 + indexOffset;
					32'h000007f8 : decode = 45 + indexOffset;
					32'h000003f9 : decode = 46 + indexOffset;
					32'h000003f7 : decode = 47 + indexOffset;
					32'h000003f5 : decode = 48 + indexOffset;
					32'h000001f8 : decode = 49 + indexOffset;
					32'h000001f7 : decode = 50 + indexOffset;
					
					32'h000000fa : decode = 51 + indexOffset;
					32'h000000f8 : decode = 52 + indexOffset;
					32'h000000f6 : decode = 53 + indexOffset;
					32'h00000079 : decode = 54 + indexOffset;
					32'h0000003a : decode = 55 + indexOffset;
					32'h00000038 : decode = 56 + indexOffset;
					32'h0000001a : decode = 57 + indexOffset;
					32'h0000000b : decode = 58 + indexOffset;
					32'h00000004 : decode = 59 + indexOffset;
					32'h00000000 : decode = 60 + indexOffset;
					
					32'h0000000a : decode = 61 + indexOffset;
					32'h0000000c : decode = 62 + indexOffset;
					32'h0000001b : decode = 63 + indexOffset;
					32'h00000039 : decode = 64 + indexOffset;
					32'h0000003b : decode = 65 + indexOffset;
					32'h00000078 : decode = 66 + indexOffset;
					32'h0000007a : decode = 67 + indexOffset;
					32'h000000f7 : decode = 68 + indexOffset;
					32'h000000f9 : decode = 69 + indexOffset;
					32'h000001f6 : decode = 70 + indexOffset;
					
					32'h000001f9 : decode = 71 + indexOffset;
					32'h000003f4 : decode = 72 + indexOffset;
					32'h000003f6 : decode = 73 + indexOffset;
					32'h000003f8 : decode = 74 + indexOffset;
					32'h000007f5 : decode = 75 + indexOffset;
					32'h000007f4 : decode = 76 + indexOffset;
					32'h000007f6 : decode = 77 + indexOffset;
					32'h000007f7 : decode = 78 + indexOffset;
					32'h00000ff5 : decode = 79 + indexOffset;
					32'h00000ff8 : decode = 80 + indexOffset;

					32'h00001ff4 : decode = 81 + indexOffset;
					32'h00001ff6 : decode = 82 + indexOffset;
					32'h00001ff8 : decode = 83 + indexOffset;
					32'h00003ff8 : decode = 84 + indexOffset;
					32'h00003ff4 : decode = 85 + indexOffset;
					32'h0000fff0 : decode = 86 + indexOffset;
					32'h00007ff4 : decode = 87 + indexOffset;
					32'h0000fff6 : decode = 88 + indexOffset;
					32'h00007ff5 : decode = 89 + indexOffset;
					32'h0003ffe2 : decode = 90 + indexOffset;
					
					32'h0007ffd9 : decode = 91 + indexOffset;
					32'h0007ffda : decode = 92 + indexOffset;
					32'h0007ffdb : decode = 93 + indexOffset;
					32'h0007ffdc : decode = 94 + indexOffset;
					32'h0007ffdd : decode = 95 + indexOffset;
					32'h0007ffde : decode = 96 + indexOffset;
					32'h0007ffd8 : decode = 97 + indexOffset;
					32'h0007ffd2 : decode = 98 + indexOffset;
					32'h0007ffd3 : decode = 99 + indexOffset;
					32'h0007ffd4 : decode = 100 + indexOffset;
					
					32'h0007ffd5 : decode = 101 + indexOffset;
					32'h0007ffd6 : decode = 102 + indexOffset;
					32'h0007fff2 : decode = 103 + indexOffset;
					32'h0007ffdf : decode = 104 + indexOffset;
					32'h0007ffe7 : decode = 105 + indexOffset;
					32'h0007ffe8 : decode = 106 + indexOffset;
					32'h0007ffe9 : decode = 107 + indexOffset;					
					32'h0007ffea : decode = 108 + indexOffset;
					32'h0007ffeb : decode = 109 + indexOffset;
					32'h0007ffe6 : decode = 110 + indexOffset;
					
					32'h0007ffe0 : decode = 111 + indexOffset;
					32'h0007ffe1 : decode = 112 + indexOffset;
					32'h0007ffe2 : decode = 113 + indexOffset;
					32'h0007ffe3 : decode = 114 + indexOffset;
					32'h0007ffe4 : decode = 115 + indexOffset;
					32'h0007ffe5 : decode = 116 + indexOffset;
					32'h0007ffd7 : decode = 117 + indexOffset;
					32'h0007ffec : decode = 118 + indexOffset;
					32'h0007fff4 : decode = 119 + indexOffset;
					32'h0007fff3 : decode = 120 + indexOffset;
					
					default: 	decode = 1000;	
					
				endcase

		   end		   		

		   1:  //livro dos coeficientes TABLE A.2		   
		   begin
				case(codeword)
					
					32'h000007f8 : decode = 0;
					32'h000001f1 : decode = 1;
					32'h000007fd : decode = 2;
					32'h000003f5 : decode = 3;
					32'h00000068 : decode = 4;
					32'h000003f0 : decode = 5;
					32'h000007f7 : decode = 6;
					32'h000001ec : decode = 7;
					32'h000007f5 : decode = 8;
					32'h000003f1 : decode = 9;
					32'h00000072 : decode = 10;
					
					32'h000003f4 : decode = 11; 
					32'h00000074 : decode = 12; 
					32'h00000011 : decode = 13;
					32'h00000076 : decode = 14;
					32'h000001eb : decode = 15;
					32'h0000006c : decode = 16;
					32'h000003f6 : decode = 17;
					32'h000007fc : decode = 18;
					32'h000001e1 : decode = 19;
					32'h000007f1 : decode = 20;
					
					32'h000001f0 : decode = 21;
					32'h00000061 : decode = 22;
					32'h000001f6 : decode = 23;
					32'h000007f2 : decode = 24;
					32'h000001ea : decode = 25;
					32'h000007fb : decode = 26;
					32'h000001f2 : decode = 27;
					32'h00000069 : decode = 28;
					32'h000001ed : decode = 29;
					32'h00000077 : decode = 30;
					
					32'h00000017 : decode = 31;
					32'h0000006f : decode = 32;
					32'h000001e6 : decode = 33;
					32'h00000064 : decode = 34;
					32'h000001e5 : decode = 35;
					32'h00000067 : decode = 36;
					32'h00000015 : decode = 37;
					32'h00000062 : decode = 38;
					32'h00000012 : decode = 39;
					32'h00000000 : decode = 40;
					
					32'h00000014 : decode = 41;
					32'h00000065 : decode = 42;
					32'h00000016 : decode = 43;
					32'h0000006d : decode = 44;
					32'h000001e9 : decode = 45;
					32'h00000063 : decode = 46;
					32'h000001e4 : decode = 47;
					32'h0000006b : decode = 48;
					32'h00000013 : decode = 49;
					32'h00000071 : decode = 50;
					
					32'h000001e3 : decode = 51;
					32'h00000070 : decode = 52;
					32'h000001f3 : decode = 53;
					32'h000007fe : decode = 54;
					32'h000001e7 : decode = 55;
					32'h000007f3 : decode = 56;
					32'h000001ef : decode = 57;
					32'h00000060 : decode = 58;
					32'h000001ee : decode = 59;
					32'h000007f0 : decode = 60;
					
					32'h000001e2 : decode = 61;
					32'h000007fa : decode = 62;
					32'h000003f3 : decode = 63;
					32'h0000006a : decode = 64;
					32'h000001e8 : decode = 65;
					32'h00000075 : decode = 66;
					32'h00000010 : decode = 67;
					32'h00000073 : decode = 68;
					32'h000001f4 : decode = 69;
					32'h0000006e : decode = 70;
					
					32'h000003f7 : decode = 71;
					32'h000007f6 : decode = 72;
					32'h000001e0 : decode = 73;
					32'h000007f9 : decode = 74;
					32'h000003f2 : decode = 75;
					32'h00000066 : decode = 76;
					32'h000001f5 : decode = 77;
					32'h000007ff : decode = 78;
					32'h000001f7 : decode = 79;
					32'h000007f4 : decode = 80;
					
					default: decode = 1000;
					
				endcase
		   end

		   
		   2:  //livro dos coeficientes TABLE A.3		   
		   begin
				case(codeword)
					
					32'h000001f3 : decode = 0;
					32'h0000006f : decode = 1;
					32'h000001fd : decode = 2;
					32'h000000eb : decode = 3;
					32'h00000023 : decode = 4;
					32'h000000ea : decode = 5;
					32'h000001f7 : decode = 6;
					32'h000000e8 : decode = 7;
					32'h000001fa : decode = 8;
					32'h000000f2 : decode = 9;
					32'h0000002d : decode = 10;
					
					32'h00000070 : decode = 11; 
					32'h00000020 : decode = 12; 
					32'h00000006 : decode = 13;
					32'h0000002b : decode = 14;
					32'h0000006e : decode = 15;
					32'h00000028 : decode = 16;
					32'h000000e9 : decode = 17;
					32'h000001f9 : decode = 18;
					32'h00000066 : decode = 19;
					32'h000000f8 : decode = 20;
					
					32'h000000e7 : decode = 21;
					32'h0000001b : decode = 22;
					32'h000000f1 : decode = 23;
					32'h000001f4 : decode = 24;
					32'h0000006b : decode = 25;
					32'h000001f5 : decode = 26;
					32'h000000ec : decode = 27;
					32'h0000002a : decode = 28;
					32'h0000006c : decode = 29;
					32'h0000002c : decode = 30;
					
					32'h0000000a : decode = 31;
					32'h00000027 : decode = 32;
					32'h00000067 : decode = 33;
					32'h0000001a : decode = 34;
					32'h000000f5 : decode = 35;
					32'h00000024 : decode = 36;
					32'h00000008 : decode = 37;
					32'h0000001f : decode = 38;
					32'h00000009 : decode = 39;
					32'h00000000 : decode = 40;
					
					32'h00000007 : decode = 41;
					32'h0000001d : decode = 42;
					32'h0000000b : decode = 43;
					32'h00000030 : decode = 44;
					32'h000000ef : decode = 45;
					32'h0000001c : decode = 46;
					32'h00000064 : decode = 47;
					32'h0000001e : decode = 48;
					32'h0000000c : decode = 49;
					32'h00000029 : decode = 50;
					
					32'h000000f3 : decode = 51;
					32'h0000002f : decode = 52;
					32'h000000f0 : decode = 53;
					32'h000001fc : decode = 54;
					32'h00000071 : decode = 55;
					32'h000001f2 : decode = 56;
					32'h000000f4 : decode = 57;
					32'h00000021 : decode = 58;
					32'h000000e6 : decode = 59;
					32'h000000f7 : decode = 60;
					
					32'h00000068 : decode = 61;
					32'h000001f8 : decode = 62;
					32'h000000ee : decode = 63;
					32'h00000022 : decode = 64;
					32'h00000065 : decode = 65;
					32'h00000031 : decode = 66;
					32'h00000002 : decode = 67;
					32'h00000026 : decode = 68;
					32'h000000ed : decode = 69;
					32'h00000025 : decode = 70;
					
					32'h0000006a : decode = 71;
					32'h000001fb : decode = 72;
					32'h00000072 : decode = 73;
					32'h000001fe : decode = 74;
					32'h00000069 : decode = 75;
					32'h0000002e : decode = 76;
					32'h000000f6 : decode = 77;
					32'h000001ff : decode = 78;
					32'h0000006d : decode = 79;
					32'h000001f6 : decode = 80;
					
					default: decode = 1000;
					
				endcase
		   end
		   
		   3:  //livro dos coeficientes TABLE A.4
		   begin
				case(codeword)
					
					32'h00000000 : decode = 0;
					32'h00000009 : decode = 1;
					32'h000000ef : decode = 2;
					32'h0000000b : decode = 3;
					32'h00000019 : decode = 4;
					32'h000000f0 : decode = 5;
					32'h000001eb : decode = 6;
					32'h000001e6 : decode = 7;
					32'h000003f2 : decode = 8;
					32'h0000000a : decode = 9;
					32'h00000035 : decode = 10;
					
					32'h000001ef : decode = 11; 
					32'h00000034 : decode = 12; 
					32'h00000037 : decode = 13;
					32'h000001e9 : decode = 14;
					32'h000001ed : decode = 15;
					32'h000001e7 : decode = 16;
					32'h000003f3 : decode = 17;
					32'h000001ee : decode = 18;
					32'h000003ed : decode = 19;
					32'h00001ffa : decode = 20;
					
					32'h000001ec : decode = 21;
					32'h000001f2 : decode = 22;
					32'h000007f9 : decode = 23;
					32'h000007f8 : decode = 24;
					32'h000003f8 : decode = 25;
					32'h00000ff8 : decode = 26;
					32'h00000008 : decode = 27;
					32'h00000038 : decode = 28;
					32'h000003f6 : decode = 29;
					32'h00000036 : decode = 30;
					
					32'h00000075 : decode = 31;
					32'h000003f1 : decode = 32;
					32'h000003eb : decode = 33;
					32'h000003ec : decode = 34;
					32'h00000ff4 : decode = 35;
					32'h00000018 : decode = 36;
					32'h00000076 : decode = 37;
					32'h000007f4 : decode = 38;
					32'h00000039 : decode = 39;
					32'h00000074 : decode = 40;
					
					32'h000003ef : decode = 41;
					32'h000001f3 : decode = 42;
					32'h000001f4 : decode = 43;
					32'h000007f6 : decode = 44;
					32'h000001e8 : decode = 45;
					32'h000003ea : decode = 46;
					32'h00001ffc : decode = 47;
					32'h000000f2 : decode = 48;
					32'h000001f1 : decode = 49;
					32'h00000ffb : decode = 50;
					
					32'h000003f5 : decode = 51;
					32'h000007f3 : decode = 52;
					32'h00000ffc : decode = 53;
					32'h000000ee : decode = 54;
					32'h000003f7 : decode = 55;
					32'h00007ffe : decode = 56;
					32'h000001f0 : decode = 57;
					32'h000007f5 : decode = 58;
					32'h00007ffd : decode = 59;
					32'h00001ffb : decode = 60;
					
					32'h00003ffa : decode = 61;
					32'h0000ffff : decode = 62;
					32'h000000f1 : decode = 63;
					32'h000003f0 : decode = 64;
					32'h00003ffc : decode = 65;
					32'h000001ea : decode = 66;
					32'h000003ee : decode = 67;
					32'h00003ffb : decode = 68;
					32'h00000ff6 : decode = 69;
					32'h00000ffa : decode = 70;
					
					32'h00007ffc : decode = 71;
					32'h000007f2 : decode = 72;
					32'h00000ff5 : decode = 73;
					32'h0000fffe : decode = 74;
					32'h000003f4 : decode = 75;
					32'h000007f7 : decode = 76;
					32'h00007ffb : decode = 77;
					32'h00000ff7 : decode = 78;
					32'h00000ff9 : decode = 79;
					32'h00007ffa : decode = 80;
					
					default: decode = 1000;
					
				endcase
		   end
		   
		   4:  //livro dos coeficientes TABLE A.5
		   begin
				case(codeword)
					
					32'h00000007 : decode = 0;
					32'h00000016 : decode = 1;
					32'h00000016 : decode = 2;
					32'h00000018 : decode = 3;
					32'h00000008 : decode = 4;
					32'h000000ef : decode = 5;
					32'h000001ef : decode = 6;
					32'h000000f3 : decode = 7;
					32'h000007f8 : decode = 8;
					32'h00000019 : decode = 9;
					32'h00000017 : decode = 10;
					
					32'h000000ed : decode = 11; 
					32'h00000015 : decode = 12; 
					32'h00000001 : decode = 13;
					32'h000000e2 : decode = 14;
					32'h000000f0 : decode = 15;
					32'h00000070 : decode = 16;
					32'h000003f0 : decode = 17;
					32'h000001ee : decode = 18;
					32'h000000f1 : decode = 19;
					32'h000007fa : decode = 20;
					
					32'h000000ee : decode = 21;
					32'h000000e4 : decode = 22;
					32'h000003f2 : decode = 23;
					32'h000007f6 : decode = 24;
					32'h000003ef : decode = 25;
					32'h000007fd : decode = 26;
					32'h00000005 : decode = 27;
					32'h00000014 : decode = 28;
					32'h000003f2 : decode = 29;
					32'h00000009 : decode = 30;
					
					32'h00000004 : decode = 31;
					32'h000000e5 : decode = 32;
					32'h000000f4 : decode = 33;
					32'h000000e8 : decode = 34;
					32'h000003f4 : decode = 35;
					32'h00000006 : decode = 36;
					32'h00000002 : decode = 37;
					32'h000000e7 : decode = 38;
					32'h00000003 : decode = 39;
					32'h00000000 : decode = 40;
					
					32'h0000006b : decode = 41;
					32'h000000e3 : decode = 42;
					32'h00000069 : decode = 43;
					32'h000001f3 : decode = 44;
					32'h000000eb : decode = 45;
					32'h000000e6 : decode = 46;
					32'h000003f6 : decode = 47;
					32'h0000006e : decode = 48;
					32'h0000006a : decode = 49;
					32'h000001f4 : decode = 50;
					
					32'h000003ec : decode = 51;
					32'h000001f0 : decode = 52;
					32'h000003f9 : decode = 53;
					32'h000000f5 : decode = 54;
					32'h000000ec : decode = 55;
					32'h000007fb : decode = 56;
					32'h000000ea : decode = 57;
					32'h0000006f : decode = 58;
					32'h000003f7 : decode = 59;
					32'h000007f9 : decode = 60;
					
					32'h000003f3 : decode = 61;
					32'h00000fff : decode = 62;
					32'h000000e9 : decode = 63;
					32'h0000006d : decode = 64;
					32'h000003f8 : decode = 65;
					32'h0000006c : decode = 66;
					32'h00000068 : decode = 67;
					32'h000001f5 : decode = 68;
					32'h000003ee : decode = 69;
					32'h000001f2 : decode = 70;
					
					32'h000007f4 : decode = 71;
					32'h000007f7 : decode = 72;
					32'h000003f1 : decode = 73;
					32'h00000ffe : decode = 74;
					32'h000003ed : decode = 75;
					32'h000001f1 : decode = 76;
					32'h000007f5 : decode = 77;
					32'h000007fe : decode = 78;
					32'h000003f5 : decode = 79;
					32'h000007fc : decode = 80;
					
					default: decode = 1000;
					
				endcase
		   end
		   
		   5:  //livro dos coeficientes TABLE A.6
		   begin
				case(codeword)
					
					32'h00001fff : decode = 0;
					32'h00000ff7 : decode = 1;
					32'h000007f4 : decode = 2;
					32'h000007e8 : decode = 3;
					32'h000003f1 : decode = 4;
					32'h000007ee : decode = 5;
					32'h000007f9 : decode = 6;
					32'h00000ff8 : decode = 7;
					32'h00001ffd : decode = 8;
					32'h00000ffd : decode = 9;
					32'h000007f1 : decode = 10;
					
					32'h000003e8 : decode = 11; 
					32'h000001e8 : decode = 12; 
					32'h000000f0 : decode = 13;
					32'h000001ec : decode = 14;
					32'h000003ee : decode = 15;
					32'h000007f2 : decode = 16;
					32'h00000ffa : decode = 17;
					32'h00000ff4 : decode = 18;
					32'h000003ef : decode = 19;
					32'h000001f2 : decode = 20;
					
					32'h000000ee : decode = 21;
					32'h000000e4 : decode = 22;
					32'h000003f2 : decode = 23;
					32'h000007f6 : decode = 24;
					32'h000003ef : decode = 25;
					32'h000007fd : decode = 26;
					32'h00000005 : decode = 27;
					32'h00000014 : decode = 28;
					32'h000003f2 : decode = 29;
					32'h00000009 : decode = 30;
					
					32'h00000008 : decode = 31;
					32'h00000019 : decode = 32;
					32'h000000ee : decode = 33;
					32'h000001ef : decode = 34;
					32'h000007ed : decode = 35;
					32'h000003f0 : decode = 36;
					32'h000000f2 : decode = 37;
					32'h00000073 : decode = 38;
					32'h0000000b : decode = 39;
					32'h00000000 : decode = 40;
					
					32'h0000000a : decode = 41;
					32'h00000071 : decode = 42;
					32'h000000f3 : decode = 43;
					32'h000007e9 : decode = 44;
					32'h000007ef : decode = 45;
					32'h000001ee : decode = 46;
					32'h000000ef : decode = 47;
					32'h00000018 : decode = 48;
					32'h00000009 : decode = 49;
					32'h0000001b : decode = 50;
					
					32'h000000eb : decode = 51;
					32'h000001e9 : decode = 52;
					32'h000007ec : decode = 53;
					32'h000007f6 : decode = 54;
					32'h000003eb : decode = 55;
					32'h000001f3 : decode = 56;
					32'h000000ed : decode = 57;
					32'h00000072 : decode = 58;
					32'h000000e9 : decode = 59;
					32'h000001f1 : decode = 60;
					
					32'h000003ed : decode = 61;
					32'h000007f7 : decode = 62;
					32'h00000ff6 : decode = 63;
					32'h000007f0 : decode = 64;
					32'h000003e9 : decode = 65;
					32'h000001ed : decode = 66;
					32'h000000f1 : decode = 67;
					32'h000001ea : decode = 68;
					32'h000003ec : decode = 69;
					32'h000007f8 : decode = 70;
					
					32'h00000ff9 : decode = 71;
					32'h00001ffc : decode = 72;
					32'h00000ffc : decode = 73;
					32'h00000ff5 : decode = 74;
					32'h000007ea : decode = 75;
					32'h000003f3 : decode = 76;
					32'h000003f2 : decode = 77;
					32'h000007f5 : decode = 78;
					32'h00000ffb : decode = 79;
					32'h00001ffe : decode = 80;
					
					default: decode = 1000;
					
				endcase
		   end
		   
		   6:  //livro dos coeficientes TABLE A.7
		   begin
				case(codeword)
					
					32'h000007fe : decode = 0;
					32'h000003fd : decode = 1;
					32'h000001f1 : decode = 2;
					32'h000001eb : decode = 3;
					32'h000001f4 : decode = 4;
					32'h000001ea : decode = 5;
					32'h000001f0 : decode = 6;
					32'h000003fc : decode = 7;
					32'h000007fd : decode = 8;
					32'h000003f6 : decode = 9;
					32'h000001e5 : decode = 10;
					
					32'h000000ea : decode = 11; 
					32'h0000006c : decode = 12; 
					32'h00000071 : decode = 13;
					32'h00000068 : decode = 14;
					32'h000000f0 : decode = 15;
					32'h000001e6 : decode = 16;
					32'h000003f7 : decode = 17;
					32'h000001f3 : decode = 18;
					32'h000000ef : decode = 19;
					32'h00000032 : decode = 20;
					
					32'h00000027 : decode = 21;
					32'h00000028 : decode = 22;
					32'h00000026 : decode = 23;
					32'h00000031 : decode = 24;
					32'h000000eb : decode = 25;
					32'h000001f7 : decode = 26;
					32'h000001e8 : decode = 27;
					32'h0000006f : decode = 28;
					32'h0000002e : decode = 29;
					32'h00000008 : decode = 30;
					
					32'h00000004 : decode = 31;
					32'h00000006 : decode = 32;
					32'h00000029 : decode = 33;
					32'h0000006b : decode = 34;
					32'h000001ee : decode = 35;
					32'h000001ef : decode = 36;
					32'h00000072 : decode = 37;
					32'h0000002d : decode = 38;
					32'h00000002 : decode = 39;
					32'h00000000 : decode = 40;//FIXME
					
					32'h00000003 : decode = 41;
					32'h0000002f : decode = 42;
					32'h00000073 : decode = 43;
					32'h000001fa : decode = 44;
					32'h000001e7 : decode = 45;
					32'h0000006e : decode = 46;
					32'h0000002b : decode = 47;
					32'h00000007 : decode = 48;
					32'h00000001 : decode = 49;
					32'h00000005 : decode = 50;
					
					32'h0000002c: decode = 51;
					32'h0000006d : decode = 52;
					32'h000001ec : decode = 53;
					32'h000001f9 : decode = 54;
					32'h000000ee : decode = 55;
					32'h00000030 : decode = 56;
					32'h00000024 : decode = 57;
					32'h0000002a : decode = 58;
					32'h00000025 : decode = 59;
					32'h00000033 : decode = 60;
					
					32'h000000ec : decode = 61;
					32'h000001f2 : decode = 62;
					32'h000003f8 : decode = 63;
					32'h000001e4 : decode = 64;
					32'h000000ed : decode = 65;
					32'h0000006a : decode = 66;
					32'h00000070 : decode = 67;
					32'h00000069 : decode = 68;
					32'h00000074 : decode = 69;
					32'h000000f1 : decode = 70;
					
					32'h000003fa : decode = 71;
					32'h000007ff : decode = 72;
					32'h000003f9 : decode = 73;
					32'h000001f6 : decode = 74;
					32'h000001ed : decode = 75;
					32'h000001f8 : decode = 76;
					32'h000001e9 : decode = 77;
					32'h000001f5 : decode = 78;
					32'h000003fb : decode = 79;
					32'h000007fc : decode = 80;
					
					default: decode = 1000;
					
				endcase
		   end
		   
		   7:  //livro dos coeficientes TABLE A.8
		   begin
				case(codeword)
					
					32'h00000000 : decode = 0;
					32'h00000005 : decode = 1;
					32'h00000037 : decode = 2;
					32'h00000074 : decode = 3;
					32'h000000f2 : decode = 4;
					32'h000001eb : decode = 5;
					32'h000003ed : decode = 6;
					32'h000007f7 : decode = 7;
					32'h00000004 : decode = 8;
					32'h0000000c : decode = 9;
					32'h00000035 : decode = 10;
					
					32'h00000071 : decode = 11; 
					32'h000000ec : decode = 12; 
					32'h000000ee : decode = 13;
					32'h000001ee : decode = 14;
					32'h000001f5 : decode = 15;
					32'h00000036 : decode = 16;
					32'h00000034 : decode = 17;
					32'h00000072 : decode = 18;
					32'h000000ea : decode = 19;
					32'h000000f1 : decode = 20;
					
					32'h000001e9 : decode = 21;
					32'h000001f3 : decode = 22;
					32'h000003f5 : decode = 23;
					32'h00000073 : decode = 24;
					32'h00000070 : decode = 25;
					32'h000000eb : decode = 26;
					32'h000000f0 : decode = 27;
					32'h000001f1 : decode = 28;
					32'h000001f0 : decode = 29;
					32'h000003ec : decode = 30;
					
					32'h000003fa : decode = 31;
					32'h000000f3 : decode = 32;
					32'h000000ed : decode = 33;
					32'h000001e8 : decode = 34;
					32'h000001ef : decode = 35;
					32'h000003ef : decode = 36;
					32'h000003f1 : decode = 37;
					32'h000003f9 : decode = 38;
					32'h000007fb : decode = 39;
					32'h000001ed : decode = 40;
					
					32'h000000ef : decode = 41;
					32'h000001ea : decode = 42;
					32'h000001f2 : decode = 43;
					32'h000003f3 : decode = 44;
					32'h000003f8 : decode = 45;
					32'h000007f9 : decode = 46;
					32'h000007fc : decode = 47;
					32'h000003ee : decode = 48;
					32'h000001ec : decode = 49;
					32'h000001f4 : decode = 50;
					
					32'h000003f4: decode = 51;
					32'h000003f7 : decode = 52;
					32'h000007f8 : decode = 53;
					32'h00000ffd : decode = 54;
					32'h00000ffe : decode = 55;
					32'h000007f6 : decode = 56;
					32'h000003f0 : decode = 57;
					32'h000003f2 : decode = 58;
					32'h000003f6 : decode = 59;
					32'h000007fa : decode = 60;
					
					32'h000007fd : decode = 61;
					32'h00000ffc : decode = 62;
					32'h00000fff : decode = 63;
					
					default: decode = 1000;
					
				endcase
		   end
		   
		   8:  //livro dos coeficientes TABLE A.9
		   begin
				case(codeword)
					
					32'h0000000e : decode = 0;
					32'h00000005 : decode = 1;
					32'h00000010 : decode = 2;
					32'h00000030 : decode = 3;
					32'h0000006f : decode = 4;
					32'h000000f1 : decode = 5;
					32'h000001fa : decode = 6;
					32'h000003fe : decode = 7;
					32'h00000003 : decode = 8;
					32'h00000000 : decode = 9; //FIXME
					32'h00000004 : decode = 10;
					
					32'h00000012 : decode = 11; 
					32'h0000002c : decode = 12; 
					32'h0000006a : decode = 13;
					32'h00000075 : decode = 14;
					32'h000000f8 : decode = 15;
					32'h0000000f : decode = 16;
					32'h00000002 : decode = 17;
					32'h00000006 : decode = 18;
					32'h00000014 : decode = 19;
					32'h0000002e : decode = 20;
					
					32'h00000069 : decode = 21;
					32'h00000072 : decode = 22;
					32'h000000f5 : decode = 23;
					32'h0000002f : decode = 24;
					32'h00000011 : decode = 25;
					32'h00000013 : decode = 26;
					32'h0000002a : decode = 27;
					32'h00000032 : decode = 28;
					32'h0000006c : decode = 29;
					32'h000000ec : decode = 30;
					
					32'h000000fa : decode = 31;
					32'h00000071 : decode = 32;
					32'h0000002b : decode = 33;
					32'h0000002d : decode = 34;
					32'h00000031 : decode = 35;
					32'h0000006d : decode = 36;
					32'h00000070 : decode = 37;
					32'h000000f2 : decode = 38;
					32'h000001f9 : decode = 39;
					32'h000000ef : decode = 40;
					
					32'h00000068 : decode = 41;
					32'h00000033 : decode = 42;
					32'h0000006b : decode = 43;
					32'h0000006e : decode = 44;
					32'h000000ee : decode = 45;
					32'h000000f9 : decode = 46;
					32'h000003fc : decode = 47;
					32'h000001f8 : decode = 48;
					32'h00000074 : decode = 49;
					32'h00000073 : decode = 50;
					
					32'h000000ed: decode = 51;
					32'h000000f0 : decode = 52;
					32'h000000f6 : decode = 53;
					32'h000001f6 : decode = 54;
					32'h000001fd : decode = 55;
					32'h000003fd : decode = 56;
					32'h000000f3 : decode = 57;
					32'h000000f4 : decode = 58;
					32'h000000f7 : decode = 59;
					32'h000001f7 : decode = 60;
					
					32'h000001fb : decode = 61;
					32'h000001fc : decode = 62;
					32'h000003ff : decode = 63;
					
					default: decode = 1000;
					
				endcase
		   end
		   
		   9:  //livro dos coeficientes TABLE A.10
		   begin
				case(codeword)
					
					32'h00000000 : decode = 0;
					32'h00000005 : decode = 1;
					32'h00000037 : decode = 2;
					32'h000000e7 : decode = 3;
					32'h000001de : decode = 4;
					32'h000003ce : decode = 5;
					32'h000003d9 : decode = 6;
					32'h000007c8 : decode = 7;
					32'h000007cd : decode = 8;
					32'h00000fc8: decode = 9;
					32'h00000fdd : decode = 10;
					
					32'h00001fe4 : decode = 11; 
					32'h00001fec : decode = 12; 
					32'h00000004 : decode = 13;
					32'h0000000c : decode = 14;
					32'h00000035 : decode = 15;
					32'h00000072 : decode = 16;
					32'h000000ea : decode = 17;
					32'h000000ed : decode = 18;
					32'h000001e2 : decode = 19;
					32'h000003d1 : decode = 20;
					
					32'h000003d3 : decode = 21;
					32'h000003e0 : decode = 22;
					32'h000007d8 : decode = 23;
					32'h00000fcf : decode = 24;
					32'h00000fd5 : decode = 25;
					32'h00000036 : decode = 26;
					32'h00000034 : decode = 27;
					32'h00000071 : decode = 28;
					32'h000000e8 : decode = 29;
					32'h000000ec : decode = 30;
					
					32'h000001e1 : decode = 31;
					32'h000003cf : decode = 32;
					32'h000003dd : decode = 33;
					32'h000003db : decode = 34;
					32'h000007d0 : decode = 35;
					32'h00000fc7 : decode = 36;
					32'h00000fd4 : decode = 37;
					32'h00000fe4 : decode = 38;
					32'h000000e6 : decode = 39;
					32'h00000070 : decode = 40;
					
					32'h000000e9 : decode = 41;
					32'h000001dd : decode = 42;
					32'h000001e3 : decode = 43;
					32'h000003d2 : decode = 44;
					32'h000003dc : decode = 45;
					32'h000007cc : decode = 46;
					32'h000007ca : decode = 47;
					32'h000007de : decode = 48;
					32'h00000fd8 : decode = 49;
					32'h00000fea : decode = 50;
					
					32'h00001fdb : decode = 51;
					32'h000001df : decode = 52;
					32'h000000eb : decode = 53;
					32'h000001dc : decode = 54;
					32'h000001e6 : decode = 55;
					32'h000003d5 : decode = 56;
					32'h000003de : decode = 57;
					32'h000007cb : decode = 58;
					32'h000007dd : decode = 59;
					32'h000007dc : decode = 60;
					
					32'h00000fcd : decode = 61;
					32'h00000fe2 : decode = 62;
					32'h00000fe7 : decode = 63;
					32'h00001fe1 : decode = 64;
					32'h000003d0 : decode = 65;
					32'h000001e0 : decode = 66;
					32'h000001e4 : decode = 67;
					32'h000003d6 : decode = 68;
					32'h000007c5 : decode = 69;
					32'h000007d1 : decode = 70;
					
					32'h000007db : decode = 71;
					32'h00000fd2 : decode = 72;
					32'h000007e0 : decode = 73;
					32'h00000fd9 : decode = 74;
					32'h00000feb : decode = 75;
					32'h00001fe3 : decode = 76;
					32'h00001fe9 : decode = 77;
					32'h000007c4 : decode = 78;
					32'h000001e5 : decode = 79;
					32'h000003d7 : decode = 80;
					
					32'h000007c6 : decode = 81;
					32'h000007cf : decode = 82;
					32'h000007da : decode = 83;
					32'h00000fcb : decode = 84;
					32'h00000fcb : decode = 85;
					32'h00000fe3 : decode = 86;
					32'h00000fe9 : decode = 87;
					32'h00001fe6 : decode = 88;
					32'h00001ff3 : decode = 89;
					32'h00001ff7 : decode = 90;
					
					32'h000007d3 : decode = 91;
					32'h000003d8 : decode = 92;
					32'h000003e1 : decode = 93;
					32'h000007d4 : decode = 94;
					32'h000007d9 : decode = 95;
					32'h00000fd3 : decode = 96;
					32'h00000fde : decode = 97;
					32'h00001fdd : decode = 98;
					32'h00001fd9 : decode = 99;
					32'h00001fe2 : decode = 100;
					
					32'h00001fea : decode = 101;
					32'h00001ff1 : decode = 102;
					32'h00001ff6 : decode = 103;
					32'h000007d2 : decode = 104;
					32'h000003d4 : decode = 105;
					32'h000003da : decode = 106;
					32'h000007c7 : decode = 107;
					32'h000007d7 : decode = 108;
					32'h000007e2 : decode = 109;
					32'h00000fce : decode = 110;
					
					32'h00000fdb : decode = 111;
					32'h00001fd8 : decode = 112;
					32'h00001fee : decode = 113;
					32'h00003ff0 : decode = 114;
					32'h00001ff4 : decode = 115;
					32'h00003ff2 : decode = 116;
					32'h000007e1 : decode = 117;
					32'h000003df : decode = 118;
					32'h000007c9 : decode = 119;
					32'h000007d6 : decode = 120;
					
					32'h00000fca : decode = 121;
					32'h00000fd0 : decode = 122;
					32'h00000fe5 : decode = 123;
					32'h00000fe6 : decode = 124;
					32'h00001feb : decode = 125;
					32'h00001fef : decode = 126;
					32'h00003ff3 : decode = 127;
					32'h00003ff4 : decode = 128;
					32'h00003ff5 : decode = 129;
					32'h00000fe0 : decode = 130;
					
					32'h000007ce : decode = 131;
					32'h000007d5 : decode = 132;
					32'h00000fc6 : decode = 133;
					32'h00000fd1 : decode = 134;
					32'h00000fe1 : decode = 135;
					32'h00001fe0 : decode = 136;
					32'h00001fe8 : decode = 137;
					32'h00001ff0 : decode = 138;
					32'h00003ff1 : decode = 139;
					32'h00003ff8 : decode = 140;
					
					32'h00003ff6 : decode = 141;
					32'h00007ffc : decode = 142;
					32'h00000fe8 : decode = 143;
					32'h000007df : decode = 144;
					32'h00000fc9 : decode = 145;
					32'h00000fd7 : decode = 146;
					32'h00000fdc : decode = 147;
					32'h00001fdc : decode = 148;
					32'h00001fdf : decode = 149;
					32'h00001fed : decode = 150;
					
					32'h00001ff5 : decode = 151;
					32'h00003ff9 : decode = 152;
					32'h00003ffb : decode = 153;
					32'h00007ffd : decode = 154;
					32'h00007ffe : decode = 155;
					32'h00001fe7 : decode = 156;
					32'h00000fcc : decode = 157;
					32'h00000fd6 : decode = 158;
					32'h00000fdf : decode = 159;
					32'h00001fde : decode = 160;
					
					32'h00001fda : decode = 161;
					32'h00001fe5 : decode = 162;
					32'h00001ff2 : decode = 163;
					32'h00003ffa : decode = 164;
					32'h00003ff7 : decode = 165;
					32'h00003ffc : decode = 166;
					32'h00003ffd : decode = 167;
					32'h00007fff : decode = 168;

					
					default: decode = 1000;
					
				endcase
		   end
		   
		   10:  //livro dos coeficientes TABLE A.11
		   begin
				case(codeword)
					
					32'h00000022 : decode = 0;
					32'h00000008 : decode = 1;
					32'h0000001d : decode = 2;
					32'h00000026 : decode = 3;
					32'h0000005f : decode = 4;
					32'h000000d3 : decode = 5;
					32'h000001cf : decode = 6;
					32'h000003d0 : decode = 7;
					32'h000003d7 : decode = 8;
					32'h000003ed : decode = 9;
					32'h000007f0 : decode = 10;					
					32'h000007f6 : decode = 11; 
					32'h00000ffd : decode = 12; 
					32'h00000007 : decode = 13;
					32'h00000000 : decode = 14; //FIXME
					32'h00000001 : decode = 15;
					32'h00000009 : decode = 16;
					32'h00000020 : decode = 17;
					32'h00000054 : decode = 18;
					32'h00000060 : decode = 19;
					32'h000000d5 : decode = 20;
					
					32'h000000dc : decode = 21;
					32'h000001d4 : decode = 22;
					32'h000003cd : decode = 23;
					32'h000003de : decode = 24;
					32'h000007e7 : decode = 25;
					32'h0000001c : decode = 26;
					32'h00000002 : decode = 27;
					32'h00000006 : decode = 28;
					32'h0000000c : decode = 29;
					32'h0000001e : decode = 30;
					
					32'h00000028 : decode = 31;
					32'h0000005b : decode = 32;
					32'h000000cd : decode = 33;
					32'h000000d9 : decode = 34;
					32'h000001ce : decode = 35;
					32'h000001dc : decode = 36;
					32'h000003d9 : decode = 37;
					32'h000003f1 : decode = 38;
					32'h00000025 : decode = 39;
					32'h0000000b : decode = 40;
					
					32'h0000000a : decode = 41;
					32'h0000000d : decode = 42;
					32'h00000024 : decode = 43;
					32'h00000057 : decode = 44;
					32'h00000061 : decode = 45;
					32'h000000cc : decode = 46;
					32'h000000dd : decode = 47;
					32'h000001cc : decode = 48;
					32'h000001de : decode = 49;
					32'h000003d3 : decode = 50;
					
					32'h000003e7 : decode = 51;
					32'h0000005d : decode = 52;
					32'h00000021 : decode = 53;
					32'h0000001f : decode = 54;
					32'h00000023 : decode = 55;
					32'h00000027 : decode = 56;
					32'h00000059 : decode = 57;
					32'h00000064 : decode = 58;
					32'h000000d8 : decode = 59;
					32'h000000df : decode = 60;
					
					32'h000001d2 : decode = 61;
					32'h000001e2 : decode = 62;
					32'h000003dd : decode = 63;
					32'h000003ee : decode = 64;
					32'h000000d1 : decode = 65;
					32'h00000055 : decode = 66;
					32'h00000029 : decode = 67;
					32'h00000056 : decode = 68;
					32'h00000058 : decode = 69;
					32'h00000062 : decode = 70;
					
					32'h000000ce : decode = 71;
					32'h000000e0 : decode = 72;
					32'h000000e2 : decode = 73;
					32'h000001da : decode = 74;
					32'h000003d4 : decode = 75;
					32'h000003e3 : decode = 76;
					32'h000007eb : decode = 77;
					32'h000001c9 : decode = 78;
					32'h0000005e : decode = 79;
					32'h0000005a : decode = 80;
					
					32'h0000005c : decode = 81;
					32'h00000063 : decode = 82;
					32'h000000ca : decode = 83;
					32'h000000da : decode = 84;
					32'h000001c7 : decode = 85;
					32'h000001ca : decode = 86;
					32'h000001e0 : decode = 87;
					32'h000003db : decode = 88;
					32'h000003e8 : decode = 89;
					32'h000007ec : decode = 90;
					
					32'h000001e3 : decode = 91;
					32'h000000d2 : decode = 92;
					32'h000000cb : decode = 93;
					32'h000000d0 : decode = 94;
					32'h000000d7 : decode = 95;
					32'h000000db : decode = 96;
					32'h000001c6 : decode = 97;
					32'h000001d5 : decode = 98;
					32'h000001d8 : decode = 99;
					32'h000003ca : decode = 100;
					
					32'h000003da : decode = 101;
					32'h000007ea : decode = 102;
					32'h000007f1 : decode = 103;
					32'h000001e1 : decode = 104;
					32'h000000d4 : decode = 105;
					32'h000000cf : decode = 106;
					32'h000000d6 : decode = 107;
					32'h000000de : decode = 108;
					32'h000000e1 : decode = 109;
					32'h000001d0 : decode = 110;
					
					32'h000001d6 : decode = 111;
					32'h000003d1 : decode = 112;
					32'h000003d5 : decode = 113;
					32'h000003f2 : decode = 114;
					32'h000007ee : decode = 115;
					32'h000007fb : decode = 116;
					32'h000003e9 : decode = 117;
					32'h000001cd : decode = 118;
					32'h000001c8 : decode = 119;
					32'h000001cb : decode = 120;
					
					32'h000001d1 : decode = 121;
					32'h000001d7 : decode = 122;
					32'h000001df : decode = 123;
					32'h000003cf : decode = 124;
					32'h000003e0 : decode = 125;
					32'h000003ef : decode = 126;
					32'h000007e6 : decode = 127;
					32'h000007f8 : decode = 128;
					32'h00000ffa : decode = 129;
					32'h000003eb : decode = 130;
					
					32'h000001dd : decode = 131;
					32'h000001d3 : decode = 132;
					32'h000001d9 : decode = 133;
					32'h000001db : decode = 134;
					32'h000003d2 : decode = 135;
					32'h000003cc : decode = 136;
					32'h000003dc : decode = 137;
					32'h000003ea : decode = 138;
					32'h000007ed : decode = 139;
					32'h000007f3 : decode = 140;
					
					32'h000007f9 : decode = 141;
					32'h00000ff9 : decode = 142;
					32'h000007f2 : decode = 143;
					32'h000003ce : decode = 144;
					32'h000001e4 : decode = 145;
					32'h000003cb : decode = 146;
					32'h000003d8 : decode = 147;
					32'h000003d6 : decode = 148;
					32'h000003e2 : decode = 149;
					32'h000003e5 : decode = 150;
					
					32'h000007e8 : decode = 151;
					32'h000007f4 : decode = 152;
					32'h000007f5 : decode = 153;
					32'h000007f7 : decode = 154;
					32'h00000ffb : decode = 155;
					32'h000007fa : decode = 156;
					32'h000003ec : decode = 157;
					32'h000003df : decode = 158;
					32'h000003e1 : decode = 159;
					32'h000003e4 : decode = 160;
					
					32'h000003e6 : decode = 161;
					32'h000003f0 : decode = 162;
					32'h000007e9 : decode = 163;
					32'h000007ef : decode = 164;
					32'h00000ff8 : decode = 165;
					32'h00000ffe : decode = 166;
					32'h00000ffc : decode = 167;
					32'h00000fff : decode = 168;

					
					default: decode = 1000;
					
				endcase
		   end
		   
		   11:  //livro dos coeficientes TABLE A.12
		   begin
				case(codeword)
					
					32'h00000000: decode = 0;
					32'h00000006: decode = 1;
					32'h00000019: decode = 2;
					32'h0000003d: decode = 3;
					32'h0000009c: decode = 4;
					32'h000000c6: decode = 5;
					32'h000001a7: decode = 6;
					32'h00000390: decode = 7;
					32'h000003c2: decode = 8;
					32'h000003df: decode = 9;
					32'h000007e6: decode = 10;
					
					32'h000007f3 : decode = 11; 
					32'h00000ffb : decode = 12; 
					32'h000007ec : decode = 13;
					32'h00000ffa : decode = 14; //FIXME
					32'h00000ffe : decode = 15;
					32'h0000038e : decode = 16;
					32'h00000005 : decode = 17;
					32'h00000001 : decode = 18;
					32'h00000008: decode = 19;
					32'h00000014 : decode = 20;
					
					32'h00000037 : decode = 21;
					32'h00000042 : decode = 22;
					32'h00000092 : decode = 23;
					32'h000000af : decode = 24;
					32'h00000191 : decode = 25;
					32'h000001a5 : decode = 26;
					32'h000001b5 : decode = 27;
					32'h0000039e : decode = 28;
					32'h000003c0 : decode = 29;
					32'h000003a2 : decode = 30;
					
					32'h000003cd : decode = 31;
					32'h000007d6 : decode = 32;
					32'h000000ae : decode = 33;
					32'h00000017 : decode = 34;
					32'h00000007 : decode = 35;
					32'h00000009 : decode = 36;
					32'h00000018 : decode = 37;
					32'h00000039 : decode = 38;
					32'h00000040 : decode = 39;
					32'h0000008e : decode = 40;
					
					32'h000000a3 : decode = 41;
					32'h000000b8 : decode = 42;
					32'h00000199 : decode = 43;
					32'h000001ac : decode = 44;
					32'h000001c1 : decode = 45;
					32'h000003b1 : decode = 46;
					32'h00000396 : decode = 47;
					32'h000003be : decode = 48;
					32'h000003ca : decode = 49;
					32'h0000009d : decode = 50;
					
					32'h0000003c : decode = 51;
					32'h00000015 : decode = 52;
					32'h00000016 : decode = 53;
					32'h0000001a : decode = 54;
					32'h0000003b : decode = 55;
					32'h00000044 : decode = 56;
					32'h00000091 : decode = 57;
					32'h000000a5 : decode = 58;
					32'h000000be : decode = 59;
					32'h00000196 : decode = 60;
					
					32'h000001ae : decode = 61;
					32'h000001b9 : decode = 62;
					32'h000003a1 : decode = 63;
					32'h00000391 : decode = 64;
					32'h000003a5 : decode = 65;
					32'h000003d5 : decode = 66;
					32'h00000094 : decode = 67;
					32'h0000009a : decode = 68;
					32'h00000036 : decode = 69;
					32'h00000038 : decode = 70;
					
					32'h0000003a : decode = 71;
					32'h00000041 : decode = 72;
					32'h0000008c : decode = 73;
					32'h0000009b : decode = 74;
					32'h000000b0 : decode = 75;
					32'h000000c3 : decode = 76;
					32'h0000019e : decode = 77;
					32'h000001ab : decode = 78;
					32'h000001bc : decode = 79;
					32'h0000039f : decode = 80;
					
					32'h0000038f : decode = 81;
					32'h000003a9 : decode = 82;
					32'h000003cf : decode = 83;
					32'h00000093 : decode = 84;
					32'h000000bf : decode = 85;
					32'h0000003e : decode = 86;
					32'h0000003f : decode = 87;
					32'h00000043 : decode = 88;
					32'h00000045 : decode = 89;
					32'h0000009e : decode = 90;
					
					32'h000000a7 : decode = 91;
					32'h000000b9 : decode = 92;
					32'h00000194 : decode = 93;
					32'h000001a2 : decode = 94;
					32'h000001ba : decode = 95;
					32'h000001c3 : decode = 96;
					32'h000003a6 : decode = 97;
					32'h000003a7 : decode = 98;
					32'h000003bb : decode = 99;
					32'h000003d4 : decode = 100;
					
					32'h0000009f : decode = 101;
					32'h000001a0 : decode = 102;
					32'h0000008f : decode = 103;
					32'h0000008d : decode = 104;
					32'h00000090 : decode = 105;
					32'h00000098 : decode = 106;
					32'h000000a6 : decode = 107;
					32'h000000b6 : decode = 108;
					32'h000000c4 : decode = 109;
					32'h0000019f : decode = 110;
					
					32'h000001af : decode = 111;
					32'h000001bf : decode = 112;
					32'h00000399 : decode = 113;
					32'h000003bf : decode = 114;
					32'h000003b4 : decode = 115;
					32'h000003c9 : decode = 116;
					32'h000003e7 : decode = 117;
					32'h000000a8 : decode = 118;
					32'h000001b6 : decode = 119;
					32'h000000ab : decode = 120;
					
					32'h000000a4 : decode = 121;
					32'h000000aa : decode = 122;
					32'h000000b2 : decode = 123;
					32'h000000c2 : decode = 124;
					32'h000000c5 : decode = 125;
					32'h00000198 : decode = 126;
					32'h000001a4 : decode = 127;
					32'h000001b8 : decode = 128;
					32'h0000038c : decode = 129;
					32'h000003a4 : decode = 130;
					
					32'h000003c4 : decode = 131;
					32'h000003c6 : decode = 132;
					32'h000003dd : decode = 133;
					32'h000003e8 : decode = 134;
					32'h000000ad : decode = 135;
					32'h000003af : decode = 136;
					32'h00000192 : decode = 137;
					32'h000000bd : decode = 138;
					32'h000000bc : decode = 139;
					32'h0000018e : decode = 140;
					
					32'h00000197 : decode = 141;
					32'h0000019a : decode = 142;
					32'h000001a3 : decode = 143;
					32'h000001b1 : decode = 144;
					32'h0000038d : decode = 145;
					32'h00000398 : decode = 146;
					32'h000003b7 : decode = 147;
					32'h000003d3 : decode = 148;
					32'h000003d1 : decode = 149;
					32'h000003db : decode = 150;
					
					32'h000007dd : decode = 151;
					32'h000000b4 : decode = 152;
					32'h000003de : decode = 153;
					32'h000001a9 : decode = 154;
					32'h0000019b : decode = 155;
					32'h0000019c : decode = 156;
					32'h000001a1 : decode = 157;
					32'h000001aa : decode = 158;
					32'h000001ad : decode = 159;
					32'h000001b3 : decode = 160;
					
					32'h0000038b : decode = 161;
					32'h000003b2 : decode = 162;
					32'h000003b8 : decode = 163;
					32'h000003ce : decode = 164;
					32'h000003e1 : decode = 165;
					32'h000003e0 : decode = 166;
					32'h000007d2 : decode = 167;
					32'h000007e5 : decode = 168;
					32'h000000b7 : decode = 169;
					32'h000007e3 : decode = 170;
					
					32'h000001bb : decode = 171;
					32'h000001a8 : decode = 172;
					32'h000001a6 : decode = 173;
					32'h000001b0 : decode = 174;
					32'h000001b2 : decode = 175;
					32'h000001b7 : decode = 176;
					32'h0000039b : decode = 177;
					32'h0000039a : decode = 178;
					32'h000003ba : decode = 179;
					32'h000003b5 : decode = 180;
					
					32'h000003d6 : decode = 181;
					32'h000007d7 : decode = 182;
					32'h000003e4 : decode = 183;
					32'h000007d8 : decode = 184;
					32'h000007ea : decode = 185;
					32'h000000ba : decode = 186;
					32'h000007e8 : decode = 187;
					32'h000003a0 : decode = 188;
					32'h000001bd : decode = 189;
					32'h000001b4 : decode = 190;
					
					32'h0000038a : decode = 191;
					32'h000001c4 : decode = 192;
					32'h00000392 : decode = 193;
					32'h000003aa : decode = 194;
					32'h000003b0 : decode = 195;
					32'h000003bc : decode = 196;
					32'h000003d7 : decode = 197;
					32'h000007d4 : decode = 198;
					32'h000007dc : decode = 199;
					32'h000007db : decode = 200;
					
					32'h000007d5 : decode = 201;
					32'h000007f0 : decode = 202;
					32'h000000c1 : decode = 203;
					32'h000007fb : decode = 204;
					32'h000003c8 : decode = 205;
					32'h000003a3 : decode = 206;
					32'h00000395 : decode = 207;
					32'h0000039d : decode = 208;
					32'h000003ac : decode = 209;
					32'h000003ae : decode = 210;
					
					32'h000003c5 : decode = 211;
					32'h000003d8 : decode = 212;
					32'h000003e2 : decode = 213;
					32'h000003e6 : decode = 214;
					32'h000007e4 : decode = 215;
					32'h000007e7 : decode = 216;
					32'h000007e0 : decode = 217;
					32'h000007e9 : decode = 218;
					32'h000007f7 : decode = 219;
					32'h00000190 : decode = 220;
					
					32'h000007f2 : decode = 221;
					32'h00000393 : decode = 222;
					32'h000001be : decode = 223;
					32'h000001c0 : decode = 224;
					32'h00000394 : decode = 225;
					32'h00000397 : decode = 226;
					32'h000003ad : decode = 227;
					32'h000003c3 : decode = 228;
					32'h000003c1 : decode = 229;
					32'h000003d2 : decode = 230;
					
					32'h000007da : decode = 231;
					32'h000007d9 : decode = 232;
					32'h000007df : decode = 233;
					32'h000007eb : decode = 234;
					32'h000007f4 : decode = 235;
					32'h000007fa : decode = 236;
					32'h00000195 : decode = 237;
					32'h000007f8 : decode = 238;
					32'h000003bd : decode = 239;
					32'h0000039c : decode = 240;
					
					32'h000003ab : decode = 241;
					32'h000003a8 : decode = 242;
					32'h000003b3 : decode = 243;
					32'h000003b9 : decode = 244;
					32'h000003d0 : decode = 245;
					32'h000003e3 : decode = 246;
					32'h000003e5 : decode = 247;
					32'h000007e2 : decode = 248;
					32'h000007de : decode = 249;
					32'h000007ed : decode = 250;
					
					32'h000007f1 : decode = 251;
					32'h000007f9 : decode = 252;
					32'h000007fc : decode = 253;
					32'h00000193 : decode = 254;
					32'h00000ffd : decode = 255;
					32'h000003dc : decode = 256;
					32'h000003b6 : decode = 257;
					32'h000003c7 : decode = 258;
					32'h000003cc : decode = 259;
					32'h000003cb : decode = 260;
					
					32'h000003d9 : decode = 261;
					32'h000003da : decode = 262;
					32'h000007d3 : decode = 263;
					32'h000007e1 : decode = 264;
					32'h000007ee : decode = 265;
					32'h000007ef : decode = 266;
					32'h000007f5 : decode = 267;
					32'h000007f6 : decode = 268;
					32'h00000ffc : decode = 269;
					32'h00000fff : decode = 270;
					
					32'h0000019d : decode = 271;
					32'h000001c2 : decode = 272;
					32'h000000b5 : decode = 273;
					32'h000000a1 : decode = 274;
					32'h00000096 : decode = 275;
					32'h00000097 : decode = 276;
					32'h00000095 : decode = 277;
					32'h00000099 : decode = 278;
					32'h000000a0 : decode = 279;
					32'h000000a2 : decode = 280;
						
					32'h000000ac : decode = 281;
					32'h000000a9 : decode = 282;
					32'h000000b1 : decode = 283;
					32'h000000b3 : decode = 284;
					32'h000000bb : decode = 285;
					32'h000000c0 : decode = 286;
					32'h0000018f : decode = 287;
					32'h00000004 : decode = 288;
					
					default: decode = 1000;
		   
				endcase		

		   end
		endcase
	endfunction
   
endclass 