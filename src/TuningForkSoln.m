% EAS 230 Fall 2024
% Final Project
% Authors: William Dove, Nathan Jachlewski
% TuningForkSoln.m

function [xm, tn, W] = TuningForkSoln(L, E, rho, I, a, tmax, M,N, Solver)
% Function C

% Calculate x and t.
deltax = L./(M-1);
xm = linspace(0, L, M)';
deltat = tmax./(N-1);
tn = linspace(0, tmax, N);

% Determine type of solver being used
switch Solver
    case 1 % Analytical

        % Initialize variables and deflection matrix W.
        Q = 12; % Given in instructions.
        [zk, Bk, phik] = AnalyticalSolnParams(L, Q, M);
        W = zeros(M,N);
        W1 = 1e-6*(xm./L).^8; % Given by equation 5.
        ck = phik\W1;

        % Calculate columns of W one timestep at a time.
        for n=1:N
            W(:,n)=0;
            % Calculate the summation given by equation 6 from k=1:Q.
            for k=1:Q
                omegak = sqrt((E.*I)./(rho.*a)).*Bk(k).^2; % Given by equation 9.
                Wk = ck(k).*phik(:,k).*cos(omegak.*tn(n));
                W(:,n) = W(:,n)+Wk;
            end
        end
    case 2 % Numerical

        % Initialize deflection matrix W.
        W = zeros(M,N);
        W(:,1:2) = [1e-6*(xm./L).^8,1e-6*(xm./L).^8]; % Given by equation 5.

        % Build A matrix.
        % A is time independent.

        A = zeros(M);
        A(1,1) = 1;
        A(2,1:2) = [-1,1];
        A(end-1, end-2:end) = [1 -2 1];
        A(end,end-3:end) = [-1 3 -3 1];
        for m = 3:M-2
            A(m,m-2:m+2) = [1 -4 (6+(rho*a*deltax^4)/(E*I*deltat^2)) -4 1];
        end

        % Create b vector.
        for n = 2:N-1

            b = zeros(M,1);
            b(3:M-2) = (rho*a*deltax^4)/(E*I*deltat^2) * (2 * W(3:M-2,n)- W(3:M-2,n-1));
            
            % solve for Wn+1.
            W(:, n+1) = A\b;
        end
    otherwise
        W = NaN(M,N);
        fprintf('Error: Please input 1 or 2 for solver.\n')
end