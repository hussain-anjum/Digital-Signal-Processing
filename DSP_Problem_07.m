% =========================================================
% Problem 7: Uniform Quantizer
% Implements a uniform quantizer, quantizes a sine wave and
% plots the input against the quantized output.
% =========================================================

clc;
clear;
close all;

% sampled sine wave
f = 1;
fs = 100;
n = 0:fs;
xs = sin(2*pi*f*n/fs);

% quantizer settings
b = 3;                              % number of bits
L = 2^b;                            % number of levels
xmin = -1;
xmax = 1;
delta = (xmax - xmin) / (L - 1);    % step size

% uniform quantization
idx = round((xs - xmin) / delta);   % level number (0 to L-1)
xq = xmin + idx * delta;            % quantized value

% input vs output
x_in = -1:0.001:1;
y_out = xmin + round((x_in - xmin) / delta) * delta;

figure;

subplot(2,1,1);
plot(n, xs);
hold on;
stairs(n, xq, 'r');
hold off;
title('Sine Wave and Quantized Signal (3 bits)');
xlabel('n');
ylabel('Amplitude');
legend('Original', 'Quantized');
grid on;

subplot(2,1,2);
plot(x_in, x_in, 'k--');
hold on;
plot(x_in, y_out, 'r');
hold off;
title('Input vs Quantized Output');
xlabel('Input');
ylabel('Output');
grid on;

disp(['Number of levels L = ', num2str(L)]);
disp(['Step size delta = ', num2str(delta)]);
disp('First 10 samples (row 1 = original, row 2 = quantized):');
disp([xs(1:10); xq(1:10)]);
disp('Binary codes of first 10 samples:');
disp(dec2bin(idx(1:10), b));