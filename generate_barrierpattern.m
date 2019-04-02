function pattern_barrier = generate_barrierpattern()
% 
% global cell_wid;
% 
% 
% N_cell_x = 100;
% N_cell_y = 100;

%左矩形
point1 = [0,5,25,20;
          50,55,35,30;];
barrier1 = myrectangle(point1);
%下矩形
point2 = [50,55,35,30;
          0,5,25,20;];
barrier2 = myrectangle(point2);
%非凸障碍
point3 = [30,65,60,50;
          60,65,30,50;];
barrier3 = myrectangle(point3);
%凸障碍
point4 = [80,90,90,80;
          40,40,30,30;];
barrier4 = myrectangle(point4);

pattern_barrier = barrier1 + barrier2 + barrier3 + barrier4;

patch(point1(1,:),point1(2,:),[0,0.5,0]);
patch(point2(1,:),point2(2,:),[0,0.5,0]);
patch(point3(1,:),point3(2,:),[0,0.5,0]);
patch(point4(1,:),point4(2,:),[0,0.5,0]);
% 
% p = zeros(N_cell_x,N_cell_y);
% g1 = zeros(N_cell_x,N_cell_y);
% g2 = zeros(N_cell_x,N_cell_y);
% g3 = zeros(N_cell_x,N_cell_y);
% 
% 
% sita1 = 0.25;
% sita2 = 0.3;
% sita3 = 1.2;
% 
% for i = 1:N_cell_x
%     for j = 1:N_cell_y
%         p(i,j) = calc_mor(p_fish,i,j);     %实际影响的就只有和目标的距离和目标的影响力
%       %  g1(i,j) = sig(p(i,j),sita1);
%         g1(i,j) = 1/(1+exp(-15*(p(i,j)-sita1)));
%        % g2(i,j) = 1-sig(p(i,j),sita2);
%        % g3(i,j) = sig(g1(i,j)+g2(i,j),sita3);
%     end
% end
% 
% 
% colormap cool
% 
% x_mat = zeros(N_cell_x,N_cell_y);               %空矩阵
% y_mat = zeros(N_cell_x,N_cell_y);
% 
% for i1 = 1:N_cell_x
%     for j1 = 1:N_cell_y
%         x_mat(i1,j1)=(i1-0.5)*cell_wid;         %求出每个细胞的中心位置坐标
%         y_mat(i1,j1)=(j1-0.5)*cell_wid;
%     end
% end
% [c,h]=contour(x_mat,y_mat,g1);                        %横纵坐标及高度画等高线
% %colormap('autumn');
% %set(h,'ShowText','on')%显示等高线的值
% %set(h,'ShowText','on','LevelList',0.3643)%设定等高线的值为0.3643
% set(h,'LevelList',0.5)%设定等高线的值为0.3643
% axis([0,25,0,25]);                              %x轴y轴都在25之内，正好是100*100
% 
% pattern_barrier = g1;