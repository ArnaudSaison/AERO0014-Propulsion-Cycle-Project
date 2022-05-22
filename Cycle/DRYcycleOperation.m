function [p, c, r] = DRYcycleOperation(p, c)
%cycleOperation executes the full resolution of the dry cycle
%   

% compressors ..............................
r.p0_3 = p.Pi * p.p0_1;

% combustion chamber .......................
FAR_in = 0; % fuel to air ratio in the cc
FAR_out = p.m_d_fcc / (p.m_d_p - p.m_d_c); % fuel to air ratio out of the cc

[r.T0_3, r.T0_4] = combChamber(p.TiT, p.TiT, p.T0_r, 1, p.m_d_p - p.m_d_c, p.m_d_fcc, p.eta_cc, p.Deltah_f, FAR_in, FAR_out);
r.p0_4 = r.p0_3 * (1 - p.cham_tot_press_loss);

% coolant flow mixing ......................
r.T0_4_turb = mixer(r.T0_3, r.T0_4, p.T0_r, 0, p.m_d_fcc / (p.m_d_p - p.m_d_c), p.m_d_c, p.m_d_p - p.m_d_c);
r.p0_4_turb = r.p0_4;

% compressor ...............................
r.p0_2 = p.pi_LPC * p.p0_1;

[r.T0_2, r.eta_cs, r.P_c] = compressor(p.T0_1, r.T0_3, p.Pi, p.gamma, p.pi_LPC, p.m_d_p, p.m_d_a);

% turbine ..................................
r.P_t = r.P_c / p.eta_t;
[r.T0_5, r.C_p_t] = turbine(r.T0_4_turb, p.m_d_p, p.m_d_fcc, r.P_t, p.R);

% duct .....................................
r.T0_5_duct = r.T0_2;
r.p0_5_duct = r.p0_2 * (1 - p.duct_tot_press_loss);
r.p0_5 = r.p0_5_duct;

% turbine expansion ratio and iso-s eff
r.pi_t = r.p0_4_turb/r.p0_5;
r.eta_ts = turbIsoSEff(r.pi_t, r.T0_4_turb, r.T0_5, r.C_p_t, p.R);

% mixer ....................................
r.T0_6 = mixer(r.T0_5_duct, r.T0_5, p.T0_r, 0, p.m_d_fcc / p.m_d_p, p.m_d_s, p.m_d_p + p.m_d_fcc);
r.p0_6 = r.p0_5 * (1 - p.mixe_tot_press_loss);

% dry afterburner ..........................
r.T0_7 = r.T0_6;
r.p0_7 = r.p0_6;

% nozzle ...................................
% (isentropic => same tot temp and press)
r.p0_8 = r.p0_7;
r.T0_8 = r.T0_7;

% p0_1 = p_1 since v_0 = 0
[r.A_ex, r.v_8, r.p_8, r.T_8] = convNozzle(p.p0_1, r.p0_7 , r.T0_7, p.v_0, p.m_d_a, p.m_d_fcc, p.gamma, p.R, p.iter.tol, p.iter.max);

% thrust ...................................
r.T = thrust(p.m_d_a, p.m_d_fcc, r.v_8, p.v_0, r.p_8, p.p0_1, r.A_ex);


end

