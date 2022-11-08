"""
    Junction

Store a city junction.

# Fields
- `latitude::Float64`: latitude (in decimal degrees)
- `longitude::Float64`: longitude (in decimal degrees)
"""
Base.@kwdef struct Junction
    latitude::Float64
    longitude::Float64
end

function Base.string(junction::Junction)
    (; latitude, longitude) = junction
    return "$latitude $longitude"
end
