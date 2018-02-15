function [ Y ] = predict_RBF( X , W, centers, sigma )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
phi = phi_compute(X, centers, sigma);
Y = phi * W;    %results
end

