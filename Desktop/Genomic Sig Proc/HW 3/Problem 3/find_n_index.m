function [ n_index ] = find_n_index( ith_sequence )
%UNTITLED16 Summary of this function goes here
%   Detailed explanation goes here

indicies = find('N' == ith_sequence);
n_index = indicies(1);


end

