"""
    Junction

Store a city junction.

# Fields
- `latitude::Float64`: latitude (in decimal degrees)
- `longitude::Float64`: longitude (in decimal degrees)
"""
@kwdef struct Junction
    latitude::Float64
    longitude::Float64
end

function Base.show(io::IO, junction::Junction)
    (; latitude, longitude) = junction
    return print(io, "Junction located at coordinates ($latitude, $longitude)")
end

function Base.string(junction::Junction)
    (; latitude, longitude) = junction
    return "$latitude $longitude"
end
