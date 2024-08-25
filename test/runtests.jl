using Aqua
using Documenter
using GoogleHashCode2014
using JET
using JuliaFormatter
using PythonCall
using Test

DocMeta.setdocmeta!(
    GoogleHashCode2014, :DocTestSetup, :(using GoogleHashCode2014); recursive=true
)

@testset verbose = true "GoogleHashCode2014.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(GoogleHashCode2014; ambiguities=false)
    end

    @testset "Code formatting (JuliaFormatter.jl)" begin
        @test format(GoogleHashCode2014; verbose=false, overwrite=false)
    end

    @testset "Code linting (JET.jl)" begin
        JET.test_package(GoogleHashCode2014; target_defined_modules=true)
    end

    @testset "Doctests (Documenter.jl)" begin
        doctest(GoogleHashCode2014)
    end

    @testset "Small instance" begin
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
        @test write_city(city, joinpath(tempdir(), "city.txt"))
        @test write_solution(solution, joinpath(tempdir(), "solution.txt"))
    end

    @testset "Large instance" begin
        city = read_city()
        solution = random_walk(city)
        @test city.total_duration == 54000
        @test is_feasible(solution, city)
        city_shorter = change_duration(city, 18000)
        @test city_shorter.total_duration == 18000
    end

    @testset "Plotting" begin
        city = read_city()
        solution = random_walk(city)
        plot_streets(city, solution; path=joinpath(tempdir(), "solution.html"))
    end
end
