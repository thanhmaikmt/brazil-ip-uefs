function [ result ] = funcao( x, k )
    result = 0;
    
    result = ( ( (x/2) .^ k) ./ fatorial(k) ) .^2 ;
    

function f = fatorial(n)
    f = 1;
    for k = 1:n
        f = f*k;
    end