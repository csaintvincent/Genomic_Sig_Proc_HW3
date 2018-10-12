function [ denominator ] = denominator( Q, Q_0, i_th_sequence, w )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

sum = 0;

for k=1:(length(i_th_sequence) - w + 1)
    sum = sum + numerator( Q, Q_0, i_th_sequence, k, w );
end

denominator = sum;

end

