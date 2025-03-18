% EAS 230 Fall 2024
% Final Project
% Authors: William Dove, Nathan Jachlewski
% TuningForkSoln.m

% Plot Functions.

% Figure 1
% Initialize variables.
note = 'A';
oct = 4;
wdth = 5;
mtrl = 'Brass';
shape = 'Rectangle';
[freq,L,E,rho,I, a, ~] = TuningForkParams (note, oct,wdth,mtrl, shape);
tmax = 3/freq;
[~, ~, WA] = TuningForkSoln(L, E, rho, I, a, tmax, 201,501, 1);
[~, ~, WN] = TuningForkSoln(L, E, rho, I, a, tmax, 201,501, 2);
close all
deltat = tmax/(200);


figure(1)
title('Brass Rectangle A 440 Hz')
p = 1;
locationx = [50,50,110,100,100,125];
locationy = [7e-7,-3e-7,2.4e-7,0,0,0];
for i = 1:100:501
    subplot(2,3,p)
    plot(WN(:,i),'b')
    hold on
    plot(WA(:,i),'r')
    xlabel('Length of fork')
    ylabel('Deflection')
    title('Brass Rectangle A 440 Hz')
    legend('Numerical','Analytical','Location','northeastoutside')
    nmin = min(WN(:,i));
    amin = min(WA(:,i));
    mins = min([nmin,amin]);
    nmax = max(WN(:,i));
    amax = max(WA(:,i));
    maxs = max([nmax,amax]);
    axis([1,201,mins,maxs]);
    text(locationx(p),locationy(p),"t = " + num2str(deltat*i))
    p = p +1;
end

% Figure 2
figure(2)
subplot(2,1,1)
plot(WN(round(201/4),:), 'r')
hold on
plot(WN(round(201/2),:), 'g--')
hold on 
plot(WN(round(3*201/4),:), 'b-.')
hold on 
plot(WN(round(201),:), 'k.')
m1 = max(WN(round(201/4),:));
m2 = max(WN(round(201/2),:));
m3 = max(WN(round(3*201/4),:));
m4 = max(WN(round(201),:));
maxall = max([m1 m2 m3 m4]);
mi1 = min(WN(round(201/4),:));
mi2 = min(WN(round(201/2),:));
mi3 = min(WN(round(3*201/4),:));
mi4 = min(WN(round(201),:));
minall = min([mi1 mi2 mi3 mi4]);
axis([0,501,minall,maxall])
title("Brass Rectangle A 440 Hz - Numerical")
ylabel("Deflection")
xlabel("Time")
legend('L/4','L/2','3L/4', 'L','Location','northeastoutside')



subplot(2,1,2)
plot(WA(round(201/4),:), 'r')
hold on
plot(WA(round(201/2),:), 'g--')
hold on 
plot(WA(round(3*201/4),:), 'b-.')
hold on 
plot(WA(round(201),:), 'k.')
m1 = max(WA(round(201/4),:));
m2 = max(WA(round(201/2),:));
m3 = max(WA(round(3*201/4),:));
m4 = max(WA(round(201),:));
maxall = max([m1 m2 m3 m4]);
mi1 = min(WA(round(201/4),:));
mi2 = min(WA(round(201/2),:));
mi3 = min(WA(round(3*201/4),:));
mi4 = min(WA(round(201),:));
minall = min([mi1 mi2 mi3 mi4]);
axis([0,501,minall,maxall])
title("Brass Rectangle A 440 Hz - Analytical")
ylabel("Deflection")
xlabel("Time")
legend('L/4','L/2','3L/4', 'L','Location','northeastoutside')

% Figure 3
figure(3)
oct = 4;
wdth = 5/1000;
mtrl = 'Brass';
shape = 'Rectangle';
note = 'A';

[freq,L,E,rho,I, a, ~] = TuningForkParams (note, oct,wdth,mtrl, shape);
tmax = 3/freq;

[~, ~, WN_A] = TuningForkSoln(L, E, rho, I, a, tmax, 201,501, 2);

plot(WN_A(201,:), 'b', 'LineWidth',.95)
hold on

note = 'C';
[freq,L,E,rho,I, a, cost] = TuningForkParams (note, oct,wdth,mtrl, shape);
tmax = 3/freq;

[xm, tn, WN_C] = TuningForkSoln(L, E, rho, I, a, tmax, 201,501, 2);

plot(WN_C(201,:), 'r_', 'LineWidth',0.45)
hold off

Amin = min(WN_A(201,:));
Cmin = min(WN_C(201,:));
themin = min([Amin Cmin]);
Amax = max(WN_A(201,:));
Cmax = max(WN_C(201,:));
themax = max([Amax Cmax]);
axis([0,501,themin,themax])
title('Free-End Deflection: A440 and middle-C')
xlabel('Time')
ylabel('Deflection')
legend('End-Deflection of Note A', 'End-Deflection of Note C', 'Location','northeastoutside')

% Figure 4
figure(4)
note = 'G';
wdth = 5/1000;
shape = 'Circle';

% Calculate cost for each material and octave.
listofmat=["Steel","Brass","Aluminum","Nickel","Copper","Chromium"];
costmatrix = NaN(7,6);
for i = 1:7
    oct = i;
    for j = 1:6
        mtrl = listofmat(j);
        [freq,L,E,rho,I, a, cost] = TuningForkParams (note, oct,wdth,mtrl, shape);
        costmatrix(i,j) = cost;
    end
end
colors = ["r","g","b","c","m","y"];
for p = 1:6
    subplot(2,3,p)
    semilogy(costmatrix(:,p),'*',color=colors(p))
    title('Cost of '+ listofmat(p))
    xlabel("Octave number")
    ylabel("Cost")
    legend(listofmat(p),'Location','northeastoutside')
end
