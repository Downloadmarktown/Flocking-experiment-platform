%GA Main
%Population=[DNA1;DNA2;DNA3……];
%DNA=[V1,V2,V3,V4……];你们的参数
 clear all;
 clc;
 close all;

%[Population]=initialSolution();%产生初始种群，这个怎么产生我们可能要商量一下
PopNum=30;%这是种群中的个体数量，可变
DNALength=20;%这是种群中的个体的长度，对应你们那边的20个参数


Population=initial(PopNum,DNALength);



%算法基本参数
count=0;
MaxCount=50;%最大的迭代的次数
SeedNum=20;%用于产生下一代的种子的数量
MuaRate=0.3;%成员的变异率

%初始化
BestFit=Inf;
BestSolution=[];

IteBest=[];

tic

while count<MaxCount
    
    count
    
    Res=[];
    
    for i=1:PopNum
        i
    
        Result = SubCheck(Population(i,:));%这是你们要写的，给你们输入一个参数的矩阵，输出一个Check的结果
        
        Res=[Res;Result];
        
    
    end
    
    %Result=rand(100,1);
    
    [BestSolution,BestFit,DNAseed]=evaluation(Population,Res,BestFit,BestSolution,SeedNum);%选择下一代的种子，并更新最优解
    
    IteBest=[IteBest;count,BestFit];
    
    [Population]=CrossOver(DNAseed,PopNum);%交叉操作
    
    [Population]=Mutation(Population,MuaRate);%变异操作
    
    count=count+1;
    
end

plot(IteBest(:,1),IteBest(:,2));

toc