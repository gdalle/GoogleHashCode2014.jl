"""
    City

Store a city made of [`Junction`](@ref)s and [`Street`](@ref)s, along with additional instance parameters.

# Fields
- `N::Int`: number of junctions
- `M::Int`: number of streets
- `T::Int`: time allotted for the car itineraries (in seconds)
- `C::Int`: number of cars in the fleet
- `S::Int`: junction at which all the cars are located initially
- `junctions::Vector{Junction}`: list of junctions
- `streets::Vector{Street}`: list of streets
"""
Base.@kwdef struct City
    N::Int
    M::Int
    T::Int
    C::Int
    S::Int
    junctions::Vector{Junction}
    streets::Vector{Street}
end
