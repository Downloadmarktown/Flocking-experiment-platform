function m = calc_mor(pos,i,j)

global cell_wid;
[num,dim] = size(pos); %% num: number of organizing agents in the env; dim: the dimension of the system, typically, 2.Can be generalized
                       %% the last element of pos reprsents the strength of
                       %% the indexed source
epi = 1;    %这是干嘛的？没物理意义的参数？
m = 0;
for index = 1:num                                       %对所有目标：所以并没有传感器范围？
    r = ((cell_wid*(i-0.5)-pos(index,1))^2+(cell_wid*(j-0.5)-pos(index,2))^2)^0.5;  %距离目标的距离
    m = m + pos(index,3)*exp(-r/epi);                   %随着距离的远近影响逐渐变小
end