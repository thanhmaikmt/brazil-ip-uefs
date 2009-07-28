function [ i0_result ] = i0( x )
    
    global kMax;
    if(~exist('kMax'))
        kMax = [];
    end;
    

    if(isempty(kMax)),
        fprintf ('\n Digite o k máximo: \n');
            kMax = input('--> ');
    end;
    

    
    
    k = [0:1:kMax];
    
    i0_result(1, :) = k;
    i0_result(2, :) = funcao(x, k);
    
    acumulador = 0;
    for i = 1:kMax+1,
        %fprintf ('k %d - result %d\n', k(i), i0_result(2, i));
        
        acumulador = acumulador + i0_result(2, i);
        i0_result(3, i) = acumulador;
        
    end;
    
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
    
    