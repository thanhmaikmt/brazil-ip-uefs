
class refmod_overlap_mutant extends ovm_component;

   ovm_get_port #(overlap_input) in_overlap_stim;
   overlap_input tr_in_in_overlap;
   
   ovm_put_port #(overlap_output) out_overlap_stim;
   overlap_output tr_out_out_overlap;
   
   covergroup crm;
      
      coverpoint tr_out_out_overlap.pcmSample {
         bins tr[] = { 0 };
         option.at_least = 1;
      }
      
   endgroup

   function new(string name, ovm_component parent);
      super.new(name,parent);
      in_overlap_stim = new("in_overlap_stim", this);
      
      out_overlap_stim = new("out_overlap_stim", this);
      
      crm = new;
   endfunction

   task run();
		while(1) begin
			
			int coef_pcm_in[4 : 0];
			int coef_pcm_out[4 : 0];
			int firstSequence;

			
			//-----------------------------------------------------------------------
			// Here goes the code that executes the reference model's functionality.
			//-----------------------------------------------------------------------

			
			for(int i = 0; i < 4; i++)
				begin
					in_overlap_stim.get(tr_in_in_overlap);
					coef_pcm_in[i] = tr_in_in_overlap.pcmSample;
				end
			
			//in_overlap_stim.get(tr_in_in_overlap);
			//firstSequence = tr_in_in_overlap.firstSequence;
	
			$display("\n");
			$display(">refmod_overlap_mutant");
			$display("firstSequence: %d", tr_in_in_overlap.firstSequence);
			$display("data in: %d, %d, %d, %d ", coef_pcm_in[0], coef_pcm_in[1], coef_pcm_in[2], coef_pcm_in[3]);
			
			
			if(tr_in_in_overlap.firstSequence == 1)
				begin
					coef_pcm_out[0] = coef_pcm_in[1];
					coef_pcm_out[1] = coef_pcm_in[1];
					coef_pcm_out[2] = coef_pcm_in[1];
					coef_pcm_out[3] = coef_pcm_in[1];
				end
			else
				begin
					coef_pcm_out[0] = coef_pcm_in[0] + coef_pcm_in[2];
					coef_pcm_out[1] = coef_pcm_in[1] + coef_pcm_in[3];
					coef_pcm_out[2] = 0;
					coef_pcm_out[3] = 0; 
				end		
			
			
			
			$display("data out: %d, %d, %d, %d ", coef_pcm_out[0], coef_pcm_out[1], coef_pcm_out[2], coef_pcm_out[3]);
			
			/////
			for(int i = 0; i < 4; i++)
				begin
					tr_out_out_overlap = new();
					tr_out_out_overlap.pcmSample = coef_pcm_out[i];
					crm.sample();
					out_overlap_stim.put(tr_out_out_overlap);
				end
				
			
        
      end
    endtask
endclass

