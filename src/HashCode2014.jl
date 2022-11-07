"""
    HashCode2014

Lightweight package designed to store the data of the [2014 Google Hash Code](https://storage.googleapis.com/coding-competitions.appspot.com/HC/2014/hashcode2014_final_task.pdf).
"""
module HashCode2014

using Artifacts

export Junction, Street, City
export read_data

include("junction.jl")
include("street.jl")
include("city.jl")
include("read.jl")

end
