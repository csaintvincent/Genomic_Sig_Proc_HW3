function [ a_mat ] = a_mat_not_i( seq_array_not_i, w )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

for index=1:length(seq_array_not_i(:,1))
    a_mat(index) = randi(length(seq_array_not_i(1,:)) - w + 1);
end

end

