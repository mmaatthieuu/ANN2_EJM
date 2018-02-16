function [ phi ] = phi_compute( X, centers, sigma )
%UNTITLED6 Construct the phi matrix as in the instructions
%   The phi matrix is such that phi(ii,jj) is phi_jj(x_ii)
nb_units = length(centers);   %n in the assignment
nb_obs = size(X,1);         %N in the assignment
phi= zeros(nb_obs,nb_units);
for ii = 1:nb_units
    phi(:,ii)=exp(-(X-centers(ii)).^2/(2*sigma^2));
end
end

