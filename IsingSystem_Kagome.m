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
            L = sqrt(length(spinstate)/3);
            obj.spinstate = reshape(spinstate, L, 3*L) * 2 - 1;
        end
        function neigh = getneigh(obj, i, j)
            L = size(obj.spinstate, 1);
            neigh(1) = obj.spinstate(i, j-1);
            neigh(2) = obj.spinstate(i, j+1);
            neigh(3) = obj.spinstate(mod(i-2,L)+1, j-1);
            neigh(4) = obj.spinstate(mod(i-2,L)+1, j+1);
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
            L=size(obj.spinstate, 1);
            for i = 1:size(obj.spinstate, 1)
                for j = 1:size(obj.spinstate, 1)
                    H = H + geth(obj, i, 3*(j-1)+2);
                end
            end
            J=1;
            for i=1:size(obj.spinstate, 1)
                for j=1:size(obj.spinstate, 1)
                    H = H - J*obj.spinstate(i,3*(j-1)+1)*(obj.spinstate(i,mod(3*(j-1)-1, 3*L)+1)+obj.spinstate(i,3*(j-1)+1+2));
                end
            end

        end
        function M_sq = get.M_sq(obj)
            % 计算系统的总磁化平方
            M_sq = sum(obj.spinstate, 'all')^2;
        end
    end
end
