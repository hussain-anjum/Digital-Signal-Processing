% =========================================================
% Problem 8: Quantization Error Analysis
% Computes the quantization error of a quantized sine wave,
% plots the error signal and calculates the Mean Squared
% Error (MSE), then compares it with the theoretical value.
% =========================================================

clc;
clear;
close all;

% sampled sine wave
f = 1;
fs = 1000;
n = 0:fs;
xs = sin(2*pi*f*n/fs);

% quantization (same as problem 7)
b = 3;
L = 2^b;
xmin = -1;
xmax = 1;
delta = (xmax - xmin) / (L - 1);
xq = xmin + round((xs - xmin) / delta) * delta;

% quantization error
e = xq - xs;

% mean squared error
mse = mean(e.^2);
mse2 = sum(e.^2) / length(e);     % same thing, manual formula
mse_theory = delta^2 / 12;

figure;

subplot(2,1,1);
plot(n, xs);
hold on;
stairs(n, xq, 'r');
hold off;
title('Original and Quantized Signal');
xlabel('n');
ylabel('Amplitude');
legend('Original', 'Quantized');
grid on;

subplot(2,1,2);
plot(n, e);
hold on;
yline(delta/2, 'k--');
yline(-delta/2, 'k--');
hold off;
title('Quantization Error e[n]');
xlabel('n');
ylabel('Error');
grid on;

disp(['Step size delta = ', num2str(delta)]);
disp(['Max error = ', num2str(max(abs(e)))]);
disp(['delta/2 = ', num2str(delta/2)]);
disp(['MSE (mean) = ', num2str(mse)]);
disp(['MSE (sum/N) = ', num2str(mse2)]);
disp(['Theoretical MSE (delta^2/12) = ', num2str(mse_theory)]);