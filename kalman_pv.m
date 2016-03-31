%% Estimating position of hockey puck by importing actual and observed positions
% and using kalman estimate over it. Pv in file name stands for plus  variance 

E_est_temp_x = 0.05; % error in estimate
E_est_temp_y = 0.05;

Est_t1_x = 0.05; % Estimate at time t-1
Est_t1_y = 0.05;

var_obs_err = 0.01;


filename = 'actual_x.xlsx';
A = importdata(filename);

filename = 'observed_x.xlsx';
B = importdata(filename);

filename = 'actual_y.xlsx';
C = importdata(filename);

filename = 'observed_y.xlsx';
D = importdata(filename);


 d =121;
 result_x= zeros(d,3);
 result_y= zeros(d,3);
 
for i =1:d
E_mea_temp_x = (A.Sheet1(i,1) - (B.Sheet1(i,1) + var_obs_err)); % error in observing x
E_mea_temp_y = (C.Sheet1(i,1) - (D.Sheet1(i,1) + var_obs_err));
kg_x = E_est_temp_x/(E_est_temp_x+E_mea_temp_x);    % kalman gain in x
kg_y = E_est_temp_y/(E_est_temp_y+E_mea_temp_y);

Est_t2_x = Est_t1_x + (kg_x * (B.Sheet1(i,1)-Est_t1_x)); % Estimate at time t for x
Est_t2_y = Est_t1_y + (kg_y * (D.Sheet1(i,1)-Est_t1_y));

E_est_temp_x = (1-kg_x)* (Est_t1_x);  % error in estimating x
E_est_temp_y = (1-kg_y)* (Est_t1_y);

Est_t1_x = Est_t2_x; 
Est_t1_y = Est_t2_y; 

%crearing result matrix of actual , observed and estimated positions of
%hockey puck
result_x(i,1)=A.Sheet1(i,1);
result_x(i,2)=B.Sheet1(i,1);
result_x(i,3)=Est_t2_x;

result_y(i,1)=C.Sheet1(i,1);
result_y(i,2)=D.Sheet1(i,1);
result_y(i,3)=Est_t2_y;

end

result_x;
result_y;

actual_x = result_x(:,1);
observed_x = result_x(:,2);
estimate_x = result_x(:,3);

actual_y = result_y(:,1);
observed_y = result_y(:,2);
estimate_y = result_y(:,3);
temp_Z = zeros(121,1);

title('Estimating 2D position by kalman filter')
xlabel('Position along x axis')
ylabel('Position along y axis')

% hold on
% plotyy(actual_x,actual_y,observed_x,observed_y)
% plotyy(observed_x,observed_y,estimate_x,estimate_y)
% hold off
hold on
scatter(actual_x, actual_y)
scatter(observed_x, observed_y)
scatter(estimate_x, estimate_y)
 
hold off
%  legend({'actual', 'observed'})
