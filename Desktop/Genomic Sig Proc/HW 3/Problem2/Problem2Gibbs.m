% We are given a set of n sequences. We then guess a1, .. ai, .. , an
% which is the starting position of the motif in each sequence. Since we
% are not given prior information, this is chosen randomly.

% Now we build the q(b,k) matrix and add everytime the S(i)_ai element is
% equal to b. Note: 1<=k = w where w is the length of the motif and k is
% the position after the start of the motif. This builds an initial
% probability weight matrix

% Now that we have done the initial PWM, we must remove an entire in a
% round-robin fashion and re-calculate a probability weight matrix without
% the ith sequence that has been removed. 

% now we find the probabilistic description of ai for every w-long
% word inside sequence i

% This array is one I made, it can be ignored
seq_array_test = [
    'CAGTAGTCGTCGATGATGCTGCTAGTGCTGTCAGTCGATGCTGCTAGTTACGTACGTAGATGCTGCTTAATTATTACGGGCGCTATGCTATACGTACGTATTCGCGCCAGCATACGTACGTATCGCAGTACGNNNNNNNNNNNNNN';
    'TATCCTACGTACGTATCTCCCGGATTCGGAGATATTACGTACGTATATTCGCGCAATCGCGACGCGTATTGCTGGATATACGTACGTATGCCGGATTATGCGCTAGCTAGGCGATTGCGATTTCGGANNNNNNNNNNNNNNNNNNN';
    'TACGTACGTATTATCTCTATTCTATTCTTATTCTTTATTCTTGGGTACGTACGTAGTTGGGTCGCGATATGCGATGTGCAGATTATGCGGGCGCGCGCGGCTTAGCGTCTATGCATGCCGTAGCTAGCGCTAGCTACGTACGTAGN';
    'TTCCGATACGTACGTACGTATTTCGTCGGCGCTACGTACGTAGAGTAGCGTAGGTGGGCGGGATTTGCGGATTTCTATTGCGGGGGCGGCTACGTACGTATACGTACGTATACGTACGTAGGCGTATGGTTGCTTATGCATCGTGN';
    'TTACGTACGTATCCGATTTTATGTACGTACGTAGCTTTCGCGCGCTTAGGATGTACGTACGTACGGTCTATGCGTAGCGATTAGCTAGGCTTCTCTCGATCHATTCGTCGGCGCGAGTCGTGNNNNNNNNNNNNNNNNNNNNNNNN';
    'TTCCTACGTACGTAGATTTTTACGTACGTACGTCTCGGAGTTTATATATGCGAGTGCTTACGTACGTAATGCGTTTAGCTATGGCTAGCTAGCTAGCTTTCTCTTATTCTGGCTACGTACGTAGCGAGTCGTGNNNNNNNNNNNNN';
    'TTCCTACGTACGTATACGTACGTATACGTACGTAGATTTTCGTCGGCGCGTACGTAGCTCGCTAGCTGATCTTCTCTCTCGGCGGGCTGTGAGAGAGTCTCGGTACGTAAGTCGTGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN'
];

% Here is the array for the artificial data set. I added 'N's to the
% sequence to make a padded array. THe code will look for 'N' and it is
% described in further detail in the funcitons.
s1 =  'GCACCACCGGAGGTCACCTCTACAGGTGTTAACCCCCTTTGACCGCAGTGAGCCATCCTATTCATCCCTCGAGTTGCACTCCTGGTGACTCGGCCAATACGCCATTGACAGGGGCCACCCTGAAGTGAAAATTAGGCCAGAGTTCTAACACACACCTGTAGCTGTAACTAGCTACTGTGATGCGGACCACACCAGATCCGTAGAAAGGATTCGAATTCGAAGGGAGGCTTCAGAACCCGCCATTTTTTGATCTGTCCGTGAAATTCGAATTCCCCGAGTCCTAGCCCTGGCTTCTCAGTTCTTCGCGGGGCGTTCATTGTAGTGATTAGCATTCGGCAAAAAAAGCGATGGTGCCCCGTTGAGAGTCCCTACAGCCGATTGGCCCTTTCGGGTGGAGTAGCGAGGAACCACGGCCATCATAGCTGCTCGCGAGCTCTATTTGCTCGCAGTATTTGTCGACGCAAAAGCTTGCGGTGCCGGATAGAAACTCTATTCGAATTCTCTGAATACCCAGTTCTACCGCCTAGCTACCTCTTCGCAAGCGGTAGGTTCCTACGCCCTTGTGAGCTGGTGCGACTCGTAAAAAGACTATGTTATCTATACTTATACAGAGGCAGTTCGTTCAAACCTGAGTCTCAAGACTAGCGGAACTTTGCATAAGTGTCTTGGGGCTTAAGACTGCCATAATCTCTTGCTACACAGCTTGCGTATCGCAGAGGGCGGGCAGTGGACAGCACGGAGATCTGTAATAGTTTCTATAGGACGAATCACATTCAGGGAAAGTTGCCCGAGATCCATTCGAATTCCCTGCAAGTCATTGCGTCCGTGCGAGATTCGAATTCCGACGTGATTGCTAATGTAGCGCCTATAGGGGGGAAGGCAGAAATACTTACGCGGTGTACTCGGCCTTTTGCTGTACATTAAGATCTCAGTCCTGTGACTCAGATCTCTAACTGGGTGATAGTACATAAGGCTCTGAGACGAAGCACACAGACCGTACTGCCGGGTAGTTTCCTTCGAACTTATCGCGCAGATACCATGTAACGGGCANNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN';
s2 =  'GTGTCCACATCTGTAGTACGACAATTTCAGAGCTCCCTTATGACACACTATGGATCGAGTAGTAGTATAATTCGGTGATAAAATTCGTGTCCGAACTTCGGGTAGCAACAAATATATCGTCCGGCGAGGTTTACCGATCCGGAATGGCTGTAACGGTAGGACCGCCATTCCCTTTTACATCCACCCAGGGTCTTGGTGCATGGAGTAACTTAATTCCTATCCTTGGAAACGCTCCTATCCAAGACCTATGGAGCTATTAAAAACACCCGAGACAGTACAGTATTCGAATTCAACAGCTCCCACGAATCAAGGATACTCCCGTAACGTCTCCCCCAAATGGCCTTAAGCTACTAGTGCTTTGTATTCTCGAACTGCTTGGAGGCCATGATTCGAATTCCTCACTACTGAAGTATGAGCCCCGCTGTCGATTCGCCTATGGGAAGATTCGAATTCATACGAATCTTCGTCATAAAGCTATTGAAAGGCTACGAGCACGCGTTATATATCTGTTGTGCGGTCATACTGACCTGACGAGACAAATTTGCGGCACTAGTAGTGATTCGGCTCACAACCCGCTTCGTCCGCAGTACCCGCCCACATGTATACAAGGGCTAGAGGAAAGTTTGGGATGCGGCAAGTAGCCAGGATTCCCAGGAAGTGACCCCTGAAGCAATCATTGACGCACAACTAATTCCTTCTGACGGGAGTAAGGCAGGAACTCTCGTGCCTCGTATCCATATTCGAATTCGAAATTCTCATCACACTGACGAGCACCCCTGGCCAACAACGAATATTCGTACGTTTAGCGTACTGTAATGTTCCAACTAGCACGGGTAATGCCTGTTGGCTGGAACTTTGCAAGCAAGTCTCGGGTGGAGTTTCTTTCTAGCGCAGAAATTCGAATTCGCTTCCCGAAAGCCTTCCTGGGGGAACTATTAAGTCGCTAAGGTAACAAGGTCACGAAGGGAGGCAGGCGATTGCGAGGCGGCATTCTGGACCGTACATCCTAGGGCCCTAGGATAAGGTCCGCTATGCAAGGCTGGTCACCCGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN';
s3 =  'GGCGGTAGCCCTATAGCATATGGCGTGCAGCGAGAATGACCACCGCATATAGCTTGCGTCGCATCGAAAGGCTATTTGGGGCAGCAACGAGCGCGAATTCATTTGTCAAACTGGGTTAGAGCCTCAAAAGTGACTTCTCGGTAGTGAGAGGATTCCAACATCTGGCCTTCCGTCACCTTCACGACCTTCAGAAGAAGCCTTCGCTACTAGTAGATCCGACACACTATCGAGAAGTGCTTGGAGTGAGTCAACCAATGAGACGTGCTCCTTAAAAGAAGGTCATCACTACTTTGGGACCAACTAGTACTTGTTAGCCTGTTGACCTCGGCCTCAACAAAATGAGAAGGGCGGCGGGTCGCCGGCAGTTCAACCATCACACTCGGGCGCCCCATGCTTCAGCCGACAAGATTCACTATGTGTACCGTCACCGAACCCAGCGTTCCCCCTATCAAGGAATTCGAATTCTGGCCGCTTAAGTTCGTTGTCGTAGCACGTCCTTGGGCCGGCCTCCCTGACGTAAGGGTACCACTTACTGTTCGGTCTGGAAATATAAAACGACAGTGCAGCACCCAGGCGACCTTCGAACAACGAGGAAATACAGAGGTCTTTGATAGTTAGCCTTGGAATTCGAATTCCAGTAAGTTTAAACTTGGATGGCAACCTTCCTAAAGTCCAGGTATGCTCAGAGATATATGGCTTTCGATAGCACCCCTAGGGGTGGGGGTGAATTGATGAGGGTATGCGGCACGAGTGTCCCTGTATTCGAATTCCGATGCGGTAAAAGGCCAGTTCGATCATGCCTTTAGACTATACAATCTAACTATCATCGTATAACGGTTCTTCTTCTCTCTCCTCATTGGTCCCCACTCCTGCTGCCCAAGATTGGCCATGAGCTGTAAGCTCGATAAGGAAGTACATAGCGCTGACTTTTGATAGCCTATGACACGGCAGTTACGCTCTTCTTGACTTCCACTTTGGACGGTGTAGGCGGCCGAAAACCAGCTTTATCGTACCGTTGTGTAATNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN';
s4 =  'ATTCGAATTCGTCTGGAGTATTGTGCGTCGAAAAGGCGAATGTAGTTACATACACCCAGTAACTGCAATCCACTCTTGGTTTAACCGAAAGTACCATGGGGAGGTTGCGGGCCTCACTTAGCGTTACTAGAAGGGGTACCTGACTCAATGTGCGTCAGTCACCCCCCGCCCAGTGCGGTAACTACATACGTCCTGTCTCCGGCTGAGGGAAACAATTCGAATTCGAAACGTTACGCGCATAAACCCTCTCTGCTTTATAGGGCACAAGCTACGTATTGCTACCGTGTCAAGAACAGAGCGAGATCGAGAAGCAGCTGGCTTAGAGTTCTTACCCATTCGAATTCTCACACTCGCCCAAGGATTGAAGTGACAGCTGATTGATCCTCTAATCCAGGTGAAAACAGGCATTTCGAAACTAGGGGGGTAACGAGGGTCGCGCTCACCCTTGAGTGACATGCACTGTGACTCGTATGTGAACTGCCCGAATCGCGGTTTCACATTCGAATTCGCGTGTGATGATCGGCTGTGGCAAGCGGTCCCGACTACCTTGATTCGAATTCCCTTATTCCGTCATAGTGTCGTGGTTAGAGATCGCCAGATTCGAATTCATTGCGAGCCCTATTGTGCATAAACTACAGTTCCAGGGACATTCAGATTAATTGAACATCGCTTGTGACTGCGCCCGACCACCCCTGCACTTCCATTCGGAGGCCCTTGTCGGGTGCGTATTCAAACATTCGAATTCCTGTCGCGCGTGGACGGTGTGCAAATTCGAATTCTGATGTGGGAGTATAACATCGCGGTTAAAACCGAGACCGGCCACGAGCCAACAATTCGAATTCCCGTCACTACTTATGATTGGGATACCTTGATATGGGTGAAGACGTAATTTACTCTTGTTGATCATTCCGCCTTCGCGTGCTATGTCGCCGTTTAGTGGAGGGCTTGTTGATTCTACGCGATTTAACTGACCAGCTAGAGCTCCGGACTCACTTGTTCTTGCTAGGGGTTGTTATTATATCCTTTAGTTGGTCGTGAACATGATACCCTCTCTCTAAGTGATTTTGGCGAGGGCTGACTAGTGCTTGGTN';
s5 =  'GCCCACCCTAAAATTGCCAGTTGCCTGCTTCAACCGGTCACGGGCCTGCTAGTCCGGGTTGAGTTGGCTGCAATTCGAATTCTAAGACCAGACATGGAAACACCCACCAAAAGGTGGAAAATTAAATAAACCGGATCACTGGTCCGCGTGTGAGCTAGTGAGCAAAATTGCCTCTTGAGGCGAAACCAGCTGATAAAAGCAGCCGGGTATCAGGTGTCCGATGTGGAGCGGGTATCTAGCCTCCGCCTGCAAAGGCAGAAACCGTCTTGCCGCACGCGCAAGCCCAATAGCTACATATCAATTTGAAGACAGTAATTTGGAGGGCTGGTCAAGCAGGGAGAACGTCAAAGCATCAAGGTCCTGTTGCGCGTATATAATTCGAATTCCTGCTTCCATAGAACTTAGGTCACATTCGAATTCTCAAGTGGTCACCGCAACAGCCGGGTGGTTGAATAAGGAAAGGTTTCGTGCTACTGGCGGACCTTATAACACAAAATTCGAATTCTGCACGTTCAAGCAGAATAATTGAGCTATTTCGAATGTGGCCCTCTTCGAACAGTCCACGGTATAACGACGTGGGTAGCGTATTCGAATTCAGGACCTATTTAAATGAGGCGACAGCCATGGTGGCTTATTCCACTTATTCGAATTCCCCCACTTTACATACGACCATAAAACCTAGATTGTAGCGCAAAGGTAGGGGCAGTTCCGGGCCTGCATCTCTCCTAAGAGACCCATATGGTCGTTCGAGTGACGTTAAGATTCGAATTCGTTGAGGAGCACCACGCACTGCGTACAACAGTCTTGGCTGGTGTAGTAGGGCCTATTTAACTGCTTGCAAAGATCCTCCCCGGCGTCAGCAGGGATTCGAATTCGTGCGATGTGGAGCCTAGCTACGGATGGGACGGTGTTGATAAGTAGGAACCACTGATCTCTTGAAAGGCGTGGGAACGCTATTAGTGGTGCGTGTCGCGCATTAAAGCAACGGCACATCTATTCGAATTCACGTTGGCGTACCAGTTCAGCCCATGCCAAGGTTCGCAGGCGTCAGGCACCCCATCAGGAACCCGAGAATGAATTTTGGTGAAAAN';
s6 =  'GGGGTAACAGCAGGAAGAGCAGGCTCATCACTGCTTGAGCATTGGTACCCGAGAAAGCTATATGCCGAAACTGGGCTGAATTTACTCTGTAAGAGAATAGACGCGACAAACGCTTACGGTTTTGAACCGTAATAAGATGTGGACTCTTGGTATGCGGACGCATCTGCGGGGTAACCAACAAGCAGAATACAAAAGCCAAGCACCAACCCAGGCGATGCGCGCAGAAGGAACCGGGCAAGAGCAATCAGCCTCTTGCTGGGAAGATTTGCCATATGTGCTTTGCTGCTGACCACGAGACGGCTTACGCTTCGCATTCGAATTCGAAGTCAAAGTTGCCGAGGTATTGATTCGAATTCAAACGCGAATCCTGGAGTAAGGCCGCCTGGGGCGATGATTCGAATTCTTATTCGAATTCGAGTTAAATCAGGGGTCTATCGATATATCTGCCTCTGGTGTCGAAGGTGCAAGGAGTCATTAGGCCTGCCCCACTGTAGACTGGATCCCATATTTTTAGGAGGTGTCTTTGAATTCGAATTCCACCGTTGAGCGGACCCCATCTGCGACTGGGTCGGCACAGTTTCGCTGGAACGTTTGACTGATTGCCGCGTACCTGTGCCGAAGCGGTGGAAGCTCCGAAAGCCCTACCAGGACGACTGAGTTTTGTTTCCCGACTATCTGCACTGATGCGGTCCCTTGGGCAAGCCAACATTGCTAGTCTTCTAGGCCTGGATAGCATTCGAATTCGCTGGCGGTAGAGCTGGGCCAGAAAGTGGCCAACTAGGTTCAGACACCCATCGCGCTACTCCTGGTTCCCATCGACATATAACACCCCAAGAGCATCTGTATGCTTGTGGCATATTCGAATTCTCGTAAAGGCTCCTATCCAACGGCCGTCAATAGTGTGACGACGTATTGGTCCGACCCTGGAGCCAGGACCTTCCCGGGAGCCAAGAGCTCAACAGGGATGCTCGTTTTCTAGGCTCTACGAAAGGTCTGCGTAGTATTTCACCGGACGAGGTAACCAATAGGCTGTCGAGTTTCCTATGCACTGGGGGTGGTTTTCTGGTCCCNNNNNNNNNNNNNNNNNNNNN';
s7 =  'AATCGGCATTAGTGTCCAGGTGTATGCGATCGGTGTCTATCGATGTGGCCCATGAAAGAATCCTAGACTGGGCGCTGCGAGACGCCGATGGGTTCCTATAGATAGAGAGACTAGATTCAGGGCATTGTGATTGTGCAAAGCGATCGCTGGACGAGAAGGGCAGGTCGATCCTTTAACCCGGTTAACTCCCAGATGCAAGAGTGTACGTATGCTCTTGCTGTAATACTCGTCCTAACATATTAGGCTCACGACGCAATACAAACAACCTCTCTTAGTGGCCAAGCAAATTGGCCTATCACGGATTGAAATTGGCGGTGTCGTGTGGATGTGTGTGCGTCTGACCATAGGCCGGGAGCCAGTAAACGCATTGGGGAATGGTCAAGTGCTGAGTCGTAATTAATTCGAATTCTGCAAAACGCGCGTGCATTGAAATCTGCGACTGCGAGGTCGTCTGGTTACTAATGGGGACGGGGGTATCTATTCGAATTCGCGTTCTGGGGCTCGGAATCTTATCGAGTCAATAGACCCGCTCGTCTTTGACACTAAGTTGGCCTTTTACTATTTGCGTTGACCAGGTATTTTTAAAGGATAATGTTCCGATTCGAATTCGTGACGCGTCTCCCCTTGACCCTGACTTCCAATCGAGACGTTAAGAGGCCTCAAACGTACCAGGTCTTCTGACTAATTCGAATTCAAACTCGGGGCTACCACCAAGCTCCCTAGTCCAGACGAGTCCATTCGTTTTGCACAATTACTCCGTCCTTCTGCTCGCCGAGGTGCAGCTGTGTGGTCACGTCAATTGTTCCCCACAGTGGAACTTGGCGCATTTTACCGGCGAGCCTCTCTTAATTCGAATTCCCCACATGTTAATCCGGATCCCAGGTGACTACACGTGAGGGCGTTGTCCTTGAAAGCCCTTAACAGCGTGCGAACACATAGTCCGCTCCAGTTTGCACCTTTAGTTGTCCTCTGTGGTTCTGTGTCCTGCTATGTGAGGCCACCTGCGAGCATACGGATCTAGTCGCTGTTAACCCGATCAAATTCAGCTGCNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN';
s8 =  'GGTTAGCACACACATTCCACAATAACGCTGAATCCCTCACTCCGTAGGGCAGATCTGGACGTGGGCTTAAACCAGACCGGAGGCAGGAGTCCGTCAAATCACTAGTTAATATTGAGTACAGACTCGGGATTGGCGATGCGTTCGGGCGCCATCCATTTGAATGGACTTCTTCGAGTAGTTTCCATTCCTTTCTCTACTACGCTCATTGGGTACATATCGGCCGAAACAGGAACGTCACAGGTCACTCGTGGTGCAAGTATTATGCCGATCTCCACATTTTAGGAGACCCCACTGAACAACGGATAACATCCTAAAGACCAGGCTCCGTTTTATCCGCACACGGAACGGGTAGGTATTCCTGTATTTCAGTGGCAATTCGAATTCAGAACGCGAATGCCAGGGGGATGAGAACCGTACACTCGGTAGGACCTGCGGTAGCTTAATTTCGGCTGCATTCGTCAGCGCAGCAATGCTTCCACATTAGCCCGTTAGCTGCTTAACGGAGCTAGTTACCAAGCTCCGGGGAGGCTCTAACAGGTAAAAAATCAGCTTTGTAGTGAAAGTGGGCAGTGGTTAAAGACTTCTACCTGTGAAACATATGTCGCAGGCGGCAGAACCGTATAGAAGAACATTCGAATTCCTGCACGAGGGCCGTTTCTCAGAGTATTGGCCAACCCACCCCTGTCTTGGGGCCCTTACCACGAGGGGAGTACTATTATTCGGTCAGTAACAATTATTGGAACACACTCCGCTCCGGTCACCGACTACTGTATTCGAATTCTAAGACGTGTTGAAATGGAGATTCGAATTCCCTACACTATGAACCGTGTATCATGGGAAGTCAAGGCTACTGGGATGCCCTTCGATCGAGAGACCACTGCCGACAGTCCGGGGCTGAGGTATGCCGGGTTCTACTAATTCGGGAGGTGTGGCTCATACAACATCAATTGGCGGCATCTATGGCATTTCCGTTGGGGGAGTACTCTATGGATCCCTGGTCTGCTTAGGGGAGGTTACTGGTGGCCCAGGTCAGTGTAAATNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN';
s9 =  'ATCGCAGAATCTCTGCCGCACCCCGTAGCACTCAATCGATATCAGACCATCCTTCCATACACCTCGCGTGCAGTGGCTAGTTAACTCGAGTCGGTTTTGCTGCGTAGAAAGTCGGATCTTGTGTTGGGGGATTCCTATACGCTAGATCGTTCAACTTTTCACTACAAGAATATGGCTTTCGTCAAACCAATTCGAATTCCTACTCCGTACCGTTCTTTGACGTTCACATCACTAATCAGCCCGGCAACATCGTCTTAAACGGGGTGGACGCCTTCCCTTTGGGGACGCGCCAGACGGTCTCTTAGAATTCCGTTAAGGATGACTAGCGTAGGTCGCTGCGCCCGCCGGATGGCTTCGAGGTATCGGAGTCTAGATGGGAGCGTGTCCATAAGTAGTTCGTCGTGTTACTTGGCGAAGGCGTATCGTCCTCAAGAATGTCCTCCACTCAGGTCATTTGATGATCTAGATTGACTAGGAGAGGTTTACGACACCTAGTGCCGGGCCGATCTAACTCACTTTATCGAAAGTTGTCCAACCTGACACTAAACACCTACCAATGCCGGTCAGTAGGCGTAATTCCAGAACCCCCTAGGCAGCACATCGTCAAAGGTCCCCATTCATCATGGTCGTATATCATGAGACTCTTCCGGCTATGACACCTCTAGAAGGTCAACACAATATCATCCAACCCGTTAGACTTTGGGAGTGGGACTTAAATTTAGTAGGTCGCCTACGAAGGAACTTGATACCTTCAGTTAGGAAGCCATAGTCCCATTCGAATTCCTATACGCTCTCGTTAGTCGCCGGCTATTTTGCGGCTTGGCTCGTTAGGATAATCCTGTACGGTATTTTACCTTTGTGTTAGCGTTTATCCTGCGTAACGATGCACCTTTACTCGACCGCTCTTATGGAAAACCACGGACCGTGAAAATTCTGGGCTGATAGCGACCTTTTTAAGTTGATGTCGTGTCTCGGAGCAACCTTCAGTTCTAGACCCATATAGTATGAAATCAAATATTGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN';
s10 = 'AACAGCAAGCGCCGATTAGCCATACACCTCATTTGCTGCAGGAGTCTTTTATGATCAACGACTGCTGGACGTTGAATGGTCTTAGAGCTCATAGGGCTCCGAGCTGATTCCCTCATGTCGTACTAATTTGCCCGCTGATGTTCTGATTCCGTGCAAGCATTTCTAAAAATAAGTCAGATTTTACGGGATTCGAATTCCAAGCCCTATACTGTGAGCCGGTATTTACAAGTGAAAAGCCGACAGAACTCAAAAATACAATCAGTGCCATAGATGTTTTCGGCCATCGAATCGGGGTCAGTCTCCTTCTGAAGACCCATTCGAATTCCAGCTATTTCGTACCTAAAGTCCAGAAGCTAAATAACATATAGTTCTCCTAACCGAGGCATTCGAATTCCGGACGTACGGCCAGTATACCATATCGAATTCGAATTCACTCCGGCGCAGTGCCGGAATACTTCCGTTAAGCCGAACGATAGGCCCTGTTCAAATCCAGCTCTATCTGCGCACACCTAATCACGGCCGTTCAGAGGATACCATCGAGCGAACAGGAACTCGTCTGGGAAATACAGGGAATATTTTCCCCCCCTCCGGCACACCAAAGGTACTTATGTAGTCTATCAGGCATGTTGCCGACCCCGAGTGGATTGCCACCCGAAGTTTTCCTCTGGTTGCGCGTTTTTTCCCATTTCGCTGAGGTGTATGCACTTCGCAATCCGGACCTCCCGGGACATTCGAATTCAACTGTTCCAACTAAACTTAGCTTAAATTCGAATTCTAACGACTATCCACGAGTAAAAGCTTGACCCATTCTATCCGGGTCATTCATTCGTACGCTACATATCGTGGTTCGTGATCAAAGGCCGAAATCCCCAACGATTGTCGATCAGCTCTCTTATTGTAAACTCGAACCTTCCGTTCGCGTATTATCCTAGGCCCGGAATCTCCCTTCACGCAACGGAAAGGTGGGTAATCGTAATCCGGCGAGTGCATAGGTAGCCCGTTCCACGTCAATGCCATCATAAGAGGACCTTGATTAACTCGCACACATGCCTAACGGGCGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN';
seq_array_artificial = [s1;s2;s3;s4;s5;s6;s7;s8;s9;s10];

% Data for the natual set. Same concept applied with the padded array.
ss1  = 'ATAGTCAACCCTCGGGTCACGTCCACTCGACACGCCCCTATGTTTTCGCCAGATCCAGTAAACGCCAGAATACCCAGCGAGAGCTCATCGGAGGGCTTGAAAAAACCATAGACTGTACTTCCATACGGCGGCGTCAACACTGCTGCATGCGAAATTAGATACCTATGCTTCTAGCCGTCCAATCCGGTGTAAGCGAGCAATCACAGCCTCAATAAATTCATCAAATATCCACATCCCAGCTAGATTAATACTTCTTAGTTCTTATTTGTCTACTAATCTGTCTATTATCCATGAATAGACTACTAGAAGCTGAGTTCAATGCGAGTTATGGTAATACTGGAGGAGTCAGGTGTGGCTTGCTTCGTAGTCCACATCGATTAGCTTGCAGCAGGGCATGGAGATCCTACTTCATATAACATCGTCTAGGTTGGAATCTGTCTGCTATAAAAGTTAGCGGTACNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN';
ss2  = 'GTCTGAGCTATGACTGTGAATATTCGGCTGGCCCCTTCAGATTATTTCCTTAACGCCTTAGGGCTGGCCGAGATATGAAGTGGGGCTCTTGATCGATGCCGTCACGCAGCACCACTGGTAGAAGAGGGAGCTGTCTACTAAGGACGTTTCAGTCTTTACTATTCTACAGAACTGTCTACTACCGAAAGCGTCACTCACAGTGTGCGGCTGTATGCGAAGTCTCCTTCAGCTATCGGTGTACTACTCCGGCTGCAGCGCTATTTCCGGGCACAATGATAATGAGCCACGTCAACCCTGGGGTTCTAGAATCTAATTCTGGAGACGCCTACGGGCACGAGTGTTTGATTTAGAAGTTAGAAGGGTTCAGTTCGCACGCGAGGGTTTTGTCGTTAAAGGACCCGGCGTCTCATCTTCCTTCGTACCATGAACTGCGCAACGGACGAGAGCGTACCACCGGCGGATAACAAGAACTGTTCTGTCAGTCAAGGACTCGCCATCGGTGTGGGTATAATAACTATCTGGCTCTAGGCCGCGAACCGAATTGTGGTATATTGACGCACTGAACGAATCATGTTCACGTCCTCGCATCTTAANNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN';
ss3  = 'AATACCCCCCAAGCAACTCTACCAGTAATCTCTGGGTAAACCCGTCTTCTACTATCGACAACTGATTCACAATACTAGGCTTTTAAAACTGTTTAGAAGTGAGCATGAGAAGTTTTCACACAGTAACACGATAAGTCCAGCTTTCATAGGAAGCGCGAATTTTAATATGATCGCAACGGCTCTTGTTGCCATAGTGATATTTTTCACGTATGAGAATCTAGTTGCGGTATTCGAAAGTTTACCTTCTGGACCATCCCCGTTCGTGATCATATCCTGATGCCAAGAGACCAGGCGTTATATGTATACTAAAACATGATTATCGCGATGACCCTTTCCGCCGAAGGGGACCGGTAGCTGTGACGTCACCCCATTAAAAGCTGAACTACTAAAGGATACGAGCGGACAATCGACGCCGGTACAAGCTTNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN';
ss4  = 'TTGCACAGCGTACCTCACACGTCATATCAGTGGGAGACCTGCAGTCAGTCGAAAAACTTCGCCGCTAGGGTTCACGCTCGACGCGCTAAGCTCCCCCATAAGTGCTTTCACTCCTAGAGCTCATCTCTTCCGGAATCCTAAGACATTCTCATCTGATTACTAGGAGTACCTTTCCCCCGGATGTGCCCTTAACAGGATATAATCTTTGGTATCCTTGAGTGCTTTACTGGTTGGACAAGCCCGGGCTCGGTCTACCGAGCTAAAAGTACGCATAGGCGAGCTGGGCATAGTGTAATGGTTCGCAAACCCACATACTACGACAACATTTAGTACGGGCGAAGACTTTCGGGCGACCGTCAGCGTTACTCTGACCACGACCGTGCGTCTCAACGGCGGGGGTTATATTGTATCTGTCGAATATAACATGCGAAAGACGCTTTACCTGGTCTCCCTACCCGGAATGTGACTTGTGGAAAGTGAACCATCTATCTAATATCAACTTTCCCTCCCATATAAAGCGAACTAGACTACGAAAATCGGTCGTATTTGAGGTAACGGCTTGCCTTTGAGTTTCTTTCAAGCACAAAATGCATCTATGACCCCTTGAGATCACCATAGAACAGACTTAAAGTTCAACGGGTTCCTGTCCGGTATCAAACCTATGGATAGGTCGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN';
ss5  = 'TCGGAGGGACGTATGGACGGACCCAGGGGGAGGGAATCGCCCGGAAGACATATCTCGGAAGTCTTCCTTTACCACGGATCGTACCCGTAAATAGATCATCTACGAAGTTAGCAAATACTCGGCCAAAGTTCCGGTGCGCGCTCTGAGCGCCACTATTCCCTTTACTGCAGTTACGCGGTATGTCCACAACGGAGGCTGTAGGTGCTCCTCTTAAGGAACGATAACATATTTGCGAGCTACTTTGCAGGCACTAAATGCGGCTGCTTAATAAACAAGGCGACAGCAGGATGGCCAGGCTAGGCCAAGGGGACAAACTGACCTGAATTGATTAGTAACACCTCGTGACCATGTGTCAACTAGTTCTATTTAGACTCTCGCGTGCTCGAGAGGTCTGTGAAACCTATGCGGGTTGGCATCCGCTGCTAAGCGAGGGTAAAACACGCTTAGAATAAGTCTACTACTCACTTCAGTCCTCCGAGTACACCCTCGGCTACTATTAAATGCTAGAGGTTCGACAGGTCCATTCCCTGAAATCCATTTTAAGTCTAAACTGGTGGCGCCATGGCACTTTAGCTTGTATAAATCGTAGAATTACGCGACGGAGGTCATATATATAAGGTGTCCTTAAATAATTATTGAGCGGATTTCTATAAAAATCCGTAAGAGCNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN';
ss6  = 'ACCCGCAGCTTAACGAAAGTAGCGCAAGTAGTGGCTGCTAACATCTCTTGAATTATTGCTATCTGACGCGGGTGTTTTGGTCTGCATTAGATGCCCAAAAAGCGGATCCCGACGTAATAACCCCTGCGGCGCCCAGACTGCAAGTCGCATATCTTATAGGTTACACCGTTATTGCAATCAATAGTGAACTCTGGAAAGGGCGGGGCTGTACATCAGTCTACTACTCAACTGCTAACAATTTCAGAGGGAGTATTACGTCTCTCATCAGTTTTGACTTGGAATGTCCATATCTGTGTACTACACGATGGTGATTCGTCTTATAAGCCCAAGAGATCAATAGTTCGCTGAAAAATTACGGCCCTGCAGTTTGGTTAACTCTGTACACGGATACATCGGTGTCTTCGCAAAGACTATCGTTGATGCACAAGCGTAGGTACCAATATAGACTCGGAAGAATAAGATGTGATACTGAATCGCGCCTGGGAAATAATCCACATCGATCGTGCACCCCGAGTCAGTGCAGCACCGCATCCTGCTACAGGGCCTCACTTCAATTGTTACTCACGAGGGAATAATACTCCAAGGTCCTTCAAGCTTTCGAACGTAAAAATAGTAACTAGGCAGCGAACCGCCACTGACTAGATCGCCGGGAATAAAAAATTACTAGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN';
ss7  = 'TGTGCAAGAATACCCTAGAACTCTGTTCCATGTGGATCGGGACGCATGTGTACGTTTGCTTACATCTGTCTGCTATCACTTACCGGCTATGATCAATTTGTGTAGGAAGTCAGCACCGGTCAATTCCCAGCCGCGGTTGTACAATCATTCTGTCAACAGGGGTATTCAAACTCCTGCTACCATAACTTCTCCCGCGCCCATGTCCTTCTGCCAGTTTTACAATCTGAATACTACGACGGCCGTGCCACGACTGGGGCGTAGCCTGTACATTCTACTAGACAACCATATGTCGAGCGTCAACCCGCATTCATCAAACCCAAGTCGGAGTTGAGGACAGCAGCACAGCTTTTTCCTCCGGTTGGACACACGCTTGGTCGTGTCCGATCCAGCTCTTCCGTCTACCAGTACCAATTCATTCCATTGGCCTAGACGTGGGGAAACAACCGGCTTTAATAGAAATCTCGCCTGTCGAATTCTCCCGGACACTGTACGGCGGCTTTATCTGTCAACTACAAAGGTTTGTAGCGGGGTCGGCTACCCGTAACACCGTCTTAAAACATAATTTTCGCAACTCGATGATCGGTCAACTAAGAGACACAGATGAGCTTTTGGCTCTTTGAGATATGACTCGCGCGCGCTAAGACTATAAAGCACACGGGCAGTATGCGTATCGTAAAATAGACACTGACTACCGGCAGAAAAGACTTTTATCCAGTGTCGTTAAGTCGAATTATCCTTGGCTCATTTCCCGTCGGTATTGGACTCGGGAGGCAGGGTTCTATCAACTCAACACTATGCGGGTTCN';
ss8  = 'AGGGTTTACGCCTTGGAAACTGGGTAATTTTTCTTCCTAATCAGGACTTTCCGGCAATGGCGCAGACATCGAAGGCAAGGTCATATAAGCGCTCTCGTCCGGGGTCCGCAGGAGTTACTAATGCTTCACCTCCACAATTTCCAAGCTCAGAGTCGCGACTCGATCCATGGATTCATACTTCCGTTGTTTTGAAAAGGACGTTTATAGGTACGGTCTGTGACGAAGCAAACGTGGGGCGGATCTATCTACTAAACTGAGAGCTGCTCAGCATGTCGCCCTGAGCCCTAGCTAGTTTACTACGGATTCGTATGTGGCTGGTGGATTGGGAAACACTCGTCCCAAACGAGTAGCGGCGGCCGTGAGGGTTAGGTGAATCGAGGGAAAAAGTGGTGTGATGCCTCCGAGACTGAAAGACAAAGCGAACAGTCATTTCCGTCATACGTAATCTCTTAAGAGCAAGCCNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN';
ss9  = 'CTCAAAACTGACGGACTGCAATTGCTATGGTACGCGTATCCATCTGATAATACAGGTGGATACTATGAAGAGCAACTTACTAATCTATCTTAGAATTGTATGAGACCAATGCCCCGGGAATAGATGACTCCGTATGAGATTGGAGCCGCCGTCGCACACCCCGAGTATAGCCGATAATCGAGCGTGCAGGTATTTTACGTATTGGCGAGCCGGTGTAGGATCTTCGACATGTCACGCAAGTCCTTATGAACTTCTGCCATCTGTCAACTAACAGGACTACGACCGACGTGTCTTAAGGGCCCGTAAGCTCTGTAGATGTGACCCGGCACGCTGCCGCAACACTCGCTTAACGATGCGGTAGTGGATGATGGTCCGTCAAGGCATGACCCAATGGCACTCGCCCGTACTAGCGGCCAGGCCTCGCTTGGGTTCCGGAATCGGCTTTTAGCAACACACCATCACGAAACCCACGAACCCTCATTTCCAGAATTGACTGCACAGTGCGAAGACTCAGGCACACGTCGCACGTGCACTATCGGGGATCGCTTTCTTTGAGTCCACATTTCCAGGTCTACACTGCAAGTTACATTCCTCGCCTTCATATAACAATAATGAGCATCGGTCTACTACTACCTATAAGTACTGTTAGTTCGCCTTTCCNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN';
ss10 = 'GATGCCCAATGAAACTCCGGAACTAAAATTTGTATTGTTGCAAAACCTTATGGACCTCTCCCAAACTTGCCACTTAACCAACGGACGCGACGGTCACATTTAATCGAGCAGGTGGGCGGGCTACTAGGATGTACATCAGGCGGGGTATCCGGCGCTTCATACAAGCAGAGATCCAGTGTTACCACACTTGGCCAGACTACACGAATAATCGCCTAGGAACGCGGTTATTTACAAGCAAGAACAGATGTGTTATCTGTCTCCTACGCATCAGCACGCGCCATTCTTCCCGGCCTTGACACATCGAGCAGGACTCATGCGCAAATATTTCCGTAACTCCCGTCCTCTACAGGAGCAATCCGAACGCGGGCCCTACGCGCCGAAGATGCAGAGTACCTCAGTCGCGATCTTATCTGTCTACTAGCTGCTCAGGGCGCGAGTATCCAGGGCNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN';
seq_array_natural = [ss1;ss2;ss3;ss4;ss5;ss6;ss7;ss8;ss9;ss10];

% We specify the length of the motif w to be 10
w = 10;

%Initialize the Q_0 matrix to be the background probabilities. We assume it
%is uniform and this will not be updated in the Gibbs algorithm.
Q_0 = 0.25*ones(4,1);% 1];

%IGNORE
%[A, a_mat] = A_ij(seq_array, Q_0, w);

tic
%We create the A matrix for the atrificial data set after several iterations of step 3 as outlines in
%class. Details on this convergence is specified in the program. Note, this
%is not normalized, but the relative ratios are the same.
Acon = converge_A(seq_array_artificial, Q_0, w,1000);
toc

tic
% A matrix for the natural data set. Same concept applied as above.
Acon_nat = converge_A(seq_array_natural, Q_0, w,1000);
toc

%IGNORE
%Acon = converge_A(seq_array, Q_0, w, 200);

% Now we make an array of motifs that our program consistently found. It
% will return the 3 strongest motifs for each ith sequence. We do this for
% the artificial and natural data sets
s = string_Acon(seq_array_artificial, Acon,w, 3);
s_nat = string_Acon(seq_array_natural, Acon_nat,w, 3);


%IGNORE ALL BELOW
% s1 = 
% TTCGAATTCC
% TTCGAATTCC
% TTCGAATTCC
% TTCGAATTCA
% TTCGAATTCA
% ATTCGAATTC
% ATTCGAATTC
% ATTCGAATTC
% ATTCGAATTC
% TTCGAATTCC
% TTCGAATTCC
% TTCGAATTCC
% TTCGAATTCC
% TTCGAATTCC
% TTCGAATTCT
% TTCGAATTCC
% TTCGAATTCA
% TTCGAATTCT
% TTCGAATTCA
% TTCGAATTCC
% TTCGAATTCT
% ATTCGAATTC
% ATTCGAATTC
% ATTCGAATTC
% ATTCGAATTC
% ATTCGAATTC
% TTCGAATTCC
% CGGGGTCAGT
% ATTCGAATTC
% ATTCGAATTC

%s = string_Acon(seq_array, Acon,w, 3);
    