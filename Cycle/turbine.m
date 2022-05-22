function [T0_2] = turbine(T0_1, m_d_a, m_d_f, P_t, R)
%TURBINE computes the conditions at the exit of the turbine
% uses fsolve to find solution of implicit equation
%
% Inputs:
%   T0_1        inlet temperature
%   m_d_a       air mass flow rate
%   m_d_f       fuel mass flow rate
%   P_c         power of the compressor
%   eta_f       mechanical efficiency
%   R           perfect gas constant
%
% Ouputs:
%   T0_2        outlet temperature
%   pi_t        turbine expansion ratio
%

% function
power =@(T0_2_var) (m_d_a + m_d_f) * findCp((T0_1 + T0_2_var)/2,m_d_f/m_d_a) * (T0_1 - T0_2_var) - P_t;

% finding solution for temperature
T0_2 = fsolve(power, T0_1-100);

% pressure
% C_p_t = findCp((T0_1 + T0_2)/2,m_d_f/m_d_a);
% gam = findgamma(C_p_t, R);
%pi_t = (T0_1/T0_2)^(gam/(gam-1)); %PROBLEME T0_2 DEVRAIT ETRE ISENTROPIQUE

end

