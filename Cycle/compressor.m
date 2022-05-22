function [T0_2, eta_cs, P_c] = compressor(T0_1, T0_3, Pi, gam, pi_c, m_d_p, m_d_a)
%COMPRESSOR computes the compressor exit temperature, power and iso-s eff
%   
% Inputs:
%   T0_1        temperature 1
%   T0_1        temperature 2
%   Pi          pressure ratio
%   gam         adiabatic index
%   pi_c        compressor pressure ratio
%   m_d_p       primary mass flow rate
%   m_d_a       total mass flow rate
%
% Outputs:
%   T0_2        outlet temperature of the compressor
%   eta_cs      comrpessor isentropic efficiency
%   P_c         total compressors power
%

disp('............................................')
disp('<strong>COMPRESSOR</strong>')

% Computing the isentropic efficiency
eta_cs = compIsoSEff(T0_1, T0_3, Pi, gam);

% isentropic temperature
T0_2s = T0_1 * pi_c^((gam-1)/gam);

% using another definition of the isentropic efficiency
T0_2 = (T0_2s - T0_1) / eta_cs + T0_1;

% !!! 2 compressors !!!
% C_p
C_p_LPC = findCp((T0_2 + T0_1)/2, 0);
C_p_HPC = findCp((T0_3 + T0_2)/2, 0);

% power
P_LPC = m_d_a * C_p_LPC * (T0_2 - T0_1);
P_HPC = m_d_p * C_p_HPC * (T0_3 - T0_2);

P_c = P_LPC + P_HPC; % total power of the compressors

end

