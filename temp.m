%% FIGURING OUT AMBIGUITIES
close all

%angles of arrival (rads)
%can be denotes as alpha in notes
theta = -80:1:80;
theta_deg = theta
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

%using LF baseline
baseline = baselines(used_base);

%calc constant (2pi/lamda)L array
%transpose to colum
%multiply by sin theta (row vector)
phi = ((((2*pi)./lambdas)*baseline).').*sin(theta);

%plotting results for longest basline
%expect ambiguities
phi = wrapToPi(phi);

plot(theta_deg, phi*180/pi)
legend('6GHz','12GHz','18GHz')
xlabel("Angle of Arrival (Deg)")
ylabel("Relative Phase (Deg)")
title(["PLOT SHOWING RELATIVE PAHSE BETWEEN TWO WAVES FOR A BASELINE"; ...
    " LENGTH OF 2.5CM OVER 3 FREQUENCIES OVER AN ANGLE OF ARRIVAL ANGLES OF [-90:90]"])

%% PLOTTING ANGULAR ACCURACY PHASE V.S AOA

%change used base to see changes in 
%accuracy for a given baseline

%calculating accuracy (fo basic bistatic case)
theta_by_phi = ((lambdas/baseline).')./(2*pi*cos(theta));
figure
plot(theta_deg, theta_by_phi*180/pi);
legend('6GHz','12GHz','18GHz')
xlabel("Angle of Arrival (Deg)")
ylabel("Relative Phase Accuracy (Deg)")
title(["PLOT SHOWING RELATIVE PAHSE ACCURACY BETWEEN TWO WAVES FOR A BASELINE"; ...
    " LENGTH OF 2.5CM OVER 3 FREQUENCIES OVER AN ANGLE OF ARRIVAL ANGLES OF [-90:90]"])

%% SINGLE FREQUENCY, MULTIPLE BASELINES, PLOTTING AMBIGUITIES

lambda = lambdas(used_lambda);

%realtive phase constant f, variable L
phi_2 = ((((2*pi)./lambda())*baselines).').*sin(theta);
phi_2 = wrapToPi(phi_2);

figure
plot(theta_deg, phi_2*180/pi);
legend('L = 2.5cm','L = 1.25m','L = 0.83cm')
xlabel("Angle of Arrival (Deg)")
ylabel("Relative Phase Accuracy (Deg)")
title(["PLOT SHOWING RELATIVE PHASE AMBIGUITIES FOR CONSTANT FREQUENCY"; ...
    " AND VARIABLE BASELINESOVER AN ANGLE OF ARRIVAL ANGLES OF [-90:90]"])

%% SINGLE FREQUENCY, MULTIPLE BASELINES, PLOTTING ACCURACY





















