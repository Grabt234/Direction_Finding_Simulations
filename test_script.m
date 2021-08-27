%% 1

%frequency of interest
foi = 18e9;
%linear array for x
pos_elements = [0 0.0083 0.0125 0.025]; %meters


[course_baseline, course_baseline_index] = select_baseline(pos_elements, foi);

[fine_baseline, fine_baseline_index] = max(pos_elements);

%ambiguity number
M = compute_ambiguity_number(fine_baseline,foi)

%% SIMULATING PHASE RECEIVAL

%10 degrees
aoa = pi/16;

%simulating receival
differential_phases = gen_diff_phases(pos_elements, foi, aoa);


%% CALCULATING COURSE AOA

%the phase on the baseline of interest
phase_oi = differential_phases(course_baseline_index);

%unambiguous phase as measured by basleine meeting nyquist
unambiguous_diff_phase = phase_oi

%unambiguous PHASES as measured by basleine not meeting nyquist
ambigious_diff_phase =  compute_ambiguities(M, phase_oi)




course_aoa = compute_aoa(course_baseline, foi, phase_oi);

% 
% ambiguous_phases_oi = compute_ambiguities(M, phase_oi)
% fine_aoa_ambiguous = compute_aoa(fine_baseline, foi, phase_oi);

