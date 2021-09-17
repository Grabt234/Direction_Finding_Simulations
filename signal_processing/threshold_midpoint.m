function [index_of_frequency] = threshold_midpoint(frequency_indicies_x)
    

    %---
    %its been a long night - I am sorry that you have to read this
    %---
    
    %used to find presence of multiple signals
    continuous_bools = (diff(frequency_indicies_x)==1);
    
    %indicies of idicies of where continuity breaks - ie seperations
    %between signals
    [~, continuous_indicies] = find(continuous_bools == 0);
    
    removed_count = 0;
    index_of_frequency = zeros(0,0);
   
    %cutting into arrs of continuous indicies
    for i = 1:numel(continuous_indicies)
    
        %cutting continuous set of signal indicies out
        continuous_sig_indicies = frequency_indicies_x(1, ...
                                   1:continuous_indicies(i)-removed_count);
   
        removed_elements = length(continuous_sig_indicies);
        
        index_of_frequency = [index_of_frequency ...
                                    continuous_sig_indicies(:,ceil( end/2))];
        
        %counting how many indicies were removed
        removed_count = removed_count + removed_elements ;
        
        %removing counted set of indicies
        frequency_indicies_x = frequency_indicies_x(1, removed_elements +1:end);
        
      
    end
    
    continuous_sig_indicies = frequency_indicies_x(1, ...
                                 1:end);
                             
    if length(continuous_sig_indicies ) ~= 0
        
        index_of_frequency = [index_of_frequency ...
                        continuous_sig_indicies(:,ceil( end/2))];
                    
    end
    
end

