function spin = Metro_spin_flip_Cubic(spin)
    spinstate=spin.spinstate;
    i=randi(size(spinstate,1));
    j=randi(size(spinstate,2));
    k=randi(size(spinstate,3));
    spinstate(i,j,k)=-spinstate(i,j,k);
    spin=IsingSystem_Cubic((reshape(spinstate,[1,size(spinstate,1)*size(spinstate,2)*size(spinstate,3)])+1)./2);
end