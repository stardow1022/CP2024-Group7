clc;
clear all;
global N;
global Ising;
global JJ;
n1 = 3; n2 = 3; n3 = 3;
cell = [1,0,0;0,1,0;0,0,1];
x=ones(n1,n2,n3);
y=ones(n1,n2,n3);
z=ones(n1,n2,n3);
JJ=440/24;
N=n1*n2*n3;
Ising=ones(n1,n2,n3);

for i=1:n1
    for j=1:n2
        for k=1:n3
            f=[ i-1 ,0,0;0, j-1 ,0;0,0, k-1 ];
            g=diag(f*cell);
            x(i,j,k)=g(1);
            y(i,j,k)=g(2);
            z(i,j,k)=g(3);
        plot3(x(i,j,k),y(i,j,k),z(i,j,k),'ro')
        xlabel('各原子x坐标');
        ylabel('各原子y坐标');
        zlabel('各原子z坐标')
        title('Ising模型');
        hold on
        end
    end
end

Temp_num=1500 ;MC_num=80000 ;MC_sta=50000 ;Num_sta=MC_num - MC_sta;
MuB=1;
Ev=ones(1,Temp_num);
E2v=ones(1,Temp_num);
Cv=ones(1,Temp_num);
M=ones(1,Temp_num);
M2v=ones(1,Temp_num);
XX=ones(1,Temp_num);
u1=ones(n1,n2,n3);u2=ones(n1,n2,n3);
Ti=1;%初始温度
Tf=1500;%最终温度
T=Ti:1:Tf;

fid = fopen('C:\Users\19112\Desktop\model.txt','a'); 
fprintf(fid,'n1=%3d   n2=%3d  n3=%3d  JJ=%10.6f     Tf=%3d   MC_nmu=%5d \n',n1, n2, n3,JJ,Tf,MC_num);
fprintf(fid,'Temp      energy               energy^2               Cv                  M                 M^2               XX \n');


for ti=1:Temp_num
    E1=0;      
    E3=0; 
    M1=0; 
    M3=0;
    tic;
  for g=1:MC_num
    u11=-JJ.*Ising.*(circshift(Ising,[1,0,0])+circshift(Ising,[-1,0,0])+circshift(Ising,[0,1,0])+circshift(Ising,[0,-1,0])+circshift(Ising,[0,0,-1])+circshift(Ising,[0,0,1]));
    u22=-JJ.*Ising.*(circshift(Ising,[1,0,0])+circshift(Ising,[-1,0,0])+circshift(Ising,[0,-1,0])+circshift(Ising,[0,1,0])+circshift(Ising,[0,0,1])+circshift(Ising,[0,0,-1]));
    for i=1:n1
        for j=1:n2
            for k=1:n3
             if (-1)^(i+j+k)==1
             u1(i,j,k)=u11(i,j,k);
             else
             u1(i,j,k)=u22(i,j,k);
             end
            end 
        end
    end   
   u2=-u1;
   p1=min(1,exp(11.6045.*(u1-u2)./ti));%11.6045是KB取m.ev的单位
   p2=rand(n1,n2,n3);
   p1(p1>p2)=-1;
   p1(p1~=-1)=1;
   Ising=Ising.*p1;
 
           if g>MC_sta
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