% =========================================================
% Problem 6: Signal Reconstruction using Interpolation
% Samples a sine wave and reconstructs it with interp1
% using 'previous', 'linear' and 'spline' methods, then
% compares the results with the original signal.
% =========================================================

clc;
clear;
close all;

% original signal
f = 5;
t = 0:0.001:1;
x = sin(2*pi*f*t);

% sampling
fs = 20;
ts = 0:1/fs:1;
xs = sin(2*pi*f*ts);

% reconstruction using interp1
x1 = interp1(ts, xs, t, 'previous');
x2 = interp1(ts, xs, t, 'linear');
x3 = interp1(ts, xs, t, 'spline');

% mean squared error
mse1 = mean((x - x1).^2);
mse2 = mean((x - x2).^2);
mse3 = mean((x - x3).^2);

figure;

subplot(2,2,1);
plot(t, x);
hold on;
stem(ts, xs, 'r');
hold off;
title('Original and Samples');
xlabel('Time');
ylabel('Amplitude');
grid on;

subplot(2,2,2);
plot(t, x);
hold on;
plot(t, x1, 'r');
hold off;
title('Previous Method');
xlabel('Time');
ylabel('Amplitude');
grid on;

subplot(2,2,3);
plot(t, x);
hold on;
plot(t, x2, 'r');
hold off;
title('Linear Method');
xlabel('Time');
ylabel('Amplitude');
grid on;

subplot(2,2,4);
plot(t, x);
hold on;
plot(t, x3, 'r--');
hold off;
title('Spline Method');
xlabel('Time');
ylabel('Amplitude');
grid on;

disp(['MSE previous = ', num2str(mse1)]);
disp(['MSE linear   = ', num2str(mse2)]);
disp(['MSE spline   = ', num2str(mse3)]);