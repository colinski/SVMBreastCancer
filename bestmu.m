%finderror.m
%Finds the error for a particular w and g
%Arguments:
%    train - training set
%    tune - tuning set
%Output:
%    mu - the best mu value between 0.5e-4 and 5e-4
function [mu] = bestmu(train,tune)
mu = 0.5e-4; best = inf; best_mu = mu;
while mu <= 5e-4
	[w,g,y,z,min,err] = solveQP(train,mu);
    [m,err] = finderror(w,g,tune);
    fprintf('mu = %d has %d misclassified points\n',mu,m);
	if (m < best)
		best = m; best_mu = mu;
	end
	mu = mu + 0.5e-4;
end
fprintf('the best mu is %d with %d misclassified points\n',best_mu,best);
mu = best_mu;
end

