T=4.5;
L=3;
spin0=Initialising_Cubic(L);
for i=1:10000
    spin=Sweep_Cubic(spin0,T);
end
E=spin.H;
M=sum(spin.spinstate,"all");
M2=spin.M_sq;