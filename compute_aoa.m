function aoa = compute_aoa(baseline, frequency, delta_p)
    
    %---------------------------------------------------------------------
    %compute_aoa: somputes the angle of arival of a signal
    %---------------------------------------------------------------------
    %baseline  - baseline length in meters
    %frequency - frequency in hz
    %delta_p   - differential phase between elements
    %---------------------------------------------------------------------
    
    lambda = 3e8/frequency;
    %aoa is commonly denoted as theta
    aoa = asin(delta_p*lambda/(2*pi*baseline));
    
end

