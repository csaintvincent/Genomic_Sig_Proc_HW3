function [ row ] = get_q_row( char )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

if char == 'A'
    row = 1;
    return
elseif char == 'C'
    row = 2;
    return
elseif char == 'G'
    row = 3;
elseif char == 'T'
    row = 4;
else
    row = 5;
    %error('Not a valid character')
    return
end


end

