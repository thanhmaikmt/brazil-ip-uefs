
class refmod_overlap extends ovm_component;

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
        in_overlap_stim.get(tr_in_in_overlap);
        
        tr_out_out_overlap= new();
        
        //-----------------------------------------------------------------------
        // Here goes the code that executes the reference model's functionality.
        //-----------------------------------------------------------------------
	
	//int nulo = 0;
	
	if(tr_in_in_overlap.firstSequence)
	begin
		tr_out_out_overlap.pcmSample[0] = tr_in_in_overlap.pcmSample[0];
		tr_out_out_overlap.pcmSample[1] = tr_in_in_overlap.pcmSample[1];
		tr_out_out_overlap.pcmSample[2] = tr_in_in_overlap.pcmSample[2];
		tr_out_out_overlap.pcmSample[3] = tr_in_in_overlap.pcmSample[3];
	end
	else
	begin
		tr_out_out_overlap.pcmSample[0] = tr_in_in_overlap.pcmSample[0] + tr_in_in_overlap.pcmSample[2];
		tr_out_out_overlap.pcmSample[1] = tr_in_in_overlap.pcmSample[1] + tr_in_in_overlap.pcmSample[3];
		tr_out_out_overlap.pcmSample[2] = 0;
		tr_out_out_overlap.pcmSample[3] = 0; 
	end		
		
	crm.sample();
	out_overlap_stim.put(tr_out_out_overlap);
        
      end
    endtask
endclass

