%�������ζ��㣬�����ϰ������
function tm2 = myrectangle(point)
np=100;
x=[0:np];
y=[0:np];

% ����ζ���
% xv=[1.2 7.6 4.5 1.2];
% yv=[4.7 2.8 7.8 4.7];
% xv=xv*10;
% yv=yv*10;


[X,Y]=meshgrid(x,y);%����

% ���ڵ�
[ind] = inpolygon(X,Y,point(1,:),point(2,:));


% % �ҳ��߽�
% flg_ind=double(ind);
% tm = flg_ind(1:np,:)+flg_ind(2:(np+1),:)+flg_ind(3:(np+2),:);     %����ƽ�Ƶ���
% tm(1,:) = [];
% tm2 = tm(:,1:np)+tm(:,2:(np+1))+tm(:,3:(np+2));              %����ƽ�Ƶ��ӣ�Ϊ1���Ǳ߽�
% tm2(:,1) = [];
% �ҳ��߽�
flg_ind=double(ind);
tm = flg_ind(1:np,:)+flg_ind(2:(np+1),:);     %����ƽ�Ƶ���
tm2 = tm(:,1:np)+tm(:,2:(np+1));              %����ƽ�Ƶ��ӣ�Ϊ1���Ǳ߽�


[num,dim] = size(tm2); 
for i=1:num                 
    for j=1:dim
      if tm2(i,j) > 0
         tm2(i,j) = 1;
      end
    end
end
% [ind_in_x,ind_in_y]=find(double(tm2==4));   %4���ڵ�
% [ind_out_x,ind_out_y]=find(double(tm2==0)); %0�����
% [ind_bd_x,ind_bd_y]=find(double(tm2>0) & double(tm2<4));



% z
%         Z=zeros(size(X));
%         Z_in=ones(size(Z)); % �ڶ�����еĲ���
%         Z_in(~ind)=NaN;
% Z_out=zeros(size(Z)); % �ڶ������Ĳ���
% Z_out(ind)=NaN;

%%�����ǻ�ͼ��
% �߽��
%mesh(X,Y,zeros(size(X)),'edgecolor','k')
%         hold on;
%         % �ڵ�
%         h_in=surf(X,Y,Z_in);
%         alpha(h_in,0.7);
%         % ���߽���
%         [num,dim] = size(point); 
%         point(:,dim+1) = point(:,1);
%         plot(point(1,:),point(2,:),'r','linewidth',2);
% ���
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