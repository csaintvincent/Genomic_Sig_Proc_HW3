function [ sum ] = sum_indicator( seq_array_not_i, a_mat_noti, c, k )

%For a specified k positions beyond the start of the motif, we check all
%the sequences (not including i) and add 1 everytime the kth position
%matched the character c.

sum = 0;
% loop over number of sequences
for j = 1:length(seq_array_not_i(:,1))
    
    % if for the jth sequence the aj + k - 1 position == c, we add 1
    if seq_array_not_i(j, a_mat_noti(j) + k - 1) == c
        sum = sum + 1;
    end
end
        
% return the sum

end

