% =========================================================
% Problem 1: Basic Signal Generation
% Generates sine, cosine, unit step, unit impulse and ramp
% signals and plots them in separate subplots.
% =========================================================

clc;
clear;
close all;

% continuous signals
f = 2;
t = 0:0.001:1;
x_sin = sin(2*pi*f*t);
x_cos = cos(2*pi*f*t);

% discrete signals
n = -10:10;
u = double(n >= 0);      % unit step
d = double(n == 0);      % unit impulse
r = n .* (n >= 0);       % ramp

figure;

subplot(3,2,1);
plot(t, x_sin);
title('Sine Wave');
xlabel('Time');
ylabel('Amplitude');
grid on;

subplot(3,2,2);
plot(t, x_cos);
title('Cosine Wave');
xlabel('Time');
ylabel('Amplitude');
grid on;

subplot(3,2,3);
stem(n, u);
title('Unit Step u[n]');
xlabel('n');
ylabel('u[n]');
grid on;

subplot(3,2,4);
stem(n, d);
title('Unit Impulse \delta[n]');
xlabel('n');
ylabel('\delta[n]');
grid on;

subplot(3,2,5);
stem(n, r);
title('Ramp r[n]');
xlabel('n');
ylabel('r[n]');
grid on;