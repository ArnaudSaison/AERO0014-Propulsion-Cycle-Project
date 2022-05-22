function [A_ex, v_ex, p_ex, T_ex] = convNozzle(p_0, p0_1, T0_1, v_0, m_d_a, m_d_f, gam_init, R, tol, max_iter)
%NOZZLE computes the convergent nozzle parameters so that it is chocked
%   
% Inputs:
%   p_0         outside pressure
%   p0_1        inlet tot pressure
%   T0_1        inlet tot temperature
%   v_0         velocity
%   m_d_a       air mass flow rate
%   m_d_f       fuel mass flow rate
%   gam_init    first guess on gamma
%   R           perfect gas constant
%   tol         tolerance on iterations to find gamma
%   max_iter    maximum number of iterations to find gamma
%
% Outputs:
%   A_ex        nozzle exhaust area (so that it is chocked)
%

disp('............................................')
disp('<strong>CONVERGING NOZZLE</strong>')

% fuel to air ratio
FAR = m_d_f / m_d_a;

% adiabatic expansion
T0_ex = T0_1;
p0_ex = p0_1;

% first guess on gamma
gam = gam_init;
last_gam = 0;

% iterative process to find gamma
i = 1;
while abs(last_gam - gam) > tol && i <= max_iter
    M = 1; % critical => M = 1 by definition since this is what we are looking for
    
    T_ex = T0_ex / (1 + (gam - 1)/2 * M); % static exit temperature
    C_p = findCp((T0_1 + T_ex)/2, FAR);
    
    last_gam = gam;
    gam = findgamma(C_p, R);

    i = i + 1;
end

if abs(last_gam - gam) > tol
    warning('Could not find gamma for the nozzle!');
else
    disp(['Found gamma for the nozzle after ', num2str(i-1), ' iterations.']);
end

clear i last_gam;

% critical pressure ratio
pi_crit = (1 + (gam - 1)/2 * M)^(gam/(gam-1));

% checking if it is chocked
pi_ratio = p0_ex/p_0;

if pi_ratio < pi_crit
    warning('Nozzle not chocked.');
end

% area of the chocked nozzle
m_d_ex = m_d_a + m_d_f; % exhaust mass flow rate

v_ex = aSound(gam, R, T_ex); % since M = 1 => a = v

p_ex =  p0_ex / (1 + (gam - 1)/2 * M)^(gam/(gam-1)); % static pressure
rho = p_ex / (R * T_ex); % air density at exhaust

A_ex = m_d_ex / (rho * v_ex);

end

