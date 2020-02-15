module PushDirectBenchmarkTest
using PushDirectBenchmark
using Test

@testset "PushDirectBenchmark.jl" begin
    n = 1000
    tc_res1 = run_test_case(1, n)
    for i = 2:get_test_cases_count()
        @test tc_res1 == run_test_case(i, n)
    end
    # @test f1(n) == f2(n)
    # @test f1(n) == f3(n)
    # @test_throws BoundsError f4(n)
    # @test f1(n) != f5(n)
    # @test f1(n) == f6(n)
    # @test f1(n) == f7(n)
end

end # module
