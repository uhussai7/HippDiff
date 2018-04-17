function noNaN= rmNaN(hasNaN)

%just set nans to zero
A=isnan(hasNaN);
hasNaN(A)=0;
noNaN=hasNaN;
end
