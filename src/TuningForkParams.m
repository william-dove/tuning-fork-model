% EAS 230 Fall 2024
% Final Project
% Authors: William Dove, Nathan Jachlewski
% TuningForkParams.m

function [freq,L,E,rho,I, a, cost] = TuningForkParams (note, oct,wdth,mtrl, shape)
% Function A

% Import the data.
data = readmatrix('materials.xlsx');
data2 = readmatrix('Piano.xlsx');

% Determine which row to read from in Piano.xlsx to determine frequency. 
switch note
    case 'C'
        notenumber = 0;
    case {'Db', 'C#'}
        notenumber = 1;
    case 'D'
        notenumber = 2;
    case {'D#', 'Eb'}
        notenumber = 3;
    case 'E'
        notenumber = 4;
    case 'F'
        notenumber = 5;
    case {'F#', 'Gb'}
        notenumber = 6;
    case 'G'
        notenumber = 7;
    case {'G#', 'Ab'}
        notenumber = 8;
    case 'A'
        notenumber = 9;
    case {'A#', 'Bb'}
        notenumber = 10;
    case 'B'
        notenumber = 11;
    otherwise
        fprintf('Error: note is invalid.\n')
        L = NaN;E = NaN;rho = NaN;I = NaN;a = NaN;cost = NaN;freq = NaN;
end

% Calculate the frequency.
freq = data2(((oct-1)*12 + notenumber+4),5); 

% Determine which material to read in data from materials.xlsx.
switch mtrl
    case 'Steel'
        matrow = 1;
    case 'Brass'
        matrow = 2;
    case 'Aluminum'
        matrow = 3;
    case 'Nickel'
        matrow = 4;
    case 'Copper'
        matrow = 5;
    case 'Chromium'
        matrow = 6;
    otherwise
        fprintf('Error: unrecognized material.\n')
        L = NaN;E = NaN;rho = NaN;I = NaN;a = NaN;cost = NaN;
end

% Calculate E, rho and cost.
E = data(matrow,2)*(10^9);
rho = data(matrow,3);
% Fix cost
costperpound = data(matrow,4);

%Determine I and a depending on the shape.
switch shape
    case 'Rectangle'
        h = wdth;
        I = (5/6)*(h^4);
        a = 2*h^2;
    case 'Circle'
        r = wdth;
        I = (1/2)*pi*r^4;
        a = pi*(r^2);
    otherwise
        fprintf('Error: Shape not recognized. Please use Rectangle or Circle.\n')
end

%Calculate L from eqaution 2. Must use algebra to rearange equation.

inside = ((1.875104^2)/(2*pi*freq))*sqrt((E*I)/(rho*a));

L = sqrt(inside);

%DV = m  --> rho*volume*converstion rate * cost per pound = cost per fork
cost = rho.*((2*a.*L) + (3/1000000)).*2.2046226218.*costperpound;

end
