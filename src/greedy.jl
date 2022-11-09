function is_street_start(i::Integer, street::Street)
    if i == street.endpointA
        return true
    elseif street.bidirectional && i == street.endpointB
        return true
    else
        return false
    end
end

function get_street_end(i::Integer, street::Street)
    if i == street.endpointA
        return street.endpointB
    elseif street.bidirectional && i == street.endpointB
        return street.endpointA
    else
        return nothing
    end
end

function greedy_algorithm(city::City)
    (; total_duration, nb_cars, starting_junction, streets) = city
    itineraries = Vector{Vector{Int}}(undef, nb_cars)
    streets_visited = fill(false, length(streets))
    @progress "Greedy algorithm" for c in 1:nb_cars
        itinerary = [starting_junction]
        duration = 0
        while true
            current_junction = last(itinerary)
            best_s, best_street, best_score = 1, first(streets), -Inf
            for (s, street) in enumerate(streets)
                valid = (
                    is_street_start(current_junction, street) &&
                    duration + street.duration <= total_duration
                )
                if valid
                    score = (1 - streets_visited[s]) * (street.distance / street.duration)
                    if score > best_score
                        best_s, best_street, best_score = s, street, score
                    end
                end
            end
            if best_score == -Inf
                break
            else
                next_junction = get_street_end(current_junction, best_street)
                push!(itinerary, next_junction)
                duration += best_street.duration
                streets_visited[best_s] = true
            end
        end
        itineraries[c] = itinerary
    end
    return Solution(itineraries)
end
