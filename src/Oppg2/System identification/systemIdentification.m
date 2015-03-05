close all
clc


% Actual system
load pitchStep40deg
measuredPitchStep = pitchStep40deg.signals.values(1:2001);
pitchTime = 0:0.001:2;

load elevStep30deg
measuredElevStep = elevStep30deg.signals.values(1:4001);
measuredElevStep = measuredElevStep + 17*pi/180;
elevTime = 0:0.001:4;

%load travelRateStep20deg
measuredTravelRateStep = travelRateStep20deg.signals.values(1:8001);
travelRateTime = 0:0.001:8;


% Model
pitch_w0 = 4;
pitch_d = 0.9;
pitch_K = 39*pi/180;
pitchModel = tf([pitch_K*pitch_w0^2],[1 2*pitch_d*pitch_w0 pitch_w0^2]);

elev_w0 = 2.5;
elev_d = 0.9;
elev_K = 32*pi/180;
elevModel = tf([elev_K*elev_w0^2],[1 2*elev_d*elev_w0 elev_w0^2]);

travelRate_K = -0.08;
travelRateModel = tf([travelRate_K], [1 0]);

% Visual comparison with measured data
subplot(311);
plot(pitchTime,measuredPitchStep,'r');
hold on
step(pitchModel)
title('Pitch');

subplot(312);
plot(elevTime,measuredElevStep,'r');
hold on
step(elevModel)
title('Elevation');

subplot(313);
plot(travelRateTime, measuredTravelRateStep,'r');
hold on
step(travelRateModel);
xlim([0,6]);

title('Travel rate');


% Scale TFs based on knowledge of input
pitchInputAmp = 40*pi/180;
elevInputAmp = 30*pi/180;
travelRateInputAmp = 20*pi/180;
pitchModel = pitchModel/pitchInputAmp;
elevModel = elevModel/elevInputAmp;
travelRateModel = travelRateModel/travelRateInputAmp;

% Output
fprintf('Pitch model:\n');
display(pitchModel);
fprintf('\nElevation model:\n');
display(elevModel);
fprintf('\nTravel rate model:\n');
display(travelRateModel);


