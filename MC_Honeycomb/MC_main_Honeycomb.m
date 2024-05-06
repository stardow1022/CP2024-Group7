T=4.5;
L=3;
spin0=Initialising_Honeycomb(L);
for i=1:100000
    spin=Sweep_Honeycomb(spin0,T);
    E(i)=spin.H/2*L^2;
    M(i)=sum(spin.spinstate,"all")/2*L^2;
    M2(i)=spin.M_sq/2*L^2;
end
figure(1)
plot(E)
ylabel('E')
title('Honeycomb')
figure(2)
plot(M)
ylabel('M')
title('Honeycomb')
