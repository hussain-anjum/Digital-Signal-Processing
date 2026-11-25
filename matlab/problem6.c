clc;
clear;
close all;

% Step 1: Generate original continuous-time signal
fm = 5;                      % Signal frequency (Hz)
t = 0:0.001:1;                % Continuous time
x = sin(2*pi*fm*t);           % Original signal

% Step 2: Sample the signal
fs = 50;                      % Sampling frequency (Hz)
ts = 0:1/fs:1;                 % Sampling time
xs = sin(2*pi*fm*ts);          % Sampled signal

% Step 3: Reconstruct using interpolation
xr = interp1(ts, xs, t, 'linear');

% Step 4: Plot original, sampled and reconstructed signals
figure;

plot(t, x, 'b', 'LineWidth', 1.5);
hold on;

stem(ts, xs, 'r', 'filled');

plot(t, xr, 'g--', 'LineWidth', 1.5);

title('Signal Reconstruction Using Interpolation');
xlabel('Time (seconds)');
ylabel('Amplitude');

legend('Original Signal', 'Sampled Signal', 'Reconstructed Signal');

grid on;

% Step 5: Calculate reconstruction error
error = x - xr;

figure;
plot(t, error, 'm', 'LineWidth', 1.5);
title('Reconstruction Error');
xlabel('Time (seconds)');
ylabel('Error');
grid on;