function [xm, tn, W] = TuningForkSoln(L, E, rho, I, a, tmax, M,N, Solver)

% Calculate x and t

deltax = L./(M-1);
xm = NaN(M,1);
for m=1:M
    xm(m) = (m-1).*deltax;
end
deltat = tmax./(N-1);
tn = NaN(N,1);
for n=1:N
    tn(n) = (n-1).*deltat;
end


% Determine type of solver being used

switch Solver
    case 1 % Analytical
        [zk, Bk, phik] = AnalyticalSolnParams(L, Q, M);
        W = zeros(M,N);
        W1= 10e-6*(xm./L).^8;
        ck = phik\W1;
        omegak = sqrt((E.*I)./(rho.*a)).*Bk.^2;
        for k=1:Q
            Wk = ck(k).*phik(:,1)*cos(omegak(k).*tn');
            W = W+Wk;
        end

    case 2 % Numerical
        W(:,1:2) = 1e-6*(xm./L).^8;
        A = zeros(M);
        A
        % Set up matrix A
        %write loop to find b and do A\b to find the next W
    otherwise
end