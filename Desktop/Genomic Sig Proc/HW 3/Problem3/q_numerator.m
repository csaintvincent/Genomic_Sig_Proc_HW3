function [ q_numerator ] = q_numerator( seq_array, w, z, k, char )
%This function calculated the numerator which is the double sum over all
% i'th sequences and all j posiitons in each sequence

%initiaize sum
sum = 0;

%length of each sequence
L = length(seq_array(1,:));

%number of sequences
num_sequences = length(seq_array(:,1));


% sum over all sequences
for i = 1:num_sequences
    
    % we pluck out the i'th sequence
    seq_of_interest = seq_array(i,:);
    
    % sum over j from 1 to L - w + 1
    % the max j can be this because it is the starting position of the
    % motif. It cannot exceed this otherwise the motif extends beyond the
    % length of the sequence. Not possible
    for j=1:(L - w + 1)
        
        % if the j + k - 1 position of the i'th sequence is the character
        % of interest, we add the i,j index of z. Remeber, the i,j posiiton
        % of z is the probability that the j'th element in the i'th
        % sequence is the starting position of the motif. Thus, the k'th
        % position in the motif will be at j + k - 1 in the sequence.
        if seq_of_interest(j + k - 1) == char
            
            % add that guy up
            sum = sum + z(i,j);
            
        end
    end
end

% at the end, we return the q_numerator
q_numerator = sum;
end

