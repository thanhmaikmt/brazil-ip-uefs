class sink extends ovm_component;

    ovm_get_port #(amostra) amostra_from_refmod;
	ovm_get_port #(erro) erro_from_refmod;
    
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
			$display("###CHECKER");
			  case(tr_erro.erro)
						1 : $display("######ERRO: ADIF_ID INCORRETO!! ");
						2 : $display("######ERRO: BITSTREAM VARIAVEL!! ");
						3: $display("######ERRO: BITRATE INADEQUADO!!");
						4: $display("######ERRO: MAIS DE UMA CONFIGURACAO DE PROGRAMA!!");
						default: $display("######ERRO: INFORMAÇÃO INESPERADA NO STREAM!! ");
						
			 endcase
			 continue;
			end
			amostra_from_refmod.get(tr_amostra);
			
		  $display("###CHECKER --------> Erro = %d   |  Amostra = %d" , tr_erro.erro , tr_amostra.amostra);

       end
    endtask
endclass

