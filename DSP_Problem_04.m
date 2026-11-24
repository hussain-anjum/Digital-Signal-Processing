clc;
clear;
close all;

% Original analog signal
fm = 5;                  % Signal frequency in Hz
A = 1;                   % Amplitude
phase = pi/6;            % Phase angle
duration = 1.5;          % Signal duration in seconds

% Continuous-time signal
t = 0:0.001:duration;
x = A * sin(2*pi*fm*t + phase);

% Three sampling frequencies
Fs_nyquist = 2*fm;       % Nyquist rate = 10 Hz
Fs_above = 4*fm;         % Above Nyquist = 20 Hz
Fs_below = 6;            % Below Nyquist = 6 Hz

% Sampling at Nyquist rate
n1 = 0:floor(duration*Fs_nyquist);
t1 = n1/Fs_nyquist;
x1 = A * sin(2*pi*fm*t1 + phase);

% Sampling above Nyquist rate
n2 = 0:floor(duration*Fs_above);
t2 = n2/Fs_above;
x2 = A * sin(2*pi*fm*t2 + phase);

% Sampling below Nyquist rate
n3 = 0:floor(duration*Fs_below);
t3 = n3/Fs_below;
x3 = A * sin(2*pi*fm*t3 + phase);

% Calculate alias frequency
f_alias = abs(fm - Fs_below);

% Aliased signal for this example
phase_alias = pi - phase;
x_alias = A * sin(2*pi*f_alias*t + phase_alias);

% Display sampling information
disp('Nyquist Rate:');
disp(Fs_nyquist);

disp('Above Nyquist Rate:');
disp(Fs_above);

disp('Below Nyquist Rate:');
disp(Fs_below);

disp('Alias Frequency:');
disp(f_alias);

% Plot 1: Nyquist rate
figure;

subplot(3,1,1);
plot(t, x, 'b', 'LineWidth', 1.3);
hold on;
stem(t1, x1, 'r', 'filled');
hold off;

title('Nyquist Sampling (Fs = 10 Hz)');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Original Signal', 'Sampled Signal');
grid on;

% Plot 2: Above Nyquist rate
subplot(3,1,2);
plot(t, x, 'b', 'LineWidth', 1.3);
hold on;
stem(t2, x2, 'r', 'filled');
hold off;

title('Above Nyquist Sampling (Fs = 20 Hz)');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Original Signal', 'Sampled Signal');
grid on;

% Plot 3: Below Nyquist rate
subplot(3,1,3);
plot(t, x, 'b', 'LineWidth', 1.3);
hold on;
plot(t, x_alias, 'm--', 'LineWidth', 1.3);
stem(t3, x3, 'r', 'filled');
hold off;

title('Below Nyquist Sampling (Fs = 6 Hz)');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Original 5 Hz Signal', 'Aliased 1 Hz Signal', 'Samples');
grid on;
