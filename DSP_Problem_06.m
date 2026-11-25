% =========================================================
% Problem 6: Signal Reconstruction using Interpolation
% Samples a sine wave and reconstructs it with interp1
% using 'previous', 'linear' and 'spline' methods, then
% compares the results with the original signal.
% =========================================================

clc;          % Clear the Command Window
clear;        % Remove all variables from the Workspace
close all;    % Close all open figures

%% Original analog signal
A = 1;                      % Amplitude
f = 5;                      % Signal frequency in Hz
T = 1;                      % Duration in seconds
t = 0:0.0001:T;             % Fine time grid (imitates an analog signal)
x = A*sin(2*pi*f*t);        % Original signal

%% Sampling
fs = 20;                    % Sampling frequency in Hz (above Nyquist rate of 10 Hz)
n  = 0:fs*T;                % Sample index: 0, 1, 2, ..., 20
ts = n/fs;                  % Sampling instants: t = n*Ts
xs = A*sin(2*pi*f*ts);      % Samples: x[n] = x(n*Ts)

%% Reconstruction with interp1
x_prev   = interp1(ts, xs, t, 'previous');   % Zero-order hold (staircase)
x_linear = interp1(ts, xs, t, 'linear');     % Straight lines between samples
x_spline = interp1(ts, xs, t, 'spline');     % Smooth cubic curve through samples

%% Reconstruction error: Mean Squared Error (MSE)
mse_prev   = mean((x - x_prev).^2);
mse_linear = mean((x - x_linear).^2);
mse_spline = mean((x - x_spline).^2);

%% Plotting
gray = [0.6 0.6 0.6];       % Color for the original signal in the background
yr   = [-1.3 1.3];          % Common amplitude range

figure('Name', 'Problem 6: Reconstruction using interp1');

subplot(2,2,1);
plot(t, x, 'b', 'LineWidth', 1.5);
hold on;
stem(ts, xs, 'r', 'MarkerFaceColor', 'r');
hold off;
title(['Original and samples (f_s = ', num2str(fs), ' Hz)']);
xlabel('Time (s)'); ylabel('Amplitude'); ylim(yr); grid on;
legend('Original', 'Samples', 'Location', 'best');

subplot(2,2,2);
plot(t, x, 'Color', gray, 'LineWidth', 2);
hold on;
plot(t, x_prev, 'm', 'LineWidth', 1.2);
stem(ts, xs, 'r', 'MarkerFaceColor', 'r');
hold off;
title(['Previous (ZOH), MSE = ', num2str(mse_prev, '%.4f')]);
xlabel('Time (s)'); ylabel('Amplitude'); ylim(yr); grid on;
legend('Original', 'Reconstructed', 'Samples', 'Location', 'best');

subplot(2,2,3);
plot(t, x, 'Color', gray, 'LineWidth', 2);
hold on;
plot(t, x_linear, 'm', 'LineWidth', 1.2);
stem(ts, xs, 'r', 'MarkerFaceColor', 'r');
hold off;
title(['Linear, MSE = ', num2str(mse_linear, '%.4f')]);
xlabel('Time (s)'); ylabel('Amplitude'); ylim(yr); grid on;

subplot(2,2,4);
plot(t, x, 'Color', gray, 'LineWidth', 2);
hold on;
plot(t, x_spline, 'm--', 'LineWidth', 1.2);
stem(ts, xs, 'r', 'MarkerFaceColor', 'r');
hold off;
title(['Spline, MSE = ', num2str(mse_spline, '%.4f')]);
xlabel('Time (s)'); ylabel('Amplitude'); ylim(yr); grid on;

sgtitle('Problem 6: Original vs Reconstructed Signal');

%% Comparison of the three methods
fprintf('Signal: %d Hz sine, sampled at %d Hz\n', f, fs);
fprintf('MSE previous (ZOH) = %.6f\n', mse_prev);
fprintf('MSE linear         = %.6f\n', mse_linear);
fprintf('MSE spline         = %.6f\n\n', mse_spline);

%% Effect of sampling frequency on reconstruction quality
fs_list = [7 12 20 50];     % 7 Hz is below Nyquist, the others are above

fprintf('fs (Hz) |  previous  |   linear   |   spline\n');
fprintf('--------+------------+------------+-----------\n');

for k = 1:length(fs_list)
    fsk = fs_list(k);                       % Current sampling frequency
    tsk = (0:fsk*T) / fsk;                  % Sampling instants
    xsk = A*sin(2*pi*f*tsk);                % Samples

    e_prev   = mean((x - interp1(tsk, xsk, t, 'previous')).^2);
    e_linear = mean((x - interp1(tsk, xsk, t, 'linear')).^2);
    e_spline = mean((x - interp1(tsk, xsk, t, 'spline')).^2);

    fprintf('%7d | %10.6f | %10.6f | %10.6f\n', fsk, e_prev, e_linear, e_spline);
end