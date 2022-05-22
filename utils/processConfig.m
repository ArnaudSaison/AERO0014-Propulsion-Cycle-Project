function par = processConfig(c, conv)
%processConfig processes the configuration file to derive important
%parameters and convert every input to SI units
%   
% Inputs:
%   par     (struct)  	parameters generated by a configuration file
%   *conv   (bool)      0 = one (default) / 
%
% Outputs:
%   par     (struct)  	parameters in SI units and additional derivations
% 
% Usage:
%   run a config fle based on the 'config_example.m' model
%   the user may define here derived parameters
%   
%
%   example:
%       to recompute SI units SFC after change
%       >> config = config_example();
%       ...
%       >> config.SFC = 0.7;
%       >> par.processConfig(config);
%
% Calls: -
%

% ('c' for 'config', 'conv' for 'unit converion')

% Optional argument
if nargin == 1
    conv = 1;
end

% copying all parameters
par = c;

% Unit conversions
if conv == 1
    par.SFC_cc = c.SFC_cc / 3600 / 10; % h -> s and daN -> N
    par.SFC_ab = c.SFC_ab / 3600 / 10; % h -> s and daN -> N
    par.T = c.T * 4.44822; % lbf -> N
end

% New derived parameters
par.m_d_fcc = par.SFC_cc * par.T;% * (1 + par.alpha); % [kg/s] fuel mass flow rate in the combustion chamber
par.m_d_fab = par.SFC_ab * par.T; % [kg/s] fuel mass flow rate in the afterburner
par.m_d_p = par.m_d_a / (1 + par.alpha); % [kg/s] primary flow rate (trhough the HPC) 
par.m_d_s = par.alpha * par.m_d_p; % [kg/s] secondary mass flow rate
par.m_d_c = par.m_d_c_ratio * par.m_d_p; % [kg/s] coolant mass flow rate

end

