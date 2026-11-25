% =========================================================
% Problem 5: Aliasing Demonstration
% Part A: one sinusoid sampled at different frequencies,
%         with the alias sinusoid drawn through the samples.
% Part B: two different sinusoids that give identical samples.
% =========================================================

clc;
clear;
close all;

% 5 Hz analog signal
f = 5;
t = 0:0.001:1;
x = cos(2*pi*f*t);

% case 1: fs = 50 Hz (above nyquist, no aliasing)
fs1 = 50;
t1 = 0:1/fs1:1;
x1 = cos(2*pi*f*t1);

% case 2: fs = 8 Hz (below nyquist, aliasing)
fs2 = 8;
t2 = 0:1/fs2:1;
x2 = cos(2*pi*f*t2);

f_alias = abs(f - fs2*round(f/fs2));   % 5 Hz looks like 3 Hz
x_alias = cos(2*pi*f_alias*t);

% case 3: 1 Hz and 9 Hz sampled at 10 Hz
fs3 = 10;
t3 = 0:1/fs3:1;
y1 = cos(2*pi*1*t);        % 1 Hz signal
y9 = cos(2*pi*9*t);        % 9 Hz signal
s1 = cos(2*pi*1*t3);       % samples of 1 Hz
s9 = cos(2*pi*9*t3);       % samples of 9 Hz

figure;

subplot(3,1,1);
plot(t, x);
hold on;
stem(t1, x1, 'r');
hold off;
title('5 Hz sampled at 50 Hz (no aliasing)');
xlabel('Time');
ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(t, x);
hold on;
plot(t, x_alias, 'g--');
stem(t2, x2, 'r');
hold off;
title('5 Hz sampled at 8 Hz looks like 3 Hz (aliasing)');
xlabel('Time');
ylabel('Amplitude');
legend('5 Hz signal', '3 Hz alias', 'samples');
grid on;

subplot(3,1,3);
plot(t, y9);
hold on;
plot(t, y1, 'g', 'LineWidth', 2);
stem(t3, s9, 'r');
hold off;
title('1 Hz and 9 Hz give the same samples at fs = 10 Hz');
xlabel('Time');
ylabel('Amplitude');
legend('9 Hz', '1 Hz', 'samples');
grid on;

disp(['Alias frequency = ', num2str(f_alias), ' Hz']);
disp('Samples of 1 Hz signal:');
disp(s1);
disp('Samples of 9 Hz signal:');
disp(s9);