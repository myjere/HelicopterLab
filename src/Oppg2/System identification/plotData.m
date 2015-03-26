close all;

subplot(131);
plot(pitch_time, y_pitch/(40*pi/180))
title('Pitch')
xlabel('time [s]')
ylabel('Amplitude [rad]')
xlim([0 3]); ylim([0 1.1]);

subplot(132);
plot(elev_time, y_elev/(30*pi/180))
title('Elevation')
xlabel('time [s]')
ylabel('Amplitude [rad]')
xlim([0 4]); ylim([0 1.1]);


subplot(133);
plot(travelRate_time, y_travelRate/(20*pi/180))
title('Travel Rate')
xlabel('time [s]')
ylabel('Amplitude [rad]')
xlim([0 8]);
