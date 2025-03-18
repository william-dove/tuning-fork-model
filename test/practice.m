rho = 1;
a = 1;
deltax = 1;
E = 1;
I = 1;
deltat = 1;
M = 201;
N = 501;


W = zeros(M,N);
        %W(:,1:2) = 1e-6*(xm./L).^8;
        A = zeros(M);
        A(1,1) = 1;
        A(2,1:2) = [-1,1];
        A(end-1, end-2:end) = [1 -2 1];
        A(end,end-3:end) = [1 3 -3 1];
        for m = 3:M-2
            A(m,m-2:m+2) = [1 -4 (6+(rho*a*deltax^4)/(E*I*deltat^2)) -4 1];
        end
