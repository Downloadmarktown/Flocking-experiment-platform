function [NewPopulation]=Mutation(Population,MuaRate)
%Muatation Operator

PopulationNum=length(Population(:,1));
PopLength=length(Population(1,:));

%Value=[0.1:0.1:1];

for i=1:PopulationNum               %��ÿ�ַ������ʲ���һ�α���
    
    if rand()<MuaRate
        
        MuaPos=ceil(rand()*PopLength);
        MuaValue=ceil(rand()*10)/10;
        
        Population(i,MuaPos)=MuaValue;
    
    end
    
end

NewPopulation=Population;

end