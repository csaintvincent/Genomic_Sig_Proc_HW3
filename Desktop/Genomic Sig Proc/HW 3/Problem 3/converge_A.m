function [ A ] = converge_A( seq_array, Q_0, w, iterations )
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here
A = zeros(length(seq_array(:,1)), length(seq_array(1,:)) - w + 1);
for i=1:iterations
    [R,n] = A_ij(seq_array, Q_0, w);
    A = A + R;
end




end

