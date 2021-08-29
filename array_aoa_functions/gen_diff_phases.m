function differential_phases = gen_diff_phases(element_positions,frequency, aoa)
    
    %---------------------------------------------------------------------
    %gen_diff_phase: given a set of linearly spaced positions, the
    %                   differential phase for a frequency and angle of
    %                   arrival will be calculated
    %---------------------------------------------------------------------
    %array_positions - array positions in meters with index 1 
    %                           as reference 0 array [0 d1 d2]
    %frequency       - frequency of signal
    %aoa             - angle of arival (rad)
    %---------------------------------------------------------------------
    
    lambda = 3e8/frequency;

    %See any text on basic angle of arrival for description of formula
    %0 is reference so differential is just phase at element itself
    differential_phases = ((2*pi)/(lambda))*(element_positions)*sin(aoa); 
    
    %moving back into range [-180:180]
    differential_phases = wrapToPi(differential_phases)
    
    differential_phases = differential_phases/(2*pi);
    
end

