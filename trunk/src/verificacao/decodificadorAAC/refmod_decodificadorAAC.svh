
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
	int id_syn_ele, global_gain, num_window_groups, max_sfb;
	bit[1:0] window_sequence;
	bit[3:0] sfb_codebook[7:0][48:0];
	bit window_shape;
	int coef = 0;
	int n_raw_data_block = 2;
	raw_data_block raw;
	int n_elements_in_raw = 0;
	individual_channel_stream ics;
	int sect_start[7:0][48:0];
	int sect_end[7:0][48:0];
	int num_sec[7:0];
	

	task handle_ics_info(ics_info ics_info);
		window_sequence = ics_info.window_sequence;
		window_shape = ics_info.window_shape;
		if(window_sequence == 2) begin //EIGHT_SHORT_SEQUENCE
			max_sfb = ics_info.max_sfb_short;
			num_window_groups = ics_info.get_num_window_groups();
		end
		else begin
			max_sfb = ics_info.max_sfb_long;
			//if(ics_info.predictor_data_present) //presença de predição
			//	tr_out_erro.erro = 5;
		end
		
	endtask
	
	 task handle_ics(individual_channel_stream ics);
		handle_ics_info(ics.ics_info);
		//TESTE - envia os coefs para o checker

		for(int i=0; i< 64 ; i++) begin			
			coef = ics.spectral_data.hcod[1][1][i];
			tr_out_amostra.amostra = coef;
			crm.sample();
			erro_stim.put(tr_out_erro);
			amostra_stim.put(tr_out_amostra);			
		end
		
		handle_section_data(ics.section_data);
	endtask
	
	task handle_section_data(section_data sd);
		int k, i, sect_len, sect_len_incr, sect_esc_val, j;
		bit[3:0] sect_cb;
		if(window_sequence == 2) //EIGHT_SHORT_SEQUENCE
			sect_esc_val = (1<<3) -1;
		else
			sect_esc_val = (1<<5) -1;
			
		//ler as informações relatias a um ics_info()
		for(int g=0; g< num_window_groups ; g++) begin	
			k = 0;
			i = 0;
			while(k < max_sfb) begin
				sect_cb = sd.sect_cb[g][i];
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
					sfb_codebook[g][sfb] = sect_cb;
				end
				k+= sect_len;
				i++;
			end
			num_sec[g] = i;
		end
		
	endtask
	
	task handle_scalefactor_data();
		//ler as informações relatias a um ics_info()
		
	endtask
	
	task handle_spectral_data();
		//ler as informações relatias a um ics_info()
		
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
								handle_ics(ics);
								
							end
							
						1 : //ID_CPE
							begin
								ics = raw.sce[n_elements_in_raw].ics;
								$display("\n######VEIO CPE!! : \n");
								handle_ics(ics);
								handle_ics(ics);
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
		else
			erro_stim.put(tr_out_erro);
        
      end //fim do while(1)
    endtask

endclass

