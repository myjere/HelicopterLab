clear all; close all; clc
init02

%% Continuous model
Ac = [0    1    0    0    0    0;
      0  -0.03 -0.39 0    0    0;
      0    0    0    1    0    0;
      0    0 -7.13 -3.6   0    0;
      0    0    0    0    0    1;
      0    0    0    0 -3.03  -2.44];
  
Bc = [ 0    0;
       0    0;
       0    0;
       6.74 0;
       0    0;
       0    3.13];

%% Discrete model
dt = .25;
A = eye(6) + Ac*dt;
B = Bc*dt;

% given: x0 = [0 0 0 0 0 0]';
xf = [pi 0 0 0 0 0]';

n_x = size(A,2);
n_u = size(B,2);

%%
duration = 12;
N = floor(duration/dt);
q1 = .1;
q2 = 1;
pitch_lim = 45; % deg
elev_lim = 20;

%% Equality constraints

Aeq = [ eye(N*n_x) + kron(diag(ones(N-1,1),-1), -A) , kron(eye(N), -B)];

Beq = [-A*xf;
       zeros(n_x*(N-1),1)];
   
%% Bounds
LB_x = repmat([-Inf -Inf -pitch_lim*pi/180 -Inf -elev_lim*pi/180 -Inf ]', N, 1);
UB_x = repmat([Inf Inf pitch_lim*pi/180 Inf elev_lim*pi/180 Inf]', N, 1);

LB_u = repmat([-pitch_lim*pi/180 -elev_lim*pi/180]', N, 1);
UB_u = repmat([pitch_lim*pi/180 elev_lim*pi/180]', N, 1);

LB = [LB_x;
      LB_u];
  
UB = [UB_x;
      UB_u];
  

%% Problem

Q = [1 0 0 0 0 0;
     0 0 0 0 0 0;
     0 0 0 0 0 0;
     0 0 0 0 0 0;
     0 0 0 0 0 0;
     0 0 0 0 0 0];

R = [q1 0;
     0  q2];

G = blkdiag(kron(eye(N), Q), kron(eye(N), R));
          
%% Solving
f = @(X) X'*G*X;

OPT = optimset('Algorithm', 'sqp');
tic
[X, FVAL, EXITFLAG] = fmincon(f, zeros(N*8,1), [], [], Aeq, Beq, LB, UB, @constraint);
toc

x = reshape(X(1:N*n_x), [n_x, N]);
travel_opt = [-xf(1), x(1,:)];
pitch_opt = [-xf(3), x(3,:)];
elevation_opt = [-xf(5), x(5,:)];
u = [reshape(X(N*n_x+1:end), [n_u, N]) , zeros(n_u, 2)];


%% Prep for actual use
padding_time = 10;
padded_input = [zeros(2,floor(padding_time/dt)) , u]';
time = [(0:length(padded_input) - 1)*dt]';
heli_input = [time padded_input];






