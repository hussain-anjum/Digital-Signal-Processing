% =========================================================
% Problem 3: Even and Odd Decomposition
% Decomposes a discrete signal into even and odd parts and
% verifies that x[n] = xe[n] + xo[n].
% Signal used: x[n] = {1, 2, 3, 4} for n = 0..3 (0 elsewhere)
% =========================================================

clc;          % Clear the Command Window
clear;        % Remove all variables from the Workspace
close all;    % Close all open figures

%% Signal on a symmetric index range
n = -3:3;                   % Symmetric range around n = 0 (needed for x[-n])
x = [0 0 0 1 2 3 4];        % x[n] with zeros added for n = -3, -2, -1

%% Time reversal: x[-n]
x_rev = fliplr(x);          % Equals x[-n] only because n is symmetric

%% Even and odd components
xe = (x + x_rev) / 2;       % Even part: (x[n] + x[-n]) / 2
xo = (x - x_rev) / 2;       % Odd part:  (x[n] - x[-n]) / 2

%% Reconstruction
x_sum = xe + xo;            % Should give back the original x[n]

%% Plotting (same axis limits everywhere for easy comparison)
xr = [-4 4];                % Common n-axis range
yr = [-3 5];                % Common amplitude range (odd part goes negative)

figure('Name', 'Problem 3: Even and Odd Decomposition');

subplot(3,2,1);
stem(n, x, 'filled');
title('Original x[n]');
xlabel('n'); ylabel('x[n]'); xlim(xr); ylim(yr); grid on;

subplot(3,2,2);
stem(n, x_rev, 'filled');
title('Reversed x[-n]');
xlabel('n'); ylabel('x[-n]'); xlim(xr); ylim(yr); grid on;

subplot(3,2,3);
stem(n, xe, 'filled');
title('Even part x_e[n]');
xlabel('n'); ylabel('x_e[n]'); xlim(xr); ylim(yr); grid on;

subplot(3,2,4);
stem(n, xo, 'filled');
title('Odd part x_o[n]');
xlabel('n'); ylabel('x_o[n]'); xlim(xr); ylim(yr); grid on;

subplot(3,2,5);
stem(n, x_sum, 'filled');
title('x_e[n] + x_o[n]');
xlabel('n'); ylabel('Sum'); xlim(xr); ylim(yr); grid on;

subplot(3,2,6);
stem(n, x, 'b', 'LineWidth', 2);     % Original in thick blue
hold on;                             % Keep this plot and draw on top of it
stem(n, x_sum, 'r--');               % Reconstructed in dashed red
hold off;                            % Stop drawing on top
title('Overlap check');
xlabel('n'); ylabel('Amplitude'); xlim(xr); ylim(yr); grid on;
legend('x[n]', 'x_e + x_o');

sgtitle('Problem 3: Even and Odd Decomposition');

%% Table in the Command Window
disp('Columns: n | x[n] | x[-n] | xe[n] | xo[n] | xe+xo');
disp([n' x' x_rev' xe' xo' x_sum']);

%% Verification (1 = true, 0 = false)
disp('--- Verification ---');
disp(['x = xe + xo  : ', num2str(isequal(x_sum, x))]);
disp(['xe is even   : ', num2str(isequal(xe, fliplr(xe)))]);
disp(['xo is odd    : ', num2str(isequal(xo, -fliplr(xo)))]);
disp(['Max error    : ', num2str(max(abs(x - x_sum)))]);