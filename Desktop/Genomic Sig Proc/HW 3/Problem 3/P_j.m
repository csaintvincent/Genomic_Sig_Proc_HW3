function [ P ] = P_j( Q, ith_sequence, j, w )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

P = 1;
pos = 1;
for row=j:(j+w-1)
    q_row = get_q_row(ith_sequence(row));
    P = P * Q(q_row, pos);
    pos = pos + 1;
end


end

