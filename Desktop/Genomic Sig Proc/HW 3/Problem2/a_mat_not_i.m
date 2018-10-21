function [ a_mat ] = a_mat_not_i( seq_array_not_i, w )
%We take in the sequence array which does not contain the ith sequence
% initialize a_mat to the the number of sequences excluding the ith
% sequence
a_mat = zeros(1,length(seq_array_not_i(:,1)));

% loop over all sequences
for index=1:length(seq_array_not_i(:,1))
    
    % pluck out the j'th sequence
    seq_interest = seq_array_not_i(index,:);
    
    % find the location of the first N in the sequence of interest
    n = find_n_index(seq_interest);
    
    %a_mat(index) = randi(length(seq_array_not_i(1,:)) - w + 1);
    
    % append the aj to be a random integer from 1 to the position of the N
    % - w + 1. This ensures that an aj is chosen such that it is guarenteed
    % to not extend into the N region
    a_mat(index) = randi(length(seq_interest(1:n-1)) - w + 1);
end

end

