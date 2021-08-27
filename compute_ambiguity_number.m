function M = compute_ambiguity_number(baseline, frequency)
    
    %---------------------------------------------------------------------
    %compute_ambiguity_number: computes number of uncertainties for a given
    %                               mesurement
    %---------------------------------------------------------------------
    %baseline  - baseline length in meters
    %frequency - frequency in hz
    %---------------------------------------------------------------------
    
    lambda = 3e8/frequency;
    %number of ambiguities in phase
    M = 2*baseline/lambda;
    %Weiss-Weinstein lower bound estimate (?)
    M = floor(M);
    
end

