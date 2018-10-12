function [ den ] = PR_denominator(Q,Q_0, ith_seq, w,L)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

sum = 0;
for j = 1:(L-w+1)
    Rj = R_j(Q_0, ith_seq, j, w);
    Pj = P_j(Q,ith_seq, j, w);
    sum = sum + Pj/Rj;
end

den = sum;
end

