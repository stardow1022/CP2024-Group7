function spin = Initialising_Square(L)
    spin_arr = randi(2,1,L^2)-1;
    spin=IsingSystem_Square(spin_arr);
end