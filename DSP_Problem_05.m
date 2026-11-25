% =========================================================
% Problem 5: Aliasing Demonstration
% Part A: one sinusoid sampled at different frequencies,
%         with the alias sinusoid drawn through the samples.
% Part B: two different sinusoids that give identical samples.
% =========================================================

clc;          % Clear the Command Window
clear;        % Remove all variables from the Workspace
close all;    % Close all open figures

%% ---------- Part A: one signal, several sampling frequencies ----------
f = 5;                          % Real signal frequency in Hz
t = 0:0.0001:1;                 % Fine time grid (imitates an analog signal)
x = cos(2*pi*f*t);              % Analog cosine

fs_list = [50 12 8 6];          % Sampling frequencies to test (Hz)

figure('Name', 'Problem 5A: Aliasing at Different Sampling Rates');
disp('--- Part A ---');
disp(['Real signal frequency = ', num2str(f), ' Hz, Nyquist rate = ', num2str(2*f), ' Hz']);

for k = 1:length(fs_list)
    fs = fs_list(k);                          % Current sampling frequency
    ts = 0:1/fs:1;                            % Sampling instants
    xs = cos(2*pi*f*ts);                      % Sample values

    f_alias = abs(f - fs*round(f/fs));        % Apparent (alias) frequency
    x_alias = cos(2*pi*f_alias*t);            % Sinusoid the samples look like

    if fs > 2*f
        status = 'No aliasing';
    else
        status = 'Aliasing';
    end

    subplot(2,2,k);
    plot(t, x, 'Color', [0.7 0.7 0.7]);           % Real 5 Hz signal (background)
    hold on;
    plot(t, x_alias, 'g--', 'LineWidth', 1.5);    % Alias sinusoid
    stem(ts, xs, 'r', 'MarkerFaceColor', 'r');    % Samples
    hold off;
    title(['f_s = ', num2str(fs), ' Hz, apparent f = ', num2str(f_alias), ' Hz']);
    xlabel('Time (s)'); ylabel('Amplitude'); ylim([-1.3 1.3]); grid on;

    if k == 1
        legend('Real 5 Hz', 'Alias', 'Samples', 'Location', 'best');
    end

    disp(['fs = ', num2str(fs), ' Hz -> appears as ', num2str(f_alias), ' Hz -> ', status]);
end

sgtitle(['Part A: Real signal is a ', num2str(f), ' Hz cosine']);

%% ---------- Part B: two different signals, identical samples ----------
fs2 = 10;                       % Sampling frequency (Hz)
f1  = 1;                        % Low-frequency signal (Hz)
f2  = 9;                        % High-frequency signal (Hz), f2 = fs2 - f1

t2  = 0:0.0001:2;               % Fine time grid for 2 seconds
ts2 = 0:1/fs2:2;                % Sampling instants

x1  = cos(2*pi*f1*t2);          % Analog 1 Hz signal
x2  = cos(2*pi*f2*t2);          % Analog 9 Hz signal
xs1 = cos(2*pi*f1*ts2);         % Samples of the 1 Hz signal
xs2 = cos(2*pi*f2*ts2);         % Samples of the 9 Hz signal

figure('Name', 'Problem 5B: Two Signals, Same Samples');
plot(t2, x2, 'Color', [0.7 0.7 0.7]);         % 9 Hz signal (background)
hold on;
plot(t2, x1, 'b', 'LineWidth', 1.5);          % 1 Hz signal
stem(ts2, xs2, 'r', 'MarkerFaceColor', 'r');  % Samples of the 9 Hz signal
hold off;
title(['Part B: ', num2str(f1), ' Hz and ', num2str(f2), ' Hz sampled at ', num2str(fs2), ' Hz']);
xlabel('Time (s)'); ylabel('Amplitude'); ylim([-1.3 1.3]); grid on;
legend('9 Hz signal', '1 Hz signal', 'Samples', 'Location', 'best');

disp(' ');
disp('--- Part B ---');
disp('First 5 samples of the 1 Hz signal:'); disp(xs1(1:5));
disp('First 5 samples of the 9 Hz signal:'); disp(xs2(1:5));
disp(['Largest difference between the two sample sets = ', num2str(max(abs(xs1 - xs2)))]);