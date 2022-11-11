"""
    City

Store a city made of [`Junction`](@ref)s and [`Street`](@ref)s, along with additional instance parameters.

# Fields
- `total_duration::Int`: total time allotted for the car itineraries (in seconds)
- `nb_cars::Int`: number of cars in the fleet
- `starting_junction::Int`: junction at which all the cars are located initially
- `junctions::Vector{Junction}`: list of junctions
- `streets::Vector{Street}`: list of streets
"""
Base.@kwdef struct City
    total_duration::Int
    nb_cars::Int
    starting_junction::Int
    junctions::Vector{Junction}
    streets::Vector{Street}
end

function City(city_string::AbstractString)
    lines = split(city_string, "\n")
    N, M, T, C, S = map(s -> parse(Int, s), split(lines[1]))

    junctions = Vector{Junction}(undef, N)
    for i in 1:N
        latᵢ, longᵢ = map(s -> parse(Float64, s), split(lines[1 + i]))
        junctions[i] = Junction(; latitude=latᵢ, longitude=longᵢ)
    end
    streets = Vector{Street}(undef, M)
    for j in 1:M
        Aⱼ, Bⱼ, Dⱼ, Cⱼ, Lⱼ = map(s -> parse(Int, s), split(lines[1 + N + j]))
        streets[j] = Street(;
            endpointA=Aⱼ + 1,
            endpointB=Bⱼ + 1,
            bidirectional=Dⱼ == 2,
            duration=Cⱼ,
            distance=Lⱼ,
        )
    end
    city = City(;
        total_duration=T,
        nb_cars=C,
        starting_junction=S + 1,
        junctions=junctions,
        streets=streets,
    )
    return city
end

function Base.string(city::City)
    N, M = length(city.junctions), length(city.streets)
    T, C, S = city.total_duration, city.nb_cars, city.starting_junction - 1
    s = "$N $M $T $C $S\n"
    for junction in city.junctions
        s *= string(junction) * "\n"
    end
    for street in city.streets
        s *= string(street) * "\n"
    end
    return chop(s; tail=1)
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
