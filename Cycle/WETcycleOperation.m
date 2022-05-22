function [p, c, r] = WETcycleOperation(p, c, r)
%WETCYCLEOPERATION executes the full resolution of the cycle
%   

% afterburner chamber ......................
% fuel to air ratio
FAR_in = p.m_d_fcc / p.m_d_a; % in the cc
FAR_out = (p.m_d_fcc + p.m_d_fab) / p.m_d_a; % out of the cc

% temperature out
[~, r.T0_7] = combChamber(r.T0_6, r.T0_6, p.T0_r, 2, p.m_d_a + p.m_d_fcc, p.m_d_fab, p.eta_ab, p.Deltah_f, FAR_in, FAR_out);

% pressure out
r.p0_7 = r.p0_6 * (1 - p.lambda_ab);


% conv nozzle ..............................
% (isentropic => same tot temp and press)
r.p0_8 = r.p0_7;
r.T0_8 = r.T0_7;

% p0_1 = p_1 since v_0 = 0
[r.A_ex, r.v_8, r.p_8, r.T_8] = convNozzle(p.p0_1, r.p0_7, r.T0_7, p.v_0, p.m_d_a, p.m_d_fcc + p.m_d_fab, p.gamma, p.R, p.iter.tol, p.iter.max);


% conv thrust ..............................
r.T_wet = thrust(p.m_d_a, p.m_d_fcc + p.m_d_fab, r.v_8, p.v_0, r.p_8, p.p0_1, r.A_ex);


% conv di nozzle ...........................
% We use the same afterbuner outlet conditions since the losses will remain
% the same. Only the nozzle is computed again and a new thrust is found.
[r.cd.A_ex, r.cd.v_8, r.cd.p_8, r.cd.T_8] = convDiNozzle(p.p0_1, r.p0_7, r.T0_7, p.v_0, p.m_d_a, p.m_d_fcc + p.m_d_fab, p.gamma, p.R, p.iter.tol, p.iter.max);

r.cd.T_wet = thrust(p.m_d_a, p.m_d_fcc + p.m_d_fab, r.cd.v_8, p.v_0, r.cd.p_8, p.p0_1, r.cd.A_ex);

end

