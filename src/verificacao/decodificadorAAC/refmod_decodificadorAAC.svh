`include "AACHuffmanDecoder.svh"

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
   
	
   //enum { ID_SCE, ID_CPE, ID_CCE, ID_LFE, ID_DSE, ID_PCE, ID_FIL, ID_END } id_syn_ele;
   //parameter int EIGHT_SHORT_SEQUENCE = 2;
	AACHuffmanDecoder huffmanDecoder;
	int id_syn_ele, global_gain, num_window_groups, max_sfb;
	bit[7:0] scale_factor_grouping;
	bit[1:0] window_sequence;
	bit[3:0] sect_codebook[7:0][48:0]; //sect_codebook[g][i] => livro de codigo usado na secao i de um grupo g
	bit[3:0] sfb_codebook[7:0][48:0]; //sfb_codebook[g][sfb] => livro de codigo usado na banda sfb de um grupo g
	int sf[7:0][48:0]; //sf[g][sfb] => fatores de escala da banda sfb de um grupo g
	int coefsR[1023:0]; //coeficientes espectrais
	int coefsL[1023:0]; //coeficientes espectrais
	bit window_shape;
	int n_raw_data_block = 2;
	raw_data_block raw;
	int n_elements_in_raw = 0;
	individual_channel_stream ics;
	channel_pair_element cpe;
	int sect_start[7:0][48:0]; //sect_start[g][i] => indice da sfb que é o inicio da secao i de um grupo g
	int sect_end[7:0][48:0]; //sect_end[g][i] => indice da sfb que é o final da secao i de um grupo g
	int num_sec[7:0]; //num_sec[g] => numero de secoes do grupo g
	

	task handle_ics_info(ics_info ics_info);
		window_sequence = ics_info.window_sequence;
		window_shape = ics_info.window_shape;
		if(window_sequence == 2) begin //EIGHT_SHORT_SEQUENCE
			max_sfb = ics_info.max_sfb_short;
			scale_factor_grouping = ics_info.scale_factor_grouping;
			num_window_groups = ics_info.get_num_window_groups();
		end
		else begin
			max_sfb = ics_info.max_sfb_long;
			if(ics_info.predictor_data_present) begin//presença de predição
				tr_out_erro.erro = 5;
			end
		end
		
	endtask
	
	 task handle_ics(individual_channel_stream ics, bit common_window);
		global_gain = ics.global_gain;
		if (!common_window)
			handle_ics_info(ics.ics_info);
		
		handle_section_data(ics.section_data);
		handle_scale_factor_data(ics.scale_factor_data);
		
		if(ics.pulse_data_present)
			tr_out_erro.erro = 5;
		if(ics.tns_data_present)
			tr_out_erro.erro = 5;
		if(ics.gain_control_data_present)
			tr_out_erro.erro = 5;
			
		handle_spectral_data(ics.spectral_data);
		
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
		if(window_sequence == 2) //EIGHT_SHORT_SEQUENCE
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
		for(int g=0; g< num_window_groups; g++) begin
			for(int sfb=0; sfb< max_sfb; sfb++) begin
				if(sfb_codebook[g][sfb] != 0) begin //ZERO_HCB
					if(sfb_codebook[g][sfb] == 14 || sfb_codebook[g][sfb] == 15) begin 
					//INTENSITY_HCB OU INTENSITY_HCB2
						tr_out_erro.erro = 5;
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
		//processa as informações relativas aos coeficientes espectrais		
		for(int g=0; g< num_window_groups; g++) begin
			for(int i=0; i< num_sec[g]; i++) begin
				if(sect_codebook[g][i] != 0 && sect_codebook[g][i] <= 11) begin //11= ESC_HCB
					huffmanDecoder = new(sect_codebook[g][i]);
					for(int k=0 ; k< 10;) begin //FIXME sect_sfb_offset
						if(sect_codebook[g][i] <= 4) begin //livros de código para quadruplas de coeficientes
							//TODO decodificar os coeficientes espectrais w,x,y,z
							if(huffmanDecoder.is_unsigned_codebook(sect_codebook[g][i])) begin
								//$display("### QUAD SEM SINAL");
							end
							k += 4;
						end
						else begin //livros de código para pares de coeficientes
							//TODO decodificar os coeficientes espectrais y,z
							if(huffmanDecoder.is_unsigned_codebook(sect_codebook[g][i])) begin
								//  $display("### PAIR SEM SINAL");
							end
							k += 2;
							if(sect_codebook[g][i] == 11) begin //ESC_HCB
								//TODO
							end
						end
					end
				end
			end			
		end
	endtask
	
   task run();
      while(1) begin
        entrada_stim.get(tr_in_entrada);        
        tr_out_amostra= new();
		tr_out_erro= new();
        
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
		else if(tr_in_entrada.bitrate > 14) begin
			//$display("\n######ERRO: BITRATE INADEQUADO!! : \n");
			tr_out_erro.erro = 3;
		end
		else if(tr_in_entrada.num_program_config_elements != 4'd0) begin
			//$display("\n######ERRO: MAIS DE UMA CONFIGURACAO DE PROGRAMA!! : \n");
			tr_out_erro.erro = 4;
		end
		if(tr_out_erro.erro == 0) begin
			//IDENTIFICA OS RAW_DATA_BLOCK		
			for(int i=0; i< n_raw_data_block ; i++) begin	
				$display("\n###### ..........RAW_DATA_BLOCK..........####### %d ", i);
				raw = tr_in_entrada.raw_data_block[i];
				//raw.reorderSyntaticElements();
				id_syn_ele = raw.id_syn_ele[0];
				n_elements_in_raw = 0;			
				while(id_syn_ele != 7) begin //ID_END
					case(id_syn_ele)					
						0 : //ID_SCE
							begin
								ics = raw.sce[n_elements_in_raw].ics;
								$display("\n######VEIO SCE!! : \n");
								handle_ics(ics, 1'b0);
								
							end
							
						1 : //ID_CPE
							begin
								cpe = raw.cpe[n_elements_in_raw];
								$display("\n######VEIO CPE!! : \n");
								handle_ics(cpe.ics1, cpe.common_window);
								handle_ics(cpe.ics2, cpe.common_window);
							end
							
						2 : //ID_CCE
							begin
								$display("\n######VEIO CCE!! : \n");
								tr_out_erro.erro = 5;
							end
							
						3 : //ID_LFE
							begin
								$display("\n######VEIO LFE!! : \n");
								tr_out_erro.erro = 5;
							end
							
						4 : //ID_DSE
							begin
								$display("\n######VEIO DSE!! : \n");
								
							end
							
						5 : //ID_PCE
							begin
								$display("\n######VEIO PCE!! : \n");
								tr_out_erro.erro = 5;
							end
						
						6 : //ID_FIL
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

endclass

