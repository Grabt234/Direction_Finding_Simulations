function unambiguous_fine_aoa = aoa(foi, pos_elements, differential_phases)
    
    %---------------------------------------------------------------------
    %aoa: computes the fine aoa of a signal given a frequency of interest,
    %       the position of elements (first a zero as reference [0 x1 x2])
    %       and the measured differential phases wrt to first element
    %---------------------------------------------------------------------
    %foi  - frequency of interest
    %pos elements - array of elements wrt to first as 0 [0 x1 x2]
    %differential phase - differential phase between elements 
    %                       (first element reference therefore set to zero
    %                       eg [0 p12 p13]0
    %                        
    %---------------------------------------------------------------------
    
    %% SELECTING PORTION OF ARRAY TO USE

    [course_baseline, course_baseline_index] = select_baseline(pos_elements, foi);

    [fine_baseline, fine_baseline_index] = max(pos_elements);


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


end

