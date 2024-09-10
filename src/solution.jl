"""
    Solution

Store a list of itineraries through a [`City`](@ref), one for each car in.

A naive `Solution` can be computed with the function [`random_walk`](@ref).

# Fields

- `itineraries::Vector{Vector{Int}}`: each itinerary is a vector of junction indices

# Example

```jldoctest
julia> using GoogleHashCode2014, Random

julia> city = read_city();

julia> rng = Random.MersenneTwister(0);

julia> solution = random_walk(rng, city)
Solution with 8 itineraries of lengths [3810, 3277, 3779, 3278, 3451, 3697, 4366, 3707]

julia> length(solution.itineraries[2])  # number of junctions visited by car nb 2
3277

julia> itinerary = solution.itineraries[2]  # sequence of junction indices visited by car nb 2
3277-element Vector{Int64}:
  4517
  1033
  3656
  7681
   398
  4680
 10361
 10089
 10361
 10089
 10361
     ⋮
   972
  2495
  5580
  3305
  5580
  2495
  9871
  6178
  9871
  2495
```
"""
@kwdef struct Solution
    itineraries::Vector{Vector{Int}}
end

function Base.show(io::IO, solution::Solution)
    (; itineraries) = solution
    return print(
        io,
        "Solution with $(length(itineraries)) itineraries of lengths $(length.(itineraries))",
    )
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
    read_solution(path)

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
    return true
end
