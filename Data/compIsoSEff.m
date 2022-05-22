function eta_cs = compIsoSEff(T0_1, T0_2, Pi, gam)
%compIsoSEff computes the compressor isentropic efficiency
%   
% Inputs:
%   T0_1        temperature 1
%   T0_1        temperature 2
%   Pi          pressure ratio
%   gam         adiabatic index
%
% Outputs:
%   eta_cs      isentropic efficiency
%

eta_cs = (Pi^((gam-1)/gam) - 1) / (T0_2/T0_1 - 1);

end

