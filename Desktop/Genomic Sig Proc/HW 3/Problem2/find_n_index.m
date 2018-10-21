function [ n_index ] = find_n_index( ith_sequence )
%We take in the ith sequence and locate the index of the first N

% We locate the indicies of all 'N'. This is naturally sorted from first to
% last
indicies = find('N' == ith_sequence);

% The first one is all we care about
n_index = indicies(1);


end

