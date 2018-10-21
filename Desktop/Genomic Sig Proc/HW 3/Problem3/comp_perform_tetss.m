Q = ones(1000,10000);

% tic
% for i=1:1000
%     for j=1:10000
%         sum = sum + Q(i,j);
%     end
% end
% toc

tic
acc1 = sum((Q(:)));
%acc1 = acc1(1);
toc
Q1 = Q(:,1:4)
acc2 = sum(Q1(:));