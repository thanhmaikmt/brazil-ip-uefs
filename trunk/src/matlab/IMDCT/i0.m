function [ i0_result ] = i0( x, kMax )
    
    k = [0:1:kMax];
    
    i0_result(1, :) = k;
    i0_result(2, :) = funcao(x, k);
    
%    while k < kMax,
%        derivada = funcao(x, k);
%        
%        i0_result(1, k + 1) = k; 
%        if(k == 0),
%            i0k = derivada;
%        else
%            i0k = i0_result(2, k) + derivada;
%        end;
%        
%        i0_result(2, k + 1) = i0k;
%        
%        k = k + 1;
%    end;
    
    