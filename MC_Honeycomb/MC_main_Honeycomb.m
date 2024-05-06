T=4.5;
L=3;
spin0=Initialising_Honeycomb(L);
for i=1:100000
    spin=Sweep_Honeycomb(spin0,T);
end
E=spin.H;
M=sum(spin.spinstate,"all");
M2=spin.M_sq;