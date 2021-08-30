function signals = condition_signal(sig, array_positions, ...
                                        frequency, true_aoa, snr)
    
    %---------------------------------------------------------------------
    %condition_signal: given a operation frequency one, the course baseline
    %                   will be selected
    %---------------------------------------------------------------------
    %array_positions - array positions in meters with index 1 
    %                           as reference 0 array [0 d1 d2]
    %  
    %---------------------------------------------------------------------
    
    %upscaling to each represent signal at each element of array
    sigs = repmat(sig, length(array_positions), 1);

    %calculating differential phase between each antenna element
    differential_phases = gen_phase_offsets(array_positions, frequency,...
                                            true_aoa);
    
    %simulating phase difference at each recieving element
    sigs = sigs.*exp(1i*2*pi*differential_phases.');
    
    %adding noise to the signal
    signals = awgn(sigs, snr, "measured");
    
end

