function [T0_2, eta_cs, P_c] = compressor(T0_1, T0_3, Pi, gam, pi_c, m_d)
%COMPRESSOR computes the compressor exit temperature, power and iso-s eff
%   
% Inputs:
%   T0_1        temperature 1
%   T0_1        temperature 2
%   Pi          pressure ratio
%   gam         adiabatic index
%   pi_c        compressor pressure ratio
%   m_d         mass flow rate through compressor
%
% Outputs:
%   T0_2        outlet temperature of the compressor
%   eta_cs      comrpessor isentropic efficiency
%   P_c         compressor power
%

% Computing the isentropic efficiency
eta_cs = compIsoSEff(T0_1, T0_3, Pi, gam);

% isentropic temperature
T0_2s = T0_1 * pi_c^((gam-1)/gam);

% using another definition of the isentropic efficiency
T0_2 = (T0_2s - T0_1) / eta_cs + T0_1;

% C_p
C_pc = findCp((T0_2 + T0_1)/2, 0);

% power
P_c = m_d * C_pc * (T0_2 - T0_1);

end

