import "DPI-C" function real dequantiza(int idx);
`include "ovm.svh"

class dequantizador extends ovm_object;
  function dequant(int coef_quant);
      dequant=dequantiza(coef_quant);
  endfunction
endclass
 