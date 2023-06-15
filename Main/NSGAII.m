clc
clear
close all
format shortG

global A Y1

A = imread('2417871.jpg');
figure(1)
imshow(A)


B2= imnoise (A,'salt & pepper',0.01);
A2=B2;
[ROW,COL]=size(A2);      
S=im2double(A2);
Y1=zeros(ROW,COL);      
E=ones(ROW,COL)*2;
M=[0.707 1 0.707;1 1 1;0.707 1 0.707];
W=[0.707 1 0.707;1 1 1;0.707 1 0.707];

aF=0.1;
aL=0.3;
aE=0.2;
VF=0.5;%1; 
VL=0.2;%1;
VE=20;%50;
F=S;
L=S;
b=0.1;%0.05;

num=4;

for n=1:num
    SUM1=imfilter(Y1,M);
    SUM2=imfilter(Y1,W);
    for i=1:ROW
        for j=1:COL
           F(i,j)=exp(-aF)*F(i,j)+S(i,j)+VF*SUM1(i,j);
           L(i,j)=exp(-aL)*L(i,j)+VL* SUM2(i,j);
           U(i,j)=F(i,j)*(1+b*L(i,j));
           E(i,j)=exp(-aE)*E(i,j)+VE*Y1(i,j);
           if  U(i,j)-E(i,j)>0
                Y1(i,j)=1; 
          else
                Y1(i,j)=0;
          end
       end 
    end
      
end
figure(2)
imshow(Y1)


%% parametres setting

nvar=18;        %  number of variable
lb=zeros(1,18); % lower bound
ub=ones(1,18);     % upper bound

npop=10;     % number of population


pc=0.7;       % percent of crossover
ncross=2*round(npop*pc/2);  % number of crossover offspring

pm=0.3;        %  percent of mutation
nmut=round(npop*pm);  % number of mutation offspring


maxiter=15;


%% initialization

empty.pos=[];
empty.cost=[];
empty.dcount=[];   % dominate count
empty.dset=[];     % dominate set
empty.rank=[];      
empty.cdis=[];      % crowding distance


pop=repmat(empty,npop,1);

for i=1:npop
    pop(i).pos=lb+rand(1,nvar).*(ub-lb);
    pop(i).cost=fitness(pop(i).pos);
end

[pop F]=non_dominated_sorting(pop);
pop=calculated_crowding_distance(pop,F);
pop=sorting(pop);

%% main loop

for iter=1:maxiter

    % crossover
    crosspop=repmat(empty,ncross,1);
     crosspop=crossover(crosspop,pop,ncross,F,nvar);
     
     % mutation
     mutpop=repmat(empty,nmut,1);
     mutpop=mutation(mutpop,pop,nmut,lb,ub,nvar);
     
     [pop]=[pop;crosspop;mutpop];
    
     [pop F]=non_dominated_sorting(pop);
      pop=calculated_crowding_distance(pop,F);
      pop=sorting(pop);
      
      pop=pop(1:npop);
      
      [pop F]=non_dominated_sorting(pop);
      pop=calculated_crowding_distance(pop,F);
      pop=sorting(pop);
      
      
      C=[pop.cost]';
      
      figure(3)
      plotpareto(F,C)
      
      
      
      disp([ ' iter =   '  num2str(iter) ' BEST F1 = ' num2str(min(C(:,1)))  ' BEST F2  = ' num2str(min(C(:,2))) ' NF1 = '  num2str(length(F{1})) ]) 
    
    
    
    
    
end

%% results

pareto=pop(F{1},:);

best=pareto.pos

x=best;

B2= imnoise (A,'salt & pepper',0.01);
    A=B2;
    [ROW,COL]=size(A);      
    S=im2double(A);
    Y=zeros(ROW,COL);      
    E=ones(ROW,COL)*2;
    M=[x(1) x(2) x(3);x(4) x(5) x(6);x(7) x(8) x(9)];
    W=[x(10) x(11) x(12);x(13) x(14) x(15);x(16) x(17) x(18)];

    aF=0.1;
    aL=0.3;
    aE=0.2;
    VF=0.5;%1; 
    VL=0.2;%1;
    VE=20;%50;
    F=S;
    L=S;
    b=0.1;%0.05;
    
    num=4;

    for n=1:num
        SUM1=imfilter(Y,M);
        SUM2=imfilter(Y,W);
        for i=1:ROW
            for j=1:COL
               F(i,j)=exp(-aF)*F(i,j)+S(i,j)+VF*SUM1(i,j);
               L(i,j)=exp(-aL)*L(i,j)+VL* SUM2(i,j);
               U(i,j)=F(i,j)*(1+b*L(i,j));
               E(i,j)=exp(-aE)*E(i,j)+VE*Y(i,j);
               if  U(i,j)-E(i,j)>0
                    Y(i,j)=1; 
              else
                    Y(i,j)=0;
              end
           end 
        end

    end
    
figure(4)
imshow(Y)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%                          www.matlabnet.ir                         %
%                   Free Download  matlab code and movie            %
%                          Shahab Poursafary                        %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

