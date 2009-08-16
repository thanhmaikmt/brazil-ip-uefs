class converter;

  function new(string name);     

  endfunction

  function bit[15:0] decToBin(integer dec);
    integer i = 0;
    bit[15:0] bin = 16'b0000000000000000;
    
    /*for (i = 0; i < 16; i ++) begin
      if(dec % 2 == 0)
        bin[i] = 1;
      else
        bin[i] = 0;
    
      dec = dec/2;  
      
    end*/
    
    bin = dec;
    
    //$display("dec %d = bin %b", dec, bin);
    
    return bin;
    
  endfunction
  
  
  
  function integer binToDec(bit [15:0] bin);
    integer i = 0;
    integer dec = 0;

    /*for (i = 15; i >= 0; i --) begin
      
      dec = dec * 2 + bin[i];
      
    end;*/
    dec = bin;
    
    //$display("bin %b = dec %d", bin, dec);
    
    return dec;
    
  endfunction
    
endclass
