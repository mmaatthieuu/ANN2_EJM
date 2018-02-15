function [ W ] = delta_rule_RBF( X, F, centers, sigma, nb_epochs, eta )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
phi = phi_compute(X, centers, sigma);
nb_units = length(centers);
nb_obs = length(X);
W = normrnd(0.0,1.0,nb_units,1);   %initialization

for ii = 1:nb_epochs
    data=[X F phi];
    data=data(randperm(size(data,1)),:);   %randomly shuffle the data
    X=data(:,1);
    F = data(:, 2);
    phi = data(:, 3:end);
    for kk =1:nb_obs
        delta_W = eta * (F(kk) - phi(kk,:)*W) * phi(kk,:)';
        W = W + delta_W;
    end
    error(ii) = mean(abs(F - phi*W));
end
end

