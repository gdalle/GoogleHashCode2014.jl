using HashCode2014
using Test

@testset verbose = true "HashCode2014.jl" begin
    @testset verbose = true "Small instance" begin
        city = read_city(joinpath(@__DIR__, "example_input.txt"))
        solution = read_solution(joinpath(@__DIR__, "example_output.txt"))
        solution_string = open(joinpath(@__DIR__, "example_output.txt"), "r") do file
            read(file, String)
        end
        @test string(solution) == solution_string
        @test is_feasible(solution, city)
        @test total_length(solution, city) > 0
    end
    @testset verbose = true "Large instance" begin
        city = read_city()
        @test city.total_time == 54000
    end
end
