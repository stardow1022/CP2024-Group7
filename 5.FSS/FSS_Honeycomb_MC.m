clear
clc
J=1;
kb=1;
T=linspace(0.6,2.6,20);
Tc=1.5;

Z=zeros(size(T,2),1);
M_sq_a=zeros(size(T,2),3);
M_sq_sq_a=zeros(size(T,2),3);
H_1=zeros(size(T,2),1);
E=zeros(size(T,2),1);
b=1./(kb.*T);
LL = [3,5,7];
for m=1:3
    L = LL(m);
    t=(T-Tc)/Tc/(L^(-1));
    for j=1:size(T,2)
        spin_arr = randi(2,1,2*L^2)-1;
        %spin0 = Initialising_Square(L);
        spin0=IsingSystem_Honeycomb(spin_arr);
        for i =1:1000000
            spin = Metro_spin_flip_Honeycomb(spin0);
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
        M_sq_a(j,m) = mean(M_sq(:,j));
        M_sq_sq_a(j,m) = mean(M_sq_sq(:,j));
        
    end
    %M_sq_a=M_sq_a./Z;
    BR(:,m)=M_sq_sq_a(:,m)./M_sq_a(:,m).^2;
    BR(BR==0)=1;
    figure (2)
    plot(T,M_sq_a(:,m));
    title('平均磁化平方随温度变化关系图像');
    xlabel('T');
    ylabel('M^2');
    hold on
    figure (4)
    plot(T,BR(:,m))
    title('Honeycomb Lattice');
    xlabel('T');
    ylabel('Binder Ratio');
    legend('L=3','L=5','L=7')
    hold on
end
%% 
function spin = Metro_spin_flip_Honeycomb(spin)
    spinstate=spin.spinstate;
    i=randi(size(spinstate,1));
    j=randi(size(spinstate,2));
    spinstate(i,j)=-spinstate(i,j);
    spin=IsingSystem_Honeycomb((reshape(spinstate,[1,size(spinstate,1)*size(spinstate,2)])+1)./2);
end
