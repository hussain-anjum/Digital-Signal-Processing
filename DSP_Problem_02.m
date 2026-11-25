% =========================================================
% Problem 2: Signal Operations on x[n] = {1, 2, 3, 4}
% Time shifting, time reversal, amplitude scaling and
% time scaling (compression and expansion).
% Origin assumed at the first sample: x[0] = 1.
% =========================================================

clc;
clear;
close all;

% given signal x[n] = {1, 2, 3, 4}, starting from n = 0
n = 0:3;
x = [1 2 3 4];

% time shifting
n_delay = n + 2;        % x[n-2], shift right by 2
n_adv = n - 1;          % x[n+1], shift left by 1

% time reversal
n_rev = -fliplr(n);     % x[-n]
x_rev = fliplr(x);

% amplitude scaling
x_amp = 2 * x;          % 2x[n]

% time compression x[2n]
x_comp = x(1:2:end);            % keep every 2nd sample
n_comp = 0:length(x_comp)-1;

% time expansion x[n/2]
x_exp = zeros(1, 2*length(x)-1);
x_exp(1:2:end) = x;             % put zeros between samples
n_exp = 0:length(x_exp)-1;

figure;

subplot(4,2,1);
stem(n, x);
title('Original x[n]');
xlabel('n');
xlim([-5 7]);
ylim([0 9]);
grid on;

subplot(4,2,2);
stem(n_delay, x);
title('Delay x[n-2]');
xlabel('n');
xlim([-5 7]);
ylim([0 9]);
grid on;

subplot(4,2,3);
stem(n_adv, x);
title('Advance x[n+1]');
xlabel('n');
xlim([-5 7]);
ylim([0 9]);
grid on;

subplot(4,2,4);
stem(n_rev, x_rev);
title('Reversal x[-n]');
xlabel('n');
xlim([-5 7]);
ylim([0 9]);
grid on;

subplot(4,2,5);
stem(n, x_amp);
title('Amplitude Scaling 2x[n]');
xlabel('n');
xlim([-5 7]);
ylim([0 9]);
grid on;

subplot(4,2,6);
stem(n_comp, x_comp);
title('Compression x[2n]');
xlabel('n');
xlim([-5 7]);
ylim([0 9]);
grid on;

subplot(4,2,7);
stem(n_exp, x_exp);
title('Expansion x[n/2]');
xlabel('n');
xlim([-5 7]);
ylim([0 9]);
grid on;

% show results (first row = n, second row = value)
disp('Delay x[n-2]:');
disp([n_delay; x]);
disp('Advance x[n+1]:');
disp([n_adv; x]);
disp('Reversal x[-n]:');
disp([n_rev; x_rev]);
disp('Compression x[2n]:');
disp([n_comp; x_comp]);
disp('Expansion x[n/2]:');
disp([n_exp; x_exp]);