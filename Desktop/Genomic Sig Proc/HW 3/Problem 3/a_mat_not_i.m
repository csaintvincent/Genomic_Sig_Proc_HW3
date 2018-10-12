function [ a_mat ] = a_mat_not_i( seq_array_not_i, w )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
a_mat = zeros(1,length(seq_array_not_i(:,1)));

for index=1:length(seq_array_not_i(:,1))
    
    % added below
    seq_interest = seq_array_not_i(index,:);
    n = find_n_index(seq_interest);
    
    %a_mat(index) = randi(length(seq_array_not_i(1,:)) - w + 1);
    a_mat(index) = randi(length(seq_interest(1:n-1)) - w + 1);
end

end

