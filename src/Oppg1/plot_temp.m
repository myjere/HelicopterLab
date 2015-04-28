close all

figure
subplot(211)
time = 0.001:0.001:2.5;

load pitchStep40deg

good = pitchStep40deg.signals.values(1:2500)-pitchStep40deg.signals.values(1);
load pitchStep40deg_bad
bad = (data(2,10001:12500) - data(2,10001))*pi/180;

plot(time,bad,'--b', time, good, 'b')

xlabel('Time [s]'); ylabel('Pitch angle [rad]');
legend('Original', 'Improved', 'Location', 'SouthEast');

subplot(212)
load elevWhilePitchStep40
good = (data(3,10001:12500)-data(3,10001))*pi/180;

load elevWhilePitchStep40_bad
bad = (data(3,10001:12500) - data(3,10001))*pi/180;

plot(time,bad,'--k', time, good, 'k')

xlabel('Time [s]'); ylabel('Elevation angle [rad]');
legend('Original', 'Improved', 'Location', 'NorthWest');



%% PITCH %%
figure
time = 0.001:0.001:5;
% Good model
Ac = [0    1    0    0;
      0    -0.03 -0.39   0;
      0    0    0    1;
      0    0  -7.13  -3.6];
Bc = [ 0 0 0 6.74]';

sys_good = ss(Ac,Bc,eye(4),[]);
step_good = step(sys_good,time)*pi*40/180;

% Bad model

Acb = [0    1    0    0;
      0    0 -K_2   0;
      0    0    0    1;
      0    0  -K_1*K_pp  -K_1*K_pd];
Bcb = [ 0 0 0 K_1*K_pp]';

sys_bad = ss(Acb,Bcb,eye(4),[]);
step_bad = step(sys_bad,time)*pi*40/180;

% Measured response
load pitchStep40deg
measured = pitchStep40deg.signals.values(1:5000)-pitchStep40deg.signals.values(1);

plot(time,step_bad(:,3),'-.b',time,step_good(:,3),'--b',time,measured,'k')
xlabel('Time [s]'); ylabel('Angle [rad]');
legend('Derived', 'Estimated', 'Measured', 'Location', 'SouthEast');


%% ELEVATION %%
figure

sys_bad = tf([K_3*K_ep],[1 K_3*K_ed K_3*K_ep]);
step_bad = step(sys_bad,time)*pi*30/180;

sys_good = tf([3.125],[1 2.435 3.028]);
step_good = step(sys_good,time)*pi*30/180;

load elevStep30deg
measured = elevStep30deg.signals.values(1:5000) + 16.8*pi/180;

plot(time,step_bad,'-.k',time,step_good,'--k',time,measured,'k')
xlabel('Time [s]'); ylabel('Angle [rad]');
legend('Derived', 'Estimated', 'Measured', 'Location', 'SouthEast');

%% TRAVEL RATE %%
figure

sys_bad = tf([K_1*K_pp],[1 K_1*K_pd K_1*K_pp])*tf([-K_2],[1 0]);
step_bad = step(sys_bad,time)*pi*20/180;

sys_good = tf([6.741],[1 3.58 7.132]) * tf([-0.2917],[1 0.05104]);
step_good = step(sys_good,time)*pi*20/180;

load travelRateStep20deg
measured = travelRateStep20deg.signals.values(1:5000) - 0.02; % unbias



plot(time,measured,'k',time,step_bad,'-.g',time,step_good,'--g')
xlabel('Time [s]'); ylabel('Angle [rad]');
legend('Measured','Derived', 'Estimated', 'Location', 'SouthEast');


