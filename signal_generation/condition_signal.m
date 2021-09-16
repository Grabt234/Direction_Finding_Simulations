function signals = condition_signal(sig, array_positions, ...
                                        frequency, true_aoa, snr)
    
    %---------------------------------------------------------------------
    %condition_signal: take an ideal signal, simulates recieving it at each
    %                   antenna elements using the signals frequency. It
    %                   also adds noise onto the signal
    %---------------------------------------------------------------------
    %sig - a 1xn length signal
    %array_positions - array positions in meters with index 1 
    %                           as reference 0 array [0 d1 d2]
    %frequency - RF the frequency of the signal  
    %true_aoa - the anlge of arrival of the signal
    %snr - the signal to noise ratio of the signal at recieval
    %---------------------------------------------------------------------

    %upscaling to each represent signal at each element of array
    sigs = repmat(sig, length(array_positions), 1);

    %calculating differential phase between each antenna element
    differential_phases = gen_phase_offsets(array_positions, frequency,...
                                            true_aoa);
    
    %simulating phase difference at each recieving element
    %note: differential phases normalised to pi
    sigs = sigs.*exp(1i*2*pi*differential_phases.');
    
    %adding noise to the signal
    signals = awgn(sigs, snr, "measured");

end

