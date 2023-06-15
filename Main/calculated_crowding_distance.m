function  pop=calculated_crowding_distance(pop,F)

C=[pop.cost]';

nobj=length(pop(1).cost);

NF=length(F);

for i=1:NF
    
    NFM=length(F{i});
    C0=C(F{i},:);
    
    D=zeros(NFM,nobj);
    
    for j=1:nobj
    
        Cj=C0(:,j);
        
        [value,index]=sort(Cj);
        
        minc=value(1);
        maxc=value(end);
        
        D(index(1),j)=10;
        D(index(end),j)=10;
        
        
        for k=2:NFM-1
            
           D(index(k),j)=abs(value(k+1)-value(k-1))/(maxc-minc); 
        end
        
    end
    
    for z=1:NFM
       pop(F{i}(z)).cdis=sum(D(z,:)); 
    end
    
end




