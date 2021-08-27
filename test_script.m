%% 1

%frequency of interest
foi = 18e9;
%linear array for x
pos_elements = [0 0.0083 0.0125 0.025]; %meters


[course_baseline, course_baseline_index] = select_baseline(pos_elements, foi);

[fine_baseline, fine_baseline_index] = max(pos_elements);

%ambiguity number
M = compute_ambiguity_number(fine_baseline,foi);

%% SIMULATING PHASE RECEIVAL


aoa = (-5)*(pi/180);
%aoa = pi/16;   

%simulating receival
differential_phases = gen_diff_phases(pos_elements, foi, aoa);


%% CALCULATING COURSE AOA

%the differential phase on the COURSE baseline of interest
course_diff_phase = differential_phases(course_baseline_index);

%the phase on the FINE baseline of interest
fine_diff_phase = differential_phases(fine_baseline_index);

%using couse baseline to find unambiguous aoa
unambiguous_aoa = compute_aoa(course_baseline, foi, course_diff_phase)

%using fine baseline to find AMBIGUOUS aoa
fine_aoa = compute_aoa(fine_baseline, foi, fine_diff_phase)
% 
ambiguous_phases_oi = compute_ambiguities(M, fine_aoa);
fine_aoa_ambiguous = compute_aoa(fine_baseline, foi, phase_oi);

