function [Ini]=initial(PopNum,DNALength)

Ini=zeros(PopNum,DNALength);

for i=1:PopNum
    
    for j=1:DNALength
        
        DNA=randperm(10);
        
        Ini(i,j)=DNA(1)/10;
        
    end
    
end        

end