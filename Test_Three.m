classdef Test_Three < matlab.unittest.TestCase


    methods (Test)
        function test1(test)%测试IsingSystem_Honeycomb方法
            in = IsingSystem_Honeycomb([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0,0,0,1,1,1]);             %输入
            expOut = [1,-1,1,1,-1,1,1,-1;-1,1,1,1,-1,1,1,1;1,-1,1,-1,1,-1,-1,1;-1,1,-1,1,-1,-1,-1,1];      %期待的输出
            actualOut = in.spinstate;                %调用待测程序
            test.verifyEqual(actualOut,expOut);
        end
        
        function test2(test)%测试getneigh方法
            in = IsingSystem_Honeycomb([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0,0,0,1,1,1]);
            expOut = [-1,1,-1];
            actualOut = getneigh(in,1,2);
            test.verifyEqual(actualOut,expOut);
        end
        
        function test3(test)%测试getneigh方法
            in = IsingSystem_Honeycomb([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0,0,0,1,1,1]);
            expOut = [-1,-1,-1];
            actualOut = getneigh(in,4,1);
            test.verifyEqual(actualOut,expOut);
        end

        function test4(test)%测试geth方法
            in = IsingSystem_Honeycomb([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0,0,0,1,1,1]);
            expOut = 3;
            actualOut = geth(in,1,1);
            test.verifyEqual(actualOut,expOut);
        end
        
        function test5(test) %测试get.H方法
            % Verifies single input case
            in        = IsingSystem_Honeycomb([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0,0,0,1,1,1]);
            expOut    = 16;      %期待的输出
            actualOut = in.H;                %调用待测程序
            test.verifyEqual(actualOut,expOut); %比较实际输出与期待输出
        end
        
        function test6(test)%测试get.M_Sq方法
            in = IsingSystem_Honeycomb([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0,0,0,1,1,1]);
            expOut = 16;
            actualOut = in.M_sq;
            test.verifyEqual(actualOut,expOut);
            
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
    end

end