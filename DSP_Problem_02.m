% =========================================================
% Problem 2: Signal Operations on x[n] = {1, 2, 3, 4}
% Time shifting, time reversal, amplitude scaling and
% time scaling (compression and expansion).
% Origin assumed at the first sample: x[0] = 1.
% =========================================================

clc;          % Clear the Command Window
clear;        % Remove all variables from the Workspace
close all;    % Close all open figures

%% Original signal
n = 0:3;              % Sample index: x[0]=1, x[1]=2, x[2]=3, x[3]=4
x = [1 2 3 4];        % Sample values

%% 1. Time shifting: y[n] = x[n - k]
k = 2;
n_delay = n + k;      % Delay by k: every sample moves k steps to the right
x_delay = x;          % Values stay the same, only positions change

m = 1;
n_adv = n - m;        % Advance by m, y[n] = x[n + m]: moves m steps to the left
x_adv = x;

%% 2. Time reversal: y[n] = x[-n]
n_rev = -fliplr(n);   % Mirror the index around n = 0
x_rev = fliplr(x);    % Reverse the order of values to match the new index

%% 3a. Amplitude scaling: y[n] = 2*x[n]
x_amp = 2 * x;        % Height changes, positions stay the same

%% 3b. Time compression: y[n] = x[2n]
keep   = (mod(n, 2) == 0);    % True only where n is even
n_comp = n(keep) / 2;         % Even n values divided by 2
x_comp = x(keep);             % Samples at odd n are lost

%% 3c. Time expansion: y[n] = x[n/2]
n_exp = 2*min(n) : 2*max(n);          % New index range is twice as long
x_exp = zeros(size(n_exp));           % Start with all zeros
x_exp(mod(n_exp, 2) == 0) = x;        % Put original samples at even n

%% Plotting (same axis limits on every subplot for easy comparison)
xr = [-5 7];          % Common n-axis range
yr = [0 9];           % Common amplitude range

figure('Name', 'Problem 2: Signal Operations');

subplot(4,2,1);
stem(n, x, 'filled');
title('Original x[n]');
xlabel('n'); ylabel('x[n]'); xlim(xr); ylim(yr); grid on;

subplot(4,2,2);
stem(n_delay, x_delay, 'filled');
title('Delay: x[n-2]');
xlabel('n'); ylabel('y[n]'); xlim(xr); ylim(yr); grid on;

subplot(4,2,3);
stem(n_adv, x_adv, 'filled');
title('Advance: x[n+1]');
xlabel('n'); ylabel('y[n]'); xlim(xr); ylim(yr); grid on;

subplot(4,2,4);
stem(n_rev, x_rev, 'filled');
title('Reversal: x[-n]');
xlabel('n'); ylabel('y[n]'); xlim(xr); ylim(yr); grid on;

subplot(4,2,5);
stem(n, x_amp, 'filled');
title('Amplitude scaling: 2x[n]');
xlabel('n'); ylabel('y[n]'); xlim(xr); ylim(yr); grid on;

subplot(4,2,6);
stem(n_comp, x_comp, 'filled');
title('Compression: x[2n]');
xlabel('n'); ylabel('y[n]'); xlim(xr); ylim(yr); grid on;

subplot(4,2,7);
stem(n_exp, x_exp, 'filled');
title('Expansion: x[n/2]');
xlabel('n'); ylabel('y[n]'); xlim(xr); ylim(yr); grid on;

sgtitle('Problem 2: Signal Operations on x[n] = \{1, 2, 3, 4\}');

%% Show every result in the Command Window (row 1 = n, row 2 = value)
disp('Original:');             disp([n; x]);
disp('Delay x[n-2]:');         disp([n_delay; x_delay]);
disp('Advance x[n+1]:');       disp([n_adv; x_adv]);
disp('Reversal x[-n]:');       disp([n_rev; x_rev]);
disp('Amplitude 2x[n]:');      disp([n; x_amp]);
disp('Compression x[2n]:');    disp([n_comp; x_comp]);
disp('Expansion x[n/2]:');     disp([n_exp; x_exp]);

%% Verification against hand calculation (1 = correct, 0 = wrong)
disp('--- Verification ---');
disp(['Delay       : ', num2str(isequal(n_delay, [2 3 4 5])  && isequal(x_delay, [1 2 3 4]))]);
disp(['Advance     : ', num2str(isequal(n_adv,   [-1 0 1 2]) && isequal(x_adv,   [1 2 3 4]))]);
disp(['Reversal    : ', num2str(isequal(n_rev,   [-3 -2 -1 0]) && isequal(x_rev, [4 3 2 1]))]);
disp(['Amplitude   : ', num2str(isequal(x_amp,   [2 4 6 8]))]);
disp(['Compression : ', num2str(isequal(n_comp,  [0 1])     && isequal(x_comp,  [1 3]))]);
disp(['Expansion   : ', num2str(isequal(n_exp,   0:6)       && isequal(x_exp,   [1 0 2 0 3 0 4]))]);