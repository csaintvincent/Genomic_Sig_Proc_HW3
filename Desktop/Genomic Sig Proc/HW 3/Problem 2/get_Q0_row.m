function [ row ] = get_Q0_row( char )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

if char == 'A'
    row = 1;
elseif char == 'C'
    row = 2;
elseif char == 'G'
    row = 3;
elseif char == 'T'
    row = 4;
else
    error('not a valid emission')
end


end

