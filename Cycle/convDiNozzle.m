function [A_ex, v_ex, p_ex, T_ex] = convDiNozzle(p_0, p0_1, T0_1, v_0, m_d_a, m_d_f, gam_init, R, tol, max_iter)
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
disp('<strong>CONVERGING DIVERGING NOZZLE</strong>')

% fuel to air ratio and total mass flow rate
FAR = m_d_f / m_d_a;
m_d_ex = m_d_f + m_d_a;

% adiabatic expansion
T0_ex = T0_1;
p0_ex = p0_1;

% flow is adapted
p_ex = p_0;

% first guess on gamma
gam = gam_init;
last_gam = 0;

% iterative process to find gamma
i = 1;
while abs(last_gam - gam) > tol && i <= max_iter
    % finding the Mach nb (not 1 anymore)
    mach_conDi =@(M_ex_var) p_ex * (1 + (gam-1)/2 * M_ex_var^2)^(gam/(gam-1)) - p0_ex;

    M_ex = fsolve(mach_conDi, 1);
    
    % deducing the static temperature
    T_ex = T0_ex / (1 + (gam - 1)/2 * M_ex); % static exit temperature
    C_p = findCp((T0_1 + T_ex)/2, FAR);
    
    % find new gamma
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

% speed of sound
a_ex = aSound(gam, R, T_ex);

% exhaust velocity
v_ex = M_ex * a_ex;

% air density at exhaust
rho = p_ex / (R * T_ex);

% outlet area
A_ex = m_d_ex / (rho * v_ex);

end

