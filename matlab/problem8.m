clc;
clear;
close all;

% Step 1: Generate sine wave
f = 5;
t = 0:0.001:1;
x = sin(2*pi*f*t);

% Step 2: Define uniform quantizer
L = 8;
xmin = -1;
xmax = 1;

delta = (xmax-xmin)/L;

% Step 3: Quantize the signal
index = floor((x-xmin)/delta);
index = min(max(index,0),L-1);

xq = xmin + (index+0.5)*delta;

% Step 4: Calculate quantization error
e = x-xq;

% Step 5: Calculate Mean Squared Error
MSE = mean(e.^2);

% Step 6: Display MSE
fprintf('Quantization Step Size = %.4f\n',delta);
fprintf('Mean Squared Error (MSE) = %.6f\n',MSE);

% Step 7: Plot quantization error
figure;

plot(t,e,'m','LineWidth',1.5);

title('Quantization Error Signal');
xlabel('Time (seconds)');
ylabel('Quantization Error');

grid on;