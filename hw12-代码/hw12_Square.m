clear
clc
L=10;
T=5;
x=-0.7:0.01:0.2;
y=-0.5:0.01:0.5;
z=0:0.1:10;
for i=5:36
    Average=Statistical_Average_Square(i,L,T);
    a(i-4)=Average.E;
    b(i-4)=Average.M;
    c(i-4)=Average.M2;
end
for i=5:68
    Average=Statistical_Average_Square(i,L,T);
    a1(i-4)=Average.E;
    b1(i-4)=Average.M;
    c1(i-4)=Average.M2;
end
x1=normpdf(x,sum(a)/32,std(a));
x2=normpdf(x,sum(a1)/64,std(a1));
y1=normpdf(y,sum(b)/32,std(b));
y2=normpdf(y,sum(b1)/64,std(b1));
z1=normpdf(z,sum(c)/32,std(c))*32;
z2=normpdf(z,sum(c1)/64,std(c1))*64;
figure
hE1=histogram(a);
xlabel('E')
title('E Square 32bin')
hold on
plot(x,x1)
figure
plot(a)
xlabel('Block Number')
ylabel('Block Average Square')
figure
hE2=histogram(a1);
xlabel('E')
title('E Square 64bin')
hold on
plot(x,x2)
figure
hM1=histogram(b);
xlabel('M')
title('M Square 32bin')
hold on
plot(y,y1)
figure
hM2=histogram(b1);
xlabel('M')
title('M Square 64bin')
hold on
plot(y,y2)
figure
hM21=histogram(c);
xlabel('M^2')
title('M^2 Square 32bin')
hold on
plot(z,z1)
figure
hM22=histogram(c1);
xlabel('M^2')
title('M^2 Square 64bin')
hold on
plot(z,z2)
%%
function spin = Metro_spin_flip_Square(spin)
    spinstate=spin.spinstate;
    i=randi(size(spinstate,1));
    j=randi(size(spinstate,2));
    spinstate(i,j)=-spinstate(i,j);
    spin=IsingSystem_Square((reshape(spinstate,[1,size(spinstate,1)*size(spinstate,2)])+1)./2);
end
%%
function [spin,E,M,M2] = Sweep_Square(spin0,T)
    spin = spin0;
    L=size(spin0.spinstate,1);
    E=zeros(1,L^2);
    M=E;
    M2=E;
    for i=1:L^2
        spin1 = Metro_spin_flip_Square(spin);
        dE=spin1.H-spin.H;
        if dE<0
            spin=spin1;
        else
            p=exp(-dE/T);
            if p>rand
                spin=spin1;
            end
        end
        E(i)=spin.H;
        M(i)=sum(spin.spinstate,'all');
        M2(i)=spin.M_sq;
    end
end