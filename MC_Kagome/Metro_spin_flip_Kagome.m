function spin = Metro_spin_flip_Kagome(spin)
    spinstate=spin.spinstate;
    i=randi(size(spinstate,1));
    j=randi(size(spinstate,2));
    spinstate(i,j)=-spinstate(i,j);
    spin=IsingSystem_Kagome((reshape(spinstate,[1,size(spinstate,1)*size(spinstate,2)])+1)./2);
end