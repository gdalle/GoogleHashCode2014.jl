"""
    Street

Store an edge between two [`Junction`](@ref)s.

# Fields
- `j::Int`: street index
- `A::Int`: index of the first junction
- `B::Int`: index of the second junction
- `D::Int`: direction, `1` for one-directional (`A -> B` only) and `2` for bi-directional
- `C::Int`: time cost of traversing the street (in seconds)
- `L::Int`: length of the street (in meters)
"""
Base.@kwdef struct Street
    j::Int
    A::Int
    B::Int
    D::Int
    C::Int
    L::Int
end
