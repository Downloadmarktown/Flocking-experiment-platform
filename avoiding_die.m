function [move,die] = avoiding_die(p_captor,move,i,barrier,p_fish)
%% ����
global v ;                                  %�������˶��ٶ�
global distent_fish;
[num1,dim] = size(p_fish); 
[num2,dim] = size(p_captor); 
thetax = atand(move(2)/move(1));            %��ǰ�˶�����
if (move(1)<0 )
    thetax = thetax +180;
end
move1=move;                                 %��¼��ʼ�ƶ�����
flag_left=0;                                    %��¼����̽������
flag_right=0;
flag_safe = 0;
distent_avoid = 0.5;                     %̽�����
max_pattern = 0;
die = 0;                                   %�ж���û�б��ϰ�ѹ��

%����Խ��
if (p_captor(i,1)-distent_avoid)/0.25>1 && (p_captor(i,1)+distent_avoid)/0.25<100 &&...
        (p_captor(i,2)-distent_avoid)/0.25>1 && (p_captor(i,2)+distent_avoid)/0.25<100
%% ����ѡ��ѭ���ķ���
if(barrier(round((p_captor(i,1)+cosd(thetax)*distent_avoid)/0.25),round((p_captor(i,2)+sind(thetax)*distent_avoid)/0.25))>max_pattern)
         thetax1=thetax+30;             %�������������ֵ���������ı�ƫ
         thetax2=thetax-30;
         barrier1=barrier(round((p_captor(i,1)+cosd(thetax1)*distent_avoid)/0.25),round((p_captor(i,2)+sind(thetax1)*distent_avoid)/0.25));
         barrier2=barrier(round((p_captor(i,1)+cosd(thetax2)*distent_avoid)/0.25),round((p_captor(i,2)+sind(thetax2)*distent_avoid)/0.25));
         if(barrier1>barrier2)
             flag_right = 1;
         else
             flag_left = 1;
         end
end
%% ������Ʒ���
   while(barrier(round((p_captor(i,1)+cosd(thetax)*distent_avoid)/0.25),round((p_captor(i,2)+sind(thetax)*distent_avoid)/0.25))>max_pattern...
           || flag_safe == 1) 
       
         flag_safe = 0;
         thetax1=thetax+30;             %�������������ֵ���������ı�ƫ
         thetax2=thetax-30;
         barrier1=barrier(round((p_captor(i,1)+cosd(thetax1)*distent_avoid)/0.25),round((p_captor(i,2)+sind(thetax1)*distent_avoid)/0.25));
         barrier2=barrier(round((p_captor(i,1)+cosd(thetax2)*distent_avoid)/0.25),round((p_captor(i,2)+sind(thetax2)*distent_avoid)/0.25));
         
         if(flag_left > 0 )                  %���Ũ�ȸߣ�����
            move(1)=cosd(thetax1)*v;
            move(2)=sind(thetax1)*v;
            thetax=thetax1;
            min_direct(flag_left) = barrier2;
            flag_left = flag_left + 1;
            
            if(flag_left>12)                        %�����û�г�·������С�ķ�����
        %        [a,b]=min(min_direct);
        %        thetax = atand(move1(2)/move1(1));
        %        if (move1(1)<0 )
        %            thetax = thetax +180;
        %        end
        %        move(1)=cosd(thetax+b*30)*v;
        %        move(2)=sind(thetax+b*30)*v;
                
                die = 1;
                break;
            end
            
         else
            move(1)=cosd(thetax2)*v;
            move(2)=sind(thetax2)*v;
            thetax=thetax2;
            min_direct(flag_right) = barrier1;
            flag_right = flag_right + 1;
            if(flag_right>12)                        %�����û�г�·������С�ķ�����
              %  [a,b]=min(min_direct);
              %  thetax = atand(move1(2)/move1(1));
              %  if (move1(1)<0 )
              %      thetax = thetax +180;
              %  end
              %  move(1)=cosd(thetax-b*30)*v;
              %  move(2)=sind(thetax-b*30)*v;
              %  break;
              die = 1;
              break;
            end
         end
         
%         for j=1:num2                            %����ı䷽������ڻ����˰�ȫ��Χ֮�ڵ�:��ѭ��
%             if(j~=i)                            %���ж��Լ�
%                 if(((p_captor(i,1)+move(1)-p_captor(j,1))^2+(p_captor(i,2)+move(2)-p_captor(j,2))^2)^0.5 < 0.25)
%                   flag_safe = 1;
%                  break;
%                 end
%             end
%         end
%         for j=1:num1
%             if(((p_captor(i,1)+move(1)-p_fish(j,1))^2+(p_captor(i,2)+move(2)-p_fish(j,2))^2)^0.5 <  distent_fish )
%                  flag_safe = 1;
%                  break;
%             end
%         end
   end
   %% ������һ���켣
         %hold on;
         %line([p_captor(i,1),p_captor(i,1)+move(1)],[p_captor(i,2),p_captor(i,2)+move(2)]);         %���˶��켣
end