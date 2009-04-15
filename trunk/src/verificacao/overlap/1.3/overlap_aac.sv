class overlap_aac;
 
 
	function new();
	endfunction
	
	function void overlap(int firstSequence, int pcm_in[3:0],  ref int pcm_out[3:0]);
		foreach(pcm_out[i])
	     $display(pcm_out[i]);
	     
		//////////////////////////EXECUTANDO/////////////////////////////////////

		$display("Valor do firstSequence = %d", firstSequence);
		
		if(firstSequence == 1)
				begin
					pcm_out[0] = pcm_in[0];
					pcm_out[1] = pcm_in[1];
					pcm_out[2] = pcm_in[2];
					pcm_out[3] = pcm_in[3];
				end
			else
				begin
					pcm_out[0] = pcm_in[0] + pcm_in[2];
					pcm_out[1] = pcm_in[1] + pcm_in[3];
					pcm_out[2] = 0;
					pcm_out[3] = 0; 
				end
			
			
			//return
			//overlap = coef_pcm_out;
   endfunction
 
 
 endclass

/*
	 
class refmod_overlap;

	//modelo de referência
	overlap_aac refmod;


  function new();
	endfunction


  task run();
		while(1) begin
			
			
			int pcm_out[3 : 0];
			int pcm_in[3 : 0];
			
			
			foreach(pcm_in[i])
			 pcm_in[i] = $urandom();
			///////////////////////////CARREGANDO/////////////////////////////////////
			foreach(pcm_out[i])
				pcm_out[i] = $urandom();
									
				
			//chama a transformada
			refmod = new();
			refmod.overlap(1, pcm_in, pcm_out);
					
			////////////////////////////DESCARREGANDO/////////////////////////////
			foreach(pcm_out[i])
	     $display(pcm_out[i]);
					
		end
	endtask
endclass*/