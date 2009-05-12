class overlap_aac;
 
 
	function new();
	endfunction
	
	function void overlap(int firstSequence, int pcm_in[3:0],  ref int pcm_out[3:0]);
		/*foreach(pcm_out[i])
	     $display(pcm_out[i]);
	  */
	     
		//////////////////////////EXECUTANDO/////////////////////////////////////

		//$display("Valor do firstSequence = %d", firstSequence);
		
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
    
   function void teste();
      $display("Teste Overlap");
   endfunction 
 endclass
