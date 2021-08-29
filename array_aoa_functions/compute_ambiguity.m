function N = compute_ambiguity(baseline, frequency)
    
    %---------------------------------------------------------------------
    %compute_ambiguity_number: computes number of uncertainties for a given
    %                               mesurement
    %---------------------------------------------------------------------
    %baseline  - baseline length in meters
    %frequency - frequency in hz
    %---------------------------------------------------------------------
    
    lambda = 3e8/frequency;
    
    %number of ambiguities in phase
    N = floor(baseline/lambda);
       
end

