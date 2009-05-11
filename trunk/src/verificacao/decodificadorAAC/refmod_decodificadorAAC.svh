`include "AACHuffmanDecoder.svh"
`include "reescalador.svh"
`include "dequantizador.svh"
`include "direct_imdct.sv"

parameter ID_SCE = 0;
parameter ID_CPE = 1;
parameter ID_CCE = 2;
parameter ID_LFE = 3;
parameter ID_DSE = 4;
parameter ID_PCE = 5;
parameter ID_FIL = 6;
parameter ID_END = 7;
parameter ZERO_HCB = 0;
parameter ESC_HCB = 11;
parameter INTENSITY_HCB = 14;
parameter INTENSITY_HCB2 = 15;
parameter FIRST_PAIR_HCB = 4;    
parameter ESC_FLAG = 16;
parameter EIGHT_SHORT_SEQUENCE = 2;
//parameter N_RAW_DATA_BLOCK = 4;

class refmod_decodificadorAAC extends ovm_component;

   ovm_get_port #(stream) entrada_stim;
   stream tr_in_entrada;
   
   ovm_put_port #(amostra) amostra_stim;
   amostra tr_out_amostra;
   
   ovm_put_port #(erro) erro_stim;
   erro tr_out_erro;

   covergroup crm;      
      coverpoint tr_out_amostra.amostra {
         bins tr[] = { 0 };
         option.at_least = 1;
      }
      
   endgroup

   function new(string name, ovm_component parent);
      super.new(name,parent);
      entrada_stim = new("entrada_stim", this);
      
      amostra_stim = new("amostra_stim", this);
      
	  erro_stim = new("erro_stim", this);
	  
      crm = new;
   endfunction

	AACHuffmanDecoder huffmanDecoder;
	reescalador reescalador = new();
	dequantizador dequantizador = new();
	direct_imdct imdct = new();
	
	int id_syn_ele, global_gain, num_window_groups, max_sfb;
	bit[7:0] scale_factor_grouping;
	bit[1:0] window_sequence;
	bit[3:0] sect_codebook[7:0][48:0]; //sect_codebook[g][i] => livro de codigo usado na secao i de um grupo g
	bit[3:0] sfb_codebook[7:0][48:0]; //sfb_codebook[g][sfb] => livro de codigo usado na banda sfb de um grupo g
	int window_group_length[7:0]; //tamanho de cada grupo de janela
	int sect_sfb_offset[7:0][48:0]; //offset dos coeficientes para cada banda de cada grupo
	int swb_offset[48:0]; // offset de coeficientes em cada swb
	int sf[7:0][48:0]; //sf[g][sfb] => fatores de escala da banda sfb de um grupo g
	int x_quant[7:0][48:0][7:0][1023:0]; // coeficientes do canal ainda quantizados
	int x_invquant[7:0][48:0][7:0][1023:0]; // coeficientes do canal dequantizados e ainda nao reescalados
	int x_rescal[7:0][48:0][7:0][1023:0]; // coeficientes do canal  dequantizados e reescalados
	int coefs[1023:0]; // coeficientes do canal  dequantizados e reescalados
	int coef_pcm[2047:0]; //amostras no dominio do tempo
	//int coefsR[1023:0]; //coeficientes espectrais canal direito
	//int coefsL[1023:0]; //coeficientes espectrais canal esquerdo
	int nChannels = 0; //numero de canais individuais que já foram decodificados => numero par indica que o proximo canal é o esquerdo, numero impar indica que o proximo canal e o direito
	bit window_shape;
	raw_data_block raw;
	int n_elements_in_raw = 0;
	individual_channel_stream ics;
	channel_pair_element cpe;
	int sect_start[7:0][48:0]; //sect_start[g][i] => indice da sfb que é o inicio da secao i de um grupo g
	int sect_end[7:0][48:0]; //sect_end[g][i] => indice da sfb que é o final da secao i de um grupo g
	int num_sec[7:0]; //num_sec[g] => numero de secoes do grupo g
	
	task handle_ics_info(ics_info ics_info);
		$display("###########ICS INFO ... ");
		window_sequence = ics_info.window_sequence;
		window_shape = ics_info.window_shape;
		if(window_sequence == EIGHT_SHORT_SEQUENCE) begin //EIGHT_SHORT_SEQUENCE
			max_sfb = ics_info.max_sfb_short;
			scale_factor_grouping = ics_info.scale_factor_grouping;
			//num_window_groups = ics_info.get_num_window_groups();			
		end
		else begin
			max_sfb = ics_info.max_sfb_long;
			if(ics_info.predictor_data_present) begin//presenca de predicao
				tr_out_erro.erro = 15;
			end
		end
		setHelpVariables();
		
	endtask
	
	task setHelpVariables( );
		int num_windows, num_swb, sect_sfb, offset, width;
		if (window_sequence == EIGHT_SHORT_SEQUENCE) begin
			//EIGHT_SHORT_SEQUENCE:
			num_windows = 8;
			num_window_groups = 1;
			window_group_length[num_window_groups-1] = 1;
			num_swb = 14;
			for (int i = 0; i < num_swb + 1; i++)
				swb_offset[i] = get_swb_offset_short_window(i);
			/*preparação do número de grupos e do tamanho de cada grupo*/
			for (int i = 0; i < num_windows-1; i++) begin
				if(scale_factor_grouping[6-i] == 1'b0) begin
					num_window_groups += 1;
					window_group_length[num_window_groups-1] = 1;
				end
				else begin
					window_group_length[num_window_groups-1] += 1;
				end
			end
			/* preparação do sect_sfb_offset para janelas curtas */
			for (int g = 0; g < num_window_groups; g++) begin
				sect_sfb = 0;
				offset = 0;
				for (int i = 0; i < max_sfb; i++) begin
					width = get_swb_offset_short_window(i+1) - get_swb_offset_short_window(i);
					width *= window_group_length[g];
					sect_sfb_offset[g][sect_sfb++] = offset;
					offset += width;
				end
				//sect_sfb_offset[g][sect_sfb] = offset; //FIXME banda 14 não existe!!
			end
		end	
		else begin
			//2'b00: //ONLY_LONG_SEQUENCE:
			//2'b01: // LONG_START_SEQUENCE:
			//2'b11: //LONG_STOP_SEQUENCE: 
			num_windows = 1;
			num_window_groups = 1;
			window_group_length[num_window_groups-1] = 1;
			num_swb = 49;
			/* preparação do sect_sfb_offset para janelas longas */
			
			for (int i = 0; i < max_sfb + 1; i++) begin
				sect_sfb_offset[0][i] = get_swb_offset_long_window(i);
				swb_offset[i] = get_swb_offset_long_window(i);
			end
		end

	endtask
	
	//retorna o valor do offset de uma banda de fator de escala de janela curta para a frequencia de 44.1
	function int get_swb_offset_short_window(int swb);
		int offset = 0;
		case(swb) 
			0: offset = 0;
			1: offset = 4;
			2: offset = 8;
			3: offset = 12;
			4: offset = 16;
			5: offset = 20;
			6: offset = 28;
			7: offset = 36;
			8: offset = 44;
			9: offset = 56;
			10: offset = 68;
			11: offset = 80;
			12: offset = 96;
			13: offset = 112;
		endcase
		
		return offset;
	endfunction
	
	//retorna o valor do offset de uma banda de fator de escala de janela longa para a frequencia de 44.1
	function int get_swb_offset_long_window(int swb);
		int offset = 0;
		case(swb) 
			0: offset = 0;
			1: offset = 4;
			2: offset = 8;
			3: offset = 12;
			4: offset = 16;
			5: offset = 20;
			6: offset = 24;
			7: offset = 28;
			8: offset = 32;
			9: offset = 36;
			10: offset = 40;
			11: offset = 48;
			12: offset = 56;
			13: offset = 64;
			14: offset = 72;
			15: offset = 80;
			16: offset = 88;
			17: offset = 96;
			18: offset = 108;
			19: offset = 120;
			20: offset = 132;
			21: offset = 144;
			22: offset = 160;
			23: offset = 176;
			24: offset = 196;
			25: offset = 216;
			26: offset = 240;
			27: offset = 264;
			28: offset = 292;
			29: offset = 320;
			30: offset = 352;
			31: offset = 384;
			32: offset = 416;
			33: offset = 448;
			34: offset = 480;
			35: offset = 512;
			36: offset = 544;
			37: offset = 576;
			38: offset = 608;
			39: offset = 640;
			40: offset = 672;
			41: offset = 704;
			42: offset = 736;
			43: offset = 768;
			44: offset = 800;
			45: offset = 832;
			46: offset = 864;
			47: offset = 896;
			48: offset = 928;				
		endcase
		
		return offset;
	endfunction
	
	 task handle_ics(individual_channel_stream ics, bit common_window);
		global_gain = ics.global_gain;
		if (!common_window)
			handle_ics_info(ics.ics_info);
		
		handle_section_data(ics.section_data);
		handle_scale_factor_data(ics.scale_factor_data);
		
		if(ics.pulse_data_present)
			tr_out_erro.erro = 15;
		if(ics.tns_data_present)
			tr_out_erro.erro = 15;
		if(ics.gain_control_data_present)
			tr_out_erro.erro = 15;
			
		handle_spectral_data(ics.spectral_data);
		
		//nChannels++;
		/*	
		//TESTE - envia os coefs para o checker
		for(int i=0; i< 64 ; i++) begin			
			int coef = ics.spectral_data.hcod[1][1][i];
			tr_out_amostra.amostra = coef;
			crm.sample();
			erro_stim.put(tr_out_erro);
			amostra_stim.put(tr_out_amostra);			
		end
		//FIM TESTE
		*/		
	endtask
	
	task handle_section_data(section_data sd);		
		//processa as informações relativas ao secionamento dos grupos
		int k, i, sect_len, sect_len_incr, sect_esc_val, j;
		$display("#### SECTION_DATA ..");
		if(window_sequence == EIGHT_SHORT_SEQUENCE) //EIGHT_SHORT_SEQUENCE
			sect_esc_val = (1<<3) -1;
		else
			sect_esc_val = (1<<5) -1;
			
		for(int g=0; g< num_window_groups ; g++) begin	
			k = 0;
			i = 0;
			while(k < max_sfb) begin
				sect_codebook[g][i] = sd.sect_cb[g][i];
				sect_len = 0;
				j = 0; //numero de incrementos dados.. foi determinado um maximo = 4
				sect_len_incr =  sd.sect_len_incr[g][i][j];//FIXME
				while(sect_len_incr == sect_esc_val) begin
					sect_len += sect_esc_val;
					j++;
					if (j == 4)
						break;
					sect_len_incr =  sd.sect_len_incr[g][i][j];
				end
				sect_len += sect_len_incr;
				sect_start[g][i] = k;
				sect_end[g][i] = k + sect_len;
				for(int sfb=k; sfb<k+sect_len; sfb++) begin
					sfb_codebook[g][sfb] = sect_codebook[g][i];
				end
				k+= sect_len;
				i++;
			end
			num_sec[g] = i;
		end
		
	endtask
	
	task handle_scale_factor_data(scale_factor_data sfd);	
	//processa as informações relativas aos fatores de escala
		int dpcmSF = 0;   
		int lastSF = global_gain;
		$display("##### SCALE_FACTOR_DATA ... " );
		for(int g=0; g< num_window_groups; g++) begin
			for(int sfb=0; sfb< max_sfb; sfb++) begin
				if(sfb_codebook[g][sfb] != 0) begin //ZERO_HCB
					if(sfb_codebook[g][sfb] == INTENSITY_HCB || sfb_codebook[g][sfb] == INTENSITY_HCB2) begin 
						tr_out_erro.erro = 15;
					end
					else begin
					//decodifica os fatores de escala de tamanho variável e calcula o valor diferencial
						huffmanDecoder = new(12); //12 indica para usar o livro de codigo dos fatores de escala
						dpcmSF = huffmanDecoder.decode(sfd.hcod_sf[g][sfb]);				
						sf[g][sfb] = lastSF + dpcmSF;
						$display("SF[%d][%d] = %d", g, sfb, sf[g][sfb] );
						lastSF = sf[g][sfb];
					end					
				end
				else begin
					sf[g][sfb] = 0;
				end
			end
		end
		
	endtask
	
	task handle_spectral_data(spectral_data spectral_data);		
	/*
		swb = banda de fator de escala de uma unica janela
		win = indice da janela dentro de um grupo
		start_win_group = indice da primeira janela de um grupo
		swb_width = quantidade de coeficientes de uma swb
		bin = indice do coeficiente dentro de uma swb
		coef_index  = indice auxiliar para acessar os termos do spectral_data
		dim = dimensao do livro de codigo
		index = valor de retorno do livro de codigo para um codeword
		lav = mairo valor absoluto do livro de codigo
		mod = valor auxiliar para calculo dos coeficientes
		off = valor auxiliar de offset para calculo dos coeficientes
		hcod_esc_y, hcod_esc_z = palavra de codigo a ser decodificada
	*/
		int swb, win, start_win_group, swb_width, bin, coef_index = 0;
		int dim, index, lav, mod, off = 0;
		int w,x,y,z;
		bit[20:0] hcod_esc_y, hcod_esc_z;
		$display("##### SPECTRAL_FACTOR_DATA ... " );
	
		//processa as informações relativas aos coeficientes espectrais		
		for(int g=0; g< num_window_groups; g++) begin			
			//$display("## num_window_groups= %d | num_sec[0] = %d | " , num_window_groups,  num_sec[0] );
			for(int i=0; i< num_sec[g]; i++) begin					
				win = start_win_group;
			//	$display("## num_window_groups= %d | num_sec[%d] = %d | sect_sfb_offset[start]=  | sect_sfb_offset[end]= " , num_window_groups, g,  num_sec[g] );
				if(sect_codebook[g][i] != ZERO_HCB && sect_codebook[g][i] <= ESC_HCB) begin //11= ESC_HCB
					huffmanDecoder = new(sect_codebook[g][i]);
					swb	= sect_start[g][i];		
					for(int k=sect_sfb_offset[g][sect_start[g][i]] ; k< sect_sfb_offset[g][sect_end[g][i]];) begin								
						if(sect_codebook[g][i] <= FIRST_PAIR_HCB) begin 
						/*livros de código para quadruplas de coeficientes*/
							dim = 4;
						end
						else begin 
						/*livros de código para pares de coeficientes*/
							dim = 2;
						end
						/*configura o maior valor absoluto para cada livro de codigo*/
						if(sect_codebook[g][i] <= 2) 
							lav = 1;
						else if (sect_codebook[g][i] <= 4)
							lav = 2;
						else if(sect_codebook[g][i] <= 6) 
							lav = 4;
						else if(sect_codebook[g][i] <= 8)
							lav = 7;
						else if(sect_codebook[g][i] <= 8)
							lav = 12;
						else
							lav = 16;
								
						if(huffmanDecoder.is_unsigned_codebook(sect_codebook[g][i])) begin
							mod = lav + 1;
							off = 0;								
						end
						else begin
							mod = 2*lav + 1;
							off = lav;
						end
						index = huffmanDecoder.decode(spectral_data.hcod[coef_index]);
						//$display("## INDEX = %d" , index);
						if (dim == 4) begin
							w = index/(mod*mod*mod) - off;
							index -= (w+off)*(mod*mod*mod);
							x = index/(mod*mod) - off;
							index-= (x+off)*(mod*mod);
							y = index/mod - off;
							index -= (y+off)*mod;
							z = index - off;							

							if(huffmanDecoder.is_unsigned_codebook(sect_codebook[g][i])) begin
								//$display("### QUAD SEM SINAL");	
								if (w != 0 && spectral_data.quad_sign_bits[coef_index][3])
									w = -w;
								if (x != 0 && spectral_data.quad_sign_bits[coef_index][2])
									x = -x;
								if (y != 0 && spectral_data.quad_sign_bits[coef_index][1])
									y = -y;
								if (z != 0 && spectral_data.quad_sign_bits[coef_index][0])
									z = -z;								
							end	
							x_quant[g][sfb][win][bin++] = w;
							x_quant[g][sfb][win][bin++] = x;
							x_quant[g][sfb][win][bin++] = y;
							x_quant[g][sfb][win][bin++] = z;
							k += 4;
						end
						else if(dim == 2) begin
							y = index/mod - off;
							index -= (y+off)*mod;
							z = index - off;

							if(huffmanDecoder.is_unsigned_codebook(sect_codebook[g][i])) begin
								//$display("### PAIR SEM SINAL");
							if (y != 0 && spectral_data.pair_sign_bits[coef_index][1])
									y = -y;
								if (z != 0 && spectral_data.pair_sign_bits[coef_index][0])
									z = -z;															
							end	
							if(sect_codebook[g][i] == ESC_HCB) begin //ESC_HCB
								//FIXME codigo de escape 
								if(y == ESC_FLAG) 
									hcod_esc_y = spectral_data.hcod_esc_y[coef_index];
								if(z == ESC_FLAG)
									hcod_esc_z = spectral_data.hcod_esc_z[coef_index]; 
							end							
							x_quant[g][sfb][win][bin++] = y;
							x_quant[g][sfb][win][bin++] = z;
							k += 2;
						end
						
						//verifica swb e janela
						if (window_sequence == EIGHT_SHORT_SEQUENCE)	
							swb_width = get_swb_offset_short_window(swb+1) - get_swb_offset_short_window(swb);
						else
							swb_width = get_swb_offset_long_window(swb+1) - get_swb_offset_long_window(swb);
							
						if (bin >= swb_width) begin
							//ja pegou todos os coeficientes de uma swb da janela, entao tem que passar para a swb da proxima janela do grupo
							win++;
							bin =0;
							if ( win >=  start_win_group + window_group_length[g] ) begin
								//ja terminou as janelas do grupo, deve-se passar para a proxima swb da primeira janela do grupo
								win = 0;
								swb++;
								if ( swb > sect_end[g][i] ) begin
									//terminou a secao de um grupo
									break;
								end
							end
						end
					end //end for  k
				end //end if
			end	//end for sect
			//a cada novo grupo configura a janela como sendo a primeira janela do proximo grupo
			start_win_group = start_win_group + window_group_length[g];			
		end //end for group
		
		/*
		if( nChannels%2 == 0)  begin			
			//se for par estamos recebendo o canal esquerdo
			$display("### Coeficientes canal esquerdo: ");
			foreach(coefs[i]) begin
				coefsL[i] = coefs[i];
				$display("### Coef[%d] = %d " , i, coefs[i] );
			end
		end
		else begin
			//se for impar estamos recebendo o canal direito
			$display("### Coeficientes canal direito: ");
			foreach(coefs[i]) begin
				coefsR[i] = coefs[i];
				$display("### Coef[%d] = %d " , i, coefs[i] );
			end
		end	
		*/
	endtask
	
   task run();
      while(1) begin
        entrada_stim.get(tr_in_entrada);        
        tr_out_amostra= new();
		tr_out_erro= new();
		//nChannels = 0;
        
        //-----------------------------------------------------------------------
        // Here goes the code that executes the reference model's functionality.
        //-----------------------------------------------------------------------
		$display("\n###### STREAM RECEBIDA PELO REFMOD : \n%s", tr_in_entrada.psprint());	
		
		//VERIFICA ALGUMAS CONFIGURAÇÕES DO CABEÇALHO
		if(tr_in_entrada.adif_id != 32'h41444946) begin
			//$display("\n######ERRO: NÂO VEIO ADIF_ID!! : \n");
			tr_out_erro.erro = 1;
			
		end
		else if(tr_in_entrada.bitstream_type) begin
			//$display("\n######ERRO: BITSTREAM VARIAVEL!! : \n");
			tr_out_erro.erro = 2;
		end
		else if(tr_in_entrada.bitrate == 0 || tr_in_entrada.bitrate > 529200) begin
			//$display("\n######ERRO: BITRATE INADEQUADO!! : \n");
			tr_out_erro.erro = 3;
		end
		else if(tr_in_entrada.num_program_config_elements != 0) begin
			//$display("\n######ERRO: MAIS DE UMA CONFIGURACAO DE PROGRAMA!! : \n");
			tr_out_erro.erro = 4;
		end
		else if(tr_in_entrada.pce[0].profile != 1) begin //LC
			//$display("\n######ERRO: PERFIL DIFERENTE DE LC!! : \n");
			tr_out_erro.erro = 5;
		end	
		else if(tr_in_entrada.pce[0].sampling_frequency_index != 4) begin //44100
			//$display("\n######ERRO: FREQUENCIA DE AMOSTRAGEM DIFERENTE DE 44.1KhZ!! : \n");
			tr_out_erro.erro = 6;
		end		
		if(tr_out_erro.erro == 0) begin
			//IDENTIFICA OS RAW_DATA_BLOCK		
			for(int i=0; i< N_RAW_DATA_BLOCK ; i++) begin	
				$display("\n###### ..........RAW_DATA_BLOCK..........####### %d ", i);
				raw = tr_in_entrada.raw_data_block[i];
				id_syn_ele = raw.id_syn_ele[0];
				n_elements_in_raw = 0;			
				while(id_syn_ele != ID_END) begin //ID_END
					case(id_syn_ele)					
						ID_SCE : //ID_SCE
							begin
								ics = raw.sce[n_elements_in_raw].ics;
								$display("\n######VEIO SCE!! : \n");
								handle_ics(ics, 1'b0);
								process_channel_coeficients();
								//TODO Dequantizar, Reescalar, IMDCT, JANELAMENTO, SOBREPOSICAO
							end
							
						ID_CPE : //ID_CPE
							begin
								cpe = raw.cpe[n_elements_in_raw];
								$display("\n######VEIO CPE!! : \n");
								if (cpe.common_window)
									handle_ics_info(cpe.ics_info);
								if(cpe.ms_mask_present == 1)
									tr_out_erro.erro = 15;
								handle_ics(cpe.ics1, cpe.common_window);
								process_channel_coeficients();
								//TODO Dequantizar, Reescalar, IMDCT, JANELAMENTO, SOBREPOSICAO
								
								handle_ics(cpe.ics2, cpe.common_window);
								process_channel_coeficients();								
								
							end
							
						ID_CCE : //ID_CCE
							begin
								$display("\n######VEIO CCE!! : \n");
								tr_out_erro.erro = 15;
							end
							
						ID_LFE : //ID_LFE
							begin
								$display("\n######VEIO LFE!! : \n");
								tr_out_erro.erro = 15;
							end
							
						ID_DSE : //ID_DSE
							begin
								$display("\n######VEIO DSE!! : \n");
								
							end
							
						ID_PCE : //ID_PCE
							begin
								$display("\n######VEIO PCE!! : \n");
								tr_out_erro.erro = 15;
							end
						
						ID_FIL: //ID_FIL
							begin
								$display("\n######VEIO FILL!! : \n");
							end

					endcase
					n_elements_in_raw++;
					id_syn_ele = raw.id_syn_ele[n_elements_in_raw];
					if(tr_out_erro.erro != 0)
						break;
				end //fim do while !id_term
				$display("\n###### VEIO TERM !! ");
				if(tr_out_erro.erro != 0) begin
					erro_stim.put(tr_out_erro);
					break;
				end
			end //fim do for para os raw_data_block
		end // fim do if do erro
		else begin
			erro_stim.put(tr_out_erro);
        end
      end //fim do while(1)
    endtask

	//TODO Dequantizar, Reescalar, IMDCT, JANELAMENTO, SOBREPOSICAO
	task process_channel_coeficients();
		int window_long = 1;
		if(window_sequence == EIGHT_SHORT_SEQUENCE) //2'b10
			window_long = 0;
			
		apply_quantization();
		apply_reescaler();
		imdct.tranformar(window_long, coefs, coef_pcm);
	endtask
	
	task apply_quantization();
		int width = 0;
		$display("########### DEQUANTIZACAO ... ");
		for(int g; g < num_window_groups ; g++)begin
			for(int sfb = 0; sfb < max_sfb ; sfb++)begin
				width = (swb_offset[sfb+1] - swb_offset[sfb]);
				for(int win = 0; win < window_group_length[g] ; win++)begin
					for(int bin = 0; bin < width; bin++)begin
					x_invquant[g][win][sfb][bin] = dequantizador.dequant(x_quant[g][win][sfb][bin]);
							/*x_invquant[g][win][sfb][bin] = sign(x_quant[g][win][sfb][bin]) *
abs(x_quant[g][win][sfb][bin])^(4/3);*/			
					end
				end
			end
		end
		
	endtask
	
	task apply_reescaler();
		int width, index = 0;
		$display("########### REESCALAMENTO ... ");
		for(int g; g < num_window_groups ; g++)begin
			for(int sfb = 0; sfb < max_sfb ; sfb++)begin
				width = (swb_offset[sfb+1] - swb_offset[sfb]);
				for(int win = 0; win < window_group_length[g] ; win++)begin
					for(int k = 0; k < width; k++)begin
							x_rescal[g][win][sfb][k] = reescalador.reescala(sf[g][sfb] , x_invquant[g][window][sfb][k] );
							/*x_rescal[g][win][sfb][k] =
x_invquant[g][window][sfb][k] * gain;*/
							coefs[index] = reescalador.reescala(sf[g][sfb] , x_invquant[g][window][sfb][k] );
							index++;
					end
				end
			end
		end
		
	endtask
	
endclass

