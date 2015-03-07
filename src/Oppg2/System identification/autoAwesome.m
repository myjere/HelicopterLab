
%%%% Pitch %%%%

load pitchStep40deg
u_pitch = 40*pi/180 * ones(3000,1);
u_pitch(1) = 0;
y_pitch = pitchStep40deg.signals.values(1:3000);
pitch_data = iddata(y_pitch, u_pitch, 0.001);
pitch_time = 0.001:0.001:3;

opt = tfestOptions('InitialCondition', 'zero');
pitch_sys = tfest(pitch_data, 3, 0,opt); % poles, zeroes

subplot(131);
plot(pitch_time, y_pitch/(40*pi/180), 'r'); % scale for easy comparison with step()
hold on
step(pitch_sys);
hold off
title('Pitch');


%%%% Elevation %%%%

load elevStep30deg
u_elev = 30*pi/180 * ones(4000,1);
u_elev(1) = 0;
y_elev = elevStep30deg.signals.values(1:4000) + 17*pi/180; % unbias the step
elev_data = iddata(y_elev, u_elev, 0.001);
elev_time = 0.001:0.001:4;

opt = tfestOptions('InitialCondition', 'zero');
elev_sys = tfest(elev_data, 3, 0,opt); % poles, zeroes

subplot(132);
plot(elev_time, y_elev/(30*pi/180), 'r'); % scale for easy comparison with step()
hold on
step(elev_sys);
hold off
title('Elevation');



%%%% TravelRate %%%%

load travelRateStep20deg
u_travelRate = 20*pi/180 * ones(8000,1);
u_travelRate(1) = 0;
y_travelRate = travelRateStep20deg.signals.values(1:8000);
travelRate_data = iddata(y_travelRate, u_travelRate, 0.001);
travelRate_time = 0.001:0.001:8;

opt = tfestOptions('InitialCondition', 'zero');
travelRate_sys = tfest(travelRate_data, 2, 0,opt); % poles, zeroes

subplot(133);
plot(travelRate_time, y_travelRate/(20*pi/180), 'r'); % scale for easy comparison with step()
hold on
step(travelRate_sys);
hold off
xlim([0,8])
title('Travel rate');