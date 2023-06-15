function j=rouletteWheel(F,pop)


h1=(1:length(F));
h1=1./h1;
h1=h1./sum(h1);
h1=cumsum(h1);

k=find(rand<=h1,1,'first');

h2=pop(F{k}).cdis;
h2=h2./sum(h2);
h2=cumsum(h2);

n=find(rand<=h2,1,'first');

j=F{k} (n);









end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%                          www.matlabnet.ir                         %
%                   Free Download  matlab code and movie            %
%                          Shahab Poursafary                        %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%