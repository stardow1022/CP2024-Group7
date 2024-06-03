clear
clc
T=4;
L=30;
spin_arr = randi(2,1,2*L^2)-1;
%spin0 = Initialising_Square(L);
spin0=IsingSystem_Honeycomb(spin_arr);
spin = spin0;
for i=1:10000
    [spin,E(i),M(i),M2(i)]=Sweep_Honeycomb(spin,T);
end
E = -E./(2*L^2);
M = M./(2*L^2);
figure (1)
plot(E)
hold on
plot(M)
legend("T=4K,H=0,L=20")
xlabel("Sweep Number")
title("Honeycomb Lattice")
%% 
function spin = Metro_spin_flip_Honeycomb(spin)
    spinstate=spin.spinstate;
    i=randi(size(spinstate,1));
    j=randi(size(spinstate,2));
    spinstate(i,j)=-spinstate(i,j);
    spin=IsingSystem_Honeycomb((reshape(spinstate,[1,size(spinstate,1)*size(spinstate,2)])+1)./2);
end
%% 
function [spin,E,M,M2] = Sweep_Honeycomb(spin0,T)
    spin = spin0;
    L=size(spin0,1);

    for i=1:2*L^2
        spin1 = Metro_spin_flip_Honeycomb(spin);
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
    E=spin.H;
    M=sum(spin.spinstate,'all');
    M2=spin.M_sq;
end



