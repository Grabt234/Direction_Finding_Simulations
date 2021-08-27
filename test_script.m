%% 1

%frequency of interest
foi = 18e9;
%linear array for x
pos_elements = [0 0.0083 0.0125 0.025]; %meters

course_baseline = select_baseline(pos_elements, foi)
fine_baseline = max(pos_elements)

%% SIMULATING PHASE RECEIVAL

%10 degrees
aoa = pi/16;

%simulating receival
differential_phases = gen_diff_phases(pos_elements, foi, aoa);


%% CALCULATING COURSE AOA

