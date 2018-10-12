function [ A, a_mat ] = A_ij( seq_array, Q_0, w )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
num_row_array = length(seq_array(:,1));
%num_col_array = length(seq_array(1,:));
a_mat = a_mat_not_i(seq_array, w);
A = zeros(num_row_array, length(seq_array(1,:)) - w + 1);

for i = 1:num_row_array
    
    %I need to update this code to find where the index containing the
    %first N and only loop j's with that length. I also need to fix the
    %a_mat_not_i to also include this index
    
    seq_i = seq_array(1,:);
    ni = find_n_index(seq_i);
    
    seq_array_not_i = seq_array;
    seq_array_not_i(i,:) = [];
    a_mat_minus_i = a_mat;
    a_mat_minus_i(i) = [];
    
    num_col_array = length(seq_i(1:(ni-1)));
    
    Q = [q_bk(seq_array_not_i, w, a_mat_minus_i); 1 1 1 1 1 1 1 1 1 1];
    ith_seq = seq_array(i,:);
    denominator = PR_denominator(Q,Q_0, ith_seq, w, num_col_array);
    
    for j = 1:(num_col_array - w +1)
        
        Rj = R_j(Q_0, ith_seq, j, w);
        Pj = P_j(Q, ith_seq ,j, w);
        
        numerator = Pj/Rj;  
        A(i,j) = numerator/denominator;
    end
    
    
end

end

