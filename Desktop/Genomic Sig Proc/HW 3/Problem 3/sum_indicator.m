function [ sum ] = sum_indicator( seq_array_not_i, a_mat_noti, c, k )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

sum = 0;
for j = 1:length(seq_array_not_i(:,1))
    if seq_array_not_i(j, a_mat_noti(j) + k - 1) == c
        sum = sum + 1;
    end
end
        


end

