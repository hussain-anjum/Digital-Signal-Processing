clc;
clear;
close all;

% Discrete time range
n = -10:10;

% Generate signals
sine_signal = sin(0.2*pi*n);
cosine_signal = cos(0.2*pi*n);
unit_step = double(n >= 0);
unit_impulse = double(n == 0);
ramp_signal = max(0,n);

% Create a large figure window
figure('Name','Basic Signal Generation',...
       'NumberTitle','off',...
       'Position',[100 50 1100 900]);

% Common plotting style
marker_size = 7;
line_width = 1.8;
font_size = 11;

% 1. Sine Wave
subplot(5,1,1);
stem(n, sine_signal, 'filled','LineWidth',line_width,...
     'MarkerSize',marker_size);
title('1. Sine Wave','FontSize',font_size+2);
xlabel('Time Index (n)');
ylabel('Amplitude');
xlim([-10 10]);
ylim([-1.5 1.5]);
xticks(-10:1:10);
grid on;

% 2. Cosine Wave
subplot(5,1,2);
stem(n, cosine_signal, 'filled','LineWidth',line_width,...
     'MarkerSize',marker_size);
title('2. Cosine Wave','FontSize',font_size+2);
xlabel('Time Index (n)');
ylabel('Amplitude');
xlim([-10 10]);
ylim([-1.5 1.5]);
xticks(-10:1:10);
grid on;

% 3. Unit Step Signal
subplot(5,1,3);
stem(n, unit_step, 'filled','LineWidth',line_width,...
     'MarkerSize',marker_size);
title('3. Unit Step Signal','FontSize',font_size+2);
xlabel('Time Index (n)');
ylabel('Amplitude');
xlim([-10 10]);
ylim([-0.3 1.5]);
xticks(-10:1:10);
yticks([0 1]);
grid on;

% 4. Unit Impulse Signal
subplot(5,1,4);
stem(n, unit_impulse, 'filled','LineWidth',line_width,...
     'MarkerSize',marker_size);
title('4. Unit Impulse Signal','FontSize',font_size+2);
xlabel('Time Index (n)');
ylabel('Amplitude');
xlim([-10 10]);
ylim([-0.3 1.5]);
xticks(-10:1:10);
yticks([0 1]);
grid on;

% 5. Ramp Signal
subplot(5,1,5);
stem(n, ramp_signal, 'filled','LineWidth',line_width,...
     'MarkerSize',marker_size);
title('5. Ramp Signal','FontSize',font_size+2);
xlabel('Time Index (n)');
ylabel('Amplitude');
xlim([-10 10]);
ylim([-1 12]);
xticks(-10:1:10);
grid on;

% Overall figure title
sgtitle('Basic Discrete-Time Signals',...
        'FontSize',16,'FontWeight','bold');

% Improve subplot spacing
set(findall(gcf,'Type','axes'),...
    'FontSize',10,'LineWidth',1.1);