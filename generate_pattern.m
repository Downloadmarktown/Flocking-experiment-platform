 function pattern = generate_pattern()

global cell_wid;


N_cell_x = 100;
N_cell_y = 100;

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
%         p(i,j) = estab_mor(p_fish,i,j);     %ʵ��Ӱ��ľ�ֻ�к�Ŀ��ľ����Ŀ���Ӱ����
%         g1(i,j) = sig(p(i,j),sita1);
%         g2(i,j) = 1-sig(p(i,j),sita2);
%         g3(i,j) = sig(g1(i,j)+g2(i,j),sita3);
%        % if(g3(i,j)<0.5 )
%         %    g3(i,j)=0;
%         %end
%     end
% end


% colormap cool

x_mat = zeros(N_cell_x,N_cell_y);               %�վ���
% y_mat = zeros(N_cell_x,N_cell_y);
% g3 = zeros(N_cell_x,N_cell_y);

for i1 = 1:N_cell_x
     for j1 = 1:N_cell_y
        x_mat(i1,j1)=(i1-0.5)*cell_wid;         %���ÿ��ϸ��������λ������
%         y_mat(i1,j1)=(j1-0.5)*cell_wid;
     end
end
[c,h]=contour(x_mat,x_mat,x_mat);                        %�������꼰�߶Ȼ��ȸ���
% [c,h]=contour(x_mat,y_mat,g3);                        %�������꼰�߶Ȼ��ȸ���
% %set(h,'ShowText','on')%��ʾ�ȸ��ߵ�ֵ
% %set(h,'ShowText','on','LevelList',0.3643)%�趨�ȸ��ߵ�ֵΪ0.3643
% set(h,'LevelList',0.65)%�趨�ȸ��ߵ�ֵΪ0.3643
axis([0,25,0,25]);                              %x��y�ᶼ��25֮�ڣ�������100*100
axis square;
% 
  pattern = 0;