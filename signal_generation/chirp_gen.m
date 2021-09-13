function signal = chirp_gen(samples,f_samp, f_sig,B,T)
    
    %---------------------------------------------------------------------
    %chirp_gen: produces a un modulated cw signal
    %---------------------------------------------------------------------
    %s - a 1xn length signal
    %array_positions - array positions in meters with index 1 
    %                           as reference 0 array [0 d1 d2]
    %frequency - the frequency of the signal  
    %true_aoa - the anlge of arrival of the signal
    %snr - the signal to noise ratio of the signal at recieval
    %B - bandwidth
    %T - repetition period in samples
    %---------------------------------------------------------------------
    
    %creating array of samples
    n = 1:1:samples;

    %converting samples into time equivalent (T = 1/f_samp)
    t = n*(1/f_samp);
    
    %creating signal
    signal = sin( pi*(B/T)*t.^2);
    
    plot(1:1:length(signal),signal)
    figure
end

