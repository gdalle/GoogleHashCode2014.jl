"""
    random_walk(rng, city)
    random_walk(city)

Create a solution from a [`City`](@ref) by letting each car follow a random walk from its starting point.
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
