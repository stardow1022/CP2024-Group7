classdef IsingSystem_Kagome
    properties
        spinstate
    end
    properties(Dependent)
        H
        M_sq
    end
    methods
        function obj = IsingSystem_Kagome(spinstate)
            sideLength = sqrt(length(spinstate)/3);
            obj.spinstate = reshape(spinstate, sideLength, 3*sideLength) * 2 - 1;
        end
        function neigh = getneigh(obj, i, j)
            L = size(obj.spinstate, 1);
            if mod(i,2) == 0
        % 对于偶数行的顶点
                neigh(1) = obj.spinstate(mod(i-2-1, L)+1, mod(j-1-1, L)+1);
                neigh(2) = obj.spinstate(mod(i-1, L)+1, mod(j-1, L)+1);
                neigh(3) = obj.spinstate(i, mod(j-1, L)+1);
                neigh(4) = obj.spinstate(mod(i-2-1, L)+1, j);
            else
        % 对于奇数行的顶点
                neigh(1) = obj.spinstate(mod(i-1, L)+1, j);
                neigh(2) = obj.spinstate(i, mod(j-1-1, L)+1);
                neigh(3) = obj.spinstate(mod(i+1-1, L)+1, mod(j-1, L)+1);
                neigh(4) = obj.spinstate(mod(i-1, L)+1, mod(j+1-1, L)+1);
            end
        end
        function h = geth(obj, i, j)
            % 计算给定格点在交换相互作用下的局部磁场
            J = 1; % 交换相互作用参数
            neigh = getneigh(obj, i, j);
            h = -J * obj.spinstate(i, j) * sum(neigh);
        end
        function H = get.H(obj)
            % 计算系统的总能量
            H = 0;
            for i = 1:size(obj.spinstate, 1)
                for j = 1:size(obj.spinstate, 2)
                    H = H + geth(obj, i, j);
                end
            end
        end
        function M_sq = get.M_sq(obj)
            % 计算系统的总磁化平方
            M_sq = sum(obj.spinstate, 'all')^2;
        end
    end
end