class pre_source extends ovm_component;

   ovm_put_port #(huffman_input) in_huffman_to_refmod;
   
   function new(string name, ovm_component parent);
      super.new(name,parent);
      in_huffman_to_refmod = new("in_huffman_to_refmod", this);
   endfunction

   task run();
      huffman_input tr_in_huffman;
      
      int file = $fopen("tr.sti", "r");
      while(1) begin 
         
	 tr_in_huffman = new();
         if(!tr_in_huffman.read(file))
            assert(tr_in_huffman.randomize());
			
         in_huffman_to_refmod.put(tr_in_huffman);
         
         #1;
       end
    endtask
    
endclass

