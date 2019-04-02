function [move,die] = non_trapping(p_captor,p_fish,i,pattern_barrier)
  %% 初始化
global  distent_detect;
global  distent_fish;                        %与目标的安全距离
global  distent_capter;                      %与其他机器人的安全距离
global  v ;                                  %机器人运动速度
    flag1 = 0;                               %系数：是否存在这种情况
    flag2 = 0;
    flag3 = 0;
    
    acceleration=zeros(6,2);                 %影响因子【远离目标，远离同类，跟随目标，跟随g3最大的,去密度低的方向，避障】
    factors=[1,1,1,10;
            1,1,0,10;
            0,0,1,10];               
        
    factor=factors(1,:);                     %默认使用规则1
  %  factor=[1 1 1 0 0.5];                         %影响因子【远离目标，远离同类，跟随目标，跟随g3最大的,去密度低的方向】
    [num1,dim] = size(p_fish); 
    [num2,dim] = size(p_captor);
    %% 在目标安全距离以内:立即远离
    for j=1:num1
        if(((p_captor(i,1)-p_fish(j,1))^2+(p_captor(i,2)-p_fish(j,2))^2)^0.5 <  distent_fish )
            acceleration(1,1) = acceleration(1,1) + (p_captor(i,1)-p_fish(j,1))/((p_captor(i,1)-p_fish(j,1))^2+(p_captor(i,2)-p_fish(j,2))^2)^0.5;
            acceleration(1,2) = acceleration(1,2) + (p_captor(i,2)-p_fish(j,2))/((p_captor(i,1)-p_fish(j,1))^2+(p_captor(i,2)-p_fish(j,2))^2)^0.5;  
            flag1 = flag1 + 1;
        end
    end
        if flag1~=0                                              %如果存在:加速度归一
                acceleration(1,1) = acceleration(1,1)/flag1/2;
                acceleration(1,2) = acceleration(1,2)/flag1/2;
                factor=factors(2,:);                             %使用规则2
        end
    
%% 在周围机器人安全距离以内:立即远离     
    for j=1:num2
        if(j~=i)                            %不判断自己
            if(((p_captor(i,1)-p_captor(j,1))^2+(p_captor(i,2)-p_captor(j,2))^2)^0.5 < distent_capter)
                acceleration(2,1) = acceleration(2,1) + (p_captor(i,1)-p_captor(j,1))/((p_captor(i,1)-p_captor(j,1))^2+(p_captor(i,2)-p_captor(j,2))^2)^0.5;
                acceleration(2,2) = acceleration(2,2) + (p_captor(i,2)-p_captor(j,2))/((p_captor(i,1)-p_captor(j,1))^2+(p_captor(i,2)-p_captor(j,2))^2)^0.5;
                flag2 = flag2 + 1;
            end
        end
    end
        if flag2~=0                                              %如果存在
            acceleration(2,1) = acceleration(2,1)/flag2/2;
            acceleration(2,2) = acceleration(2,2)/flag2/2;
            factor=factors(2,:);                             %使用规则2
        end
        
%% 在探测范围内：跟随，等于邻居们的方向矢量和
%if(flag==0)
        for j=1:num2
            if(j~=i && (p_captor(j,3)==2)    )                            %不判断自己，并且只跟随组织机器人
                if(((p_captor(i,1)-p_captor(j,1))^2+(p_captor(i,2)-p_captor(j,2))^2)^0.5 < distent_detect)
                    acceleration(3,1) = acceleration(3,1) + p_captor(j,4);
                    acceleration(3,2) = acceleration(3,2) + p_captor(j,5);
                    flag3 = flag3 + 1;
                end
            end
        end
        if flag3~=0;
            acceleration(3,1)=acceleration(1)/flag3;               
            acceleration(3,2)=acceleration(2)/flag3;
        end
%end


    %% 根据各个速度求最终移动方向
    move = zeros(1,2);                  %给每个速度加权求和
    for p=1:3
        move = move + factor(p)*acceleration(p,:);
    end

    
    [a,die] = avoiding_die(p_captor,move,i,pattern_barrier,p_fish);
    acceleration(6,1) = a(1);
    acceleration(6,2) = a(2);
    
    move = zeros(1,2);                  %加上避障后，给每个速度加权求和
    for p=1:4
        move = move + factor(p)*acceleration(p,:);
    end

    
    theta = atand(move(2)/move(1));     %求最终方向
    if (move(1)<0 )
        theta = theta +180;
    end
    move(1) = v * cosd(theta);          %求最终速度
    move(2) = v * sind(theta);
    