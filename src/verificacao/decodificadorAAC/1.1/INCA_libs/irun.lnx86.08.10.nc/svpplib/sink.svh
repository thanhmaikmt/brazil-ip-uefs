class sink extends ovm_component;

    ovm_get_port_amostra amostra_from_refmod;
	ovm_get_port_erro erro_from_refmod;
    
    int fiber;
    function new(string name, ovm_component parent);
      super.new(name,parent);
      amostra_from_refmod = new("amostra_from_refmod", this);
	  erro_from_refmod = new("erro_from_refmod", this);
      
      fiber = $sdi_create_fiber("checker", "TVM", "top");
    endfunction

    task run();
       amostra tr_amostra;
	   erro tr_erro;
       
       while(1) begin
			erro_from_refmod.get(tr_erro);
			if(tr_erro.erro != 0) begin
			  case(tr_erro.erro)
						1 : $display("######CHECKER -> ERRO: ADIF_ID INCORRETO!! ");
						2 : $display("######CHECKER -> ERRO: BITSTREAM VARIAVEL!! ");
						3:  $display("######CHECKER -> ERRO: BITRATE INADEQUADO!!");
						4:  $display("######CHECKER -> ERRO: MAIS DE UMA CONFIGURACAO DE PROGRAMA!!");
						5:  $display("######CHECKER -> ERRO: PERFIL AAC INADEQUADO!!");
						6:  $display("######CHECKER -> ERRO: FREQUENCIA DE AMOSTRAGEM INADEQUADA!!");
						15: $display("######CHECKER -> ERRO: INFORMAÇÃO INESPERADA NO STREAM!!");
						default: $display("######CHECKER -> ERRO: ARQUIVO CORROMPIDO!! ");
						
			 endcase
			 continue;
			end
			amostra_from_refmod.get(tr_amostra);
			
		  $display("###CHECKER --------> Erro = %d   |  Amostra = %d" , tr_erro.erro , tr_amostra.amostra);

       end
    endtask
endclass

