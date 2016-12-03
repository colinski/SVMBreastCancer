%Determines the best pair of features
[train,tune,test] = getdata('wdbc.data',30);
best = inf; best_i = 0; best_j = 0; best_w = zeros(2,1); best_g = 0;
for i=2:31
    for j=i+1:31
        %1st column of A contains the classification information
        A = [train(:,1) train(:,i) train(:,j)]; 
        [w,g,y,z,min,err] = solveQP(A,1.5e-4);
        [m,p] = finderror(w,g,[tune(:,1) tune(:,i) tune(:,j)]);
        if (m < best)
            best = m; best_i = i; best_j = j; best_w = w; best_g = g;
        end
        fprintf('atts %2d %2d: misclass %3d\n',i-1,j-1,m);
    end
end
