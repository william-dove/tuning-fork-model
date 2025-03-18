% EAS 230 Fall 2024
% Final Project
% Authors: William Dove, Nathan Jachlewski
% PrintResults.m

% Results for note A:

% Define initial conditions.
note = 'A';
wdth = 5; % mm
mtrl = 'Brass';
shape = 'Rectangle'; % cross-section shape
oct = (0:7)';

% Initialize frequency, cost and length as vectors.
freq=NaN(8,1);
cost=NaN(8,1);
L=NaN(8,1);

% Print header and table column labels. 
fprintf('%s %s h=%imm\n', mtrl, shape, wdth)
fprintf('Note   Octave  Freq [Hz]   Length [in]    Cost [$]\n')

% Calculate values for different octaves and display results.

for n=1:8
    [freq(n),L(n),~,~,~,~,cost(n)] = TuningForkParams (note, oct(n),wdth/1000,mtrl, shape);
    fprintf('%-6s %6i %10.1f %12.2f %12.4f\n', note, oct(n), freq(n), L(n), cost(n));
end

% Save data
ProductA = [oct, freq, L, cost];
writematrix(ProductA, 'ProductA.dat')

% Results for note C: 

% Define initial conditions.
note = 'C';
wdth = 5; % mm
mtrl = 'Brass';
shape = 'Rectangle'; % cross-section shape
oct = (1:8)';

% Initialize frequency, cost and length as vectors.
freq=NaN(8,1);
cost=NaN(8,1);
L=NaN(8,1);

% Print header and table column labels. 
fprintf('%s %s h=%imm\n', mtrl, shape, wdth)
fprintf('Note   Octave  Freq [Hz]   Length [in]    Cost [$]\n')

% Calculate values for different octaves and display results.

for n=1:8
    [freq(n),L(n),~,~,~,~,cost(n)] = TuningForkParams (note, oct(n),wdth/1000,mtrl, shape);
    fprintf('%-6s %6i %10.1f %12.2f %12.4f\n', note, oct(n), freq(n), L(n), cost(n));
end

% Save data
ProductC = [oct, freq, L, cost];
writematrix(ProductC, 'ProductC.dat')
