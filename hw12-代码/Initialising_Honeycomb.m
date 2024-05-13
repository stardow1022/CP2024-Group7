function spin = Initialising_Honeycomb(L)
    spin_arr = randi(2,1,2*L^2)-1;
    spin=IsingSystem_Honeycomb(spin_arr);
end