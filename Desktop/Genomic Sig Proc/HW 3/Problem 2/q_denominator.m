function [ q_denominator ] = q_denominator( seq_array, w, z )
%This function will calculate the denominator, which is the sum over all
%characters for the double sum over i and j

% initialize sum
sum = 0;

% length of each sequence
L = length(seq_array(1,:));

% number of sequences
num_sequences = length(seq_array(:,1));

% sum over number of sequences
for i = 1:num_sequences
    
    % sum over j from 1 to L - w + 1. z_ij is the probability that the i'th
    % sequence has the motiff start at posiiton j. Now, no matter what k we
    % choose, the denominator will be the same. This is because for each k,
    % we will check if it is a A,C,G, or T. Since it has to be one of
    % those, we will add z_ij anyway, independent of the k used.
    for j=1:(L - w + 1)
        sum = sum + z(i,j);
    end
    
end


q_denominator = sum;
end

