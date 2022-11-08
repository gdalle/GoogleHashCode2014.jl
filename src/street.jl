"""
    Street

Store an edge between two [`Junction`](@ref)s.

# Fields
- `index::Int`: street index
- `endpointA::Int`: index of the first junction
- `endpointB::Int`: index of the second junction
- `bidirectional::Bool`: whether `B -> A` is allowed
- `duration::Int`: time cost of traversing the street (in seconds)
- `distance::Int`: length of the street (in meters)
"""
Base.@kwdef struct Street
    index::Int
    endpointA::Int
    endpointB::Int
    bidirectional::Bool
    duration::Int
    distance::Int
end

function Base.string(street::Street)
    (; endpointA, endpointB, bidirectional, duration, distance) = street
    return "$(endpointA-1) $(endpointB-1) $(1 + bidirectional) $duration $distance"
end
