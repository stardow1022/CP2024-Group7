clear
clc
J=1;
kb=1;
T=2.21;
LL = [2,8,32,64];
n_L = size(LL,2);
M_sq_a=zeros(size(T,2),n_L);
M_sq_sq_a=zeros(size(T,2),n_L);
H_1=zeros(size(T,2),1);
E=zeros(size(T,2),1);
b=1./(kb.*T);
for m=1:4
    L = LL(m);

    spin_arr = randi(2,1,L^2)-1;
    %spin0 = Initialising_Square(L);
    spin0=IsingSystem_Square(spin_arr);
    for i =1:2000000
        spin = Metro_spin_flip_Square(spin0);
        dE = spin.H - spin0.H;
        if dE < 0
            spin0 = spin;
        else
            if exp(-dE/T)>rand
                spin0 = spin;
            end
        end
        H(i) = spin0.H;
        M_sq(i) = spin0.M_sq;
        M_sq_sq(i) = spin0.M_sq.^2;
        M4H(i) = spin0.M_sq.^2.*spin0.H;
        M2H(i) = spin0.M_sq.*spin0.H;
    end
    H_a(m) = mean(H(:));
    M_sq_a(m) = mean(M_sq(:));
    M_sq_sq_a(m) = mean(M_sq_sq(:));
    M4H_a(m) = mean(M4H(:));
    M2H_a(m) = mean(M2H(:));

    D(m) = -M4H_a(m)./M_sq_a(m).^2-M_sq_sq_a(m).*H_a(m)./M_sq_a(m).^2+2*M_sq_sq_a(m).*M2H_a(m)./M_sq_a(m).^3;
end
D=log10(-D);
LL=log10(LL);
figure
plot(LL,D)
xlabel('log_{10}L')
ylabel('log_{10}((-1)d_\beta (Binder Ratio))')
title('Cubic')
hold on
P = polyfit(LL,D,1);
%%
function spin = Metro_spin_flip_Square(spin)
    spinstate=spin.spinstate;
    i=randi(size(spinstate,1));
    j=randi(size(spinstate,2));
    spinstate(i,j)=-spinstate(i,j);
    spin=IsingSystem_Square((reshape(spinstate,[1,size(spinstate,1)*size(spinstate,2)])+1)./2);
end