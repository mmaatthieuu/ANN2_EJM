function [ W ] = least_squares_RBF( X, F, centers, sigma )
%UNTITLED3 Compute the weigths for the RBF neural networks according to the
%least squares method
%   It is the batxh approach which is used here
phi = phi_compute(X, centers, sigma);
W=(phi'*phi)\phi'*F;   %compute W
end

