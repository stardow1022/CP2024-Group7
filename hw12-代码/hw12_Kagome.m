clear
close all
clc
L=6;
T=5;
x=-3:0.01:0.5;
y=-2:0.01:2;
z=0:0.1:50;
for i=10:41
    Average=Statistical_Average_Kagome(i,L,T);
    a(i-4)=Average.E;
    b(i-4)=Average.M;
    c(i-4)=Average.M2;
end
for i=10:73
    Average=Statistical_Average_Kagome(i,L,T);
    a1(i-4)=Average.E;
    b1(i-4)=Average.M;
    c1(i-4)=Average.M2;
end
x1=normpdf(x,sum(a)/32,std(a))*32;
x2=normpdf(x,sum(a1)/64,std(a1))*32;
y1=normpdf(y,sum(b)/32,std(b))*16;
y2=normpdf(y,sum(b1)/64,std(b1))*32;
z1=normpdf(z,sum(c)/32,std(c))*32*15;
z2=normpdf(z,sum(c1)/64,std(c1))*64*12;
figure
hE1=histogram(a);
xlabel('E')
title('E Kagome 32bin')
hold on
plot(x,x1)
figure
plot(a)
xlabel('Block Number')
ylabel('Block Average Kagome')
figure
hE2=histogram(a1);
xlabel('E')
title('E Kagome 64bin')
hold on
plot(x,x2)
figure
hM1=histogram(b);
xlabel('M')
title('M Kagome 32bin')
hold on
plot(y,y1)
figure
hM2=histogram(b1);
xlabel('M')
title('M Kagome 64bin')
hold on
plot(y,y2)
figure
hM21=histogram(c);
xlabel('M^2')
title('M^2 Kagome 32bin')
hold on
plot(z,z1)
figure
hM22=histogram(c1);
xlabel('M^2')
title('M^2 Kagome 64bin')
hold on
plot(z,z2)