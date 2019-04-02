function [move,die] = trapping(p_captor,p_fish,i,pattern_barrier,factors)

  %% 初始化

  distance_a = 1;
  distance_b = 2;    
  distance_c = 3;                     
% global  v ;                                  %机器人运动速度
%     flag1 = 0;                               %判断前进方向是否有障碍
    flag1 = 0;                               %判断个体周围是否有agent
    flag2 = 0;
    flag3 = 0;                              
    flag4 = 0;
    flag_barrier = 0;
    max_v = 0.5;                               %agent最大速度
    acceleration=zeros(5,2);                 %影响因子【远离目标，远离同类，跟随目标，跟随g3最大的,去密度低的方向，避障】
    factor=factors(1,:);                     %默认使用规则1
    [num2,dim] = size(p_captor); 
        xaxis = fix(p_captor(i,1)/0.25)+1;   %当前网格
        yaxis = fix(p_captor(i,2)/0.25)+1;
    %% 对在机器人距离a范围以内:远离，在ab之间：靠近
    for j=1:num2
        if(j~=i)                            %不判断自己
            distance_agentij = ((p_captor(i,1)-p_captor(j,1))^2+(p_captor(i,2)-p_captor(j,2))^2)^0.5;
            if(distance_agentij <= distance_a)                                          %如果在内圈1内:离内圈1越近力越小
                acceleration(1,1) = acceleration(1,1) + (distance_a - distance_agentij)*(p_captor(i,1)-p_captor(j,1))/distance_agentij;
                acceleration(1,2) = acceleration(1,2) + (distance_a - distance_agentij)*(p_captor(i,2)-p_captor(j,2))/distance_agentij;
                flag1 = flag1 + 1;
            elseif(distance_agentij > distance_a && distance_agentij < distance_b)      %在内圈1和外圈2之间：保持速度一致
                acceleration(2,1) = acceleration(2,1) + p_captor(j,4);
                acceleration(2,2) = acceleration(2,2) + p_captor(j,5);
                flag2 = flag2 + 1;
            elseif(distance_agentij >= distance_b && distance_agentij < distance_c)      %在内圈2和外圈3之间：离内圈2越近力越小
                acceleration(3,1) = acceleration(3,1) - (distance_agentij - distance_b)*(p_captor(i,1)-p_captor(j,1))/distance_agentij;
                acceleration(3,2) = acceleration(3,2) - (distance_agentij - distance_b)*(p_captor(i,2)-p_captor(j,2))/distance_agentij;
                flag3 = flag3 + 1;
            end
        end
    end
        if flag1 ~= 0                                              %如果在这个范围内都没有机器人：自己朝目标走
            acceleration(1,1) = acceleration(1,1)/flag1;
            acceleration(1,2) = acceleration(1,2)/flag1;
        end
        if flag2 ~= 0                                              %如果在这个范围内都没有机器人：自己朝目标走
            acceleration(2,1) = acceleration(2,1)/flag2;
            acceleration(2,2) = acceleration(2,2)/flag2;
        end
        if flag3 ~= 0                                              %如果在这个范围内都没有机器人：自己朝目标走
            acceleration(3,1) = acceleration(3,1)/flag3;
            acceleration(3,2) = acceleration(3,2)/flag3;
        end
    max = distance_a*flag1 + max_v*flag2 + (distance_c - distance_b)*flag3;       %求最大的速度
    %% 向目标前进 
    nearfish = near(p_fish, p_captor(i,1), p_captor(i,2));      %找最近的目标
    target_distance = ((p_captor(i,1)-p_fish(nearfish,1))^2+(p_captor(i,2)-p_fish(nearfish,2))^2)^0.5;
   % if(flag==0)         %首先不能在安全范围内，然后才能移动
        if(xaxis>0 && yaxis>0 && xaxis<101 && yaxis<101)
            acceleration(4,1) = acceleration(4,1) - (p_captor(i,1)-p_fish(nearfish,1))/target_distance;
            acceleration(4,2) = acceleration(4,2) - (p_captor(i,2)-p_fish(nearfish,2))/target_distance;
           % flag = flag + factor(3);
        else
            acceleration(4,1) = 0;
            acceleration(4,2) = 0;
        end
    %% 三原则  
    %求平均坐标和平均速度
%     if num2 > 1
%         average = mean(p_captor);
%     elseif num2 == 1
%         average = p_captor;
%     else
%         average = [0,0,0,0,0];
%     end
%     average_distance = ((p_captor(i,1)-average(1))^2+(p_captor(i,2)-average(2))^2)^0.5;
%     if(average_distance==0)
%         acceleration(4,1) = 0;
%         acceleration(4,2) = 0;
%     elseif(average_distance<0.5)                                %如果距离小于a，去中心相反方向
%         acceleration(4,1) = acceleration(4,1) + (p_captor(i,1)-average(1))/average_distance;
%         acceleration(4,2) = acceleration(4,2) + (p_captor(i,2)-average(2))/average_distance;
%     elseif(average_distance>=0.5 && average_distance<3)     %距离在ab之间，方向保持一致
%         acceleration(4,1) = average(4);
%         acceleration(4,2) = average(5);
%     else                                                    %距离在之外，去中心      
%         acceleration(4,1) = acceleration(4,1) - (p_captor(i,1)-average(1))/average_distance;
%         acceleration(4,2) = acceleration(4,2) - (p_captor(i,2)-average(2))/average_distance;
%     end
%         
    %% 根据各个速度求最终移动方向
    %规则设定:由是否存在周围agent、是否存在障碍物判断
    if(flag2 + flag4 == 0 && flag_barrier == 0)            %无个体无障碍
        factor=factors(1,:);                     
    elseif(flag2 + flag4 == 0 && flag_barrier == 1)        %无个体有障碍
        factor=factors(2,:);                     
    elseif(flag2 + flag4 ~= 0 && flag_barrier == 0)        %有个体无障碍
        factor=factors(3,:);                     
    elseif(flag2 + flag4 ~= 0 && flag_barrier == 1)        %有个体有障碍
        factor=factors(4,:);         
    end
    
    
    move = zeros(1,2);                  %给每个速度加权求和：算出不考虑障碍时的综合速度
    for p=1:4
        move = move + factor(p)*acceleration(p,:);
    end
    
    [a,die] = avoiding_die(p_captor,move,i,pattern_barrier,p_fish);
    acceleration(5,1) = a(1);
    acceleration(5,2) = a(2);
    if(a == move)                       %如果这两个值相等，说明没有遇到障碍
        flag_barrier = 0;
    else
        flag_barrier = 1;
    end
    
    %再判断一遍用哪个规则
    if(flag2 + flag4 == 0 && flag_barrier == 0)            %无个体无障碍
        factor=factors(1,:);                     
    elseif(flag2 + flag4 == 0 && flag_barrier == 1)        %无个体有障碍
        factor=factors(2,:);                     
    elseif(flag2 + flag4 ~= 0 && flag_barrier == 0)        %有个体无障碍
        factor=factors(3,:);                     
    elseif(flag2 + flag4 ~= 0 && flag_barrier == 1)        %有个体有障碍
        factor=factors(4,:);         
    end
    
     factor(5) = factor(5)*10;
    move = zeros(1,2);                  %加上避障后，给每个速度加权求和
    for p=1:5
        move = move + factor(p)*acceleration(p,:);
    end
    
    theta = atand(move(2)/move(1));     %求最终方向
    if (move(1)<0 )
        theta = theta +180;
    end
    
%      move1=move;
%       move(1) = max_v * ((move1(1)^2+move1(2)^2)^0.5)/max * cosd(theta);          %求最终速度
%       move(2) = max_v * ((move1(1)^2+move1(2)^2)^0.5)/max * sind(theta);
    move(1) = max_v * cosd(theta);          %求最终速度
    move(2) = max_v * sind(theta);
     
    
    
    
    





