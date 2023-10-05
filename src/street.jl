"""
    Street

Store an edge between two [`Junction`](@ref)s.

# Fields
- `endpointA::Int`: index of the first junction
- `endpointB::Int`: index of the second junction
- `bidirectional::Bool`: whether `B -> A` is allowed
- `duration::Int`: time cost of traversing the street (in seconds)
- `distance::Int`: length of the street (in meters)
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
    direction_descriptor = bidirectional ? "Bidirectional" : "Monodirectional"
    return print(
        io,
        "$direction_descriptor street between junctions $endpointA and $endpointB, with duration $duration seconds and distance $distance meters",
    )
end

function Base.string(street::Street)
    (; endpointA, endpointB, bidirectional, duration, distance) = street
    return "$(endpointA-1) $(endpointB-1) $(1 + bidirectional) $duration $distance"
end
