class overlap_aac;
  
  //tamanho de cada metade
  parameter int HALF_WINDOW_SIZE = 512;
  
  typedef enum { middle = 0, first = 1, last = 2} SequencePosition;
  SequencePosition position;
  
	function new();
	  position = middle;
	endfunction
	
	/*
	* int sequencePos - definido de acordo ao enum SequencePosition
	* pcm_in_1 - ultima metade da primeira seqüência
	* pcm_in_2 - primeira metada da segunda seqüência
	* pcm_out - saída
	*/
	function void overlap(int sequencePos, int pcm_in_1[(HALF_WINDOW_SIZE-1):0], int pcm_in_2[(HALF_WINDOW_SIZE-1):0],  ref int pcm_out[(HALF_WINDOW_SIZE-1):0]);
		int i = 0;
		
		position = SequencePosition'(sequencePos);
				
		if(position == first)
				begin
				  for(i = 0; i < HALF_WINDOW_SIZE; i++) begin
					   pcm_out[i] = pcm_in_2[i];
					end
					/*
					pcm_out[0] = pcm_in[0]
					pcm_out[1] = pcm_in[1];
					pcm_out[2] = pcm_in[2];
					pcm_out[3] = pcm_in[3];*/
				end
			else if (position == last)
				begin
				  
					for(i = 0; i < HALF_WINDOW_SIZE; i++) begin
					   pcm_out[i] = pcm_in_1[i];
					end
					
				end
      else //middle
			  begin
				  for(i = 0; i < HALF_WINDOW_SIZE; i++) begin
					   pcm_out[i] = pcm_in_1[i] + pcm_in_2[i];
					end
					
				end
			
			//return
			//overlap = coef_pcm_out;
   endfunction
    
   function void teste();
      $display("Teste Overlap");
   endfunction 
 endclass
