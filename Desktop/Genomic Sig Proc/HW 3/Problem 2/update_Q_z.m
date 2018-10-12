function [ Q,z ] = update_Q_z( initialQ, initialQ_0, num_updates, seq_array, motif_len )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


    z = z_ij(initialQ,initialQ_0,seq_array);
    
    for i=1:num_updates
        Q = Q_estimate(seq_array, z, motif_len);
        z = z_ij(Q,initialQ_0,seq_array);
    end

end

