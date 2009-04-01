


  class in_huffman_driver extends ovm_threaded_component;

    ovm_get_port #(huffman_input) in_huffman_from_source;
    huffman_input p_in_huffman;
     
    int fiber_codeword;
    
    int fiber_codebook;
    
    int fiber_globalGain;
    

    function new(string name, ovm_component parent);
      super.new(name,parent);

      in_huffman_from_source = new("in_huffman_from_source", this);
       
      fiber_codeword = $sdi_create_fiber("Driver", "TVM", "top");
      
      fiber_codebook = $sdi_create_fiber("Driver", "TVM", "top");
      
      fiber_globalGain = $sdi_create_fiber("Driver", "TVM", "top");
      
    endfunction

    task run();

      delay d = new;

      in_huffman_valid <= 0;
      @(posedge clk);
      while(reset) @(posedge clk);
      while(1) begin

        in_huffman_from_source.get(p_in_huffman);
        p_in_huffman.rec_begin(fiber_codewordcodebookglobalGain,"in_huffman");  
          in_huffman_clock  
          in_huffman_reset  
          in_huffman_acionar  
          in_huffman_codebook  
          in_huffman_globalGain  
          in_huffman_codeword  <= p_in_huffman.codewordcodebookglobalGain;
          in_huffman_valid <= 1;
          @(posedge clk);
          while(!in_huffman_ready) @(posedge clk);
        p_in_huffman.rec_end();
          in_huffman_valid  <= 0;
          assert(d.randomize());
          repeat(d.d) @(posedge clk);
      end
    endtask
  endclass

