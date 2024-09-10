"""
    Street

Store an edge between two junctions in a [`City`](@ref).

!!! tip
    A `Street` refers to junctions with their integer indices, not with the [`Junction`](@ref) object itself.

# Fields

- `endpointA::Int`: index of the first junction
- `endpointB::Int`: index of the second junction
- `bidirectional::Bool`: whether `B -> A` is allowed
- `duration::Int`: time cost of traversing the street (in seconds)
- `distance::Int`: length of the street (in meters)

# Example

```jldoctest
julia> using GoogleHashCode2014

julia> city = read_city();

julia> street = city.streets[10]
Bidirectional street between junction indices 6814 and 2728 - duration 13s, distance 187m

julia> street.bidirectional
true

julia> (street.endpointA, street.endpointB)
(6814, 2728)

julia> (street.distance / street.duration) * 3.6  # speed on that street in km/h
51.784615384615385

julia> street = city.streets[11]
Monodirectional street from junction index 3779 to index 7853 - duration 12s, distance 88m

julia> street.bidirectional
false
```
"""
Base.@kwdef struct Street
    endpointA::Int
    endpointB::Int
    bidirectional::Bool
    duration::Int
    distance::Int
end

function Base.show(io::IO, street::Street)
    (; endpointA, endpointB, bidirectional, duration, distance) = street
    if bidirectional
        return print(
            io,
            "Bidirectional street between junction indices $endpointA and $endpointB - duration $(duration)s, distance $(distance)m",
        )
    else
        print(
            io,
            "Monodirectional street from junction index $endpointA to index $endpointB - duration $(duration)s, distance $(distance)m",
        )
    end
end

function Base.string(street::Street)
    (; endpointA, endpointB, bidirectional, duration, distance) = street
    return "$(endpointA-1) $(endpointB-1) $(1 + bidirectional) $duration $distance"
end
