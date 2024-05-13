clear
clc
close all
L=10;
T=5;
x=-0.3:0.01:0.2;
y=-0.15:0.01:0.15;
z=0:0.1:6;
for i=10:41
    Average=Statistical_Average_Cubic(i,L,T);
    a(i-4)=Average.E;
    b(i-4)=Average.M;
    c(i-4)=Average.M2;
end
for i=10:73
    Average=Statistical_Average_Cubic(i,L,T);
    a1(i-4)=Average.E;
    b1(i-4)=Average.M;
    c1(i-4)=Average.M2;
end
x1=normpdf(x,sum(a)/32,std(a))*2;
x2=normpdf(x,sum(a1)/64,std(a1))*3;
y1=normpdf(y,sum(b)/32,std(b));
y2=normpdf(y,sum(b1)/64,std(b1))*2;
z1=normpdf(z,sum(c)/32,std(c))*5*32/1.5;
z2=normpdf(z,sum(c1)/64,std(c1))*5*32;
figure
hE1=histogram(a);
xlabel('E')
title('E Cubic 32bin')
hold on
plot(x,x1)
figure
plot(a)
xlabel('Block Number')
ylabel('Block Average Cubic')
figure
hE2=histogram(a1);
xlabel('E')
title('E Cubic 64bin')
hold on
plot(x,x2)
figure
hM1=histogram(b);
xlabel('M')
title('M Cubic 32bin')
hold on
plot(y,y1)
figure
hM2=histogram(b1);
xlabel('M')
title('M Cubic 64bin')
hold on
plot(y,y2)
figure
hM21=histogram(c);
xlabel('M^2')
title('M^2 Cubic 32bin')
hold on
plot(z,z1)
figure
hM22=histogram(c1);
xlabel('M^2')
title('M^2 Cubic 64bin')
hold on
plot(z,z2)