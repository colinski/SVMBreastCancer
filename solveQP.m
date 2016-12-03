%solveQP.m
%Solves the QP as described in the handout
%Arguments:
%    A - training data that can be split into M and B
%   mu - tuning factor
%Output:
%    w,g,y,z - solution to the QP
%    Note: w,g determine the best dividing plane w'x = g
%    min - the minimal objective value of the QP
%    err - the testing set error, e'y+e'z
function [w,g,y,z,min,err] = solveQP(A,mu)
%split the data into M and B
M = []; B = [];
for i = 1:length(A)
    if A(i,1) == 'B'
        B = [B; A(i,2:end)];
    else
        M = [M; A(i,2:end)];
    end
end
[m,n] = size(M);
[k,n] = size(B);

%setup Q and c
Q = zeros(n+m+k+1);
Q(1:n,1:n) = mu*eye(n);
c = [zeros(n+1,1); (ones(m,1)./m); (ones(k,1)./k)];

%setup H and h (using -H and -h in order to flip >= to <=)
H = -[M -ones(m,1) eye(m) zeros(m,k);
    -B ones(k,1) zeros(k,m) eye(k)];
h = -ones(m+k,1);

%setup the upper and lower bound, note that w,g are free
lb = [-inf*ones(n,1); -inf; zeros(m,1); zeros(k,1)];
ub = inf*ones(n+k+m+1,1);

%solve the QP and extract w,g,y,z
options = optimoptions('quadprog');
options.Display = 'off';
sol = quadprog(Q,c,H,h,[],[],lb,ub,[],options);
w = sol(1:n);
g = sol(n+1);
y = sol(n+2:n+m+1);
z = sol(n+m+2:end);
err = ones(m,1)'*y + ones(k,1)'*z;

%calculate the objective value at the solution
min = c'*sol + .5*sol'*Q*sol;
end

