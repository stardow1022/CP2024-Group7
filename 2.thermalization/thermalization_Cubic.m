clear
clc
T=2;
L=10;
spin_arr = randi(2,1,L^3)-1;
%spin0 = Initialising_Square(L);
spin0=IsingSystem_Cubic(spin_arr);
for i=1:500
    [spin,E(i),M(i),M2(i)]=Sweep_Cubic(spin0,T);
end
figure (1)
plot(E)
hold on
plot(M)
legend("T=3K,H=0")
xlabel("Sweep Number")
title("Cubic Lattice")
%% 
function [spin,E,M,M2] = Sweep_Cubic(spin0,T)
    spin = spin0;
    L=size(spin0.spinstate,1);
    E=zeros(1,L^3);
    M=E;
    M2=E;
    for i=1:L^3
        spin1 = Metro_spin_flip_Cubic(spin);
        dE=spin1.H-spin.H;
        if dE<0
            spin=spin1;
        else
            p=exp(-dE/T);
            if p>rand
                spin=spin1;
            end
        end
        
    end
    E = -spin.H/L^3;
    M = sum(spin.spinstate,'all')/L^3;
    M2 = spin.M_sq;
end
%% 
function spin = Metro_spin_flip_Cubic(spin)
    spinstate=spin.spinstate;
    i=randi(size(spinstate,1));
    j=randi(size(spinstate,2));
    k=randi(size(spinstate,3));
    spinstate(i,j,k)=-spinstate(i,j,k);
    spin=IsingSystem_Cubic((reshape(spinstate,[1,size(spinstate,1)*size(spinstate,2)*size(spinstate,3)])+1)./2);
end

