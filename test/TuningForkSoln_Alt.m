function [x, t, W] = TuningForkSoln_Alt(L, E, rho, I, a, tmax, M, N, Solver)
% TuningForkSoln computes the deflection of a tuning fork under dynamic loading
% L       - Length of the tuning fork (m)
% E       - Young's Modulus (Pa)
% rho     - Density of material (kg/m^3)
% I       - Moment of inertia (m^4)
% a       - Cross-sectional area (m^2)
% tmax    - Maximum time (s)
% M       - Number of spatial points
% N       - Number of time steps
% Solver  - 1 for analytical solution, 2 for numerical solution

% Define the spatial and time grids
deltax = L / (M - 1);      % Spatial step size
dt = tmax / (N - 1);   % Time step size
x = linspace(0, L, M)'; % Spatial grid (column vector)
t = linspace(0, tmax, N); % Time grid (row vector)

% Initialize the deflection matrix
W = zeros(M, N); % M x N matrix for deflection over time and space

% Switch case for solver type
switch Solver
    case 1 % Analytical Solution
        % Number of terms in the series for the analytical solution
        Q = 12; % Choose a reasonable number for the series terms
        
        % Call AnalyticalSolnParams to get eigenvalues, modes, and shape functions
        [zk, Bk, phik] = AnalyticalSolnParams(L, Q, M);
        
        % Initial condition: W(xm, t = 0)
        W_1 = (1e-6) * (x / L).^8; % Initial deflection
        
        % Calculate coefficients Ck using initial deflection and eigenmodes
        ck = phik \ W_1; % Solve for the coefficients
        
        % Calculate deflection at each time step using the summation
        for n = 1:N
            W(:, n) = 0; % Reset the deflection for the current time step
            for k = 1:Q
                % Frequency of the k-th mode
                wk = sqrt((E * I) / (rho * a)) * (Bk(k))^2;
                % Summation over modes
                W(:, n) = W(:, n) + ck(k) * phik(:, k) * cos(wk * t(n));
            end
        end
        
    case 2 % Numerical Solution
        % Initial condition: W(xm, t = 0) and W(xm, t = dt)
        W(:, 1) = (1e-6) * (x / L).^8; % t=0 deflection
        W(:, 2) = (1e-6) * (x / L).^8; % t=dt deflection (same as initial)

        % Construct matrix A for the system of equations (time-independent)
        A = zeros(M, M);
        A(1, 1) = 1; % Boundary condition at x=0
        A(2, 1:2) = [-1, 1]; % Boundary condition at x=dx
        A(M-1, M-2:M) = [1, -2, 1]; % Boundary condition at x=L-dx
        A(M, M-3:M) = [-1, 3, -3, 1]; % Boundary condition at x=L
        
        % Fill the interior nodes of matrix A
        factor = (rho * a * deltax^4) / (E * I * dt^2);
        for m = 3:M-2
            A(m, m-2:m+2) = [1, -4, 6 + factor, -4, 1]; % Interior nodes
        end

        % Time-stepping loop for the numerical solution
        for n = 2:N-1
            % Create the vector b for the current time step
            b = zeros(M, 1);
            
            % Boundary conditions
            b(1) = 0; % w1^(n+1) = 0
            b(2) = 0; % w2^(n+1) - w1^(n+1) = 0
            b(M-1) = 0; % Second-to-last node condition
            b(M) = 0; % Last node condition
            
            % Update the b vector for interior nodes using the governing equation
            for m = 3:M-2
                b(m) = factor * (2 * W(m, n) - W(m, n-1));
            end
            
            % Solve the system of equations for W(:, n+1)
            W(:, n+1) = A \ b;
        end
end

% Save the results to a file named 'Deflection.mat'
save('Deflection.mat', 'x', 't', 'W');

end
