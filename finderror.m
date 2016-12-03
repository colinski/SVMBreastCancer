%finderror.m
%Finds the error for a particular w and g
%Arguments:
%    w,g - values that define the dividing plane
%   data - data set of interest (train, test, or tune)
%Output:
%    m - the number of misclassified points
%    p - the percent accuracy
function [m,p] = finderror(w,g,data)
count = 0;
for i=1:length(data)
    fx = w'*data(i,2:end)' - g;
    if (fx > 0)
        guess = 'M';
    else
        guess = 'B';
    end
    if (guess == data(i,1))
        count = count + 1;
    end
end
m = length(data)-count;
p = count/length(data);
end

