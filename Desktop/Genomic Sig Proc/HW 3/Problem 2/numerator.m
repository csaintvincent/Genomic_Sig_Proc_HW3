function [ numerator ] = numerator( Q, Q_0, i_th_sequence, j, w )
%This funciton will compute a product of probabilities
scale_factor = 4;
% We need the probabilities for outside the motif (before and after) as
% well as inside the motif
% we assume the motif starts at the j'th posiiton in the i'th sequence

% we will calculate the product of probabilities for every element in the
% sequence before the j'th position using Q_0
prod1 = 1;
for row = 1:(j-1)
    q0_row = get_Q0_row(i_th_sequence(row));
    prod1 = prod1 * Q_0( q0_row,1)*scale_factor;
    
end


% then we will calcualte the product of probabilities starting at the j'th
% position to the j + w - 1 posiiotn using the Q matrix

prod2 = 1;
i = 1;
for row = j:(j + w - 1)
    q_row = get_Q0_row(i_th_sequence(row));
    prod2 = prod2 * Q(q_row,i)*scale_factor;
    i = i + 1;
end    

% next, calculate the product of probabilities starting at the j + w
% position to the end using Q_0 again

prod3 = 1;
for row = (j+1):length(i_th_sequence)
    q0_row = get_Q0_row(i_th_sequence(row));
    prod3 = prod3 * Q_0( q0_row,1)*scale_factor;
end

% finally, multiply all three together for the numerator
numerator = prod1*prod2*prod3;

end

