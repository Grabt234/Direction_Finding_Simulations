%% 1

%frequency of interest
foi = 18e9;
%linear array for x
pos_elements = [0 0.0083 0.0125 0.025]; %meters


[course_baseline, course_baseline_index] = select_baseline(pos_elements, foi);

[fine_baseline, fine_baseline_index] = max(pos_elements);

%% SIMULATING PHASE RECEIVAL


aoa = (35)*(pi/180);

%aoa = pi/16;   

%simulating receival phase 
% ---- NORMALISED TO 2PI ----
differential_phases = gen_diff_phases(pos_elements, foi, aoa)


%% SELECTING DIFFERENTIAL PAHSES

%the differential phase on the COURSE baseline of interest
course_diff_phase = differential_phases(course_baseline_index);

%the phase on the FINE baseline of interest
fine_diff_phase = differential_phases(fine_baseline_index);


%% COMPUTING AMBIGUITIES

N = compute_ambiguity(fine_baseline,foi);

fine_diff_phases = compute_ambiguities(N, fine_diff_phase);


%% CALCULATING COURSE AOA'S
%using couse baseline to find unambiguous aoa
unambiguous_aoa = compute_aoa(course_baseline, foi, course_diff_phase);
 
%using fine baseline to find AMBIGUOUS aoa
ambiguous_aoas = compute_aoa(fine_baseline, foi, fine_diff_phases);

%% COMPUTING AMBIGUOUS 

%selecting correct aoa
unambiguous_fine_aoa = select_aoa(unambiguous_aoa, ambiguous_aoas);









