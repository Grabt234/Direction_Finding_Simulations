function signal = chirp_gen(samples,f_samp, f0,B,T)
    
    %---------------------------------------------------------------------
    %chirp_gen: produces a un modulated cw signal
    %---------------------------------------------------------------------
    %samples - a 1xn length signal
    %f_samp - sampling rate of the signal
    %f0 - the starting frequency of the signal  
    %B - bandwidth
    %T - repetition period in samples
    %---------------------------------------------------------------------
    
    %creating array of samples
    n = 1:1:samples;

    %converting samples into time equivalent (T = 1/f_samp)
    t = n*(1/f_samp);
    
    %creating signal
    signal = sin(2*pi*f0*t + pi*(B/T)*t.^2);

    plot(t, signal)
end

