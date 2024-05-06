classdef IsingSystem_Cubic
    properties
       spinstate % 存储每个格点的自旋状态
    end
    properties(Dependent)
        H % 系统的哈密顿量
        M_sq % 系统的磁化强度平方
    end
    methods
        function obj = IsingSystem_Cubic(spinstate)
            % 构造函数，初始化自旋状态和晶格大小
            % 假设spinstate是一个线性数组
            L=size(spinstate,2)^(1/3);
            obj.spinstate = reshape(spinstate, L, L, L) * 2 - 1;
        end
        function H = get.H(obj)
            J = 1; % 交换常数
            % 计算哈密顿量，考虑每个方向的周期性边界条件
            H = -J * sum(sum(sum(obj.spinstate .* circshift(obj.spinstate, [0, 1, 0])))) ...
                -J * sum(sum(sum(obj.spinstate .* circshift(obj.spinstate, [1, 0, 0])))) ...
                -J * sum(sum(sum(obj.spinstate .* circshift(obj.spinstate, [0, 0, 1]))));
        end
        function M_sq = get.M_sq(obj)
            % 计算磁化强度平方
            M_sq = sum(obj.spinstate, 'all')^2;
        end
    end
end