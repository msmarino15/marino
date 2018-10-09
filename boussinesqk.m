%% BOUSSINESQ WAVE NUMBER
% compute the k boussinesq wave number - Massimiliano Marino, March 2018
% -----------------------
% OUTPUT:   k = boussinesqk(h,omega)
% -----------------------
% INPUT:    h = local depth
%           omega = wave angular frequency

function k = boussinesqk(h,omega)

if nargin ~= 2
    disp('insufficient input variables');
else
    B = 1/15;                                    % parameter
    g = 9.81;                                    % gravity acceleration
    a = g*h/(omega^2)*B*(h^2);
    b = (g*h/(omega^2)-(B+1/3)*(h^2));
    c = -1;
    kk1 = sqrt((-b+sqrt(b^2-4*a*c))/(2*a));
    kk2 = -sqrt((-b+sqrt(b^2-4*a*c))/(2*a));
    kk3 = sqrt((-b-sqrt(b^2-4*a*c))/(2*a));
    kk4 = -sqrt((-b-sqrt(b^2-4*a*c))/(2*a));
    kk = horzcat(kk1,kk2,kk3,kk4);
    k = kk(real(kk)>0&imag(kk)==0);
    
    if numel(k) ~= 1
        disp('ERROR output k has more than one value')
    end
end
end