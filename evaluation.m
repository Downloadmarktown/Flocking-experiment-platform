function [NewBestSolution,NewBestFit,DNASeed]=evaluation(Population,Result,OldBestFit,OldBestSolution,SeedNum)
%����ȫ�����Ž⣬�����Ӧ�Ⱥ����Լ���һ�׶ε�DNA seed

DNASeed=[];

[NewBestFit,P]=min(Result);             %NewBestFit:ÿ����Сֵ��P����Сֵ����

if NewBestFit<=OldBestFit          %����������
    
    NewBestSolution=Population(P,:);
    
else
    
    NewBestSolution=OldBestSolution;
    NewBestFit=OldBestFit;
    
end

SortRes=sort(Result);                   %ѡ����һ�׶ε�Seed:��С��������

for i=1:SeedNum
    
    NextDNA=find(Result==SortRes(i),1); %�ҵ����ӵ�����
    DNASeed=[DNASeed;Population(NextDNA,:)];%�����ӷ���DNASeed����
    Result(NextDNA)=Inf;                %���н����Ϊ����
    
end

end