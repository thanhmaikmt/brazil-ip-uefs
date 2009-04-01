class sink extends ovm_component;

    ovm_get_port #(huffman_output) out_huffman_from_refmod;
    
    int fiber;
    function new(string name, ovm_component parent);
      super.new(name,parent);
      out_huffman_from_refmod = new("out_huffman_from_refmod", this);
      
      fiber = $sdi_create_fiber("checker", "TVM", "top");
    endfunction

    task run();
		string msg;
       huffman_output tr_out_huffman;
       
       while(1) begin
          out_huffman_from_refmod.get(tr_out_huffman);
		  msg = $psprintf("received_from_modref  %s", tr_out_huffman.psprint() );
		  //ovm_report_info("checker", msg);
          
       end
    endtask
endclass

