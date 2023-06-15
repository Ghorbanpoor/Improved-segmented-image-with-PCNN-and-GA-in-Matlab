function  mutpop=mutation(mutpop,pop,nmut,lb,ub,nvar)

npop=length(pop);

for n=1:nmut
    
   i=randi([1 npop]);
   p=pop(i).pos;
   
   j=randi([1 nvar]);
   
   if rand<0.5
       
    p(j)=p(j)-rand*0.1*(p(j)-lb(j));  
   else
    p(j)=p(j)+rand*0.1*(ub(j)-p(j));     
       
   end
    
    
    
    mutpop(n).pos=p;
    mutpop(n).cost=fitness(p);
    
    
end






end


