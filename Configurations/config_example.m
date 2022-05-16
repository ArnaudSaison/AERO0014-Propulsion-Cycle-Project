%config_test is a configuration file for the Cycle project
%   
% Inputs: -
%
% Outputs:
%   par     (struct)    parameters, including derived ones and constants
%
% Calls:
%   Data/constants.m
%   utils/processConfig.m
%

% Parameters
par.Deltah_f = 42.8e6; % [J/kg] fuel lower heating value
par.Pi = 24.5; % [-] overall pressure ratio
par.m_dot_a = 65; % [kg/s] total air mass flow rate
par.alpha = 0.3:0.1:1; % [-] bypass ratio
par.m_dot_p = -1; % [?] ???
par.m_dot_c = 0.3 * par.m_dot_p; % [-] turbine coolant flow rate
par.TiT = 1850; % [K] turbine inlet temperature
par.SFC = 0.5; % [kg/daN.h] thrust specific fuel consumption
par.T = 11250; % [lbf] thrust

% Assumptions
par.as.sec_tot_press_loss = 0.02; % [-] total pressure loss un secondary
par.as.c_tot_press_loss = 0.03; % [-] total chamber pressure pressure loss
par.as.comb_eff = 1; % [-] combustion efficiency
par.as.mix_tot_press_loss = 0.03; % [-] mixing total pressure loss wrt common tot pres loss at mixe inlet (dry conditions)

% Physical constants
par = constants(par);

% Processing the configuration for use in code
par = processConfig(par);

