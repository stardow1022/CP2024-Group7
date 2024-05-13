clear
clc
L=10;
T=5;
x=-1:0.01:0.5;
y=-0.5:0.01:0.5;
z=0:0.1:25;
for i=5:36
    Average=Statistical_Average_Honeycomb(i,L,T);
    a(i-4)=Average.E;
    b(i-4)=Average.M;
    c(i-4)=Average.M2;
end
for i=5:68
    Average=Statistical_Average_Honeycomb(i,L,T);
    a1(i-4)=Average.E;
    b1(i-4)=Average.M;
    c1(i-4)=Average.M2;
end
x1=normpdf(x,sum(a)/32,std(a))*5;
x2=normpdf(x,sum(a1)/64,std(a1))*5;
y1=normpdf(y,sum(b)/32,std(b))*5;
y2=normpdf(y,sum(b1)/64,std(b1))*5;
z1=normpdf(z,sum(c)/32,std(c))*32*5;
z2=normpdf(z,sum(c1)/64,std(c1))*64*5;
figure
hE1=histogram(a);
xlabel('E')
title('E Honeycomb 32bin')
hold on
plot(x,x1)
figure
plot(a)
xlabel('Block Number')
ylabel('Block Average Honeycomb')
figure
hE2=histogram(a1);
xlabel('E')
title('E Honeycomb 64bin')
hold on
plot(x,x2)
figure
hM1=histogram(b);
xlabel('M')
title('M Honeycomb 32bin')
hold on
plot(y,y1)
figure
hM2=histogram(b1);
xlabel('M')
title('M Honeycomb 64bin')
hold on
plot(y,y2)
figure
hM21=histogram(c);
xlabel('M^2')
title('M^2 Honeycomb 32bin')
hold on
plot(z,z1)
figure
hM22=histogram(c1);
xlabel('M^2')
title('M^2 Honeycomb 64bin')
hold on
plot(z,z2)
