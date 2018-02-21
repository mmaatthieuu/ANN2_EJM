function [phi] = phi3(x, mu, sig)
%% computes phi matrix
% x = input matrix of size n by d
% mu = centers of all RBF units, size h by d
% sig = spread of all RBF units, size h
% returns phi, a n by h matrix for the next layer
n = size(x,1);
h = size(mu, 1);
phi = zeros(n,h);
for i = 1:n
    for j = 1:h
        phi(i,j) = exp(-(x(i,:)-mu(j,:))*(x(i,:)-mu(j,:))'/(2*sig(j)^2));
    end
end