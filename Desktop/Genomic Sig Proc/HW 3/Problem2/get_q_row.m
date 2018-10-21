function [ row ] = get_q_row( char )
%Assigns a row based on the input character. Row correspond to that of the
%Q or Q_0 matrix assuming it goes ACGT

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

