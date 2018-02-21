function [out] = h(icenter,imin,imax,TotalNodes)
%H Summary of this function goes here
%   Detailed explanation goes here
    
    out=zeros(1,imax-imin);
    out(1:icenter-imin)=(0:(icenter-imin))/(icenter-imin);
    out(icenter-imax:end)=abs((0:(imax-icenter))/(imax-icenter)-1);
end

