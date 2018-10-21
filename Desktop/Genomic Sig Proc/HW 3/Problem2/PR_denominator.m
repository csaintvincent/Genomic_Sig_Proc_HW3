function [ den ] = PR_denominator(Q,Q_0, ith_seq, w,L)
% We calculate the denominator by summing all Pj and Rj from j= 1 to the
% length of the ith sequence

sum = 0;

% loop over the possible starting positions for the motif in the ith
% sequence
for j = 1:(L-w+1)
    
    % calculate Rj and Pj
    Rj = R_j(Q_0, ith_seq, j, w);
    Pj = P_j(Q,ith_seq, j, w);
    
    % add to the sum
    sum = sum + Pj/Rj;
end
% return the sum
den = sum;
end

