%Test 

Q = 12;
L = 10;
M = 208;
zk = NaN(Q,1);
for k=1:Q
    zk(k) = fzero(@(z) cosh(z)*cos(z)+1, (k-0.5)*pi);
end

Bk = zk./L;

deltax = L./(M-1);

xm = NaN(M,1);
for m=1:M
    xm(m) = (m-1).*deltax;
end

phik = NaN(M,Q);
for k=1:Q
    phik(:,k) = 0.5*( (cosh(Bk(k).*xm)-cos(Bk(k).*xm)) + ((cos(Bk(k).*L)+cosh(Bk(k).*L))./(sin(Bk(k).*L)+sinh(Bk(k).*L))).*(sin(Bk(k).*xm)-sinh(Bk(k).*xm)) );
end
% 
% 
% hold on
% for q=1:4
%     plot(xm,phik(:,q))
% end
