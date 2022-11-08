"""
    Street

Store an edge between two [`Junction`](@ref)s.

# Fields
- `index::Int`: street index
- `endpointA::Int`: index of the first junction
- `endpointB::Int`: index of the second junction
- `bidirectional::Bool`: whether `B -> A` is allowed
- `time::Int`: time cost of traversing the street (in seconds)
- `length::Int`: length of the street (in meters)
"""
Base.@kwdef struct Street
    index::Int
    endpointA::Int
    endpointB::Int
    bidirectional::Bool
    time::Int
    length::Int
end
