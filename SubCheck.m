function [Result] = SubCheck(factors)

% clear all;
% clc;
% close all;
% factors=[0.2,0.6,0.7,0.7,0.6,     0.9,0.5,0.9,0.2,0.8,      0.6,0.7,0.7,0.9,0.9,      0.9,0.7,0.8,0.8,0.1];   
%factors = [0.800000000000000,0.700000000000000,0.500000000000000,0.100000000000000,0.400000000000000,1,0.800000000000000,0.800000000000000,0.900000000000000,1,0.800000000000000,0.700000000000000,0.300000000000000,0.500000000000000,0.200000000000000,0.900000000000000,0.200000000000000,0.300000000000000,0.500000000000000,0.700000000000000];
factors = [0,1,1,1,0,  0,0,0,0,1,   1,0,0,0,1,   1,0,0,0,0];
%factors = [0.700000000000000,0.700000000000000,0.300000000000000,0.800000000000000,0.600000000000000,0.300000000000000,1,0.200000000000000,0.700000000000000,0.800000000000000,0.600000000000000,0.400000000000000,0.700000000000000,0.400000000000000,1,0.100000000000000,0.200000000000000,0.700000000000000,0.500000000000000,1];
factors = reshape(factors,5,4);
factors = factors';

num_targets = 1;        
num_robot = 20;                          
num_barrier = 2;                          
%num_barrier = 1+ceil(4*rand());                     %如果想的话，开场随机障碍物数量
%p_fish = 5*rand(num_targets,3)+10;                   %随机生成4个target的坐标
%p_fish = 0.1*rand(num_targets,3)+10;p_fish(:,2) = p_fish(:,2)+5;           
p_fish = [25, 25, 1];
%p_captor = 6*rand(num_robot,3)+7;p_captor(:,2) = p_captor(:,2)+5; 
%p_captor = rand(num_robot,3);
p_captor = [0.692531986386519,0.683715572408358,0.789363943641905;
    0.556669834964013,0.132082955713563,0.367652918437877;
    0.396520792581593,0.722724539656766,0.206027859505195;
    0.0615906670539647,0.110353480642349,0.0866665473955323;
    0.780175531491174,0.117492852151833,0.771933917099107;
    0.337583864052045,0.640717922965926,0.205674521464760;
    0.607865907262946,0.328814214756803,0.388271631047802;
    0.741254049502218,0.653812022595774,0.551778531957228;
    0.104813241973500,0.749131463103519,0.228953252023100;
    0.127888379782995,0.583185731454876,0.641940620399187;
    0.549540107015198,0.740032327987778,0.484480372398180;
    0.485229408584959,0.234826914747904,0.151845525116267;
    0.890475679184438,0.734957541696052,0.781931966588002;
    0.798960278812879,0.970598525086615,0.100606322362422;
    0.734341083695970,0.866930291751916,0.294066333758628;
    0.0513318861123711,0.0862345298634963,0.237373019705579;
    0.0728852990989761,0.366436616319199,0.530872257027928;
    0.0885274596747204,0.369198804330018,0.0914987313394122;
    0.798350864113952,0.685028472661609,0.405315419880591;
    0.943008139570703,0.597941635383889,0.104846247115757];
%p_captor = 25*rand(num_robot,3);
%p_barrier = 5*rand(num_barrier,3)+10;
p_barrier = [ 12.5, 12, 1; 7.5,  12, 1 ];
%p_barrier = [10.3079533352698,13.0393295363147,1;13.9008776574559,13.7062702475111,1;11.6879193202602,10.5240662098675,1];
p_fish(:,3) = 1;                                    %每个目标的影响力：目前暂设影响力都为1
p_captor(:,3) = 1;                      
p_captor(:,4) = 0;                      
p_captor(:,5) = 0;         
captortime(1,1:num_robot) = 200;
th = 1;

global cell_wid;
global distent_fish;                        %与目标的安全距离
global distent_capter;                      %与其他机器人的安全距离
global distent_detect ;                     %探测距离
global v ;                                  %机器人运动速度
cell_wid = 0.25;                            %细胞的长宽
distent_detect = 10;                        %探测范围
distent_fish = 1.5;                         %安全距离
distent_capter = 0.5;                       %安全距离
v = 0.25;


% N = 8;
% target = zeros(N,2);    
%下矩形                                     
point1 = [0,5,25,20;                        %这边是碰撞判定的多边形顶点，一列是一个点的横纵坐标
          50,55,35,30;];                    %注意这个坐标画出来是关于x=y对称的
barrier1 = myrectangle(point1);
point1 = [0.5,4.5,24.5,20.5;                        %这边是画图的多边形顶点
          50.5,54.5,34.5,30.5;]*cell_wid;
%左矩形
point2 = [50,55,32,27;
          0,5,28,23;];
barrier2 = myrectangle(point2);
point2 = point2*cell_wid;
%非凸障碍
point3 = [30,65,60,50;
          60,65,30,50;];
barrier3 = myrectangle(point3);
point3 = [31,64,59,51;
          59,64,31,51;]*cell_wid;
%凸障碍
point4 = [50,50,40,40;
          70,80,80,70;];
barrier4 = myrectangle(point4);
point4 = [49,49,41,41;
          71,79,79,71;]*cell_wid;

pattern_barrier = barrier1' + barrier2' + barrier3' + barrier4';

    
[num,dim] = size(p_captor);                         %机器人个数
N = 200;                                            %循环绘图100次
for i = 1:N

%         if i==130                                   %第30次（受到火力打击第一象限机器人消失的时间点）
%             j = 1;
%             while j<=num
%                 if( p_captor(j,1) >12 && p_captor(j,2) >12 )
%                     p_captor(j,:)=[];
%                     j=j-1;
%                     num=num-1;
%                 end
%                     j=j+1;
%             end
%             [num,dim] = size(p_captor); 
%         end
        
       % if 10*rand()<0.8                                    %概率增加一个障碍
       %     p_barrier(num_barrier+1,:) =  25*rand();
       %     p_barrier(num_barrier+1,3) =  3*rand();
       %     p_barrier(num_barrier+1,4) =  360*rand();
       %     num_barrier = num_barrier + 1;
       % end

%     pattern_target = generate_pattern();              %形成pattern
%     hold on;
%     plot(p_fish(:,1),p_fish(:,2),'x')                       %四个target用.画出
   %         pattern_barrier = generate_barrierpattern();   %形成障碍范围
   % for p=1:num_barrier                                    %画障碍物周围的圆
   %     [x,y]=scircle1(p_barrier(p,1),p_barrier(p,2),p_barrier(p,3)/1.2);
   %     plot(x,y);
   % end
   % plot(p_barrier(:,1),p_barrier(:,2),'.g')                %画出障碍
   
        r=1;
        k=1;
    j=1;
    while j<=num
       % flagorg = organize(p_fish,p_captor,j);
       %flagorg = 1;

    flagstop=1;                   %判断是否跳出
    for p=1:num                   %判断纵坐标都到右上角
        if  p_captor(p,3) == 1;
            flagstop = 0;
        end
    end
%     if flagstop == 1
%         break;
%     end
    
    distance_target = ((p_captor(j,1)-25)^2+(p_captor(j,2)-25)^2)^0.5;     %判断是否到终点了
    if(distance_target<4 && p_captor(j,3)==1)
        p_captor(j,3)=2;
             if( captortime(th) == 200)
                captortime(th)=i;    %记录下到达终点的时间
                th=th+1;
             end
    end
    
        if (p_captor(j,3) == 1)                                   %如果还活着
            [move,die] = trapping(p_captor,p_fish,j,pattern_barrier,factors);
           % move = avoiding(p_captor,move,j,pattern_barrier,p_fish);
           % [move,die] = avoiding_die(p_captor,move,j,pattern_barrier,p_fish);
            p_captor(j,1) = p_captor(j,1)+move(1);         
            p_captor(j,2) = p_captor(j,2)+move(2); 
            p_captor(j,4) = move(1);
            p_captor(j,5) = move(2);
            p_organizing(r,:) = p_captor(j,:);   
            r = r+1;
        else                                    %如果不是组织机器人：与组织机器人运动方向相同
%             p_captor(j,3) = 1;
%             non_move = non_trapping(p_captor,p_fish,j,pattern_barrier);
%             %non_move = avoiding(p_captor,non_move,j,pattern_barrier,p_fish);
%             [non_move,die] = avoiding_die(p_captor,non_move,j,pattern_barrier,p_fish);
%             p_captor(j,1) = p_captor(j,1)+non_move(1);         
%             p_captor(j,2) = p_captor(j,2)+non_move(2);  
%             p_captor(j,4) = non_move(1);
%             p_captor(j,5) = non_move(2);
%             p_nonorganizing(k,:) = p_captor(j,:);
             non_move=[0,0];
             p_captor(j,1) = p_captor(j,1)+non_move(1);         
             p_captor(j,2) = p_captor(j,2)+non_move(2);  
%             p_captor(j,1) = 24;         
%             p_captor(j,2) = 24;  
             p_captor(j,4) = non_move(1);
             p_captor(j,5) = non_move(2); 
             p_nonorganizing(k,:) = p_captor(j,:);
            k = k+1;
        end
        trace(2*j-1,i) = p_captor(j,1);
        trace(2*j,i) = p_captor(j,2);
        
        if die==1
             p_captor(j,:)=[];
             
             temp(1,:)=trace(2*j-1,:);          %画轨迹
             temp(2,:)=trace(2*j,:);
             trace(2*j,:)=[];
             trace(2*j-1,:)=[];
             trace(2*num_robot-1,:)=temp(1,:);
             trace(2*num_robot,:)=temp(2,:);
             clear temp;

             num = num - 1;
             j = j-1;
             
        end
        j=j+1;
    end
        
    %接下来这一段是算参数用的
    %算质心
    [numnum,dim] = size(p_captor); 
    if numnum > 1
    tempp = mean(p_captor);
     elseif numnum == 1
         tempp = p_captor;
     else
         tempp = [0,0,0,0,0];
         flagstop = 1;
    end
  %  tempp = mean(p_captor);
   % flagstop = 1;
    index_averagecenter(:,i) = tempp(1,1:2)';
    
    %算平均角度
    index_averagetheta(i) = atand(tempp(5)/tempp(4));   
    if (tempp(4)<0 )
        index_averagetheta(i) = index_averagetheta(i) +180;
    elseif (tempp(4)==0 && tempp(5)>=0)
        index_averagetheta(i) = 90;
    elseif (tempp(4)==0 && tempp(5)<0)
        index_averagetheta(i) = 270;
    end
    
    %算平均速度
    index_averagexy(:,i) = tempp(1,4:5)';
    index_averagev(i) = (index_averagexy(1,i)^2 + index_averagexy(2,i)^2)^0.5;
    j=1;
    while j<=num
        index_centerdistance(j,i)=((p_captor(j,1)-index_averagecenter(1,i))^2+(p_captor(j,2)-index_averagecenter(2,i))^2)^0.5;%到质心的距离
        theta = atand(p_captor(j,5)/p_captor(j,4));   %与平均角度的角度差
        if (p_captor(j,4)<0 )
             theta = theta +180;
        elseif (p_captor(j,4)==0 && p_captor(j,5)>=0 )
             theta =  90;
        elseif (p_captor(j,4)==0 && p_captor(j,5)<0)
             theta = 270;
        end
        index_centertheta(j,i) = abs(theta - index_averagetheta(i));
        j=j+1;
    end
    clear tempp;
%     
%     
%     patch(point1(1,:),point1(2,:),[0,0.9,0])                           %画出障碍
%     patch(point2(1,:),point2(2,:),[0,0.9,0])
%     patch(point3(1,:),point3(2,:),[0,0.9,0])
%     patch(point4(1,:),point4(2,:),[0,0.9,0])
%     
%     [x11,y11]=scircle1(25,25,4);                                        %画终点区域
%     plot(x11,y11);
%     if r~=1
%      plot(p_organizing(:,1),p_organizing(:,2),'.')                      %organizer用.画出 
%     end
%     if k~=1
%      plot(p_nonorganizing(:,1),p_nonorganizing(:,2),'.r')               %nonorganizer用.画出
%      a = size(p_nonorganizing);
%     else
%         a=[0,0];
%     end
    

     clear p_organizing p_nonorganizing ;
     
     
     
      %  plot(p_capter(:,1),p_capter(:,2),'.')                          %十五个organizer用.画出
        
%     crv = generate_curve(p_fish);
%     dest = linspace(0,1,num_organizer+1);
%     p_target = nrbeval(crv,dest(1:end-1));
%     hold on;
%     plot(p_target(1,:),p_target(2,:),'o');
    
 %   p_fish(1,2) = p_fish(1,2)-0.1;        
 %   p_fish(1,2) = p_fish(1,2)-0.1;          %第一和第二个目标竖直方向远离
 %   p_fish(2,2) = p_fish(2,2)+0.1;
    
    
 %   p_fish(3,1) = p_fish(3,1)-0.1;          %第三和第四个目标水平方向远离
 %   p_fish(4,1) = p_fish(4,1)+0.1;
   
  % for p=1:num_barrier
  %      p_barrier(p,1) = p_barrier(p,1)+cosd(p_barrier(p,4))*0.1;      
  %      p_barrier(p,2) = p_barrier(p,2)+sind(p_barrier(p,4))*0.1;   
  %      if rem(i,3)==0
  %          p_barrier(p,4)=p_barrier(p,4)+ 60*rand(1) - 30;                %更新速度方向 
  %      end
  % end
    
    for p = 1:num_targets
        if(p_fish(p,1)>25 || p_fish(p,2)>25 || p_fish(p,1)<0 || p_fish(p,2)<0)      %移出屏幕被设置为目标消失或被击毁，机器人寻找最近目标
           p_fish(p,1)=50;
           p_fish(p,2)=50;
        end
    end
%     hold off;                               %关闭图像保持功能

    
%     pause(0.1);
    if flagstop == 1
        break;
    end
    %figure(0.1);
end
%聚集性
 index_aggregation = mean(mean(index_centerdistance')');
%均匀性:各个个体从头到尾的到质心的平均值，再方差
 index_uniformity = var(mean(index_centerdistance')');
%或者不用从头到尾平均，直接算方差随时间的变化
 index_uniformityT = var(index_centerdistance);
%各项异质性
 index_anisotropy = mean(mean(index_centertheta')');
%平均到达目的地的时间
 index_averagetime = mean(captortime');

% [num1,dim] = size(trace); 
% for p=1:num1                 %0清成NaN，避免回0
%     for j=1:dim
%       if trace(p,j) == 0
%          trace(p,j) = trace(p,j-1);
%       end
%     end
% end
% for p=1:num_robot
%     line(trace(2*p-1,:),trace(2*p,:));
% end
deathrate = (num_robot - num)/ num_robot;
Result = index_aggregation * index_uniformity * index_anisotropy * index_averagetime/200;%死亡个数
if isnan(Result)|| deathrate > 0.2
    Result=Inf;
end
%Result(2)=index_anisotropy;                        %结束时间
