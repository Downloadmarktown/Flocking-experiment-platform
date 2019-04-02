%GA Main
%Population=[DNA1;DNA2;DNA3����];
%DNA=[V1,V2,V3,V4����];���ǵĲ���
 clear all;
 clc;
 close all;

%[Population]=initialSolution();%������ʼ��Ⱥ�������ô�������ǿ���Ҫ����һ��
PopNum=30;%������Ⱥ�еĸ����������ɱ�
DNALength=20;%������Ⱥ�еĸ���ĳ��ȣ���Ӧ�����Ǳߵ�20������


Population=initial(PopNum,DNALength);



%�㷨��������
count=0;
MaxCount=50;%���ĵ����Ĵ���
SeedNum=20;%���ڲ�����һ�������ӵ�����
MuaRate=0.3;%��Ա�ı�����

%��ʼ��
BestFit=Inf;
BestSolution=[];

IteBest=[];

tic

while count<MaxCount
    
    count
    
    Res=[];
    
    for i=1:PopNum
        i
    
        Result = SubCheck(Population(i,:));%��������Ҫд�ģ�����������һ�������ľ������һ��Check�Ľ��
        
        Res=[Res;Result];
        
    
    end
    
    %Result=rand(100,1);
    
    [BestSolution,BestFit,DNAseed]=evaluation(Population,Res,BestFit,BestSolution,SeedNum);%ѡ����һ�������ӣ����������Ž�
    
    IteBest=[IteBest;count,BestFit];
    
    [Population]=CrossOver(DNAseed,PopNum);%�������
    
    [Population]=Mutation(Population,MuaRate);%�������
    
    count=count+1;
    
end

plot(IteBest(:,1),IteBest(:,2));

toc