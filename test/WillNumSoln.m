% Wills numerical soln. 


xm = linspace(0, L, M);
tn = linspace(0, tmax, N);

W = zeros(M,N);
W(:,1:2) = 1e-6*(xm./L).^8;
b = zeros(M,1);

for n=3:N
    b(3:M-2) = ((rho.*a.*deltax.^4)./(E.*I.*deltat.^2)).*(2*W(3:M-2,n-1)-W(3:M-2,n-2));
    A = [1, zeros(1,7);
    -1, 1, zeros(1,6);
    1, -4, 6+((rho.*a.*deltax.^4)./(E.*I.*deltat.^2)), -4, 1, 0, 0, 0;
    0, 1, -4, 6+((rho.*a.*deltax.^4)./(E.*I.*deltat.^2)), -4, 1, 0, 0;
    0, 0, 1, -4, 6+((rho.*a.*deltax.^4)./(E.*I.*deltat.^2)), -4, 1, 0;
    0, 0, 0, 1, -4, 6+((rho.*a.*deltax.^4)./(E.*I.*deltat.^2)), -4, 1;
    zeros(1,5), 1, -2, 1;
    zeros(1,4), -1, 3, -3, 1];
    W(:,n) = A\b;
end
