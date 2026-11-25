% =========================================================
% Problem 8: Quantization Error Analysis
% Computes the quantization error of a quantized sine wave,
% plots the error signal and calculates the Mean Squared
% Error (MSE), then compares it with the theoretical value.
% =========================================================

clc;          % Clear the Command Window
clear;        % Remove all variables from the Workspace
close all;    % Close all open figures

%% Signal and samples
A  = 1;                       % Amplitude
f  = 1;                       % Signal frequency in Hz
fs = 1000;                    % Sampling frequency in Hz (many samples for good statistics)
T  = 1;                       % Duration in seconds

n  = 0:fs*T;                  % Sample index
ts = n/fs;                    % Sampling instants
xs = A*sin(2*pi*f*ts);        % Samples x[n]
N  = length(xs);              % Number of samples

%% Quantization (same quantizer as Problem 7)
b    = 3;                     % Number of bits
xmin = -A;                    % Lowest quantizer value
xmax =  A;                    % Highest quantizer value
[xq, ~, delta] = uniform_quantizer(xs, b, xmin, xmax);   % ~ skips the 2nd output

%% 1. Quantization error
eq = xq - xs;                 % e[n] = xq[n] - x[n]

%% 2. MSE computed in three equivalent ways
% (a) Manual loop, the same way as in C/C++
total = 0;
for k = 1:N
    total = total + eq(k)^2;  % Add the square of each error
end
mse_loop = total / N;

% (b) Vector formula: sum of squares divided by N
mse_sum = sum(eq.^2) / N;

% (c) Built-in mean of the squared error
mse_mean = mean(eq.^2);

%% 3. Other error measures
rmse       = sqrt(mse_mean);      % Root mean squared error (same unit as the signal)
mse_theory = delta^2 / 12;        % Theoretical MSE assuming uniform error
max_err    = max(abs(eq));        % Largest error magnitude
mean_err   = mean(eq);            % Average error (should be close to 0)

%% Error as a function of the input (error characteristic)
x_in = linspace(xmin, xmax, 2000);                          % Input sweep
e_in = uniform_quantizer(x_in, b, xmin, xmax) - x_in;       % Error for each input

%% Plotting
figure('Name', 'Problem 8: Quantization Error Analysis');

subplot(2,2,1);
plot(ts, xs, 'b', 'LineWidth', 1.2);
hold on;
stairs(ts, xq, 'r', 'LineWidth', 1.2);
hold off;
title(['Original vs quantized (b = ', num2str(b), ' bits)']);
xlabel('Time (s)'); ylabel('Amplitude'); ylim([-1.3 1.3]); grid on;
legend('Original x[n]', 'Quantized x_q[n]', 'Location', 'best');

subplot(2,2,2);
plot(ts, eq, 'm');
hold on;
yline( delta/2, 'k--', 'LineWidth', 1.2);   % Upper bound +delta/2
yline(-delta/2, 'k--', 'LineWidth', 1.2);   % Lower bound -delta/2
hold off;
title('Error signal e[n] = x_q[n] - x[n]');
xlabel('Time (s)'); ylabel('Error'); ylim([-0.2 0.2]); grid on;

subplot(2,2,3);
plot(x_in, e_in, 'm', 'LineWidth', 1.2);
hold on;
yline( delta/2, 'k--', 'LineWidth', 1.2);
yline(-delta/2, 'k--', 'LineWidth', 1.2);
hold off;
title('Error vs input amplitude');
xlabel('Input x'); ylabel('Error'); ylim([-0.2 0.2]); grid on;

subplot(2,2,4);
histogram(eq, 10);                           % How often each error value occurs
hold on;
yline(N/10, 'r--', 'LineWidth', 1.5);        % Height if the error were perfectly uniform
hold off;
title('Histogram of the error');
xlabel('Error value'); ylabel('Count'); grid on;
legend('Measured', 'Ideal uniform', 'Location', 'south');

sgtitle(['Problem 8: Quantization Error Analysis (\Delta = ', num2str(delta, '%.4f'), ')']);

%% Results in the Command Window
fprintf('Bits b = %d, Levels L = %d, Step size delta = %.4f\n', b, 2^b, delta);
fprintf('Number of samples N = %d\n\n', N);

fprintf('Max |error|       = %.4f   (limit delta/2 = %.4f)\n', max_err, delta/2);
fprintf('Mean error        = %.5f  (should be close to 0)\n\n', mean_err);

fprintf('MSE (loop)        = %.6f\n', mse_loop);
fprintf('MSE (sum / N)     = %.6f\n', mse_sum);
fprintf('MSE (mean)        = %.6f\n', mse_mean);
fprintf('MSE (theory)      = %.6f   (delta^2 / 12)\n', mse_theory);
fprintf('Measured / theory = %.3f\n', mse_mean / mse_theory);
fprintf('RMSE              = %.4f\n\n', rmse);

fprintf('Error within delta/2: %d\n', max_err <= delta/2 + 1e-12);

%% ---------- Local function: uniform quantizer (same as Problem 7) ----------
% Must stay at the end of the script file.
function [xq, idx, delta, levels] = uniform_quantizer(x, b, xmin, xmax)
    L      = 2^b;                          % Number of levels
    delta  = (xmax - xmin) / (L - 1);      % Step size
    x      = min(max(x, xmin), xmax);      % Clip values outside [xmin, xmax]
    idx    = round((x - xmin) / delta);    % Level index from 0 to L-1
    xq     = xmin + idx * delta;           % Quantized values
    levels = xmin + (0:L-1) * delta;       % All available levels
end