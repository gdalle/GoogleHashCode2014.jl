"""
    Solution

Store a set of itineraries, one for each car.

# Fields
- `itineraries::Vector{Vector{Int}}`: each itinerary is a vector of junction indices
"""
Base.@kwdef struct Solution
    itineraries::Vector{Vector{Int}}
end

function Solution(solution_string::AbstractString)
    lines = split(solution_string, "\n")
    C = parse(Int, lines[1])
    itineraries = Vector{Vector{Int}}(undef, C)
    k = 2
    for c in 1:C
        V = parse(Int, lines[k])
        itinerary = Vector{Int}(undef, V)
        for v in 1:V
            i = parse(Int, lines[k + v])
            itinerary[v] = i + 1
        end
        itineraries[c] = itinerary
        k += V + 1
    end
    return Solution(; itineraries=itineraries)
end

function Base.string(solution::Solution)
    C = length(solution.itineraries)
    s = "$C\n"
    for itinerary in solution.itineraries
        V = length(itinerary)
        s *= "$V\n"
        for i in itinerary
            s *= "$(i-1)\n"
        end
    end
    return chop(s; tail=1)
end

"""
    read_solution(solution, path)

Read and parse a [`Solution`](@ref) from a file located at `path`.
"""
function read_solution(path)
    solution_string = open(path, "r") do file
        read(file, String)
    end
    return Solution(solution_string)
end

"""
    write_solution(solution, path)

Write a [`Solution`](@ref) to a file located at `path`.
"""
function write_solution(solution::Solution, path)
    solution_string = string(solution)
    open(path, "w") do file
        write(file, solution_string)
    end
end
