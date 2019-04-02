function pattern_barrier = generate_barrierpattern()
% 
% global cell_wid;
% 
% 
% N_cell_x = 100;
% N_cell_y = 100;

%�����
point1 = [0,5,25,20;
          50,55,35,30;];
barrier1 = myrectangle(point1);
%�¾���
point2 = [50,55,35,30;
          0,5,25,20;];
barrier2 = myrectangle(point2);
%��͹�ϰ�
point3 = [30,65,60,50;
          60,65,30,50;];
barrier3 = myrectangle(point3);
%͹�ϰ�
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
%         p(i,j) = calc_mor(p_fish,i,j);     %ʵ��Ӱ��ľ�ֻ�к�Ŀ��ľ����Ŀ���Ӱ����
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
% x_mat = zeros(N_cell_x,N_cell_y);               %�վ���
% y_mat = zeros(N_cell_x,N_cell_y);
% 
% for i1 = 1:N_cell_x
%     for j1 = 1:N_cell_y
%         x_mat(i1,j1)=(i1-0.5)*cell_wid;         %���ÿ��ϸ��������λ������
%         y_mat(i1,j1)=(j1-0.5)*cell_wid;
%     end
% end
% [c,h]=contour(x_mat,y_mat,g1);                        %�������꼰�߶Ȼ��ȸ���
% %colormap('autumn');
% %set(h,'ShowText','on')%��ʾ�ȸ��ߵ�ֵ
% %set(h,'ShowText','on','LevelList',0.3643)%�趨�ȸ��ߵ�ֵΪ0.3643
% set(h,'LevelList',0.5)%�趨�ȸ��ߵ�ֵΪ0.3643
% axis([0,25,0,25]);                              %x��y�ᶼ��25֮�ڣ�������100*100
% 
% pattern_barrier = g1;