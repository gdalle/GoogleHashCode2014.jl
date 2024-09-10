"""
    GoogleHashCode2014

Lightweight package designed to interact with the data of the 2014 Google Hash Code.
"""
module GoogleHashCode2014

using Artifacts: @artifact_str
using Random: AbstractRNG, default_rng

export Junction
export Street
export City, read_city, write_city, change_duration
export Solution, read_solution, write_solution
export is_street
export is_feasible, total_distance
export random_walk
export plot_streets

include("junction.jl")
include("street.jl")
include("city.jl")
include("solution.jl")
include("eval.jl")
include("utils.jl")
include("random_walk.jl")

"""
    plot_streets(
        city::City, solution::Union{Solution,Nothing}=nothing;
        path::Union{AbstractString,Nothing}=nothing
    )

Plot a [`City`](@ref) and an optional [`Solution`](@ref) using the Python library [folium](https://python-visualization.github.io/folium/), save the result as an HTML file at `path`

This method is defined in a package extension and requires PythonCall.jl to be loaded.
"""
function plot_streets end

end
