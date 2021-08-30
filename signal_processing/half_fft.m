function SIGS = half_fft(sigs)
    
    %---------------------------------------------------------------------
    %half_fft: will return one side of the FFT'ed function. Gain of fft
    %               reduced to 1
    %---------------------------------------------------------------------
    %sig - signal to be FFT'ed
    %---------------------------------------------------------------------
    
    SIGS = fft(sigs,[],2)./length(sigs);
    SIGS = SIGS(:,length(SIGS)/2:end);
    
end

