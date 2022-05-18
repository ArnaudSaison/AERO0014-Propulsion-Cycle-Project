function [res_T0_1, res_T0_2] = combChamber(T0_1, T0_2, T0_r, asmpt, m_d_a, m_d_f, eta_cc, Dh_f)%, tol, max_iter)
%combChamber finds the temperatures at the entrance and exit of 
%
% Inputs:
%   T0_1        total temperature at entrance
%   T0_2        total temperature at exit
%   T0_r        reference temperature
%   asmpt       1 if T0_1 is the assumption / 2 is T0_2 is the assumption
%   m_d_a       air mass flow rate
%   m_d_f       fuel mass flow rate
%   eta_cc      combustion chamber efficiency
%   Dh_f        fuel lower heating value
%   *tol        tolerance on iteration
%   *max_iter   maximum nb of iterations
%
% Outputs:
%   T0_1        total temperature at entrance (after iterations if 
%   T0_2        total temperature at exit
%
% Calls: findCp, fsolve
%

FAR = m_d_f / m_d_a
cc_eq =@(T0_1_var, T0_2_var)    (m_d_a * findCp((T0_1_var+T0_r)/2, FAR) * (T0_1_var-T0_r) + eta_cc * Dh_f * m_d_f) ...
                                / ((m_d_a + m_d_f) * findCp((T0_2_var+T0_r)/2, FAR))...
                                + T0_r - T0_2_var;

if asmpt == 1   % if the assumption is T0_1
    cc_eq_1 =@(x) cc_eq(x, T0_2);
    res_T0_1 = fsolve(cc_eq_1, T0_1-100);
    res_T0_2 = T0_2;
else            % if the assumption is T0_2
    cc_eq_2 =@(x) cc_eq(T0_1, x);
    res_T0_2 = fsolve(cc_eq_2, T0_2+100);
    res_T0_1 = T0_1;
end

end

