"""
    is_street(i, j, street)

Check if the trip from junction `i` to junction `j` corresponds to a valid direction of `street`.
"""
function is_street(i::Integer, j::Integer, street::Street)
    if (i, j) == (street.endpointA, street.endpointB)
        return true
    elseif (street.bidirectional && (i, j) == (street.endpointB, street.endpointA))
        return true
    else
        return false
    end
end

"""
    is_street_start(i, street)

Check if junction `i` corresponds to a valid starting point of `street`.
"""
function is_street_start(i::Integer, street::Street)
    if i == street.endpointA
        return true
    elseif street.bidirectional && i == street.endpointB
        return true
    else
        return false
    end
end

"""
    get_street_end(i, street)

Retrieve the arrival endpoint of `street` when it starts at junction `i`.
"""
function get_street_end(i::Integer, street::Street)
    if i == street.endpointA
        return street.endpointB
    elseif street.bidirectional && i == street.endpointB
        return street.endpointA
    else
        return 0
    end
end
