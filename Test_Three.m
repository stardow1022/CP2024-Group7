classdef Test_Three < matlab.unittest.TestCase



    methods (Test)
        function test11(test)%测试IsingSystem_Honeycomb方法
            in = IsingSystem_Honeycomb([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0,0,0,1,1,1]);             %输入
            expOut = [1,-1,1,1,-1,1,1,-1;-1,1,1,1,-1,1,1,1;1,-1,1,-1,1,-1,-1,1;-1,1,-1,1,-1,-1,-1,1];      %期待的输出
            actualOut = in.spinstate;                %调用待测程序
            test.verifyEqual(actualOut,expOut);
        end
        
        function test12(test)%测试getneigh方法
            in = IsingSystem_Honeycomb([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0,0,0,1,1,1]);
            expOut = [-1,1,-1];
            actualOut = getneigh(in,1,2);
            test.verifyEqual(actualOut,expOut);
        end
        
        function test13(test)%测试getneigh方法
            in = IsingSystem_Honeycomb([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0,0,0,1,1,1]);
            expOut = [-1,-1,-1];
            actualOut = getneigh(in,4,1);
            test.verifyEqual(actualOut,expOut);
        end

        function test14(test)%测试geth方法
            in = IsingSystem_Honeycomb([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0,0,0,1,1,1]);
            expOut = 3;
            actualOut = geth(in,1,1);
            test.verifyEqual(actualOut,expOut);
        end
        
        function test15(test) %测试get.H方法
            % Verifies single input case
            in        = IsingSystem_Honeycomb([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0,0,0,1,1,1]);
            expOut    = 16;      %期待的输出
            actualOut = in.H;                %调用待测程序
            test.verifyEqual(actualOut,expOut); %比较实际输出与期待输出
        end
        
        function test16(test)%测试get.M_Sq方法
            in = IsingSystem_Honeycomb([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0,0,0,1,1,1]);
            expOut = 16;
            actualOut = in.M_sq;
            test.verifyEqual(actualOut,expOut);
            
        end

        function test17(test)%测试
            import matlab.unittest.constraints.IsLessThanOrEqualTo
            import matlab.unittest.constraints.AbsoluteTolerance
            J=1;
            kb=1;
            T=linspace(0.05,4.0,79);
            Z=zeros(size(T,2),1);
            M_sq_a=zeros(size(T,2),1);
            H_1=zeros(size(T,2),1);
            E=zeros(size(T,2),1);
            b=1./(kb.*T);
            L=2;
            spins = dec2bin(0:2^(L*2*L)-1) - '0';
            for i=1:size(spins,1)
                spin_arr = spins(i,:);
                spin=IsingSystem_Honeycomb(spin_arr);
                H=spin.H;
                M_sq=spin.M_sq;
                for j=1:size(T,2)
                    Z(j)=Z(j)+exp(-b(j)*H);
                    H_1(j)=H_1(j)+H^2*exp(-b(j)*H);
                    E(j)=E(j)+H*exp(-b(j)*H);
                    M_sq_a(j)=M_sq_a(j)+M_sq*exp(-b(j)*H);
                end
            end
            E=E./Z;
            x=exp(b*J);
            E22=-12*(-1+3*x.^2-5*x.^4+3*x.^6-3*x.^8+5*x.^10-3*x.^12+x.^14)./(1+x.^2)./(1+x.^4)./(1-4*x.^2+8*x.^4-4*x.^6+x.^8);
            actualOut = E;
            expOut = E22';
            A=actualOut-expOut;
            for i=1:79
                test.verifyThat(abs(A(i)),IsLessThanOrEqualTo(0.000001));
            end
        end
        
        function test21(test)%测试IsingSystem_Kagome方法
            in = IsingSystem_Kagome([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0]);             %输入
            expOut = [1    -1    -1     1     1     1     1     1     1
        -1    -1     1     1     1    -1    -1    -1     1
         1     1     1    -1    -1    -1     1    -1    -1];      %期待的输出
            actualOut = in.spinstate;                %调用待测程序
            test.verifyEqual(actualOut,expOut);
        end
        
        function test22(test)%测试getneigh方法
            in = IsingSystem_Kagome([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0]);
            expOut = [1,-1,1,1];
            actualOut = getneigh(in,1,2);
            test.verifyEqual(actualOut,expOut);
        end
        
        function test23(test)%测试getneigh方法
            in = IsingSystem_Kagome([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0]);
            expOut = [-1     1     1     -1];
            actualOut = getneigh(in,2,2);
            test.verifyEqual(actualOut,expOut);
        end

        function test24(test)%测试geth方法
            in = IsingSystem_Kagome([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0]);
            expOut = 0;
            actualOut = geth(in,2,2);
            test.verifyEqual(actualOut,expOut);
        end
        
        function test25(test) %测试get.H方法
            % Verifies single input case
            in        = IsingSystem_Kagome([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0]);
            expOut    = -2;      %期待的输出
            actualOut = in.H;                %调用待测程序
            test.verifyEqual(actualOut,expOut); %比较实际输出与期待输出
        end
        
        function test26(test)%测试get.M_Sq方法
            in = IsingSystem_Kagome([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0]);
            expOut = 9;
            actualOut = in.M_sq;
            test.verifyEqual(actualOut,expOut);
            
        end

        function test27(test)%测试
            import matlab.unittest.constraints.IsLessThanOrEqualTo
            import matlab.unittest.constraints.AbsoluteTolerance
            J=1;
            kb=1;
            T=linspace(0.05,4.0,79);
            Z=zeros(size(T,2),1);
            M_sq_a=zeros(size(T,2),1);
            H_1=zeros(size(T,2),1);
            E=zeros(size(T,2),1);
            b=1./(kb.*T);
            L=2;
            clear C
            spins = dec2bin(0:2^(L*3*L)-1) - '0';
            for i=1:size(spins,1)
                spin_arr = spins(i,:);
                spin=IsingSystem_Kagome(spin_arr);
                H=spin.H;
                M_sq=spin.M_sq;
                for j=1:size(T,2)
                    Z(j)=Z(j)+exp(-b(j)*H);
                    H_1(j)=H_1(j)+H^2*exp(-b(j)*H);
                    E(j)=E(j)+H*exp(-b(j)*H);
                    M_sq_a(j)=M_sq_a(j)+M_sq*exp(-b(j)*H);
                end
            end
            E=E./Z;
            x=exp(4*b*J);
            E22=-24*(-1-10*x+7*x.^2+12*x.^3+7*x.^4-2*x.^5+x.^6)./(5+2*x+x.^2)./(9+12*x+14*x.^2-4*x.^3+x.^4);
            actualOut = E;
            expOut = E22';
            A=actualOut-expOut;
            for i=1:79
                test.verifyThat(abs(A(i)),IsLessThanOrEqualTo(0.2));
            end
        end

        function test31(test)%测试IsingSystem_Cubic方法
            in = IsingSystem_Cubic([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0],3);             %输入
            expOut(1,:,:) = [1,1,1;-1,1,1;-1,1,1];      %期待的输出
            expOut(2,:,:) = [-1,1,-1;-1,1,-1;1,-1,1];
            expOut(3,:,:) = [1,-1,1;1,-1,-1;1,-1,-1];
            actualOut = in.spinstate;                %调用待测程序
            test.verifyEqual(actualOut,expOut);
        end

        function test32(test) %测试get.H方法
            % Verifies single input case
            in        = IsingSystem_Honeycomb([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0,0,0,1,1,1]);
            expOut    = 16;      %期待的输出
            actualOut = in.H;                %调用待测程序
            test.verifyEqual(actualOut,expOut); %比较实际输出与期待输出
        end
        
        function test33(test)%测试get.M_Sq方法
            in = IsingSystem_Honeycomb([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0,0,0,1,1,1]);
            expOut = 16;
            actualOut = in.M_sq;
            test.verifyEqual(actualOut,expOut);
            
        end

        function test34(test)%测试
            import matlab.unittest.constraints.IsLessThanOrEqualTo
            import matlab.unittest.constraints.AbsoluteTolerance
            J=1;
            kb=1;
            T=linspace(0.05,4.0,79);
            Z=zeros(size(T,2),1);
            M_sq_a=zeros(size(T,2),1);
            H_1=zeros(size(T,2),1);
            E=zeros(size(T,2),1);
            b=1./(kb.*T);
            for L=2
                clear C
                spins = dec2bin(0:2^(L^3)-1) - '0';
                for i=1:size(spins,1)
                    spin_arr = spins(i,:);
                    spin=IsingSystem_Cubic(spin_arr,L);
                    H=spin.H;
                    M_sq=spin.M_sq;
                    for j=1:size(T,2)
                        Z(j)=Z(j)+exp(-b(j)*H);
                        H_1(j)=H_1(j)+H^2*exp(-b(j)*H);
                        E(j)=E(j)+H*exp(-b(j)*H);
                        M_sq_a(j)=M_sq_a(j)+M_sq*exp(-b(j)*H);
                    end
                end
                H_1=H_1./Z;
                E=E./Z;
            end
            x=exp(4*b*J);
            E22=-24*(-1+3*x-5*x.^2+3*x.^3-3*x.^4+5*x.^5-3*x.^6+x.^7)./(1+x)./(1+x.^2)./(1-4*x+8*x.^2-4*x.^3+x.^4);
            actualOut = E;
            expOut = E22';
            A=actualOut-expOut;
            for i=1:79
                test.verifyThat(abs(A(i)),IsLessThanOrEqualTo(0.00001));
            end
        end
    end

end
