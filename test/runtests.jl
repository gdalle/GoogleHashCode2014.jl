using HashCode2014
using Test

@testset verbose = true "HashCode2014.jl" begin
    @testset verbose = true "Small instance" begin
        city = read_city(joinpath(@__DIR__, "example_input.txt"))
        solution = read_solution(joinpath(@__DIR__, "example_output.txt"))

        open(joinpath(@__DIR__, "example_input.txt"), "r") do file
            @test string(city) == read(file, String)
        end
        open(joinpath(@__DIR__, "example_output.txt"), "r") do file
            @test string(solution) == read(file, String)
        end

        @test is_feasible(solution, city)
        @test total_distance(solution, city) == 450
    end

    @testset verbose = true "Large instance" begin
        city = read_city()
        solution = random_walk(city)
        @test city.total_duration == 54000
        @test is_feasible(solution, city)
    end

    @testset verbose = true "Plotting" begin
        city = read_city()
        solution = random_walk(city)
        plot_streets(city, solution; path=nothing)
    end
end
