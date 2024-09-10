"""
    random_walk(rng::Random.AbstractRNG, city::City)
    random_walk(city:::City)

Compute and return a [`Solution`](@ref) from `city` by letting each car follow a random walk from its starting point.

!!! tip
    You can pass a random number generator with a specific seed, like `Random.MersenneTwister(0)`, to obtain reproducible results.
    Otherwise, the global random number generator will be used, and the results will be different for every run.

# Example

```jldoctest
julia> using GoogleHashCode2014, Random

julia> city = read_city();

julia> rng = Random.MersenneTwister(0);

julia> solution = random_walk(rng, city)
Solution with 8 itineraries of lengths [3810, 3277, 3779, 3278, 3451, 3697, 4366, 3707]

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
function random_walk(rng::AbstractRNG, city::City)
    (; total_duration, nb_cars, starting_junction, streets) = city
    itineraries = Vector{Vector{Int}}(undef, nb_cars)
    for c in 1:nb_cars
        itinerary = [starting_junction]
        duration = 0
        while true
            current_junction = last(itinerary)
            candidates = [
                (s, street) for (s, street) in enumerate(streets) if (
                    is_street_start(current_junction, street) &&
                    duration + street.duration <= total_duration
                )
            ]
            if isempty(candidates)
                break
            else
                s, street = rand(rng, candidates)
                next_junction = get_street_end(current_junction, street)
                push!(itinerary, next_junction)
                duration += street.duration
            end
        end
        itineraries[c] = itinerary
    end
    return Solution(itineraries)
end

random_walk(city::City) = random_walk(default_rng(), city)
