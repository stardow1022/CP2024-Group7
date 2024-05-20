classdef Binomial_Test_of_Four_Lattices < matlab.unittest.TestCase

    methods (Test)
        function test_Square(test)%??IsingSystem_Square??
            import matlab.unittest.constraints.IsGreaterThanOrEqualTo
            import matlab.unittest.constraints.IsLessThanOrEqualTo
            import matlab.unittest.constraints.AbsoluteTolerance
            L=10;
            T=5;
            for i=1001:1064
                Average=Statistical_Average_Square(i,L,T);
                a1(i-1000)=Average.E;
                b1(i-1000)=Average.M;
                c1(i-1000)=Average.M2;
            end
            E_Average=sum(a1)/64;
            E_SE=std(a1);
            M_Average=sum(b1)/64;
            M_SE=std(b1);
            M2_Average=sum(c1)/64;
            M2_SE=std(c1);
            z=1.96;
            a=0;b=0;c=0;
            spin0=Initialising_Square(L);
            for i=1:500000
                [spin,E1,M1,M21]=Sweep_Square(spin0,T);
                spin0=spin;
                E(i)=E1;
                M(i)=M1;
                M2(i)=M21;
            end
            E=E./L^2;
            M=M./L^2;
            M2=M2/L^4;

            for i=30000:500000
                if E(i)<= E_Average+E_SE*z && E(i)>=E_Average-E_SE*z
                    a=a+1;
                end
                if M(i)<= M_Average+M_SE*z && M(i)>=M_Average-M_SE*z
                    b=b+1;
                end
                if M2(i)<= M2_Average+M2_SE*z && M2(i)>=M2_Average-M2_SE*z
                    c=c+1;
                end
            end
            test.verifyThat(a/(500000-30000+1),IsLessThanOrEqualTo(0.99));
            test.verifyThat(a/(500000-30000+1),IsGreaterThanOrEqualTo(0.91));
            test.verifyThat(b/(500000-30000+1),IsLessThanOrEqualTo(0.99));
            test.verifyThat(b/(500000-30000+1),IsGreaterThanOrEqualTo(0.91));
            test.verifyThat(c/(500000-30000+1),IsLessThanOrEqualTo(1));
            test.verifyThat(c/(500000-30000+1),IsGreaterThanOrEqualTo(0.91));
        end

        function test_Honeycomb(test)%KÕIsingSystem_Honeycomb
            import matlab.unittest.constraints.IsGreaterThanOrEqualTo
            import matlab.unittest.constraints.IsLessThanOrEqualTo
            import matlab.unittest.constraints.AbsoluteTolerance
            L=6;
            T=5;
            for i=1001:1064
                Average=Statistical_Average_Honeycomb(i,L,T);
                a1(i-1000)=Average.E;
                b1(i-1000)=Average.M;
                c1(i-1000)=Average.M2;
            end
            E_Average=sum(a1)/64;
            E_SE=std(a1);
            M_Average=sum(b1)/64;
            M_SE=std(b1);
            M2_Average=sum(c1)/64;
            M2_SE=std(c1);
            z=1.96;
            a=0;b=0;c=0;
            spin0=Initialising_Honeycomb(L);
            for i=1:500000
                [spin,E1,M1,M21]=Sweep_Honeycomb(spin0,T);
                spin0=spin;
                E(i)=E1(2);
                M(i)=M1(2);
                M2(i)=M21(2);
            end
            E=E./L^2;
            M=M./L^2;
            M2=M2/L^4;

            for i=30000:500000
                if E(i)<= E_Average+E_SE*z && E(i)>=E_Average-E_SE*z
                    a=a+1;
                end
                if M(i)<= M_Average+M_SE*z && M(i)>=M_Average-M_SE*z
                    b=b+1;
                end
                if M2(i)<= M2_Average+M2_SE*z && M2(i)>=M2_Average-M2_SE*z
                    c=c+1;
                end
            end
            test.verifyThat(a/(500000-30000+1),IsLessThanOrEqualTo(1));
            test.verifyThat(a/(500000-30000+1),IsGreaterThanOrEqualTo(0.91));
            test.verifyThat(b/(500000-30000+1),IsLessThanOrEqualTo(1));
            test.verifyThat(b/(500000-30000+1),IsGreaterThanOrEqualTo(0.91));
            test.verifyThat(c/(500000-30000+1),IsLessThanOrEqualTo(1));
            test.verifyThat(c/(500000-30000+1),IsGreaterThanOrEqualTo(0.91));
        end

        function test_Kagome(test)%KÕIsingSystem_Kagome
            import matlab.unittest.constraints.IsGreaterThanOrEqualTo
            import matlab.unittest.constraints.IsLessThanOrEqualTo
            import matlab.unittest.constraints.AbsoluteTolerance
            L=3;
            T=5;
            for i=1001:1064
                Average=Statistical_Average_Kagome(i,L,T);
                a1(i-1000)=Average.E;
                b1(i-1000)=Average.M;
                c1(i-1000)=Average.M2;
            end
            E_Average=sum(a1)/64;
            E_SE=std(a1);
            M_Average=sum(b1)/64;
            M_SE=std(b1);
            M2_Average=sum(c1)/64;
            M2_SE=std(c1);
            z=1.96;
            a=0;b=0;c=0;
            spin0=Initialising_Kagome(L);
            for i=1:500000
                [spin,E1,M1,M21]=Sweep_Kagome(spin0,T);
                spin0=spin;
                E(i)=E1(2);
                M(i)=M1(2);
                M2(i)=M21(2);
            end
            E=E./3/L^2;
            M=M./3/L^2;
            M2=M2/9/L^4;

            for i=30000:500000
                if E(i)<= E_Average+E_SE*z && E(i)>=E_Average-E_SE*z
                    a=a+1;
                end
                if M(i)<= M_Average+M_SE*z && M(i)>=M_Average-M_SE*z
                    b=b+1;
                end
                if M2(i)<= M2_Average+M2_SE*z && M2(i)>=M2_Average-M2_SE*z
                    c=c+1;
                end
            end
            test.verifyThat(a/(500000-30000+1),IsLessThanOrEqualTo(1));
            test.verifyThat(a/(500000-30000+1),IsGreaterThanOrEqualTo(0.91));
            test.verifyThat(b/(500000-30000+1),IsLessThanOrEqualTo(1));
            test.verifyThat(b/(500000-30000+1),IsGreaterThanOrEqualTo(0.91));
            test.verifyThat(c/(500000-30000+1),IsLessThanOrEqualTo(1));
            test.verifyThat(c/(500000-30000+1),IsGreaterThanOrEqualTo(0.91));
        end

        function test_Cubic(test)%KÕIsingSystem_Cubic
            import matlab.unittest.constraints.IsGreaterThanOrEqualTo
            import matlab.unittest.constraints.IsLessThanOrEqualTo
            import matlab.unittest.constraints.AbsoluteTolerance
            L=3;
            T=5;
            for i=1001:1064
                Average=Statistical_Average_Cubic(i,L,T);
                a1(i-1000)=Average.E;
                b1(i-1000)=Average.M;
                c1(i-1000)=Average.M2;
            end
            E_Average=sum(a1)/64;
            E_SE=std(a1);
            M_Average=sum(b1)/64;
            M_SE=std(b1);
            M2_Average=sum(c1)/64;
            M2_SE=std(c1);
            z=1.96;
            a=0;b=0;c=0;
            spin0=Initialising_Cubic(L);
            for i=1:500000
                [spin,E1,M1,M21]=Sweep_Cubic(spin0,T);
                spin0=spin;
                E(i)=E1;
                M(i)=M1;
                M2(i)=M21;
            end
            E=E./L^3;
            M=M./L^3;
            M2=M2/L^6;

            for i=30000:500000
                if E(i)<= E_Average+E_SE*z && E(i)>=E_Average-E_SE*z
                    a=a+1;
                end
                if M(i)<= M_Average+M_SE*z && M(i)>=M_Average-M_SE*z
                    b=b+1;
                end
                if M2(i)<= M2_Average+M2_SE*z && M2(i)>=M2_Average-M2_SE*z
                    c=c+1;
                end
            end
            test.verifyThat(a/(500000-30000+1),IsLessThanOrEqualTo(1));
            test.verifyThat(a/(500000-30000+1),IsGreaterThanOrEqualTo(0.91));
            test.verifyThat(b/(500000-30000+1),IsLessThanOrEqualTo(1));
            test.verifyThat(b/(500000-30000+1),IsGreaterThanOrEqualTo(0.91));
            test.verifyThat(c/(500000-30000+1),IsLessThanOrEqualTo(1));
            test.verifyThat(c/(500000-30000+1),IsGreaterThanOrEqualTo(0.91));
        end


    end

end
