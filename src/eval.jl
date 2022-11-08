function is_feasible(solution::Solution, city::City; verbose=false)
    nb_cars = length(solution.itineraries)
    if nb_cars != city.nb_cars
        verbose && @warn "Incoherent number of cars"
        return false
    else
        for (c, itinerary) in enumerate(solution.itineraries)
            if first(itinerary) != city.starting_junction
                verbose && @warn "Itinerary $c has invalid starting junction"
                return false
            else
                V = length(itinerary)
                time = 0
                for v in 1:(V - 1)
                    i, j = itinerary[v], itinerary[v + 1]
                    exists = false
                    for street in city.streets
                        if (
                            ((i, j) == (street.endpointA, street.endpointB)) || (
                                street.bidirectional &&
                                (i, j) == (street.endpointB, street.endpointA)
                            )
                        )
                            exists = true
                            time += street.time
                            break
                        end
                    end
                    if !exists
                        verbose && @warn "Street $i -> $j does not exist"
                        return false
                    end
                end
                if time > city.total_time
                    verbose && @warn "Itinerary $c has duration $time > $(city.total_time)"
                    return false
                end
            end
        end
    end
    return true
end

function total_length(solution::Solution, city::City)
    L = 0
    for itinerary in solution.itineraries
        V = length(itinerary)
        for v in 1:(V - 1)
            i, j = itinerary[v], itinerary[v + 1]
            for street in city.streets
                if (
                    ((i, j) == (street.endpointA, street.endpointB)) || (
                        street.bidirectional &&
                        (i, j) == (street.endpointB, street.endpointA)
                    )
                )
                    L += street.length
                    break
                end
            end
        end
    end
    return L
end
