function [ Y ] = predict_RBF( X , W, centers, sigma )
%UNTITLED4 Gives the output for the inputs X for a given RBF neural network
%   Detailed explanation goes here
phi = phi_compute(X, centers, sigma);
Y = phi * W;    %results
end

