function [ R ] = R_j( Q_0, ith_sequence, j, w )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

R = 1;
for row=j:(j+w-1)
    q_row = get_q_row(ith_sequence(row));
    R = R * Q_0(q_row, 1);
end

end

