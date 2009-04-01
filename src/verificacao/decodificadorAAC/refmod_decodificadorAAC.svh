
class refmod_decodificadorAAC extends ovm_component;

   ovm_get_port #(stream) entrada_stim;
   stream tr_in_entrada;
   
   ovm_put_port #(amostra) amostra_stim;
   amostra tr_out_amostra;

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
      
      crm = new;
   endfunction
   
   function void tratar_ics(individual_channel_stream ics);
	
	
	endfunction
   
   //enum { ID_SCE, ID_CPE, ID_CCE, ID_LFE, ID_DSE, ID_PCE, ID_FIL, ID_END } id_syn_ele;
	int id_syn_ele;
	int coef = 0;
	int nRawDataBlock = 2;
	raw_data_block raw;
	int nElements = 0;
   task run();
      while(1) begin
        entrada_stim.get(tr_in_entrada);        
        tr_out_amostra= new();
        
        //-----------------------------------------------------------------------
        // Here goes the code that executes the reference model's functionality.
        //-----------------------------------------------------------------------
		$display("\n###### STREAM RECEBIDA PELO REFMOD : \n%s", tr_in_entrada.psprint());	
		
		//VERIFICA ALGUMAS CONFIGURAÇÕES DO CABEÇALHO
		if(tr_in_entrada.bitstream_type) begin
			$display("\n######ERRO: BITSTREAM VARIAVEL!! : \n");
		end
		else if(tr_in_entrada.bitrate > 14) begin
			$display("\n######ERRO: BITRATE INADEQUADO!! : \n");
		end
		else if(tr_in_entrada.num_program_config_elements != 4'd0) begin
			$display("\n######ERRO: MAIS DE UMA CONFIGURACAO DE PROGRAMA!! : \n");
		end
		
		//IDENTIFICA OS RAW_DATA_BLOCK		
		for(int i=0; i< nRawDataBlock ; i++) begin	
			$display("\n###### ..........RAW_DATA_BLOCK..........####### %d ", i);
			raw = tr_in_entrada.raw_data_block[i];
			id_syn_ele = raw.id_syn_ele[0];
			nElements = 0;			
			while(id_syn_ele != 7) begin //ID_END
				case(id_syn_ele)					
					0 :
						begin
							$display("\n######VEIO SCE!! : \n");
							tratar_ics(raw.sce[nElements].ics );
						end
						
					1 : //ID_CPE
						begin
							$display("\n######VEIO CPE!! : \n");
						end
						
					2 : //ID_CCE
						begin
							$display("\n######ERRO: VEIO CCE!! : \n");
						end
						
					3 : //ID_LFE
						begin
							$display("\n######ERRO: VEIO LFE!! : \n");
						end
						
					4 : //ID_DSE
						begin
							$display("\n######VEIO DSE!! : \n");
						end
						
					5 : //ID_PCE
						begin
							$display("\n######ERRO: VEIO PCE!! : \n");
						end
					
					6 : //ID_FIL
						begin
							$display("\n######VEIO FILL!! : \n");
						end

				endcase
				nElements++;
				id_syn_ele = raw.id_syn_ele[nElements];
			end
			$display("\n###### VEIO TERM !! ");
			
			
			coef = tr_in_entrada.raw_data_block[0].sce[0].ics.spectral_data.hcod[0][0][i];
			//$display("###### REFMOD : hcod[0][0][%d] = %d", i, coef );
			tr_out_amostra.amostra = coef;
			crm.sample();
			amostra_stim.put(tr_out_amostra);
			//coef = tr_in_entrada.pce[0].back_element_is_cpe;
		end
		
		
		for(int i=0; i< 64 ; i++) begin			
			coef = tr_in_entrada.raw_data_block[0].sce[0].ics.spectral_data.hcod[0][0][i];
			//$display("###### REFMOD : hcod[0][0][%d] = %d", i, coef );
			tr_out_amostra.amostra = coef;
			crm.sample();
			amostra_stim.put(tr_out_amostra);
			//coef = tr_in_entrada.pce[0].back_element_is_cpe;
		end
		
        
      end
    endtask

endclass

