classdef Honeycomb_Test < matlab.unittest.TestCase


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
        
        function test5(test)%测试getneigh方法
            in = IsingSystem_Honeycomb([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0,0,0,1,1,1]);
            expOut = [-1,-1,-1];
            actualOut = getneigh(in,4,1);
            test.verifyEqual(actualOut,expOut);
        end

        function test3(test)%测试geth方法
            in = IsingSystem_Honeycomb([1,0,1,0,0,1,0,1,1,1,1,0,1,1,0,1,0,0,1,0,1,1,0,0,1,1,0,0,0,1,1,1]);
            expOut = 3;
            actualOut = geth(in,1,1);
            test.verifyEqual(actualOut,expOut);
        end
        
        function testSingle(test) %测试get.H方法
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
    end

end