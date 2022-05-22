function a = aSound(gam,R,T)
%ASOUND computes the speed of soung
%   
% Inputs:
%   gam     heat capavity ratio
%   R       perfect gas constant
%   T       temperature
%
% Output:
%   a       speed of sound
%

a = sqrt(gam * R * T);

end

