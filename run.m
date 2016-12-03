[train,tune,test] = getdata('wdbc.data',30);
mu = bestmu(train,tune)
[w,g,y,z,min,err] = solveQP(train,mu);
[m,p] = finderror(w,g,test);
fprintf('num misclassified points in test set with mu = %d is %d\n',mu,m);
fprintf('testing set error is %f\n',p);

