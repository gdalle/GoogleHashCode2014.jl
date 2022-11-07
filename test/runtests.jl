using HashCode2014
using Test

@testset verbose = true "HashCode2014.jl" begin
    @testset verbose = true "Small instance" begin
        city = read_city(joinpath(@__DIR__, "example_input.txt"))
        solution = read_solution(joinpath(@__DIR__, "example_output.txt"))
        solution_string = string(solution)
        real_solution_string = open(joinpath(@__DIR__, "example_output.txt"), "r") do file
            read(file, String)
        end
        @test solution_string == real_solution_string
    end
    @testset verbose = true "Large instance" begin
        city = read_city()
        @test city.N == length(city.junctions)
        @test city.M == length(city.streets)
        @test city.T == 54000
    end
end
