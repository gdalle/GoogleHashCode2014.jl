"""
    is_feasible(solution::Solution, city::City; verbose::Bool=false)

Check if `solution` satisfies the constraints for the instance defined by `city`.

The following criteria are considered (taken from the problem statement):
- the number of itineraries has to match the number of cars of `city`
- the first junction of each itinerary has to be the starting junction of `city`
- for each consecutive pair of junctions on an itinerary, a street connecting these junctions has to exist in `city` (if the street is one directional, it has to be traversed in the correct direction)
- the duration of each itinerary has to be lower or equal to the total duration of `city`

# Example

```jldoctest
julia> using GoogleHashCode2014, Random

julia> city = read_city();

julia> rng = Random.MersenneTwister(0);

julia> solution = random_walk(rng, city)
Solution with 8 itineraries of lengths [3810, 3277, 3779, 3278, 3451, 3697, 4366, 3707]

julia> is_feasible(solution, city; verbose=false)
true

julia> partial_solution = Solution(solution.itineraries[1:7])
Solution with 7 itineraries of lengths [3810, 3277, 3779, 3278, 3451, 3697, 4366]

julia> is_feasible(partial_solution, city; verbose=false)
false
```
"""
function is_feasible(solution::Solution, city::City; verbose::Bool=false)
    nb_itineraries = length(solution.itineraries)
    if nb_itineraries != city.nb_cars
        verbose &&
            @warn "Incoherent number of itineraries $nb_itineraries (it should be equal to the number of cars $(city.nb_cars))."
        return false
    else
        for (c, itinerary) in enumerate(solution.itineraries)
            j0 = first(itinerary)
            if j0 != city.starting_junction
                verbose && @warn "Itinerary $c has invalid starting junction index $j0."
                return false
            else
                duration = 0
                for v in 1:(length(itinerary) - 1)
                    i, j = itinerary[v], itinerary[v + 1]
                    exists = false
                    for street in city.streets
                        if is_street(i, j, street)
                            exists = true
                            duration += street.duration
                            break
                        end
                    end
                    if !exists
                        verbose &&
                            @warn "A street linking junction indices $i -> $j does not exist."
                        return false
                    end
                end
                if duration > city.total_duration
                    verbose &&
                        @warn "Itinerary $c has duration $duration > $(city.total_duration) seconds."
                    return false
                end
            end
        end
    end
    return true
end

"""
    total_distance(solution::Solution, city::City)

Compute the total distance traveled by all itineraries in `solution` based on the street data from `city`.

!!! warning
    Streets visited several times or in both directions are only counted once.

# Example


```jldoctest
julia> using GoogleHashCode2014, Random

julia> city = read_city();

julia> rng = Random.MersenneTwister(0);

julia> solution = random_walk(rng, city)
Solution with 8 itineraries of lengths [3810, 3277, 3779, 3278, 3451, 3697, 4366, 3707]

julia> total_distance(solution, city)
752407
```
"""
function total_distance(solution::Solution, city::City)
    L = 0
    for street in city.streets
        visited = false
        for itinerary in solution.itineraries
            for v in 1:(length(itinerary) - 1)
                i, j = itinerary[v], itinerary[v + 1]
                if is_street(i, j, street)
                    L += street.distance
                    visited = true
                    break
                end
            end
            if visited
                break
            end
        end
    end
    return L
end
