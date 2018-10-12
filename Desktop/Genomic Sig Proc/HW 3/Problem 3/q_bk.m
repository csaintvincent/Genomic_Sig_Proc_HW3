function [ q ] = q_bk( seq_array_not_i, w, a_mat_noti )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

den = length(seq_array_not_i(:,1));

for k = 1:w
    for b = 1:4
        c = get_char(b);
        num = sum_indicator(seq_array_not_i, a_mat_noti, c, k);
        q(b,k) = num/den;
    end
end


end

