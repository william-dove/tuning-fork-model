% EAS 230 Fall 2024
% Final Project
% Authors: William Dove, Nathan Jachlewski
% AnalyticalSolnParams.m

function [zk, Bk, phik] = AnalyticalSolnParams(L, Q, M)
% Function B

% Calculate zk as the first Q roots of f(z). 
zk = NaN(Q,1);
for k=1:Q
    zk(k) = fzero(@(z) cosh(z)*cos(z)+1, (k-0.5)*pi);
end

% Calculate Bk using equation 7b.
Bk = (zk./L);

% Calculate x.
xm = linspace(0, L, M)';

% Calculate phik using equations 7a and 7b.
phik = NaN(M,Q);
for k=1:Q
    phik(:,k) = 0.5*( (cosh(Bk(k).*xm)-cos(Bk(k).*xm)) + ((cos(Bk(k).*L)+cosh(Bk(k).*L))./(sin(Bk(k).*L)+sinh(Bk(k).*L))).*(sin(Bk(k).*xm)-sinh(Bk(k).*xm)) );
end

end