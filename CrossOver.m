function [NewPopulation]=CrossOver(DNASeed,PopNum)
%CrossOver Operator

NewPopulation=[];
LengthPop=length(DNASeed(1,:));
NumPop=length(DNASeed(:,1));

for i=1:PopNum/2                            %ͨ����������µ�100�ַ���
    
    DNAPosition=randperm(NumPop);%ѡ��DNA
    DNA1=DNASeed(DNAPosition(1),:);
    DNA2=DNASeed(DNAPosition(2),:);
    
    CrossOverPosition=randperm(LengthPop);%ѡ�񽻲�λ��
    CrossOver1=min(CrossOverPosition(1:2));
    CrossOver2=max(CrossOverPosition(1:2));
    
    NewDNA1=DNA1;%ִ�н������
    NewDNA2=DNA2;
    NewDNA1(CrossOver1:CrossOver2)=DNA2(CrossOver1:CrossOver2);
    NewDNA2(CrossOver1:CrossOver2)=DNA1(CrossOver1:CrossOver2);
    
    NewPopulation=[NewPopulation;NewDNA1;NewDNA2];
    
end

end