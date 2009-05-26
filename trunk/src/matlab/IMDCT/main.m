function [ output_args ] = main( )

x = 1.5;
kMax = 100;

i0_result = i0(x, kMax);

figure(1);
plot(i0_result(1,:), i0_result(2,:) );

