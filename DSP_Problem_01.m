% =========================================================
% Problem 1: Basic Signal Generation
% Generates sine, cosine, unit step, unit impulse and ramp
% signals and plots them in separate subplots.
% =========================================================

clc;          % Clear the Command Window
clear;        % Remove all variables from the Workspace
close all;    % Close all open figure windows

%% ---------- Part A: Continuous-time signals ----------
A = 1;                 % Amplitude (peak height of the wave)
f = 2;                 % Frequency in Hz (2 cycles per second)
t = 0:0.001:1;         % Time axis: 0 to 1 s with 0.001 s step

x_sin = A * sin(2*pi*f*t);   % Sine wave
x_cos = A * cos(2*pi*f*t);   % Cosine wave

%% ---------- Part B: Discrete-time signals ----------
n = -10:10;                  % Sample index from -10 to 10 (integers only)

u = double(n >= 0);          % Unit step: 1 for n >= 0, otherwise 0
d = double(n == 0);          % Unit impulse: 1 only at n = 0, otherwise 0
r = n .* (n >= 0);           % Ramp: n for n >= 0, otherwise 0

%x_dsin = sin(2*pi*0.1*n);    % Bonus: discrete sine (0.1 cycles per sample)

%% ---------- Part C: Plotting ----------
figure('Name', 'Problem 1: Basic Signal Generation');

subplot(3,2,1);
plot(t, x_sin, 'b', 'LineWidth', 1.5);
title('Sine Wave');
xlabel('Time t (s)'); ylabel('Amplitude');
grid on;

subplot(3,2,2);
plot(t, x_cos, 'r', 'LineWidth', 1.5);
title('Cosine Wave');
xlabel('Time t (s)'); ylabel('Amplitude');
grid on;

subplot(3,2,3);
stem(n, u, 'filled');
title('Unit Step u[n]');
xlabel('n'); ylabel('u[n]');
ylim([-0.2 1.2]);            % Leave some space above and below
grid on;

subplot(3,2,4);
stem(n, d, 'filled');
title('Unit Impulse \delta[n]');
xlabel('n'); ylabel('\delta[n]');
ylim([-0.2 1.2]);
grid on;

subplot(3,2,5);
stem(n, r, 'filled');
title('Ramp r[n]');
xlabel('n'); ylabel('r[n]');
grid on;

%subplot(3,2,6);
%stem(n, x_dsin, 'filled');
%title('Bonus: Discrete Sine sin(2\pi 0.1 n)');
%xlabel('n'); ylabel('Amplitude');
%grid on;

sgtitle('Problem 1: Basic Signal Generation');   % One big title for the whole figure