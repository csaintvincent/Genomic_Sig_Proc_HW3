function [ s ] = string_Acon( seq_array, Acon,w, num_similar )
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here

num_sequences = length(seq_array(:,1));
index = 1;
for row = 1:num_sequences
    seq_interest = seq_array(row,:);
    [val, ind] = sort(Acon(row,:), 'descend');
    for i = 1:num_similar
        
        s(index,:) = seq_interest(ind(i):(ind(i) + w -1));
        index = index + 1;
    end
end



end

