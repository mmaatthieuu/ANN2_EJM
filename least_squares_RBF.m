function [ W ] = least_squares_RBF( X, F, centers, sigma )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
phi = phi_compute(X, centers, sigma);
W=(phi'*phi)\phi'*F;   %compute W
end

