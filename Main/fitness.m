function  Z=fitness(x)


    global A Y1

    B2= imnoise (A,'salt & pepper',0.01);
    A1=B2;
    [ROW,COL]=size(A1);      
    S=im2double(A1);
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
        
    [peaksnr, snr] = psnr(Y,Y1);
    
    I = Y1;
    Gray = Y;
    n = size(I);
    M = n(1);
    N = n(2);
    MSE = sum(sum(I-Gray).^2)/(M*N);
    
    
    z1=peaksnr;
    z2=MSE;
    Z=[z1 z2]';

end

