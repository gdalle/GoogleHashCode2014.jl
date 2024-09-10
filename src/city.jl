"""
    City

Store a city made of [`Junction`](@ref)s and [`Street`](@ref)s, along with additional instance parameters.

A `City` object can be constructed with the function [`read_city`](@ref).

# Fields

- `total_duration::Int`: total time allotted for the car itineraries (in seconds)
- `nb_cars::Int`: number of cars in the fleet
- `starting_junction::Int`: index of the junction at which all the cars are located initially (the index refers to a position in the list of junctions)
- `junctions::Vector{Junction}`: list of junctions
- `streets::Vector{Street}`: list of streets

# Example

```jldoctest
julia> using GoogleHashCode2014

julia> city = read_city()
City with 11348 junctions and 17958 streets.
8 cars all start from junction 4517 and travel for at most 54000s.
    
julia> length(city.junctions)
11348
    
julia> length(city.streets)
17958

julia> city.starting_junction
4517

julia> city.junctions[10]  # get the junction object at junction index 10
Junction at coordinates (48.872250900000004, 2.3124588)

julia> city.streets[10]  # get the street object at street index 10
Bidirectional street between junction indices 6814 and 2728 - duration 13s, distance 187m
```
"""
@kwdef struct City
    total_duration::Int
    nb_cars::Int
    starting_junction::Int
    junctions::Vector{Junction}
    streets::Vector{Street}
end

function Base.show(io::IO, city::City)
    (; total_duration, nb_cars, starting_junction, junctions, streets) = city
    return print(
        io,
        "City with $(length(junctions)) junctions and $(length(streets)) streets.\n$nb_cars cars start from junction $starting_junction and travel for at most $(total_duration)s.",
    )
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
    read_city()
    read_city(path::AbstractString)

Parse and return a [`City`](@ref), either from the default challenge data (<https://storage.googleapis.com/coding-competitions.appspot.com/HC/2014/paris_54000.txt>), or from a similarly formatted text file located at `path`.
"""
function read_city(
    path::AbstractString=joinpath(
        artifact"GoogleHashCode2014Data", "GoogleHashCode2014Data-0.1", "paris_54000.txt"
    ),
)
    city_string = open(path, "r") do file
        read(file, String)
    end
    return City(city_string)
end

"""
    write_city(city::City, path::AbstractString)

Write `city` to a file located at `path`.
"""
function write_city(city::City, path::AbstractString)
    city_string = string(city)
    open(path, "w") do file
        write(file, city_string)
    end
    return true
end

"""
    change_duration(city::City, total_duration::Integer)

Return a new [`City`](@ref) with a different `total_duration` and every other field equal to the ones in `city`.

# Example

```jldoctest
julia> using GoogleHashCode2014

julia> city = read_city()
City with 11348 junctions and 17958 streets.
8 cars all start from junction 4517 and travel for at most 54000 seconds.

julia> change_duration(city, 3600)
City with 11348 junctions and 17958 streets.
8 cars start from junction 4517 and travel for at most 3600 seconds.
```
"""
function change_duration(city::City, total_duration::Integer)
    new_city = City(;
        total_duration=total_duration,
        nb_cars=city.nb_cars,
        starting_junction=city.starting_junction,
        junctions=copy(city.junctions),
        streets=copy(city.streets),
    )
    return new_city
end
