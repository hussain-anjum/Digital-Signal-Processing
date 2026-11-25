clc;
clear;
close all;

% Original signal
x = [1 2 3 4];
n = 0:3;

% 1. Time Shifting (Right Shift)
n1 = 0:4;
y1 = [0 x];

% 2. Amplitude Scaling
y2 = 2*x;
n2 = n;

% 3. Time Reversal
y3 = fliplr(x);
n3 = -3:0;

% Plot Original Signal
subplot(2,2,1);
stem(n,x,'filled');
title('Original Signal');
xlabel('n');
ylabel('x[n]');
grid on;

% Plot Time Shifting
subplot(2,2,2);
stem(n1,y1,'filled');
title('Right Shift: x[n-1]');
xlabel('n');
ylabel('y[n]');
grid on;

% Plot Amplitude Scaling
subplot(2,2,3);
stem(n2,y2,'filled');
title('Amplitude Scaling: 2x[n]');
xlabel('n');
ylabel('y[n]');
grid on;

% Plot Time Reversal
subplot(2,2,4);
stem(n3,y3,'filled');
title('Time Reversal: x[-n]');
xlabel('n');
ylabel('y[n]');
grid on;

sgtitle('Discrete-Time Signal Operations');