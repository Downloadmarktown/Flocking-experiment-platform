function [NewBestSolution,NewBestFit,DNASeed]=evaluation(Population,Result,OldBestFit,OldBestSolution,SeedNum)
%更新全局最优解，解得适应度函数以及下一阶段的DNA seed

DNASeed=[];

[NewBestFit,P]=min(Result);             %NewBestFit:每列最小值，P：最小值行数

if NewBestFit<=OldBestFit          %如果结果更优
    
    NewBestSolution=Population(P,:);
    
else
    
    NewBestSolution=OldBestSolution;
    NewBestFit=OldBestFit;
    
end

SortRes=sort(Result);                   %选择下一阶段的Seed:从小到大排列

for i=1:SeedNum
    
    NextDNA=find(Result==SortRes(i),1); %找到种子的行数
    DNASeed=[DNASeed;Population(NextDNA,:)];%将种子放入DNASeed矩阵
    Result(NextDNA)=Inf;                %该行结果设为无穷
    
end

end