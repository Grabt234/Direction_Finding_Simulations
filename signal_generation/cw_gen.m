function signal = cw_gen(samples,f_samp, f_sig)
    
    %---------------------------------------------------------------------
    %cw_gen: produces a un modulated cw signal
    %---------------------------------------------------------------------
    %s - a 1xn length signal
    %array_positions - array positions in meters with index 1 
    %                           as reference 0 array [0 d1 d2]
    %frequency - the frequency of the signal  
    %true_aoa - the anlge of arrival of the signal
    %snr - the signal to noise ratio of the signal at recieval
    %---------------------------------------------------------------------
    
    %creating array of samples
    n = 1:1:samples;

    %converting samples into time equivalent (T = 1/f_samp)
    t = n*(1/f_samp);
    
    %creating signal
    signal = sin(2*pi*f_sig*t);

end

