%all credit to original author, Michael Ferris!

function [train,tune,test] = getdata(datafile,dataDim)
% syntax: [train,tune,test] = getdata(datafile,dataDim)
% extract data from the database
% here, datafile should be a string, eg 'wdbc.data'
%       dataDim is a scalar, eg 30

% first check input data
if (nargin < 2) 
  error('two input arguments are required to getdata');
end
if (~ischar(datafile))
  error('first argument must be a string');
end
if (isnumeric(dataDim)&max(size(dataDim))==1)
  if (isempty(dataDim)) 
    error('second argument must be a scalar');
  elseif (dataDim <= 0) 
    error('second argument must be a positive integer');
  end
else
  error('second argument must be a positive number');
end
    
fp = fopen(datafile,'r');
samples = 0;
train = zeros(0,dataDim+1);
[id,count] = fscanf(fp,'%d',1);
while (count == 1) 
  samples = samples + 1;
  throw = fscanf(fp,',');
  categ = fscanf(fp,'%1s',1);
  vec = fscanf(fp,',%f',dataDim);
%  keyboard,
  train = [train; abs(categ) vec'];
  [id,count] = fscanf(fp,'%d,',1);
end
if (samples < 569) 
  error('Not enough samples');
end
tdata = 1:369; features = 2:dataDim+1;
% now whiten data (subtract mean and divide by 2*SD)
m = mean(train(tdata,features)); sd = std(train(tdata,features));
train(:,features) = (train(:,features)-ones(size(train,1),1)*m)*diag(1./sd);
% now split into tuning, testing and training
tune = train(370:469,:);
test = train(470:end,:);
train = train(tdata,:);
return;
