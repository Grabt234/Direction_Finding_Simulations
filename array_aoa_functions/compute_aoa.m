function aoa = compute_aoa(baseline, frequency, diff_phase)
    
    %---------------------------------------------------------------------
    %compute_aoa: somputes the angle of arival of a signal
    %---------------------------------------------------------------------
    %baseline  - baseline length in meters
    %frequency - frequency in hz
    %diff_phase   - differential phase between elements
    %---------------------------------------------------------------------
    
    lambda = 3e8/frequency;    
    
    %aoa is commonly denoted as theta
    
    aoa = asin(diff_phase*lambda/(baseline));
    
end

