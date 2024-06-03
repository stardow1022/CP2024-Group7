% 参数设置
LL = [4,5,6,7,8,100]; % 网格大小
T = 2.0; % 温度
J = 1; % 相互作用常数
num_MCs = 1000; % 模拟步数

% 初始化自旋网格，取值为-1或1
for j = 1:6
    L=LL(j);
spins = 2 * randi([0, 1], L, L) - 1;

% 计算加入簇的概率
p_add = 1 - exp(-2 * J / T);


for i=1:num_MCs
    [spins,E(j,i),M(j,i)] = Sweep_Square(spins,T,L);
end
figure (1)
plot(E(j,:))
hold on
figure (2)
plot(M(j,:))
hold on
end
%%
function [spins,E,M] = Sweep_Square(spins,T,L)
    p_add = 1 - exp(-2 * 1 / T);
    for step = 1:L^2
    % 随机选择一个种子自旋
    seed_i = randi(L);
    seed_j = randi(L);
    
    % 初始化簇和待处理列表
    cluster = false(L, L);
    to_process = [seed_i, seed_j];
    cluster(seed_i, seed_j) = true;
    
    % 簇生长
    while ~isempty(to_process)
        % 从待处理列表中取出一个自旋
        [current_i, current_j] = deal(to_process(1, 1), to_process(1, 2));
        to_process(1, :) = [];
        
        % 检查四个方向的邻居自旋
        neighbors = [
            mod(current_i - 2, L) + 1, current_j;
            mod(current_i, L) + 1, current_j;
            current_i, mod(current_j - 2, L) + 1;
            current_i, mod(current_j, L) + 1;
        ];
        
        for k = 1:4
            ni = neighbors(k, 1);
            nj = neighbors(k, 2);
            if ~cluster(ni, nj) && spins(current_i, current_j) == spins(ni, nj)
                if rand < p_add
                    cluster(ni, nj) = true;
                    to_process = [to_process; ni, nj];
                end
            end
        end
    end
    
    % 翻转簇中的所有自旋
    spins(cluster) = -spins(cluster);
    
    
    end
    M = sum(spins,"all")/L^2;
    E = -1 * sum(sum(spins .* circshift(spins, [0, 1])) + sum(spins .* circshift(spins, [1, 0])));
    E = -E/L^2;
end