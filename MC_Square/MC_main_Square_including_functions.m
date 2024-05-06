T=4.5;
L=3;
spin0=Initialising_Square(L);
for i=1:100000
    spin=Sweep_Square(spin0,T);
end
E=spin.H;
M=sum(spin.spinstate,"all");
M2=spin.M_sq;
%%
function spin = Initialising_Square(L)
    spin_arr = randi(2,1,L^2)-1;
    spin=IsingSystem_Square(spin_arr);
end
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
    L=size(spin0,1);
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