function [ q ] = q_bk( seq_array_not_i, w, a_mat_noti )
%We take in the sequence of arrays that does not contain the ith sequence
%initialize for computational efficiency 
q = zeros(4,w);

% the denominator is the number of sequences
den = length(seq_array_not_i(:,1));

% loop over all positions in the motif
for k = 1:w
    % loop over all characters
    for b = 1:4
        
        % get the character corresponding to the row
        c = get_char(b);
        
        % claculate the numerstor by evaluating the inicator function for
        % the k'th position of the motif in all sequences
        num = sum_indicator(seq_array_not_i, a_mat_noti, c, k);
        
        % calculate q_bk. Note: the sum over all b's equals 1
        q(b,k) = num/den;
    end
    
end


end

