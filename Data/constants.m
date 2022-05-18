function par = constants(par)
% constants adds physical constants to the input parameters
%   
% Inputs: 
%   par     (struct)    parameters
%
% Outputs:
%   par     (struct)    parameters, with added constants
%
% Calls: -
%

par.R = 287.15; % [J/kg.K] perfect gas constant
par.gamma = 1.4; % [-] heat capacity ratio
par.T0_r = 288.15; % [K] temperature reference for C_p

end

