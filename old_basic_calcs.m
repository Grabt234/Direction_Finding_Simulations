%% FIGURING OUT AMBIGUITIES
close all

%angles of arrival (rads)
%can be denotes as alpha in notes
theta = -45:1:45;
theta_deg = theta;
theta = theta*(pi/180);

%frequency and wave lengths
c = 3e8;
F = [6e9 12e9 18e9];
lambdas = c./F;

%set baselines as lambda/2
baselines = lambdas/2;

used_base = 1;
used_lambda = 3;

%% PLOTTING RELATIVE PHASE V.S AOA
% 
% %using LF baseline
% baseline = baselines(used_base);
% 
% %calc constant (2pi/lamda)L array
% %transpose to colum
% %multiply by sin theta (row vector)
% phi = ((((2*pi)./lambdas)*baseline).').*sin(theta);
% 
% %plotting results for longest basline
% %expect ambiguities
% phi = wrapToPi(phi);
% 
% plot(theta_deg, phi*180/pi)
% legend('6GHz','12GHz','18GHz')
% xlabel("Angle of Arrival (Deg)")
% ylabel("Relative Phase (Deg)")
% title(["PLOT SHOWING RELATIVE PAHSE BETWEEN TWO WAVES FOR A BASELINE"; ...
%     " LENGTH OF 2.5CM OVER 3 FREQUENCIES OVER AN ANGLE OF ARRIVAL ANGLES OF [-90:90]"])
% 
% %% PLOTTING ANGULAR ACCURACY PHASE V.S AOA
% 
% %change used base to see changes in 
% %accuracy for a given baseline
% 
% %calculating accuracy (fo basic bistatic case)
% theta_by_phi = ((lambdas/baseline).')./(2*pi*cos(theta));
% figure
% plot(theta_deg, theta_by_phi*180/pi);
% legend('6GHz','12GHz','18GHz')
% xlabel("Angle of Arrival (Deg)")
% ylabel("Relative Phase Accuracy (Deg)")
% title(["PLOT SHOWING ANGULAR ACCURACY BETWEEN TWO WAVES FOR A BASELINE"; ...
%     " LENGTH OF 2.5CM OVER 3 FREQUENCIES OVER AN ANGLE OF ARRIVAL ANGLES OF [-90:90]"])

%% SINGLE FREQUENCY, MULTIPLE BASELINES, PLOTTING AMBIGUITIES

lambda = 3e8/18e9; %0.0167

%realtive phase constant f, variable L
phi_2 = ((((2*pi)./lambda)*([0.5*0.0167 2*0.0167])).').*sin(theta);
phi_2 = wrapToPi(phi_2);
theta = -90:1:90;

figure
plot(theta_deg, phi_2*180/pi);
legend('L = 0.83cm', 'L = 3.3cm')
xlabel("Angle of Arrival (Deg)")
ylabel("Element Phase (Deg)")
title(["PLOT SHOWING PHASE AMBIGUITIES FOR A FREQUENCY OF 18GHZ"; ...
    " AND VARIABLE BASELINES OVER AN ANGLE OF ARRIVAL ANGLES OF [-45:45]"])

%% SINGLE FREQUENCY, MULTIPLE BASELINES, PLOTTING ACCURACY

% %calculating accuracy
% theta_by_phi_2 = ((lambda./baselines).')./(2*pi*cos(theta));
% 
% figure
% plot(theta_deg, theta_by_phi_2*180/pi);
% legend('L = 2.5cm','L = 1.25m','L = 0.83cm')
% xlabel("Angle of Arrival (Deg)")
% ylabel("Relative Phase (Deg)")
% title(["PLOT SHOWING ANGULAR ACCURACY BETWEEN TWO WAVES FOR VARIABLE BASELINES"; ...
%     " AND CONSTANT FREQUENCY OVER AN ANGLE OF ARRIVAL ANGLES OF [-90:90]"])
% 
% 
% 
















