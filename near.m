function minfish = near(fish,x,y)

[num,dim] = size(fish); %% num: number of organizing agents in the env; dim: the dimension of the system, typically, 2.Can be generalized
                       %% the last element of pos reprsents the strength of
                       %% the indexed source
minfish = 1;
mindis = ((x-fish(1,1))^2+(y-fish(1,2))^2)^0.5;         %��ʼ�����ΪĿ��1

for index = 1:num                                       %������Ŀ�꣺�ҳ������Ŀ��
    r = ((x-fish(index,1))^2+(y-fish(index,2))^2)^0.5;  %����Ŀ��ľ���
    if(mindis > r)
        minfish = index;
        mindis = r;
    end
end