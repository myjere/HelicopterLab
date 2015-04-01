clear all
close all
init02
clc

%% Continous model
Ac = [0    1    0    0;
      0    -0.03 -0.39   0;
      0    0    0    1;
      0    0  -7.13  -3.6];
Bc = [ 0 0 0 6.74]';

%% Discrete model
dt = 0.25;
A = eye(4) + Ac*dt;
B = Bc*dt;

% given: x0 = [0 0 0 0]';
xf = [pi 0 0 0]';

n_x = size(A,2);
n_u = size(B,2);

%%
duration = 25;
N = floor(duration/dt);
q = .1;
pitch_lim = 45; % deg

%% Equality constraints

Aeq = [ eye(N*n_x) + kron(diag(ones(N-1,1),-1), -A) , kron(eye(N), -B)];

beq = [-A*xf;
       zeros(n_x*(N-1),1)];
   
%% Inequality constraints
LB_x = repmat([-Inf -Inf -pitch_lim*pi/180 -Inf]', N, 1);
UB_x = repmat([Inf Inf pitch_lim*pi/180 Inf]', N, 1);

LB_u = repmat(-pitch_lim*pi/180, N, 1);
UB_u = repmat(pitch_lim*pi/180, N, 1);

LB = [LB_x;
      LB_u];
  
UB = [UB_x;
      UB_u];

%% QP formulation

Q = zeros(n_x);
Q(1, 1) = 1;
 
R = zeros(n_u);
R(1,1) = q/(1/2);

G = blkdiag(kron(eye(N), Q), kron(eye(N), R));

%% Solve
[z,fval,exitflag,output,lambda] = quadprog(G, [], [], [], Aeq, beq, LB, UB);
output

x = reshape(z(1:N*n_x), [n_x, N]);
travel = [-xf(1), x(1,:)];
pitch = [-xf(3), x(3,:)];
u = [reshape(z(N*n_x+1:end), [n_u, N]) , zeros(n_u, 1)];

time = (0:N)*dt;
figure(1)
hold on
plot(time, u, 'r');
plot(time, pitch, 'b');
plot(time, travel, 'g');
xlabel('Time [s]'); ylabel('Angle [rad]');
legend('Opt. input', 'Opt. pitch', 'Opt. travel', 'Location', 'SouthEast');
xlim([0 12.8])

%% Prep for actual use
padding_time = 10;
padded_input = [zeros(1,floor(padding_time/dt)) , u]';
time = [(0:length(padded_input) - 1)*dt]';
heli_input = [time padded_input];



