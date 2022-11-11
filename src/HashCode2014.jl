"""
    HashCode2014

Lightweight package designed to interact with the data of the 2014 Google Hash Code.

Challenge description: <https://storage.googleapis.com/coding-competitions.appspot.com/HC/2014/hashcode2014_final_task.pdf>

Challenge data: <https://storage.googleapis.com/coding-competitions.appspot.com/HC/2014/paris_54000.txt>

Made for MIT course C25: [_Julia: Solving Real-World Problems with Computation_](https://github.com/mitmath/JuliaComputation)
"""
module HashCode2014

using Artifacts
using PythonCall

export Junction
export Street
export City, read_city, write_city
export Solution, read_solution, write_solution
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
include("plot.jl")

end
