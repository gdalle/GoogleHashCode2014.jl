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

function City(city_string::AbstractString)
    lines = split(city_string, "\n")
    N, M, T, C, S = map(s -> parse(Int, s), split(lines[1]))
    junctions = Vector{Junction}(undef, N)
    for i in 1:N
        lat, long = map(s -> parse(Float64, s), split(lines[1 + i]))
        junctions[i] = Junction(; i, lat, long)
    end
    streets = Vector{Street}(undef, M)
    for j in 1:M
        A, B, D, C, L = map(s -> parse(Int, s), split(lines[1 + N + j]))
        A += 1
        B += 1
        streets[j] = Street(; j, A, B, D, C, L)
    end
    city = City(; N, M, T, C, S, junctions, streets)
    return city
end

"""
    read_city(path)

Read and parse a [`City`](@ref) from a file located at `path`.

The default path is an artifact containing the official challenge data.
"""
function read_city(
    path=joinpath(artifact"HashCode2014Data", "HashCode2014Data-0.1", "paris_54000.txt")
)
    city_string = open(path, "r") do file
        read(file, String)
    end
    return City(city_string)
end

"""
    write_city(city, path)

Write a [`City`](@ref) to a file located at `path`.
"""
function write_city(city::City, path)
    city_string = string(city)
    open(path, "w") do file
        write(file, city_string)
    end
end
