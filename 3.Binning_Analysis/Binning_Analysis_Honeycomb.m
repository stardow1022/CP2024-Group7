clear
clc
L=[4,8,16];
T = 2.2;
N = 2^25;
E = zeros(size(L,2),N);
M = E;
for i=1:size(L,2)
    spin_arr = randi(2,1,2*L(i)^2)-1;
    %spin0 = Initialising_Square(L);
    spin0=IsingSystem_Honeycomb(spin_arr);
    for t=1:10000
        spin = Metro_spin_flip_Honeycomb(spin0);
        dE = spin.H - spin0.H;
        if dE < 0
            spin0 = spin;
        else
            if exp(-dE/T)>rand
                spin0 = spin;
            end
        end
    end

    for j=1:N*2
        spin = Metro_spin_flip_Honeycomb(spin0);
        dE = spin.H - spin0.H;
        if dE < 0
            spin0 = spin;
        else
            if exp(-dE/T)>rand
                spin0 = spin;
            end
        end
        E(i,j) = spin0.H;
        M(i,j) = sum(spin0.spinstate,'all');
    end
end


for j = 1:size(L,2)
    s2E = var(E(j,:));
    s2M = var(M(j,:));
    % 设置初始箱子大小
    binSize = 2;
    NB = zeros(25,1);
    % 循环直到箱子大小达到数据长度的一半
    for k = 1:25
    
        % 计算当前箱子数量
        numBins = 2^26/2^k;
    
        % 初始化合并后的数据向量
        binnedE = zeros(numBins, 1);
        binnedM = zeros(numBins, 1);
    
        % 计算合并后的箱子平均值
        for i = 1:numBins
            binStart = (i-1)*binSize + 1;
            binEnd = i*binSize;
            binnedE(i) = mean(E(j,binStart:binEnd));
            binnedM(i) = mean(M(j,binStart:binEnd));
        end
        sB2E = var(binnedE);
        sB2M = var(binnedM);
        %NB(k) = 2^k;
        NB(k) = k;
        RE(k) = NB(k).*sB2E./s2E;
        RM(k) = NB(k)*sB2M./s2M;
    

        % 翻倍箱子大小
        binSize = binSize * 2;
    end
    figure (1)
    plot(NB,RE)
    xlabel('NB')
    ylabel('RE')
    title('Honeycomb')
    hold on
    figure (2)
    plot(NB,RM)
    xlabel('NB')
    ylabel('RM')
    title('Honeycomb')
    hold on
end
%% 
function spin = Metro_spin_flip_Honeycomb(spin)
    spinstate=spin.spinstate;
    i=randi(size(spinstate,1));
    j=randi(size(spinstate,2));
    spinstate(i,j)=-spinstate(i,j);
    spin=IsingSystem_Honeycomb((reshape(spinstate,[1,size(spinstate,1)*size(spinstate,2)])+1)./2);
end
