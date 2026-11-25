clc;
clear;
close all;

% Step 1: Define the continuous-time signal
fm = 10;                  % Signal frequency (Hz)
t = 0:0.0001:0.5;          % Continuous-time approximation
x = sin(2*pi*fm*t);        % Sinusoidal signal

% Step 2: Define different sampling frequencies
fs1 = 50;                  % Above Nyquist rate
fs2 = 20;                  % Nyquist rate
fs3 = 15;                  % Below Nyquist rate (Aliasing)

% Generate sampling time points
n1 = 0:1/fs1:0.5;
n2 = 0:1/fs2:0.5;
n3 = 0:1/fs3:0.5;

% Generate sampled signals
x1 = sin(2*pi*fm*n1);
x2 = sin(2*pi*fm*n2);
x3 = sin(2*pi*fm*n3);

% Step 3: Plot the continuous and sampled signals

figure;

% Sampling above Nyquist rate
subplot(3,1,1);
plot(t, x, 'b', 'LineWidth', 1.5);
hold on;
stem(n1, x1, 'r', 'filled');
title('Sampling Above Nyquist Rate (fs = 50 Hz)');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Continuous Signal', 'Sampled Signal');
grid on;

% Sampling at Nyquist rate
subplot(3,1,2);
plot(t, x, 'b', 'LineWidth', 1.5);
hold on;
stem(n2, x2, 'r', 'filled');
title('Sampling At Nyquist Rate (fs = 20 Hz)');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Continuous Signal', 'Sampled Signal');
grid on;

% Sampling below Nyquist rate
subplot(3,1,3);
plot(t, x, 'b', 'LineWidth', 1.5);
hold on;
stem(n3, x3, 'r', 'filled');
title('Aliasing: Sampling Below Nyquist Rate (fs = 15 Hz)');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Continuous Signal', 'Sampled Signal');
grid on;

sgtitle('Aliasing Demonstration');