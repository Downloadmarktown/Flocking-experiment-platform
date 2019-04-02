function [move,die] = trapping(p_captor,p_fish,i,pattern_barrier,factors)

  %% ��ʼ��

  distance_a = 1;
  distance_b = 2;    
  distance_c = 3;                     
% global  v ;                                  %�������˶��ٶ�
%     flag1 = 0;                               %�ж�ǰ�������Ƿ����ϰ�
    flag1 = 0;                               %�жϸ�����Χ�Ƿ���agent
    flag2 = 0;
    flag3 = 0;                              
    flag4 = 0;
    flag_barrier = 0;
    max_v = 0.5;                               %agent����ٶ�
    acceleration=zeros(5,2);                 %Ӱ�����ӡ�Զ��Ŀ�꣬Զ��ͬ�࣬����Ŀ�꣬����g3����,ȥ�ܶȵ͵ķ��򣬱��ϡ�
    factor=factors(1,:);                     %Ĭ��ʹ�ù���1
    [num2,dim] = size(p_captor); 
        xaxis = fix(p_captor(i,1)/0.25)+1;   %��ǰ����
        yaxis = fix(p_captor(i,2)/0.25)+1;
    %% ���ڻ����˾���a��Χ����:Զ�룬��ab֮�䣺����
    for j=1:num2
        if(j~=i)                            %���ж��Լ�
            distance_agentij = ((p_captor(i,1)-p_captor(j,1))^2+(p_captor(i,2)-p_captor(j,2))^2)^0.5;
            if(distance_agentij <= distance_a)                                          %�������Ȧ1��:����Ȧ1Խ����ԽС
                acceleration(1,1) = acceleration(1,1) + (distance_a - distance_agentij)*(p_captor(i,1)-p_captor(j,1))/distance_agentij;
                acceleration(1,2) = acceleration(1,2) + (distance_a - distance_agentij)*(p_captor(i,2)-p_captor(j,2))/distance_agentij;
                flag1 = flag1 + 1;
            elseif(distance_agentij > distance_a && distance_agentij < distance_b)      %����Ȧ1����Ȧ2֮�䣺�����ٶ�һ��
                acceleration(2,1) = acceleration(2,1) + p_captor(j,4);
                acceleration(2,2) = acceleration(2,2) + p_captor(j,5);
                flag2 = flag2 + 1;
            elseif(distance_agentij >= distance_b && distance_agentij < distance_c)      %����Ȧ2����Ȧ3֮�䣺����Ȧ2Խ����ԽС
                acceleration(3,1) = acceleration(3,1) - (distance_agentij - distance_b)*(p_captor(i,1)-p_captor(j,1))/distance_agentij;
                acceleration(3,2) = acceleration(3,2) - (distance_agentij - distance_b)*(p_captor(i,2)-p_captor(j,2))/distance_agentij;
                flag3 = flag3 + 1;
            end
        end
    end
        if flag1 ~= 0                                              %����������Χ�ڶ�û�л����ˣ��Լ���Ŀ����
            acceleration(1,1) = acceleration(1,1)/flag1;
            acceleration(1,2) = acceleration(1,2)/flag1;
        end
        if flag2 ~= 0                                              %����������Χ�ڶ�û�л����ˣ��Լ���Ŀ����
            acceleration(2,1) = acceleration(2,1)/flag2;
            acceleration(2,2) = acceleration(2,2)/flag2;
        end
        if flag3 ~= 0                                              %����������Χ�ڶ�û�л����ˣ��Լ���Ŀ����
            acceleration(3,1) = acceleration(3,1)/flag3;
            acceleration(3,2) = acceleration(3,2)/flag3;
        end
    max = distance_a*flag1 + max_v*flag2 + (distance_c - distance_b)*flag3;       %�������ٶ�
    %% ��Ŀ��ǰ�� 
    nearfish = near(p_fish, p_captor(i,1), p_captor(i,2));      %�������Ŀ��
    target_distance = ((p_captor(i,1)-p_fish(nearfish,1))^2+(p_captor(i,2)-p_fish(nearfish,2))^2)^0.5;
   % if(flag==0)         %���Ȳ����ڰ�ȫ��Χ�ڣ�Ȼ������ƶ�
        if(xaxis>0 && yaxis>0 && xaxis<101 && yaxis<101)
            acceleration(4,1) = acceleration(4,1) - (p_captor(i,1)-p_fish(nearfish,1))/target_distance;
            acceleration(4,2) = acceleration(4,2) - (p_captor(i,2)-p_fish(nearfish,2))/target_distance;
           % flag = flag + factor(3);
        else
            acceleration(4,1) = 0;
            acceleration(4,2) = 0;
        end
    %% ��ԭ��  
    %��ƽ�������ƽ���ٶ�
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
%     elseif(average_distance<0.5)                                %�������С��a��ȥ�����෴����
%         acceleration(4,1) = acceleration(4,1) + (p_captor(i,1)-average(1))/average_distance;
%         acceleration(4,2) = acceleration(4,2) + (p_captor(i,2)-average(2))/average_distance;
%     elseif(average_distance>=0.5 && average_distance<3)     %������ab֮�䣬���򱣳�һ��
%         acceleration(4,1) = average(4);
%         acceleration(4,2) = average(5);
%     else                                                    %������֮�⣬ȥ����      
%         acceleration(4,1) = acceleration(4,1) - (p_captor(i,1)-average(1))/average_distance;
%         acceleration(4,2) = acceleration(4,2) - (p_captor(i,2)-average(2))/average_distance;
%     end
%         
    %% ���ݸ����ٶ��������ƶ�����
    %�����趨:���Ƿ������Χagent���Ƿ�����ϰ����ж�
    if(flag2 + flag4 == 0 && flag_barrier == 0)            %�޸������ϰ�
        factor=factors(1,:);                     
    elseif(flag2 + flag4 == 0 && flag_barrier == 1)        %�޸������ϰ�
        factor=factors(2,:);                     
    elseif(flag2 + flag4 ~= 0 && flag_barrier == 0)        %�и������ϰ�
        factor=factors(3,:);                     
    elseif(flag2 + flag4 ~= 0 && flag_barrier == 1)        %�и������ϰ�
        factor=factors(4,:);         
    end
    
    
    move = zeros(1,2);                  %��ÿ���ٶȼ�Ȩ��ͣ�����������ϰ�ʱ���ۺ��ٶ�
    for p=1:4
        move = move + factor(p)*acceleration(p,:);
    end
    
    [a,die] = avoiding_die(p_captor,move,i,pattern_barrier,p_fish);
    acceleration(5,1) = a(1);
    acceleration(5,2) = a(2);
    if(a == move)                       %���������ֵ��ȣ�˵��û�������ϰ�
        flag_barrier = 0;
    else
        flag_barrier = 1;
    end
    
    %���ж�һ�����ĸ�����
    if(flag2 + flag4 == 0 && flag_barrier == 0)            %�޸������ϰ�
        factor=factors(1,:);                     
    elseif(flag2 + flag4 == 0 && flag_barrier == 1)        %�޸������ϰ�
        factor=factors(2,:);                     
    elseif(flag2 + flag4 ~= 0 && flag_barrier == 0)        %�и������ϰ�
        factor=factors(3,:);                     
    elseif(flag2 + flag4 ~= 0 && flag_barrier == 1)        %�и������ϰ�
        factor=factors(4,:);         
    end
    
     factor(5) = factor(5)*10;
    move = zeros(1,2);                  %���ϱ��Ϻ󣬸�ÿ���ٶȼ�Ȩ���
    for p=1:5
        move = move + factor(p)*acceleration(p,:);
    end
    
    theta = atand(move(2)/move(1));     %�����շ���
    if (move(1)<0 )
        theta = theta +180;
    end
    
%      move1=move;
%       move(1) = max_v * ((move1(1)^2+move1(2)^2)^0.5)/max * cosd(theta);          %�������ٶ�
%       move(2) = max_v * ((move1(1)^2+move1(2)^2)^0.5)/max * sind(theta);
    move(1) = max_v * cosd(theta);          %�������ٶ�
    move(2) = max_v * sind(theta);
     
    
    
    
    





