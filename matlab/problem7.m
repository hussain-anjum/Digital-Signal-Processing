clc;
clear;
close all;

% Step 1: Generate a sine wave
f = 5;                      % Signal frequency
t = 0:0.001:1;              % Time vector
x = sin(2*pi*f*t);          % Input sine wave

% Step 2: Define uniform quantizer
L = 8;                      % Number of quantization levels
xmin = -1;                  % Minimum amplitude
xmax = 1;                   % Maximum amplitude

delta = (xmax-xmin)/L;      % Quantization step size

% Step 3: Quantize the signal (uniform mid-rise quantizer)
index = floor((x-xmin)/delta);
index = min(max(index,0),L-1);

xq = xmin + (index+0.5)*delta;

% Step 4: Plot input and quantized signals
figure;

plot(t,x,'b','LineWidth',1.5);
hold on;

stairs(t,xq,'r','LineWidth',1.5);

title('Uniform Quantization of Sine Wave');
xlabel('Time (seconds)');
ylabel('Amplitude');

legend('Original Input','Quantized Output');
grid on;