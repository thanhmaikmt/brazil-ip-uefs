function [ w_result ] = W( n, N )

    a = -1;
    if (N == 2048),
        a = 4;
    end;
    if (N == 256),
        a = 6;
    end;
    
    

    pi_a = pi * a;

    temp = (n - N/4)/(N/4);
    x = pi_a * sqrt( 1 - (temp ^ 2) );


    i0_x = i0(x);
    i0_pi_a = i0(pi_a);
    
    w_result = i0_x(3,:)./i0_pi_a(3,:);
    
    for i = 1:max(size(w_result)),
        fprintf ('k %d - result %d (i0(x) = %d, i0(pi * a) = %d)\n', i + 1, w_result(i), i0_x(3,i), i0_pi_a(3,i));
    end;