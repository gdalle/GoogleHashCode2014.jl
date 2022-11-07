"""
    Junction

Store a city junction.

# Fields
- `i::Int`: junction index
- `lat::Float64`: latitude
- `long::Float64`: longitude
"""
Base.@kwdef struct Junction
    i::Int
    lat::Float64
    long::Float64
end
