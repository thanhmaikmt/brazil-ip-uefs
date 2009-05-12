

`include "overlap_aac.sv"

class refmod_overlap extends ovm_component;

  	//modelo de overlap_aac
	 overlap_aac tr_overlap_aac;

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
			
			int pcm_in[3 : 0];
			int pcm_out[3 : 0];
			int firstSequence;
      
      
			for(int i = 0; i < 4; i++)
				begin
					in_overlap_stim.get(tr_in_in_overlap);
					pcm_in[i] = tr_in_in_overlap.pcmSample;
				end
			
			firstSequence = tr_in_in_overlap.firstSequence;
			
			//in_overlap_stim.get(tr_in_in_overlap);
			//firstSequence = tr_in_in_overlap.firstSequence;
	
			$display("\n");
			$display(">refmod_overlap");
			$display("firstSequence: %d", firstSequence);
			$display("data in: %d, %d, %d, %d ", pcm_in[0], pcm_in[1], pcm_in[2], pcm_in[3]);
			
			
			//chama a overlap_aac
			tr_overlap_aac = new();
			tr_overlap_aac.overlap(firstSequence, pcm_in, pcm_out);		
			
			
			
			$display("data out: %d, %d, %d, %d ", pcm_out[0], pcm_out[1], pcm_out[2], pcm_out[3]);
			
			//seta saídas
			for(int i = 0; i < 4; i++)
				begin
					tr_out_out_overlap = new();
					tr_out_out_overlap.pcmSample = pcm_out[i];
					crm.sample();
					out_overlap_stim.put(tr_out_out_overlap);
				end
				
			
        
      end
    endtask
endclass

