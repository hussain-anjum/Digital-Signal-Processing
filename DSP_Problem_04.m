% =========================================================
% Problem 4: Sampling of an Analog Signal
% Samples a sine wave above, at, and below the Nyquist rate
% and compares the results.
% =========================================================

clc;          % Clear the Command Window
clear;        % Remove all variables from the Workspace
close all;    % Close all open figures

%% Analog (continuous-time) signal
A   = 1;                    % Amplitude
f   = 5;                    % Signal frequency in Hz
phi = 0;                    % Phase in radians (try pi/2 to see the effect at Nyquist)
t   = 0:0.0001:1;           % Very fine time grid to imitate an analog signal
x   = A*sin(2*pi*f*t + phi);

%% Sampling frequencies
fN      = 2*f;              % Nyquist rate = 2f = 10 Hz
fs_high = 10*f;             % Above Nyquist: 50 Hz
fs_nyq  = fN;               % At Nyquist:    10 Hz
fs_low  = 7;                % Below Nyquist:  7 Hz

%% Sampling: x[n] = x(n*Ts), where Ts = 1/fs
t_high = 0:1/fs_high:1;                 % Sampling instants (step = Ts)
x_high = A*sin(2*pi*f*t_high + phi);    % Sample values

t_nyq  = 0:1/fs_nyq:1;
x_nyq  = A*sin(2*pi*f*t_nyq + phi);

t_low  = 0:1/fs_low:1;
x_low  = A*sin(2*pi*f*t_low + phi);

%% Apparent (alias) frequency for the below-Nyquist case
f_alias = abs(f - fs_low*round(f/fs_low));   % 5 Hz appears as 2 Hz when fs = 7 Hz

%% Plotting
gray = [0.6 0.6 0.6];       % RGB color for the analog signal in the background
yr   = [-1.3 1.3];          % Common amplitude range

figure('Name', 'Problem 4: Sampling of Analog Signal');

subplot(2,2,1);
plot(t, x, 'b', 'LineWidth', 1.5);
title(['Analog signal: f = ', num2str(f), ' Hz']);
xlabel('Time (s)'); ylabel('Amplitude'); ylim(yr); grid on;

subplot(2,2,2);
plot(t, x, 'Color', gray);                        % Analog signal (background)
hold on;
stem(t_high, x_high, 'r', 'MarkerFaceColor', 'r'); % Samples
plot(t_high, x_high, 'k--');                      % Samples joined by straight lines
hold off;
title(['Above Nyquist: f_s = ', num2str(fs_high), ' Hz']);
xlabel('Time (s)'); ylabel('Amplitude'); ylim(yr); grid on;
legend('Analog', 'Samples', 'Joined samples', 'Location', 'best');

subplot(2,2,3);
plot(t, x, 'Color', gray);
hold on;
stem(t_nyq, x_nyq, 'r', 'MarkerFaceColor', 'r');
plot(t_nyq, x_nyq, 'k--');
hold off;
title(['At Nyquist: f_s = ', num2str(fs_nyq), ' Hz']);
xlabel('Time (s)'); ylabel('Amplitude'); ylim(yr); grid on;

subplot(2,2,4);
plot(t, x, 'Color', gray);
hold on;
stem(t_low, x_low, 'r', 'MarkerFaceColor', 'r');
plot(t_low, x_low, 'k--');
hold off;
title(['Below Nyquist: f_s = ', num2str(fs_low), ' Hz']);
xlabel('Time (s)'); ylabel('Amplitude'); ylim(yr); grid on;

sgtitle('Problem 4: Sampling Above, At and Below Nyquist Rate');

%% Summary in the Command Window
disp(['Signal frequency f = ', num2str(f), ' Hz']);
disp(['Nyquist rate 2f    = ', num2str(fN), ' Hz']);
disp(' ');
disp(['Above Nyquist: fs = ', num2str(fs_high), ' Hz, ', num2str(fs_high/f), ' samples per cycle, ', num2str(numel(t_high)), ' samples -> shape preserved']);
disp(['At Nyquist:    fs = ', num2str(fs_nyq),  ' Hz, ', num2str(fs_nyq/f),  ' samples per cycle, ', num2str(numel(t_nyq)),  ' samples -> borderline']);
disp(['Below Nyquist: fs = ', num2str(fs_low),  ' Hz, ', num2str(fs_low/f),  ' samples per cycle, ', num2str(numel(t_low)),  ' samples -> aliasing']);
disp(['Apparent frequency below Nyquist = ', num2str(f_alias), ' Hz (real: ', num2str(f), ' Hz)']);
disp(' ');
disp('Sample values at Nyquist rate (all practically zero):');
disp(x_nyq);