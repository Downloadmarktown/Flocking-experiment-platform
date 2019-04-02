function [move,die] = avoiding_die(p_captor,move,i,barrier,p_fish)
%% 参数
global v ;                                  %机器人运动速度
global distent_fish;
[num1,dim] = size(p_fish); 
[num2,dim] = size(p_captor); 
thetax = atand(move(2)/move(1));            %当前运动方向
if (move(1)<0 )
    thetax = thetax +180;
end
move1=move;                                 %记录初始移动距离
flag_left=0;                                    %记录左右探索次数
flag_right=0;
flag_safe = 0;
distent_avoid = 0.5;                     %探测距离
max_pattern = 0;
die = 0;                                   %判断有没有被障碍压死

%避免越界
if (p_captor(i,1)-distent_avoid)/0.25>1 && (p_captor(i,1)+distent_avoid)/0.25<100 &&...
        (p_captor(i,2)-distent_avoid)/0.25>1 && (p_captor(i,2)+distent_avoid)/0.25<100
%% 首先选择循环的方向
if(barrier(round((p_captor(i,1)+cosd(thetax)*distent_avoid)/0.25),round((p_captor(i,2)+sind(thetax)*distent_avoid)/0.25))>max_pattern)
         thetax1=thetax+30;             %计算两个方向的值，决定向哪边偏
         thetax2=thetax-30;
         barrier1=barrier(round((p_captor(i,1)+cosd(thetax1)*distent_avoid)/0.25),round((p_captor(i,2)+sind(thetax1)*distent_avoid)/0.25));
         barrier2=barrier(round((p_captor(i,1)+cosd(thetax2)*distent_avoid)/0.25),round((p_captor(i,2)+sind(thetax2)*distent_avoid)/0.25));
         if(barrier1>barrier2)
             flag_right = 1;
         else
             flag_left = 1;
         end
end
%% 重新设计方向
   while(barrier(round((p_captor(i,1)+cosd(thetax)*distent_avoid)/0.25),round((p_captor(i,2)+sind(thetax)*distent_avoid)/0.25))>max_pattern...
           || flag_safe == 1) 
       
         flag_safe = 0;
         thetax1=thetax+30;             %计算两个方向的值，决定向哪边偏
         thetax2=thetax-30;
         barrier1=barrier(round((p_captor(i,1)+cosd(thetax1)*distent_avoid)/0.25),round((p_captor(i,2)+sind(thetax1)*distent_avoid)/0.25));
         barrier2=barrier(round((p_captor(i,1)+cosd(thetax2)*distent_avoid)/0.25),round((p_captor(i,2)+sind(thetax2)*distent_avoid)/0.25));
         
         if(flag_left > 0 )                  %左边浓度高：向右
            move(1)=cosd(thetax1)*v;
            move(2)=sind(thetax1)*v;
            thetax=thetax1;
            min_direct(flag_left) = barrier2;
            flag_left = flag_left + 1;
            
            if(flag_left>12)                        %如果都没有出路，找最小的方向走
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
            if(flag_right>12)                        %如果都没有出路，找最小的方向走
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
         
%         for j=1:num2                            %如果改变方向后有在机器人安全范围之内的:再循环
%             if(j~=i)                            %不判断自己
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
   %% 画出上一步轨迹
         %hold on;
         %line([p_captor(i,1),p_captor(i,1)+move(1)],[p_captor(i,2),p_captor(i,2)+move(2)]);         %画运动轨迹
end