`include "AACHuffmanDecoder.svh"

class refmod_huffman extends ovm_component;

   ovm_get_port #(huffman_input) in_huffman_stim;
   huffman_input tr_in_in_huffman;
   
   ovm_put_port #(huffman_output) out_huffman_stim;
   huffman_output tr_out_out_huffman;
   
   AACHuffmanDecoder huffmanDecoder;
   int dim = 0;
   int lav = 0;
   int off = 0;
   int mod = 0;
   int index = 0;
   int dpcmSF = 0;
   int codebook = 0;
   int lastSF = 0;
   
   int nReceivedScalefactors = 0;
   int nReceivedCoefs = 0;
   
   bit isUnsignedCodebook = 1'b0;
   
   covergroup crm;
      
      coverpoint tr_out_out_huffman.w {
         bins tr[] = { [0:120] };
         option.at_least = 1;
      }
      
      coverpoint tr_out_out_huffman.x {
         bins tr[] = { 0 };
         option.at_least = 1;
      }
      
      coverpoint tr_out_out_huffman.y {
         bins tr[] = { 0 };
         option.at_least = 1;
      }
      
      coverpoint tr_out_out_huffman.z {
         bins tr[] = { 0 };
         option.at_least = 1;
      }
      
   endgroup

   function new(string name, ovm_component parent);
      super.new(name,parent);
      in_huffman_stim = new("in_huffman_stim", this);
      
      out_huffman_stim = new("out_huffman_stim", this);
      
      crm = new;
   endfunction
   
   task run();
		//recebe o livro de codigo e o ganho global
		in_huffman_stim.get(tr_in_in_huffman);
		lastSF = tr_in_in_huffman.globalGain;
		codebook = tr_in_in_huffman.codebook;
		huffmanDecoder = new(codebook);
		$display( "################# Livro de código: %d | Ganho Global: %d ", codebook, dpcmSF  );
		
      while(1) begin
        in_huffman_stim.get(tr_in_in_huffman);
		
        tr_out_out_huffman= new();

        //-----------------------------------------------------------------------
        // Here goes the code that executes the reference model's functionality.
        //-----------------------------------------------------------------------
		
		
		//LIVROS DE CÓDIGO NO ANEXO A DA ISO IEC 13818-7		
		case (codebook)

		   12:  //livro dos fatores de escala TABLE A.1 
		   begin
		   //TODO mais um case com as entradas do livro de código correspondente
				dpcmSF = huffmanDecoder.decode(tr_in_in_huffman.codeword);				
				tr_out_out_huffman.w = lastSF + dpcmSF;
				lastSF = tr_out_out_huffman.w;
				$display( " --- Fator de escala: %d",  tr_out_out_huffman.w );
				 nReceivedScalefactors++;
		   end
		   		   
		   0: //não há transmissão de fatores de escala nem de coeficientes
		   begin
				$display( "Livro de código 0!!! ");
		   end		   
		   
		   1:  //livro dos coeficientes TABLE A.2		   
		   begin
				isUnsignedCodebook = 1'b0;								
				index = huffmanDecoder.decode(tr_in_in_huffman.codeword);
				dim=4;
				lav=1;
		   end
		   
		   2:  //livro dos coeficientes TABLE A.3		   
		   begin
				isUnsignedCodebook = 1'b0;
				index = huffmanDecoder.decode(tr_in_in_huffman.codeword);
				dim=4;
				lav=1;
		   end
		   
		   3:  //livro dos coeficientes TABLE A.4
		   begin
				isUnsignedCodebook = 1'b1;
				index = huffmanDecoder.decode(tr_in_in_huffman.codeword);
				dim=4;
				lav=2;
		   end
		   
		   4:  //livro dos coeficientes TABLE A.5
		   begin
				isUnsignedCodebook = 1'b1;
				index = huffmanDecoder.decode(tr_in_in_huffman.codeword);
				dim=4;
				lav=2;
		   end
		   
		   5:  //livro dos coeficientes TABLE A.6
		   begin
				isUnsignedCodebook = 1'b0;
				index = huffmanDecoder.decode(tr_in_in_huffman.codeword);
				dim=2;
				lav=4;
		   end
		   
		   6:  //livro dos coeficientes TABLE A.7
		   begin
				isUnsignedCodebook = 1'b0;
				index = huffmanDecoder.decode(tr_in_in_huffman.codeword);
				dim=2;
				lav=4;
		   end
		   
		   7:  //livro dos coeficientes TABLE A.8
		   begin
				isUnsignedCodebook = 1'b1;
				index = huffmanDecoder.decode(tr_in_in_huffman.codeword);
				dim=2;
				lav=7;
		   end
		   
		   8:  //livro dos coeficientes TABLE A.9
		   begin
				isUnsignedCodebook = 1'b1;
				index = huffmanDecoder.decode(tr_in_in_huffman.codeword);
				dim=2;
				lav=7;
		   end
		   
		   9:  //livro dos coeficientes TABLE A.10
		   begin
				isUnsignedCodebook = 1'b1;
				index = huffmanDecoder.decode(tr_in_in_huffman.codeword);
				dim=2;
				lav=12;
		   end
		   
		   10:  //livro dos coeficientes TABLE A.11
		   begin
				isUnsignedCodebook = 1'b1;
				index = huffmanDecoder.decode(tr_in_in_huffman.codeword);
				dim=2;
				lav=12;
		   end
		   
		   11:  //livro dos coeficientes TABLE A.12
		   begin
				isUnsignedCodebook = 1'b1;
				index = huffmanDecoder.decode(tr_in_in_huffman.codeword);
				dim=2;
				lav=16;
		   end
		endcase
		
		$display( "CODEBOOK: %d | CODEWORD: %h | INDEX: %d",  codebook ,tr_in_in_huffman.codeword, index);
		if (isUnsignedCodebook) begin
			mod = lav + 1;
			off = 0;
		end
		else begin
			mod = 2*lav + 1;
			off = lav;
		end
		
		if (codebook != 12) begin
			if (dim == 4) begin
				tr_out_out_huffman.w = index/(mod*mod*mod) - off;
				index -= (tr_out_out_huffman.w+off)*(mod*mod*mod);
				tr_out_out_huffman.x = index/(mod*mod) - off;
				index-= (tr_out_out_huffman.x+off)*(mod*mod);
				tr_out_out_huffman.y = index/mod - off;
				index -= (tr_out_out_huffman.y+off)*mod;
				tr_out_out_huffman.z = index - off;
				nReceivedCoefs += 4;
				
			end
			else begin
				tr_out_out_huffman.y = index/mod - off;
				index -= (tr_out_out_huffman.y+off)*mod;
				tr_out_out_huffman.z = index - off;
				nReceivedCoefs += 2;
			end
			$display("##COEFS : %s", tr_out_out_huffman.psprint());
			if(nReceivedCoefs == 1024) begin
				nReceivedCoefs=0;
				in_huffman_stim.get(tr_in_in_huffman);
				dpcmSF = tr_in_in_huffman.globalGain;
				codebook = tr_in_in_huffman.codebook;
				huffmanDecoder = new(codebook);
				$display( "################# Livro de código: %d | Ganho Global: %d ", codebook, dpcmSF  );
			end
			
		end
		else begin
			if(nReceivedScalefactors == 49) begin
				nReceivedScalefactors=0;
				in_huffman_stim.get(tr_in_in_huffman);
				lastSF = tr_in_in_huffman.globalGain;
				codebook = tr_in_in_huffman.codebook;
				huffmanDecoder = new(codebook);
				$display( "################# Livro de código: %d | Ganho Global: %d ", codebook, dpcmSF  );
			end
		end

        crm.sample();
	out_huffman_stim.put(tr_out_out_huffman);
	
        
      end
    endtask
endclass

