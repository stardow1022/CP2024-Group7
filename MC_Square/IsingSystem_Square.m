classdef IsingSystem_Square
    properties   %属性
       spinstate
       
       %...
    end
    properties(Dependent)
        H
        M_sq
    end
    methods   %方法
        function obj = IsingSystem_Square(spinstate)%...
            obj.spinstate = reshape(spinstate, sqrt(size(spinstate,2)), sqrt(size(spinstate,2))) * 2 - 1;
        end
        function H=get.H(obj)
            J=1;
            H = -J * sum(sum(obj.spinstate .* circshift(obj.spinstate, [0, 1])) + sum(obj.spinstate .* circshift(obj.spinstate, [1, 0])));
        end
        function M_sq=get.M_sq(obj)
            M_sq = sum(obj.spinstate,'all')^2;
        end

    end
end