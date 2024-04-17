clc;
clear all;
global N;
global JJ;
global Ising;
n1=30;n2=30;
cell=[1,0;1/2,sqrt(3)/2];
x=ones(n1,n2);
y=ones(n1,n2);
N=n1*n2;
JJ=440/24;
Ising=ones(n1,n2);

%画出Ising模型的结构图
for i=1:n1
    b1=0;
    b2=1;
    for j=1:n2
        if mod(i,2)==1
            if mod(j,2)==0
            b1=b1+2;
            end
            a=j-1;                
            c=0;
            d=i-1;
            f=[a,b1;c,d];
            g=diag(f*cell);
            x(i,j)=g(1);
            y(i,j)=g(2);             
        end          
        if mod(i,2)==0
            a=j-1;
            c=0;
            d=i-1;
             f=[a,b2;c,d];
            g=diag(f*cell);
            x(i,j)=g(1);
            y(i,j)=g(2);
            if mod(j,2)==0
            b2=b2+2;
            end
        end
        plot(x(i,j),y(i,j),'ro')
        xlabel('每个原子的横坐标'); 
        ylabel('每个原子的纵坐标');       
        title('Ising模型'); 
        hold on
    end
end

Temp_num=1500;MC_num=80000;MC_sta=50000;Num_sta=MC_num-MC_sta;
MuB=1;
Ev=ones(1,Temp_num);
E2v=ones(1,Temp_num);
Cv=ones(1,Temp_num);
M=ones(1,Temp_num);
M2v=ones(1,Temp_num);
XX=ones(1,Temp_num);
u1=ones(n1,n2);u2=ones(n1,n2);
Ti=1;%初始温度
Tf=1500;%最终温度
T=Ti:1:Tf;

fid = fopen('作业临时文件夹\111.txt','a'); 
fprintf(fid,'n1=%3d   n2=%3d  JJ=%10.6f     Tf=%3d   MC_nmu=%5d \n',n1, n2,JJ,Tf,MC_num);
fprintf(fid,'Temp      energy               energy^2               Cv                  M                 M^2               XX \n');


for ti=1:Temp_num
    E1=0;      
    E3=0; 
    M1=0; 
    M3=0;
    tic;
  for k=1:MC_num
    u11=-JJ.*Ising.*(circshift(Ising,[1,0])+circshift(Ising,[-1,0])+circshift(a,[0,1]));
    u22=-JJ.*Ising.*(circshift(Ising,[1,0])+circshift(Ising,[-1,0])+circshift(a,[0,-1]));
    for i=1:n1
        for j=1:n2
             if (-1)^(i+j)==1
             u1(i,j)=u11(i,j);
             else
             u1(i,j)=u22(i,j);
             end
        end
    end   
   u2=-u1;
   p1=min(1,exp(11.6045.*(u1-u2)./ti));%11.6045是KB取m.ev的单位
   p2=rand(n1,n2);
   p1(p1>p2)=-1;
   p1(p1~=-1)=1;
   Ising=Ising.*p1;
 
           if k>MC_sta
               %统计物理性质 
               M0=sum(sum(Ising))./N; 
               E0=sum(sum(u1))./N; 
               E2=E0.^2; 
               M2=M0.^2; 
               E1=E1+E0; 
               E3=E3+E2; 
               M1=M1+M0; 
               M3=M3+M2;
           end  
  end
    fprintf('temperature=%4d    time_elapsed=%10.6f \n',T(ti),toc)
   
    Ev(ti)=E1/Num_sta; 
    E2v(ti)=E3/Num_sta; 
    Cv(ti)=(11.6045)^2.*(E2v(ti)-Ev(ti)^2)/(ti^2); 
    M(ti)=MuB*abs(M1/Num_sta); 
    M2v(ti)=M3/Num_sta; 
    XX(ti)=11.6045.*(M2v(ti)-M(ti)^2)/(ti); 
    fprintf('Ev=%10.6f     E2v(ti)=%10.6f     Cv=%10.6f    M2v=%10.6f     M=%10.6f     XX=%10.6f \n',Ev(ti),E2v(ti),Cv(ti),M2v(ti),M(ti),XX(ti));
    fprintf(fid,'%3d    %10.6f     %10.6f     %10.6f    %10.6f     %10.6f     %10.6f \n',T(ti),Ev(ti),E2v(ti),Cv(ti),M(ti),M2v(ti),XX(ti));   
end
    
    
 %showpicture()
figure 
plot(T,Cv,'--*k')%,Tdown,Cv0,'--xr') 
xlabel('温度 T'); 
ylabel('热容 Cv'); 
legend('T')%,'Tdown'); 
title('温度与热容的关系图');  

 %showpicture()
figure 
plot(T,M,'--*k')%,Tdown,M0,'--xr') 
xlabel('温度 T'); 
ylabel('磁化强度 uB'); 
legend('T')%,'Tdown'); 
title('温度与磁化强度的关系图'); 


  %showpicture()
figure 
plot(T,XX,'--*k')%,Tdown,XX,'--xr') 
xlabel('温度 T'); 
ylabel('磁化率'); 
legend('T')%,'Tdown'); 
title('温度与磁化率的关系图');   
    
   %showpicture()
figure 
plot(T,Ev,'--*k')%,Tdown,E0,'--xr')  
xlabel('温度 T'); 
ylabel('平均能量 mev'); 
legend('T')%,'Tdown'); 
title('温度与平均能量的关系图');