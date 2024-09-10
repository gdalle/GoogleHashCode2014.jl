# Tutorial

## Getting started

To install this package, just run

```julia
using Pkg
Pkg.add("GoogleHashCode2014")
```

## Instance and solutions

A problem instance is encoded in an object of type [`City`](@ref).
You can create one for the setting of the challenge (the streets of Paris) as follows:

```jldoctest tuto
julia> using GoogleHashCode2014

julia> city = read_city()
City with 11348 junctions and 17958 streets.
8 cars start from junction 4517 and travel for at most 54000s.

julia> city.junctions[10]  # get the junction object corresponding to junction index 10
Junction located at coordinates (48.872250900000004, 2.3124588)

julia> city.streets[10]
Bidirectional street between junction indices 6814 and 2728 - duration 13s, distance 187m
```

A problem solution is encoded in an object of type [`Solution`](@ref).
You can generate a random one like this:

```jldoctest tuto
julia> using Random: MersenneTwister

julia> rng = MersenneTwister(0);

julia> solution = random_walk(rng, city)
Solution with 8 itineraries of lengths [3810, 3277, 3779, 3278, 3451, 3697, 4366, 3707]
```

Then, you can check its feasibility and objective value:

```jldoctest tuto
julia> is_feasible(solution, city; verbose=true)
true

julia> total_distance(solution, city)
752407
```

Finally, you can export it to a text file:

```jldoctest tuto
julia> write_solution(solution, joinpath(tempdir(), "solution.txt"))
true
```

## Visualization

If you load the package [PythonCall.jl](https://github.com/JuliaPy/PythonCall.jl), you will be able to visualize a `City` and its `Solution` with a nice HTML map.
The code below yields an object that is displayed automatically in a Jupyter or Pluto notebook.
If you are working outside of a notebook, just open the resulting file `"city_map.html"` in your favorite browser.

```julia
using PythonCall
city_map = plot_streets(city, solution; path="city_map.html")
```

## Performance

This package was designed for pedagogical purposes.
It defines types and functions that may be suboptimal in terms of performance.
The goal is to invite students to reimplement their own, while providing them with a reliable starting point.
