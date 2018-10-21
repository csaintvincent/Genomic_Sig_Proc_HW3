function [ R ] = R_j( Q_0, ith_sequence, j, w )
%calculate the porrbability the character in the position of the motif is
%actually supposed to be in the background

% product starts at 1
R = 1;

% loop over all positions in the motif that starts at j
for row=j:(j+w-1)
    
    % get the row b of q_bk
    q_row = get_q_row(ith_sequence(row));
    
    % calcualte new produt based on the character being located in the
    % position in the motif shoul be in the background
    R = R * Q_0(q_row, 1);
end

end

