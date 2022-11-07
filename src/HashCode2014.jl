"""
    HashCode2014

Lightweight package designed to store the data of the 2014 Google Hash Code.

Challenge description: <https://storage.googleapis.com/coding-competitions.appspot.com/HC/2014/hashcode2014_final_task.pdf>

Challenge data: <https://storage.googleapis.com/coding-competitions.appspot.com/HC/2014/paris_54000.txt>
"""
module HashCode2014

using Artifacts

export Junction
export Street
export City, read_city, write_city
export Solution, read_solution, write_solution

include("junction.jl")
include("street.jl")
include("city.jl")
include("solution.jl")

end
