function [move,die] = non_trapping(p_captor,p_fish,i,pattern_barrier)
  %% ��ʼ��
global  distent_detect;
global  distent_fish;                        %��Ŀ��İ�ȫ����
global  distent_capter;                      %�����������˵İ�ȫ����
global  v ;                                  %�������˶��ٶ�
    flag1 = 0;                               %ϵ�����Ƿ�����������
    flag2 = 0;
    flag3 = 0;
    
    acceleration=zeros(6,2);                 %Ӱ�����ӡ�Զ��Ŀ�꣬Զ��ͬ�࣬����Ŀ�꣬����g3����,ȥ�ܶȵ͵ķ��򣬱��ϡ�
    factors=[1,1,1,10;
            1,1,0,10;
            0,0,1,10];               
        
    factor=factors(1,:);                     %Ĭ��ʹ�ù���1
  %  factor=[1 1 1 0 0.5];                         %Ӱ�����ӡ�Զ��Ŀ�꣬Զ��ͬ�࣬����Ŀ�꣬����g3����,ȥ�ܶȵ͵ķ���
    [num1,dim] = size(p_fish); 
    [num2,dim] = size(p_captor);
    %% ��Ŀ�갲ȫ��������:����Զ��
    for j=1:num1
        if(((p_captor(i,1)-p_fish(j,1))^2+(p_captor(i,2)-p_fish(j,2))^2)^0.5 <  distent_fish )
            acceleration(1,1) = acceleration(1,1) + (p_captor(i,1)-p_fish(j,1))/((p_captor(i,1)-p_fish(j,1))^2+(p_captor(i,2)-p_fish(j,2))^2)^0.5;
            acceleration(1,2) = acceleration(1,2) + (p_captor(i,2)-p_fish(j,2))/((p_captor(i,1)-p_fish(j,1))^2+(p_captor(i,2)-p_fish(j,2))^2)^0.5;  
            flag1 = flag1 + 1;
        end
    end
        if flag1~=0                                              %�������:���ٶȹ�һ
                acceleration(1,1) = acceleration(1,1)/flag1/2;
                acceleration(1,2) = acceleration(1,2)/flag1/2;
                factor=factors(2,:);                             %ʹ�ù���2
        end
    
%% ����Χ�����˰�ȫ��������:����Զ��     
    for j=1:num2
        if(j~=i)                            %���ж��Լ�
            if(((p_captor(i,1)-p_captor(j,1))^2+(p_captor(i,2)-p_captor(j,2))^2)^0.5 < distent_capter)
                acceleration(2,1) = acceleration(2,1) + (p_captor(i,1)-p_captor(j,1))/((p_captor(i,1)-p_captor(j,1))^2+(p_captor(i,2)-p_captor(j,2))^2)^0.5;
                acceleration(2,2) = acceleration(2,2) + (p_captor(i,2)-p_captor(j,2))/((p_captor(i,1)-p_captor(j,1))^2+(p_captor(i,2)-p_captor(j,2))^2)^0.5;
                flag2 = flag2 + 1;
            end
        end
    end
        if flag2~=0                                              %�������
            acceleration(2,1) = acceleration(2,1)/flag2/2;
            acceleration(2,2) = acceleration(2,2)/flag2/2;
            factor=factors(2,:);                             %ʹ�ù���2
        end
        
%% ��̽�ⷶΧ�ڣ����棬�����ھ��ǵķ���ʸ����
%if(flag==0)
        for j=1:num2
            if(j~=i && (p_captor(j,3)==2)    )                            %���ж��Լ�������ֻ������֯������
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


    %% ���ݸ����ٶ��������ƶ�����
    move = zeros(1,2);                  %��ÿ���ٶȼ�Ȩ���
    for p=1:3
        move = move + factor(p)*acceleration(p,:);
    end

    
    [a,die] = avoiding_die(p_captor,move,i,pattern_barrier,p_fish);
    acceleration(6,1) = a(1);
    acceleration(6,2) = a(2);
    
    move = zeros(1,2);                  %���ϱ��Ϻ󣬸�ÿ���ٶȼ�Ȩ���
    for p=1:4
        move = move + factor(p)*acceleration(p,:);
    end

    
    theta = atand(move(2)/move(1));     %�����շ���
    if (move(1)<0 )
        theta = theta +180;
    end
    move(1) = v * cosd(theta);          %�������ٶ�
    move(2) = v * sind(theta);
    