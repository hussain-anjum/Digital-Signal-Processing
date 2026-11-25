% =========================================================
% Problem 7: Uniform Quantizer
% Implements a uniform quantizer, quantizes a sine wave and
% plots the input against the quantized output.
% =========================================================

clc;          % Clear the Command Window
clear;        % Remove all variables from the Workspace
close all;    % Close all open figures

%% Analog signal and its samples
A  = 1;                       % Amplitude
f  = 1;                       % Signal frequency in Hz (one cycle in 1 s)
fs = 100;                     % Sampling frequency in Hz
T  = 1;                       % Duration in seconds

t  = 0:0.0001:T;              % Fine time grid (imitates an analog signal)
x  = A*sin(2*pi*f*t);         % Analog signal

n  = 0:fs*T;                  % Sample index
ts = n/fs;                    % Sampling instants
xs = A*sin(2*pi*f*ts);        % Samples x[n]

%% Quantizer settings
b    = 3;                     % Number of bits
xmin = -A;                    % Lowest value the quantizer covers
xmax =  A;                    % Highest value the quantizer covers

%% Quantize the samples
[xq, idx, delta, levels] = uniform_quantizer(xs, b, xmin, xmax);
L  = 2^b;                     % Number of levels
eq = xq - xs;                 % Quantization error (studied in Problem 8)

%% Quantizer characteristic: sweep the input from xmin to xmax
x_in  = linspace(xmin, xmax, 1000);                  % 1000 evenly spaced input values
y_out = uniform_quantizer(x_in, b, xmin, xmax);     % Corresponding quantized outputs

%% Plotting
figure('Name', 'Problem 7: Uniform Quantizer');

subplot(2,1,1);
plot(t, x, 'Color', [0.6 0.6 0.6], 'LineWidth', 1.5);   % Analog signal
hold on;
plot(ts, xs, 'b.', 'MarkerSize', 10);                   % Samples
stairs(ts, xq, 'r', 'LineWidth', 1.5);                  % Quantized signal
yline(levels, ':k');                                    % Quantization levels
hold off;
title(['Sine wave quantized with b = ', num2str(b), ' bits (L = ', num2str(L), ' levels)']);
xlabel('Time (s)'); ylabel('Amplitude'); ylim([-1.3 1.3]); grid on;
legend('Analog', 'Samples', 'Quantized', 'Location', 'best');

subplot(2,1,2);
plot(x_in, x_in, 'k--');                                % Ideal: output = input
hold on;
plot(x_in, y_out, 'r', 'LineWidth', 1.5);               % Quantizer staircase
hold off;
title('Input vs quantized output (quantizer characteristic)');
xlabel('Input amplitude'); ylabel('Quantized output');
xlim([-1.2 1.2]); ylim([-1.2 1.2]); grid on;
legend('Ideal (no quantization)', 'Uniform quantizer', 'Location', 'northwest');

sgtitle('Problem 7: Uniform Quantization of a Sine Wave');

%% Quantizer details in the Command Window
fprintf('Bits b = %d, Levels L = %d, Step size delta = %.4f\n\n', b, L, delta);

fprintf('Index | Code | Level\n');
for i = 1:L
    fprintf('%5d | %s  | %7.4f\n', i-1, dec2bin(i-1, b), levels(i));
end

fprintf('\n  n |   x[n]  | Index | Code |  xq[n]  |  Error\n');
for k = 1:10
    fprintf('%3d | %7.4f | %5d | %s  | %7.4f | %7.4f\n', ...
            n(k), xs(k), idx(k), dec2bin(idx(k), b), xq(k), eq(k));
end

%% Verification: error must never exceed delta/2
fprintf('\nMax |error| = %.4f, delta/2 = %.4f\n', max(abs(eq)), delta/2);
fprintf('Error within delta/2: %d\n', max(abs(eq)) <= delta/2 + 1e-12);

%% ---------- Local function: uniform quantizer ----------
% Must stay at the end of the script file.
function [xq, idx, delta, levels] = uniform_quantizer(x, b, xmin, xmax)
    L      = 2^b;                          % Number of levels
    delta  = (xmax - xmin) / (L - 1);      % Step size
    x      = min(max(x, xmin), xmax);      % Clip values outside [xmin, xmax]
    idx    = round((x - xmin) / delta);    % Level index from 0 to L-1
    xq     = xmin + idx * delta;           % Quantized values
    levels = xmin + (0:L-1) * delta;       % All available levels
end