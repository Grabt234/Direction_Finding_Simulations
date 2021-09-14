function [count, true_index_indicies] = check_false_alarm(I_known, I_found)
    
    %---------------------------------------------------------------------
    %check_false_alarm: checking for, coounting and removing false alarms
    %---------------------------------------------------------------------
    %I_known - incies know frequencies
    %I_found - indicies of values the were higher than threshold
    %---------------------------------------------------------------------
    
    %finding value closes to course aoa
    distance = abs(I_found - I_known.');
    
    %so the variable can be used
    true_index_indicies = [];

    for i = 1:size(distance)
        
        %not all frequencies are present, therefore dynamic size
        %finding indicies of frequency that have broken thresholds
        true_index_indicies = [ true_index_indicies ...
                                    find(distance(1,:) == 0)];

    end
    
    %how many additional frequencies that were not supposed to be there
    count = length(I_found) - length(I_known);
end

