% =========================================================
% Problem 4: Sampling of an Analog Signal
% Samples a sine wave above, at, and below the Nyquist rate
% and compares the results.
% =========================================================

clc;
clear;
close all;

% analog signal
f = 5;                 % signal frequency 5 Hz
t = 0:0.001:1;
x = sin(2*pi*f*t);

% three sampling frequencies
fs1 = 50;              % above nyquist
fs2 = 10;              % at nyquist (2*f)
fs3 = 7;               % below nyquist

% sampling
t1 = 0:1/fs1:1;
x1 = sin(2*pi*f*t1);

t2 = 0:1/fs2:1;
x2 = sin(2*pi*f*t2);

t3 = 0:1/fs3:1;
x3 = sin(2*pi*f*t3);

% plot
figure;

subplot(2,2,1);
plot(t, x);
title('Analog Signal (f = 5 Hz)');
xlabel('Time');
ylabel('Amplitude');
grid on;

subplot(2,2,2);
plot(t, x);
hold on;
stem(t1, x1, 'r');
plot(t1, x1, 'k--');
hold off;
title('Above Nyquist (fs = 50 Hz)');
xlabel('Time');
ylabel('Amplitude');
grid on;

subplot(2,2,3);
plot(t, x);
hold on;
stem(t2, x2, 'r');
plot(t2, x2, 'k--');
hold off;
title('At Nyquist (fs = 10 Hz)');
xlabel('Time');
ylabel('Amplitude');
grid on;

subplot(2,2,4);
plot(t, x);
hold on;
stem(t3, x3, 'r');
plot(t3, x3, 'k--');
hold off;
title('Below Nyquist (fs = 7 Hz)');
xlabel('Time');
ylabel('Amplitude');
grid on;

disp('Nyquist rate = 2 * 5 = 10 Hz');
disp('Samples at Nyquist rate:');
disp(x2);