function T0_3 = mixer(T0_1, T0_2, T0_r, FAR_1, FAR_2, m_d_1, m_d_2)
%MIXER finds the outlet temperature of a mixer
% Uses fsolve to find the temperature at the outlet of a mixer so to take
% into account the change the different C_p
%   
% Input:
%   T0_1        temperature of flow 1
%   T0_2        temperature of flow 2
%   T0_r        reference temperature for C_p calculation
%   FAR_1       fuel to air ratio in flow 1
%   FAR_2       fuel to air ratio in flow 2
%   m_d_1       mass flow rate 1
%   m_d_2       mass flow rate 2
%
% Output:
%   T0_3        temperature after mixing
%

C_p_1 = findCp(T0_1 + T0_r, FAR_1);
C_p_2 = findCp(T0_2 + T0_r, FAR_2);

mix_eq =@(T0_3_var)  T0_r - T0_3_var + (m_d_1 * C_p_1 * (T0_1 - T0_r) + m_d_2 * C_p_2 * (T0_2 - T0_r)) ...
                     /((m_d_1 + m_d_2) * findCp(T0_3_var + T0_r, (FAR_1*m_d_1 + FAR_2*m_d_2)/(m_d_1+m_d_2)));

T0_3 = fsolve(mix_eq, (T0_1+T0_2)/2);

end

