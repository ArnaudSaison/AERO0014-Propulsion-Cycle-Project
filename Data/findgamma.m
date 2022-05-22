function [gamma_index] = findgamma(C_p, R)
%FINDGAMMA finds gamma
%   
% Inputs:
%   C_p             pressure cofficient
%   R               gas constant
%
% Output:
%   gamma_index     adiabatic index
%

gamma_index = C_p / (C_p - R);

end

