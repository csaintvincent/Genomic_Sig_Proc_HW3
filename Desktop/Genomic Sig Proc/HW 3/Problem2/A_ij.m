function [ A, a_mat ] = A_ij( seq_array, Q_0, w )
%This function takes in a set of sequences, a background probability
%matrix, and a motif length w. It calculates all A_ij.

% We need to get the numbers of arrays in the sequence
num_row_array = length(seq_array(:,1));

%IGNORE
%num_col_array = length(seq_array(1,:));

% We now specify a matrix consisting of all ai starting position of the
% motif in each seqence. This is chosen randomly.
a_mat = a_mat_not_i(seq_array, w);

%Initialize A for computational effic.
A = zeros(num_row_array, length(seq_array(1,:)) - w + 1);

% Loop through all sequences
for i = 1:num_row_array
    
    %seq_i = seq_array(1,:);
    
    % In round-robin fashion, we pluck out the ith sequence
    % seq_i = seq_array(i,:);
    ith_seq = seq_array(i,:);
    
    % Now for the ith sequence, we locate the index ni of the first 'N'. Note:
    % we are guarenteed to have an 'N' because the padded array added an
    % 'N' to the longest sequence.
    ni = find_n_index(ith_seq);
    
    % Now we create a set of sequences that does not contain our ith
    % sequence.
    seq_array_not_i = seq_array;
    seq_array_not_i(i,:) = []; % ith sequence is now empty
    
    % Now we must also pluck out the ai position from a_mat
    a_mat_minus_i = a_mat;
    a_mat_minus_i(i) = [];
    
    % We must get the length of the ith sequence until right before the
    % first N. This way we can ensure that motifs do not extend into the N
    % region.
    num_col_array = length(ith_seq(1:(ni-1)));
    
    % Now re re-calculate Q using all sequences and randomly chosen
    % starting positions for the motifs that DO NOT include the ith
    % sequence
    Q = q_bk(seq_array_not_i, w, a_mat_minus_i);% 1 1 1 1 1 1 1 1 1 1];
    
    
    % We calculate or denominator by summing Pj/Rj for all j from 1 to
    % L - w + 1 where L is the length of our ith sequence up until the
    % first N. Should sum to one. Will look at in a bit.
    denominator = PR_denominator(Q,Q_0, ith_seq, w, num_col_array);

    % Now we calculate each numerator from j = 1 to the last possible
    % position of the motif for the ith sequence
    for j = 1:(num_col_array - w +1)
        
        % Calculate Rj and Pj for the ith sequence with the updated Q and
        % current j
        Rj = R_j(Q_0, ith_seq, j, w);
        Pj = P_j(Q, ith_seq ,j, w);
        
        % get ratio
        numerator = Pj/Rj; 
        
        % Aij = (Pj/Rj)/(sum(Pj/Rj) from j = 1 -> L - w + 1)
        A(i,j) = numerator/denominator;
    end
    
    
end

end

