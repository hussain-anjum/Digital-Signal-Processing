clc;
clear;
close all;

% Message signal parameters
fm = 10;
t = 0:0.001:0.5;

% Original analog signal
x = sin(2*pi*fm*t);

% Sampling frequencies
fs1 = 20;  % Nyquist rate
fs2 = 40;  % Above Nyquist
fs3 = 10;  % Below Nyquist

% Sampling time
t1 = 0:1/fs1:0.5;
t2 = 0:1/fs2:0.5;
t3 = 0:1/fs3:0.5;

% Sampled signals
x1 = sin(2*pi*fm*t1);
x2 = sin(2*pi*fm*t2);
x3 = sin(2*pi*fm*t3);

% Plot original signal
subplot(3,1,1);
plot(t,x,'b','LineWidth',1.5);
hold on;
stem(t1,x1,'r','filled');
title('Sampling at Nyquist Rate (20 Hz)');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Analog Signal','Sampled Signal');
grid on;

% Plot above Nyquist
subplot(3,1,2);
plot(t,x,'b','LineWidth',1.5);
hold on;
stem(t2,x2,'r','filled');
title('Sampling Above Nyquist Rate (40 Hz)');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Analog Signal','Sampled Signal');
grid on;

% Plot below Nyquist
subplot(3,1,3);
plot(t,x,'b','LineWidth',1.5);
hold on;
stem(t3,x3,'r','filled');
title('Sampling Below Nyquist Rate (10 Hz)');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Analog Signal','Sampled Signal');
grid on;

sgtitle('Comparison of Sine Wave Sampling');