function [ z ] = z_ij( Q, Q_0, seq_array)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
w = length(Q(1,:));
L = length(seq_array(1,:));
z = zeros(length(seq_array(:,1)),L);

for i = 1:length(seq_array(:,1))
    
    % calculate our denominator here b/c it does not depend on j
    
    den = denominator(Q, Q_0, seq_array(i,:), w);
    
    for j = 1:(L-w+1)
  
        num =  numerator(Q,Q_0,seq_array(i,:),j, w);
        % calculate the demonimator -> function
        
        z(i,j) = num/den;
    end
    
end
        

end

