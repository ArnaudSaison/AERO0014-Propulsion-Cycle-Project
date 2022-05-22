function config = constants(config)
% constants adds constants to the input parameters
%   
% Inputs: 
%   par     (struct)    parameters
%
% Outputs:
%   par     (struct)    parameters, with added constants
%
% Calls: -
%

ISA_values = 0; % 1 if using ISA values / 0 if not
altitude = 0; % altitude for ISA values only

% physical
config.R = 287.15; % [J/kg.K] perfect gas constant
config.gamma = 1.4; % [-] heat capacity ratio
config.T0_r = 288.15; % [K] temperature reference for C_p


% exterior conditions
if ISA_values == 1

    % atmosisa toolbox
    [T, ~, P, ~] = atmosisa(altitude);

    % setting values
    config.p0_1 = P; % [Pa] atmospheric pressure
    config.T0_1 = T; % [K] atmospheric temperature

else

    config.p0_1 = 101325; % [Pa] atmospheric pressure
    config.T0_1 = 273.15 + 15; % [K] atmospheric temperature

end

config.v_0 = 0; % [m/s] velocity

end

