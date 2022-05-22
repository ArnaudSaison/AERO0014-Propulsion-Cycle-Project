function [par, config] = config_wet()
%config_wet is a configuration file for the Cycle project
% 
% "Note that the TiT given in the statement is actually the temperature 
% right after the combustion chamber."
%     
% Inputs: -
%
% Outputs:
%   config     (struct)    configameters, including derived ones and constants
%
% Calls:
%   Data/constants.m
%   utils/processConfig.m
%

config.operation = 'wet';

% Configameters
config.Deltah_f = 42.8e6; % [J/kg] fuel lower heating value
config.Pi = 24.5; % [-] overall pressure ratio
config.m_d_a = 65; % [kg/s] total air mass flow rate
config.alpha = 0.3; % [-] bypass ratio
config.m_d_c_ratio = 0.3; % [-] turbine coolant flow rate
config.TiT = 1850; % [K] turbine inlet temperature
config.SFC_cc = 0.8; % [kg/daN.h] thrust specific fuel consumption in the combustion chamber
config.SFC_ab = 1.7; % [kg/daN.h] thrust specific fuel consumption in the afterburner
config.T = 11250; % [lbf] thrust
config.T_wet = 16860; % [lbf] thrust

% Assumptions
config.duct_tot_press_loss = 0.02; % [-] total pressure loss un secondary
config.cham_tot_press_loss = 0.03; % [-] total combustion chamber pressure loss
config.mixe_tot_press_loss = 0.03; % [-] mixing total pressure loss wrt common tot pres loss at mixer inlet (dry conditions)
config.eta_cc = 1; % [-] combustion efficiency
config.eta_ab = 1; % [-] combustion efficiency
config.eta_t = 1; % [-] turbine efficiency

% Physical constants
config = constants(config);

% Iterations parameters
config.iter.tol = 1e-7; % not used everywhere!
config.iter.max = 50; % not used everywhere!

% Processing the configuration for use in code
par = processConfig(config);

end