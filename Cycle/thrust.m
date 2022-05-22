function T = thrust(m_d_a, m_d_f, v_ex, v_0, p_ex, p_0, A_ex)
%THRUST Summary of this function goes here
%   
% Inputs:
% 
%
% Outputs:
% 
%

T = (m_d_a + m_d_f) * v_ex - m_d_a * v_0 + (p_ex - p_0) * A_ex;

end

