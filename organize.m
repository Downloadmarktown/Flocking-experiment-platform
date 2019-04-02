function yesorno = organize(p_fish,p_captor,i)      %判断有没有发现目标

yesorno = 0;
global  distent_detect;

    [num1,dim] = size(p_fish); 

    for j=1:num1
        if(((p_captor(i,1)-p_fish(j,1))^2+(p_captor(i,2)-p_fish(j,2))^2)^0.5 <  distent_detect )
            yesorno = 1;
        end
    end