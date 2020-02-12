module PushDirectBenchmarkTest
using PushDirectBenchmark
using PushDirectBenchmark: f1, f2, f3, f4, f5, f6, f7
using Test

@testset "PushDirectBenchmark.jl" begin
    n = 1000
    @test f1(n) == f2(n)
    @test f1(n) == f3(n)
    @test_throws BoundsError f4(n)
    @test f1(n) != f5(n)
    @test f1(n) == f6(n)
    @test f1(n) == f7(n)
end

end # module
