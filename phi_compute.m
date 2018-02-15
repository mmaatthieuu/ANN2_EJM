function [ phi ] = phi_compute( X, centers, sigma )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
nb_units = length(centers);   %n in the assignment
nb_obs = size(X,1);         %N in the assignment
phi= zeros(nb_obs,nb_units);
for ii = 1:nb_units
    phi(:,ii)=exp(-(X-centers(ii)).^2/(2*sigma^2));
end
end

