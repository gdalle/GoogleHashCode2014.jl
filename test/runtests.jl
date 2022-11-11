using Aqua
using Documenter
using HashCode2014
using JuliaFormatter
using Test

DocMeta.setdocmeta!(HashCode2014, :DocTestSetup, :(using HashCode2014); recursive=true)

@testset verbose = true "HashCode2014.jl" begin
    @testset verbose = true "Code quality (Aqua.jl)" begin
        Aqua.test_all(HashCode2014; ambiguities=false)
    end

    @testset verbose = true "Code formatting (JuliaFormatter.jl)" begin
        @test format(HashCode2014; verbose=true, overwrite=false)
    end

    @testset verbose = true "Doctests (Documenter.jl)" begin
        doctest(HashCode2014)
    end

    @testset verbose = true "Small instance" begin
        input_path = joinpath(@__DIR__, "data", "example_input.txt")
        output_path = joinpath(@__DIR__, "data", "example_output.txt")
        city = read_city(input_path)
        solution = read_solution(output_path)
        open(input_path, "r") do file
            @test string(city) == read(file, String)
        end
        open(output_path, "r") do file
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
