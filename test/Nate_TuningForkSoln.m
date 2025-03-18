function [xm, tn, W] = Nate_TuningForkSoln(L, E, rho, I, a, tmax, M,N, Solver)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

xm = linspace(0,L,M)



[zk, Bk, phik] = AnalyticalSolnParams(L, 12, M)

W = zeros(M,N)
W(:,1) = (10e-6)*(xm./L)^8
ck = phik\W(:,1)

for n = 2:N
    for k = 1:Q
        thesum = thesum + ck(k)*phik(m,k)*cos(w(k)*t(n))
        
        W(:,n) = thesum

    end
end


end