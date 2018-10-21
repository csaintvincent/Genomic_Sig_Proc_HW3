function [ P ] = P_j( Q, ith_sequence, j, w )
%We calculate the probability that the motif starts at the jth position
%based on the re-caculated Q from all sequences not incluing the ith.

% product starts at 1
P = 1;
pos = 1;

% loop over all positions in the motif that starts at j
for row=j:(j+w-1)
    
    % get the row b of q_bk
    q_row = get_q_row(ith_sequence(row));
    
    % calcualte new produt based on the character being located in the
    % position in the motif
    P = P * Q(q_row, pos);
    
    % increment our position in motif
    pos = pos + 1;
end


end

