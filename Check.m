%function Result = Check(Population)


Population=ones(100,18);

tic;
[num,dim] = size(Population); 
  
for i=1:num
    Result(i,:) = SubCheck(Population(i,:));
end
%factors=[1,1,1,1,1,1,   1,1,0,0,0,1,   0,0,1,1,1,1];       %测试：输入矩阵返回评价指标
%Result(1,:) = SubCheck(factors);
t=toc;