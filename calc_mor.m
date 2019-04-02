function m = calc_mor(pos,i,j)

global cell_wid;
[num,dim] = size(pos); %% num: number of organizing agents in the env; dim: the dimension of the system, typically, 2.Can be generalized
                       %% the last element of pos reprsents the strength of
                       %% the indexed source
epi = 1;    %���Ǹ���ģ�û��������Ĳ�����
m = 0;
for index = 1:num                                       %������Ŀ�꣺���Բ�û�д�������Χ��
    r = ((cell_wid*(i-0.5)-pos(index,1))^2+(cell_wid*(j-0.5)-pos(index,2))^2)^0.5;  %����Ŀ��ľ���
    m = m + pos(index,3)*exp(-r/epi);                   %���ž����Զ��Ӱ���𽥱�С
end