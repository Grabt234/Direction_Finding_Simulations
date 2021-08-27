%frequency of interest
foi = 18e9;
%linear array for x
pos_elements = [0 0.0083 0.0125 0.025]; %meters

course_baseline = select_baseline(pos_elements, foi)
fine_baseline = max(pos_elements)