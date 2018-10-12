function [ Q_estimate ] = Q_estimate( seq_array, z,w )
%This function will estimate q based on a z that we have already
%emperically calculated

% these are the possible characters that can be emitted
chars = ['A', 'C', 'G', 'T'];

% for computational efficiency, we initialize Q_estimate to be all zeros of
% the desired size
Q_estimate = zeros(length(chars), w);

% calculate the denominator for all b's
    % description inside function
    %den = q_denominator(seq_array, w, z);
    % can have it out here since it will always be the same
den = q_denominator(seq_array, w, z);

% start with the first to the k'th column (position of motif)
for k=1:w
    
    % calculate the denominator for all b's
    % description inside function
    %den = q_denominator(seq_array, w, z);
    
    % rows through all b's (character to be emitted in position)
    for b=1:length(chars)
        
        % calculate the numerator for the b'th char
        num = q_numerator(seq_array,w,z,k,chars(b));
        
        %calculate the q_k(b) = q(b,k) = num/den
        Q_estimate(b,k) = num/den;
        
      
    end
end

end

