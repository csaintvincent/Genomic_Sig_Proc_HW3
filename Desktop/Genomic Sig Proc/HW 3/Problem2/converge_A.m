function [ A ] = converge_A( seq_array, Q_0, w, iterations )
%This function will compute A for a specified number of iterations. It will
%then add up all the A's and we should notice a global maximum.

%Initialize A for computational efficiency 
A = zeros(length(seq_array(:,1)), length(seq_array(1,:)) - w + 1);


for i=1:iterations
    % R becomes the new A
    [R,n] = A_ij(seq_array, Q_0, w);
    
    % Sum all matricies. Return A after the iterations.
    A = A + R;
end




end

