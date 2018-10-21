function [ c ] = get_char( b )
%Input a row b and return the row of the probability matrix Q or Q_0
if b == 1
    c = 'A';
    return
elseif b == 2
    c = 'C';
    return
elseif b == 3
    c = 'G';
    return
elseif b == 4
    c = 'T';
    return
end

end

