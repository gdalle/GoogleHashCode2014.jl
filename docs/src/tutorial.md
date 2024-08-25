# Tutorial

## Getting started

This package is not registered.
You need to install it from the GitHub repo with

```julia
using Pkg
Pkg.add(url="https://github.com/gdalle/GoogleHashCode2014.jl")
```

## Instance and solutions

A problem instance is encoded in an object of type [`City`](@ref).
You can create one for the setting of the challenge (the streets of Paris) as follows:

```jldoctest tuto
julia> using GoogleHashCode2014

julia> city = read_city()
City with 11348 junctions and 17958 streets, where 8 cars must start from junction 4517 and travel for at most 54000 seconds

julia> city.junctions[1]
Junction located at coordinates (48.8351503, 2.3077904)

julia> city.streets[1]
Monodirectional street between junctions 8400 and 8402, with duration 4 seconds and distance 36 meters
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
