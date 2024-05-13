function spin = Initialising_Kagome(L)
    spin_arr = randi(2,1,3*L^2)-1;
    spin=IsingSystem_Kagome(spin_arr);
end