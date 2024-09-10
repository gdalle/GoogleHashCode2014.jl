"""
    Junction

Store a junction from a [`City`](@ref).

!!! tip
    Junctions are usually referred to by their integer index in a city's list of junctions.
    The junction object itself is mainly useful for geographic visualization.

# Fields

- `latitude::Float64`: latitude (in decimal degrees)
- `longitude::Float64`: longitude (in decimal degrees)

# Example

```jldoctest
julia> using GoogleHashCode2014

julia> city = read_city();

julia> junction = city.junctions[10]  # get the junction object at junction index 10
Junction at coordinates (48.872250900000004, 2.3124588)

julia> junction.latitude
48.872250900000004
```
"""
@kwdef struct Junction
    latitude::Float64
    longitude::Float64
end

function Base.show(io::IO, junction::Junction)
    (; latitude, longitude) = junction
    return print(io, "Junction at coordinates ($latitude, $longitude)")
end

function Base.string(junction::Junction)
    (; latitude, longitude) = junction
    return "$latitude $longitude"
end
