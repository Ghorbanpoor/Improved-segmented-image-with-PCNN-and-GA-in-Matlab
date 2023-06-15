function  [pop F]=non_dominated_sorting(pop)



npop=length(pop);




F{1}=[];


for i=1:npop
    
   pop(i).dcount=0; 
   pop(i).dset=[];
    
    p=pop(i).cost;
    

    for j=[1:i-1 i+1:npop] 
        
        q=pop(j).cost;
        
        if all(p<=q) && any(p<q)
            pop(i).dset=[pop(i).dset j];    
        elseif all(q<=p) && any(q<p)
            pop(i).dcount=pop(i).dcount+1;
        end
    
    end
    
    if pop(i).dcount==0
        F{1}=[F{1} i];
    end
    
    
end




k=1;


while true
y=[];

for i=F{k}
    
   for j=pop(i).dset 
      pop(j).dcount=pop(j).dcount-1;
      
      if pop(j).dcount==0
          [y]=[y j];
      end
      
   end
    
end

if isempty(y)
    break
end

k=k+1;
F{k}=y;

end




for i=1:length(F)
   
    for j=F{i}
        
       pop(j).rank=i; 
        
    end
    
    
end


end



