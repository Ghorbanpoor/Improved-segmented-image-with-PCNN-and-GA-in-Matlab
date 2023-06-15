function  crosspop=crossover(crosspop,pop,ncross,F,nvar)

npop=length(pop);


for n=1:2:ncross

    
    % NAGAII
    %i1=tournoment_binary(npop);
    %i2=tournoment_binary(npop);
    
    % NRGA
    i1=rouletteWheel(F,pop);
    i2=rouletteWheel(F,pop);
    
    p1=pop(i1).pos;
    p2=pop(i2).pos;
    
    r=rand(1,nvar);
    
    o1=(r.*p1)+(1-r).*p2;
    o2=(r.*p2)+(1-r).*p1;


crosspop(n).pos=o1;
crosspop(n).cost=fitness(o1);

crosspop(n+1).pos=o2;
crosspop(n+1).cost=fitness(o2);





end

end


