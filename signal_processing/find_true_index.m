function I = find_true_index(signal)
    
    %---------------------------------------------------------------------
    %find_true_index: finds fft index of the signal frequency
    %---------------------------------------------------------------------
    %signal - signal for which one wants to find frequency
    %---------------------------------------------------------------------
 
    signal = half_fft(signal);

    %finding index of where frequency is 
    [~,I] = max(abs(signal));

end

