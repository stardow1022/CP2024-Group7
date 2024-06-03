clear
clc
J=1;
kb=1;
T=linspace(3.1,6.0,30);
Z=zeros(size(T,2),1);
M_sq_a=zeros(size(T,2),1);
M_sq_sq_a=zeros(size(T,2),1);
H_1=zeros(size(T,2),1);
E=zeros(size(T,2),1);
b=1./(kb.*T);
LL = [3,7,11];
Tc = 4.48;

for m=1:3
    L = LL(m);
    t=(T-Tc)/Tc/(L^(-0.63));
    for j=1:size(T,2)
        spin_arr = randi(2,1,L^3)-1;
        %spin0 = Initialising_Square(L);
        spin0=IsingSystem_Cubic(spin_arr);
        for i =1:10000000
            spin = Metro_spin_flip_Cubic(spin0);
            dE = spin.H - spin0.H;
            if dE < 0
                spin0 = spin;
            else
                if exp(-dE/T(j))>rand
                    spin0 = spin;
                end
            end
            H(i,j) = spin0.H;
            M_sq(i,j) = spin0.M_sq;
            M_sq_sq(i,j) = spin0.M_sq.^2;
        end
        M_sq_a(j) = mean(M_sq(:,j));
        M_sq_sq_a(j) = mean(M_sq_sq(:,j));
        
    end
    %M_sq_a=M_sq_a./Z;
    BR=M_sq_sq_a./M_sq_a.^2;
    BR(BR==0)=1;
    figure (2)
    plot(T,M_sq_a);
    title('平均磁化平方随温度变化关系图像');
    xlabel('T');
    ylabel('M^2');
    hold on
    figure (4)
    plot(t,BR)
    title('Cubic Lattice');
    xlabel('t/L^{-1/\nu}');
    ylabel('Binder Ratio');
    legend('L=3','L=7','L=11')
    hold on
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
