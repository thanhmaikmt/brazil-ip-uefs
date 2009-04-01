`include "ovm.svh"
`include "sdi.svh"
 
   function void record_set_huffman_input(int reco , int codeword, int codebook, int globalGain);
      // optionaly use format specifier as 3rd argument of sdi_set_attribute 
      $sdi_set_attribute(reco, codeword);
      $sdi_set_attribute(reco, codebook);
      $sdi_set_attribute(reco, globalGain);
   endfunction

class huffman_input extends ovm_object;
   int record;
    
	//probabilidades determinadas pela uniao de todas as tabelas de huffman em ISO 13818-7
   rand int codeword; 
   constraint codeword_range {
     codeword dist { [32'h00000000:32'h00000045] :/ 5 , [32'h00000054:32'h00000059] :/ 2, [32'h00000060:32'h0000007a] :/ 2, [32'h0000008c:32'h000000fa] :/ 1, [32'h00000190:32'h000001ff] :/ 1, [32'h0000038a:32'h000003ff] :/ 1, [32'h000007c4:32'h000007ff] :/ 1, [32'h00000fc6:32'h00000fff] :/ 1, [32'h00001fd8:32'h00001fff] :/ 1, [32'h00003ff0:32'h00003ffd] :/ 1, [32'h00007ff4:32'h00007fff] :/ 1, [32'h0000fff0:32'h0000ffff] :/ 1, [32'h0001ffee:32'h0001ffef] :/ 1, [32'h0003ffe2:32'h0003ffe8] :/ 1, [32'h0007ffd2:32'h0007ffff] :/ 1 };
   }
   
   
   rand int codebook; 
   constraint codebook_range {
     codebook dist { [1:12] };
   }
   
   rand int globalGain; 
   constraint globalGain_range {
     globalGain dist { [0:255] };
   }
   

   function integer equal(huffman_input tr);
      equal = (this.codeword == tr.codeword) && (this.codebook == tr.codebook) && (this.globalGain == tr.globalGain);
   endfunction

   function string psprint();
      psprint = $psprintf("codeword= %d, codebook= %d, globalGain= %d)", codeword, codebook, globalGain);
   endfunction

   function bit read(int file);
      if (file && !$feof(file))
        read = 0 != $fscanf(file, "%d %d %d ", this.codeword, this.codebook, this.globalGain);
      else read = 0;    
   endfunction

   task rec_begin(int fiber, string label);
      record = record_begin(fiber, label);
   endtask

   task rec_end();
      record_set_huffman_input(record,codeword,codebook,globalGain);
      record_end(record);
   endtask

endclass

   function void record_set_huffman_output(int reco , int w, int x, int y, int z);
      // optionaly use format specifier as 3rd argument of sdi_set_attribute 
      $sdi_set_attribute(reco, w);
      $sdi_set_attribute(reco, x);
      $sdi_set_attribute(reco, y);
      $sdi_set_attribute(reco, z);
   endfunction

class huffman_output extends ovm_object;
   int record;
    
   rand int w; 
   constraint w_range {
     w dist { [-8191:8191] };
   }
   
   rand int x; 
   constraint x_range {
     x dist { [-8191:8191] };
   }
   
   rand int y; 
   constraint y_range {
     y dist { [-8191:8191] };
   }
   
   rand int z; 
   constraint z_range {
     z dist { [-8191:8191] };
   }
   

   function integer equal(huffman_output tr);
      equal = (this.w == tr.w) && (this.x == tr.x) && (this.y == tr.y) && (this.z == tr.z);
   endfunction

   function string psprint();
      psprint = $psprintf("w= %d, x= %d, y= %d, z= %d ", w, x, y, z);
   endfunction

   function bit read(int file);
      if (file && !$feof(file))
        read = 0 != $fscanf(file, "%d %d %d %d ", this.w, this.x, this.y, this.z);
      else read = 0;    
   endfunction

   task rec_begin(int fiber, string label);
      record = record_begin(fiber, label);
   endtask

   task rec_end();
      record_set_huffman_output(record,w,x,y,z);
      record_end(record);
   endtask

endclass


class delay; // used for delay in signal handshake
   rand int d;
   constraint delay_range {
      d dist {0 :/ 8, [1:2] :/2, [3:10] :/1 };
   }
endclass

