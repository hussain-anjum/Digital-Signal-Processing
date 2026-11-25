clc;
clear;
close all;

% Original signal
x = [1 2 3 4];
n = 0:3;

% Time reversal
xr = fliplr(x);

% Even component
xe = (x + xr)/2;

% Odd component
xo = (x - xr)/2;

% Mathematical verification
x_verify = xe + xo;

% Display results
disp('Original Signal:');
disp(x);

disp('Even Component:');
disp(xe);

disp('Odd Component:');
disp(xo);

disp('Verified Signal:');
disp(x_verify);

% Plot original signal
subplot(3,1,1);
stem(n,x,'filled');
title('Original Signal x[n]');
xlabel('n');
ylabel('Amplitude');
grid on;

% Plot even component
subplot(3,1,2);
stem(n,xe,'filled');
title('Even Component xe[n]');
xlabel('n');
ylabel('Amplitude');
grid on;

% Plot odd component
subplot(3,1,3);
stem(n,xo,'filled');
title('Odd Component xo[n]');
xlabel('n');
ylabel('Amplitude');
grid on;

sgtitle('Even and Odd Signal Decomposition');