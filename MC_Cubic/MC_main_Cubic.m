T=4.5;
L=3;
spin0=Initialising_Cubic(L);
for i=1:10000
    spin=Sweep_Cubic(spin0,T);
    E(i)=spin.H/L^3;
    M(i)=sum(spin.spinstate,"all")/L^3;
    M2(i)=spin.M_sq/L^3;
end
figure(1)
plot(E)
ylabel('E')
title('Cubic')
figure(2)
plot(M)
ylabel('M')
title('Cubic')
