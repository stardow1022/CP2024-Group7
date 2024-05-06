function spin = Initialising_Cubic(L)
    spin_arr = randi(2,1,L^3)-1;
    spin=IsingSystem_Cubic(spin_arr);
end