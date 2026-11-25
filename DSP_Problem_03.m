% =========================================================
% Problem 3: Even and Odd Decomposition
% Decomposes a discrete signal into even and odd parts and
% verifies that x[n] = xe[n] + xo[n].
% Signal used: x[n] = {1, 2, 3, 4} for n = 0..3 (0 elsewhere)
% =========================================================

clc;
clear;
close all;

% x[n] = {1, 2, 3, 4} from n = 0, zeros added on the left side
n = -3:3;
x = [0 0 0 1 2 3 4];

x_rev = fliplr(x);        % x[-n]

xe = (x + x_rev) / 2;     % even part
xo = (x - x_rev) / 2;     % odd part

x_sum = xe + xo;          % should be equal to x

figure;

subplot(2,2,1);
stem(n, x);
title('Original x[n]');
xlabel('n');
ylim([-3 5]);
grid on;

subplot(2,2,2);
stem(n, xe);
title('Even Part xe[n]');
xlabel('n');
ylim([-3 5]);
grid on;

subplot(2,2,3);
stem(n, xo);
title('Odd Part xo[n]');
xlabel('n');
ylim([-3 5]);
grid on;

subplot(2,2,4);
stem(n, x_sum);
title('xe[n] + xo[n]');
xlabel('n');
ylim([-3 5]);
grid on;

disp('x[n] =');
disp(x);
disp('xe[n] =');
disp(xe);
disp('xo[n] =');
disp(xo);
disp('xe[n] + xo[n] =');
disp(x_sum);

if isequal(x, x_sum)
    disp('Verified: x[n] = xe[n] + xo[n]');
else
    disp('Not equal');
end