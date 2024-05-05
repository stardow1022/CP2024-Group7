classdef IsingSystem_Honeycomb
    properties   %属性
       spinstate
       
       %...
    end
    properties(Dependent)
        H
        M_sq
    end
    methods   %方法
        function obj = IsingSystem_Honeycomb(spinstate)%...
            obj.spinstate = reshape(spinstate, sqrt(size(spinstate,2)/2), 2*sqrt(size(spinstate,2)/2)) * 2 - 1;
        end
        function neigh = getneigh(obj,i,j)
            L=size(obj.spinstate,1);
            if mod(i,2)==1
                neigh = [obj.spinstate(i,mod(2*j-3,2*L)+1), obj.spinstate(i,2*j), obj.spinstate(mod(i-2,L)+1,2*j-1)];
            else
                neigh = [obj.spinstate(i,2*j-1), obj.spinstate(i,mod(2*j,2*L)+1), obj.spinstate(mod(i-2,L)+1,2*j)];
            end
        end
        function h = geth(obj,i,j)
            J=1;
            neigh=getneigh(obj,i,j);
            if mod(i,2)==1
                h=-J*(obj.spinstate(i,2*j-1)*(sum(neigh)));
            else
                h=-J*(obj.spinstate(i,2*j)*(sum(neigh)));
            end
        end
        function H=get.H(obj)
            H=0;
            for i=1:size(obj.spinstate,1)
                for j=1:size(obj.spinstate,1)
                    h=geth(obj,i,j);
                    H=H+h;
                end
            end
        end
        function M_sq=get.M_sq(obj)
            M_sq = sum(obj.spinstate,'all')^2;
        end

    end
end