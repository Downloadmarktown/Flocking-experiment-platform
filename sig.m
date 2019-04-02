function gene = sig(p,sita1)

k = 20;

gene = 1/(1+exp(-k*(p-sita1)));
