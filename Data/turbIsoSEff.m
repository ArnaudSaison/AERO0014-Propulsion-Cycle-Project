function eta_ts = turbIsoSEff(pi_t, T0_1, T0_2, C_p, R)
%TURBISOSEFF computes the turbine isentropic efficiency
%   
% Inputs:
%   pi_t        turbine expansion ratio
%   T0_1        turbine inlet temperature
%   T0_2        turbine outlet temperature
%   C_p         turbine heat capacity
%   R           perfect gas constant
%   
% Outputs:
%   eta_ts      turbine isentropic efficiency
%

% finding the adiabatic index for the turbine
gam = findgamma(C_p, R);

% efficiency
eta_ts = (1 - T0_2/T0_1) / (1 - pi_t^(-(gam-1)/gam));

end

