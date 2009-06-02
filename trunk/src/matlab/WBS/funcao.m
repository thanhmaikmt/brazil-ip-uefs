function [ result ] = funcao( x, k )
    result = 0;
    
    result = ( ( (x/2) .^ k) ./ factorial(k) ) .^2 ;