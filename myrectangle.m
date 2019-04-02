%输入多边形顶点，返回障碍物矩阵
function tm2 = myrectangle(point)
np=100;
x=[0:np];
y=[0:np];

% 多边形顶点
% xv=[1.2 7.6 4.5 1.2];
% yv=[4.7 2.8 7.8 4.7];
% xv=xv*10;
% yv=yv*10;


[X,Y]=meshgrid(x,y);%网格化

% 找内点
[ind] = inpolygon(X,Y,point(1,:),point(2,:));


% % 找出边界
% flg_ind=double(ind);
% tm = flg_ind(1:np,:)+flg_ind(2:(np+1),:)+flg_ind(3:(np+2),:);     %上下平移叠加
% tm(1,:) = [];
% tm2 = tm(:,1:np)+tm(:,2:(np+1))+tm(:,3:(np+2));              %左右平移叠加：为1的是边界
% tm2(:,1) = [];
% 找出边界
flg_ind=double(ind);
tm = flg_ind(1:np,:)+flg_ind(2:(np+1),:);     %上下平移叠加
tm2 = tm(:,1:np)+tm(:,2:(np+1));              %左右平移叠加：为1的是边界


[num,dim] = size(tm2); 
for i=1:num                 
    for j=1:dim
      if tm2(i,j) > 0
         tm2(i,j) = 1;
      end
    end
end
% [ind_in_x,ind_in_y]=find(double(tm2==4));   %4是内点
% [ind_out_x,ind_out_y]=find(double(tm2==0)); %0是外点
% [ind_bd_x,ind_bd_y]=find(double(tm2>0) & double(tm2<4));



% z
%         Z=zeros(size(X));
%         Z_in=ones(size(Z)); % 在多边形中的部分
%         Z_in(~ind)=NaN;
% Z_out=zeros(size(Z)); % 在多边形外的部分
% Z_out(ind)=NaN;

%%下面是画图的
% 边界点
%mesh(X,Y,zeros(size(X)),'edgecolor','k')
%         hold on;
%         % 内点
%         h_in=surf(X,Y,Z_in);
%         alpha(h_in,0.7);
%         % 画边界线
%         [num,dim] = size(point); 
%         point(:,dim+1) = point(:,1);
%         plot(point(1,:),point(2,:),'r','linewidth',2);
% 外点
%h_out=surf(X,Y,Z_out);
%alpha(h_out,0.2);
% view(0,90)
% 
% plot in points
% plot(X(ind),Y(ind),'bo','MarkerFaceColor','b')
% hidden off
% 
% plot in, out, bd grid
% plot3(x(ind_in_y)+0.5,y(ind_in_x)+0.5,2*ones(size(ind_in_x)),'gs','MarkerFaceColor','g')
% plot(x(ind_out_y)+0.5,y(ind_out_x)+0.5,'yo','MarkerFaceColor','y')
% plot(x(ind_bd_y)+0.5,y(ind_bd_x)+0.5,'ms','MarkerFaceColor','m')
% 
% axis equal
% axis tight
%pattern_barrier = tm2;