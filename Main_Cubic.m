clear
clc
kb=1;
T=linspace(0.05,4.0,79);
Z=zeros(size(T,2),1);
M_sq_a=zeros(size(T,2),1);
M_sq_sq_a=zeros(size(T,2),1);
H_1=zeros(size(T,2),1);
E=zeros(size(T,2),1);
b=1./(kb.*T);
for L=2:3
    clear C
    for i=0:2^(L^3)-1
        spin_arr = dec2bin(i, L^3) - '0';
        spin=IsingSystem_Cubic(spin_arr,L);
        H=spin.H;
        M_sq=spin.M_sq;
        M_sq_sq=spin.M_sq^2;
        for j=1:size(T,2)
            Z(j)=Z(j)+exp(-b(j)*H);
            H_1(j)=H_1(j)+H^2*exp(-b(j)*H);
            E(j)=E(j)+H*exp(-b(j)*H);
            M_sq_a(j)=M_sq_a(j)+M_sq*exp(-b(j)*H);
            M_sq_sq_a(j)=M_sq_sq_a(j)+M_sq_sq*exp(-b(j)*H);
        end
    end
    H_1=H_1./Z;
    E=E./Z;
    E2=E/L^3;
    M_sq_a2=M_sq_a./Z/L^6;
    C=(H_1-E.^2)./T'.^2/L^3;
    BR=M_sq_sq_a./M_sq_a.^2.*Z;
    BR(find(BR==0))=1;
    figure (1)
    plot(T,C);
    title('Kagome Lattice (exact)');
    xlabel('T');
    ylabel('C');
    hold on
    figure (2)
    plot(T,M_sq_a2);
    title('Kagome Lattice (exact)');
    xlabel('T');
    ylabel('M^2');
    hold on
    figure (3)
    plot(T,E2)
    title('Kagome Lattice (exact)');
    xlabel('T');
    ylabel('E');
    hold on
    figure (4)
    plot(T,BR)
    title('Kagome Lattice (exact)');
    xlabel('T');
    ylabel('Binder Ratio');
    hold on
end
%% 
%2*2ã
clear
clc
J=1;
kb=1;
T=linspace(0.05,4.0,79);
Z=zeros(size(T,2),1);
M_sq_a=zeros(size(T,2),1);
H_1=zeros(size(T,2),1);
E=zeros(size(T,2),1);
b=1./(kb.*T);
for L=2
    clear C
    spins = dec2bin(0:2^(L^3)-1) - '0';
    for i=1:size(spins,1)
        spin_arr = spins(i,:);
        spin=IsingSystem_Cubic(spin_arr,L);
        H=spin.H;
        M_sq=spin.M_sq;
        for j=1:size(T,2)
            Z(j)=Z(j)+exp(-b(j)*H);
            H_1(j)=H_1(j)+H^2*exp(-b(j)*H);
            E(j)=E(j)+H*exp(-b(j)*H);
            M_sq_a(j)=M_sq_a(j)+M_sq*exp(-b(j)*H);
        end
    end
    H_1=H_1./Z;
    E=E./Z;
    figure (5)
    plot(T,E)
    title('2*2 Kagome Lattice (exact)');
    xlabel('T');
    ylabel('E');
    figure (6)
    x=exp(4*b*J);
    E22=-24*(-1+3*x-5*x.^2+3*x.^3-3*x.^4+5*x.^5-3*x.^6+x.^7)./(1+x)./(1+x.^2)./(1-4*x+8*x.^2-4*x.^3+x.^4);
    plot(T,E22');
    title('2*2 Kagome Lattice (fomular)');
    xlabel('T');
    ylabel('E');
end