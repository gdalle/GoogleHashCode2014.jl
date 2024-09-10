"""
    is_street(i::Integer, j::Integer, street::Street)

Check if the trip from junction index `i` to junction index `j` corresponds to a valid direction of `street`.

The valid directions for a [`Street`](@ref) are:
- from `street.endpointA` to `street.endpointB` in every case
- from `street.endpointB` to `street.endpointA` only if `street.bidirectional` is `true`

# Example

```jldoctest
julia> using GoogleHashCode2014

julia> city = read_city(); 

julia> street = city.streets[10]
Bidirectional street between junction indices 6814 and 2728 - duration 13s, distance 187m

julia> is_street(1, 2728, street)
false

julia> is_street(6814, 2728, street)
true

julia> is_street(2728, 6814, street)
true

julia> street = city.streets[11]
Monodirectional street from junction index 3779 to index 7853 - duration 12s, distance 88m

julia> is_street(3779, 7853, street)
true

julia> is_street(7853, 3779, street)  # because it is not bidirectional
false
```
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
    is_street_start(i::Integer, street::Street)

Check if junction index `i` is a valid starting point of `street`.

# Example

```jldoctest
julia> using GoogleHashCode2014

julia> city = read_city();

julia> street = city.streets[10]
Bidirectional street between junction indices 6814 and 2728 - duration 13s, distance 187m

julia> is_street_start(6814, street)
true

julia> is_street_start(2728, street)
true

julia> street = city.streets[11]
Monodirectional street from junction index 3779 to index 7853 - duration 12s, distance 88m

julia> is_street_start(3779, street)
true

julia> is_street_start(7853, street)
false
```
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
    get_street_end(i::Integer, street::Street)

Retrieve the junction index at the other end `street` when it is crossed starting from junction index `i`.

If `i` is not a valid starting point for `street`, an error is thrown.

# Example

```jldoctest
julia> using GoogleHashCode2014

julia> city = read_city();

julia> street = city.streets[10]
Bidirectional street between junction indices 6814 and 2728 - duration 13s, distance 187m

julia> get_street_end(6814, street)
2728

julia> get_street_end(2728, street)
6814

julia> street = city.streets[11]
Monodirectional street from junction index 3779 to index 7853 - duration 12s, distance 88m

julia> get_street_end(3779, street)
7853
```
"""
function get_street_end(i::Integer, street::Street)
    if i == street.endpointA
        return street.endpointB
    elseif street.bidirectional && i == street.endpointB
        return street.endpointA
    else
        throw(ArgumentError("Invalid endpoint $i for $street"))
    end
end
