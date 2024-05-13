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
