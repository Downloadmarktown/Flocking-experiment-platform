function [NewPopulation]=CrossOver(DNASeed,PopNum)
%CrossOver Operator

NewPopulation=[];
LengthPop=length(DNASeed(1,:));
NumPop=length(DNASeed(:,1));

for i=1:PopNum/2                            %通过交叉产生新的100种方案
    
    DNAPosition=randperm(NumPop);%选择DNA
    DNA1=DNASeed(DNAPosition(1),:);
    DNA2=DNASeed(DNAPosition(2),:);
    
    CrossOverPosition=randperm(LengthPop);%选择交叉位置
    CrossOver1=min(CrossOverPosition(1:2));
    CrossOver2=max(CrossOverPosition(1:2));
    
    NewDNA1=DNA1;%执行交叉操作
    NewDNA2=DNA2;
    NewDNA1(CrossOver1:CrossOver2)=DNA2(CrossOver1:CrossOver2);
    NewDNA2(CrossOver1:CrossOver2)=DNA1(CrossOver1:CrossOver2);
    
    NewPopulation=[NewPopulation;NewDNA1;NewDNA2];
    
end

end