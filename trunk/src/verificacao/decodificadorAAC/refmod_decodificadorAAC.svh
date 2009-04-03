
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
	int id_syn_ele;
	int coef = 0;
	int nRawDataBlock = 2;
	raw_data_block raw;
	int nElementsInRaw = 0;
	individual_channel_stream ics;
	
	 function void tratar_ics(individual_channel_stream ics);
		
	endfunction
	
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
			for(int i=0; i< nRawDataBlock ; i++) begin	
				$display("\n###### ..........RAW_DATA_BLOCK..........####### %d ", i);
				raw = tr_in_entrada.raw_data_block[i];
				id_syn_ele = raw.id_syn_ele[0];
				nElementsInRaw = 0;			
				while(id_syn_ele != 7) begin //ID_END
					case(id_syn_ele)					
						0 : //ID_SCE
							begin
								ics = raw.sce[nElementsInRaw].ics;
								$display("\n######VEIO SCE!! : \n");
								tratar_ics(ics);
								//TESTE - envia os coefs para o checker
								for(int i=0; i< 64 ; i++) begin			
									coef = ics.spectral_data.hcod[0][0][i];
									tr_out_amostra.amostra = coef;
									crm.sample();
									erro_stim.put(tr_out_erro);
									amostra_stim.put(tr_out_amostra);			

								end
							end
							
						1 : //ID_CPE
							begin
								$display("\n######VEIO CPE!! : \n");
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
					nElementsInRaw++;
					id_syn_ele = raw.id_syn_ele[nElementsInRaw];
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

