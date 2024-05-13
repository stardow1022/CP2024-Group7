classdef Statistical_Average_Square
    properties   %属性
       number
       L
       T
       
       %...
    end
    properties(Dependent)
        E
        M
        M2
    end
    methods   %方法
        function obj = Statistical_Average_Square(number,L,T)%...
            obj.number = number;
            obj.L = L;
            obj.T = T;
        end
        function E=get.E(obj)
            spin0=Initialising_Square(obj.L);
            for i=1:obj.number
                [spin,E1,M1,M21]=Sweep_Square(spin0,obj.T);
                spin0=spin;
                E=E1;
            end
            E=sum(E)/obj.L^2;
        end
        function M=get.M(obj)
            spin0=Initialising_Square(obj.L);
            for i=1:obj.number
                [spin,E1,M1,M21]=Sweep_Square(spin0,obj.T);
                spin0=spin;
                M=M1;
            end
            M=sum(M)/obj.L^2;
        end
        function M2=get.M2(obj)
            spin0=Initialising_Square(obj.L);
            for i=1:obj.number
                [spin,E1,M1,M21]=Sweep_Square(spin0,obj.T);
                spin0=spin;
                M2=M21;
            end
            M2=sum(M2)/obj.L^2;
        end

    end
end