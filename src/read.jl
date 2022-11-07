"""
    read_data()

Read the text file available at <https://storage.googleapis.com/coding-competitions.appspot.com/HC/2014/paris_54000.txt> and parse it as a [`City`](@ref).
"""
function read_data()
    rootpath = artifact"paris_54000"
    lines = open(joinpath(rootpath, "bin", "paris_54000.txt")) do file
        readlines(file)
    end
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
