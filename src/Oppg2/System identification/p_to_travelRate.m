
%%%% pitch to travelRate %%%%
% h = travelRate/pitch

load p_to_travelRate

dt = data(1,2) - data(1,1);
pitch = data(3,10000:end)' - 0.069;
travel = data(4,9999:end)' - 0.19;
travelRate = diff(travel)/dt;

tf_data = iddata(travelRate, pitch, 0.001);

opt = tfestOptions('InitialCondition', 'zero');
sys = tfest(tf_data, 1, 0,opt); % poles, zeroes
sys