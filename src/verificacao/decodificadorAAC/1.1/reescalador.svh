//scalefactor, coeficiente	  
import "DPI-C" function real reesc(byte idx, int coef);
`include "ovm.svh"

class reescalador extends ovm_object;

  function reescala(byte sf, int coef);
     reescala=reesc(sf,coef);
  endfunction
  
endclass