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
for L=2:4
    clear C
    for i=0:2^(L*2*L)-1
        spin_arr = dec2bin(i, 2*L^2) - '0';
        spin=IsingSystem_Honeycomb(spin_arr);
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
    E2=E/2/L^2;
    M_sq_a2=M_sq_a./Z/4/L^4;
    C=(H_1-E.^2)./T'.^2/2/L^2;
    BR=M_sq_sq_a./M_sq_a.^2.*Z;
    BR(find(BR==0))=1;
    figure (1)
    plot(T,C);
    title('Honeycomb Lattice (exact)');
    xlabel('T');
    ylabel('C');
    hold on
    figure (2)
    plot(T,M_sq_a2);
    title('Honeycomb Lattice (exact)');
    xlabel('T');
    ylabel('M^2');
    hold on
    figure (3)
    plot(T,E2)
    title('Honeycomb Lattice (exact)');
    xlabel('T');
    ylabel('E');
    hold on
    figure (4)
    plot(T,BR)
    title('Honeycomb Lattice (exact)');
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
    spins = dec2bin(0:2^(L*2*L)-1) - '0';
    for i=1:size(spins,1)
        spin_arr = spins(i,:);
        spin=IsingSystem_Honeycomb(spin_arr);
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
    title('2*2 Honeycomb Lattice (exact)');
    xlabel('T');
    ylabel('E');
    figure (6)
    x=exp(b*J);
    E22=-12*(-1+3*x.^2-5*x.^4+3*x.^6-3*x.^8+5*x.^10-3*x.^12+x.^14)./(1+x.^2)./(1+x.^4)./(1-4*x.^2+8*x.^4-4*x.^6+x.^8);
    plot(T,E22');
    title('2*2 Honeycomb Lattice (theoretical)');
    xlabel('T');
    ylabel('E');
end

