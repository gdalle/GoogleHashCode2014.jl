using HashCode2014
using Test

@testset "HashCode2014.jl" begin
    city = read_data()
    @test city.N == length(city.junctions)
    @test city.M == length(city.streets)
end
