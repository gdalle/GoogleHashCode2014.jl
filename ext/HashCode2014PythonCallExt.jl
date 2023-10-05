module HashCode2014PythonCallExt

using HashCode2014
using PythonCall

function HashCode2014.plot_streets(
    city::City, solution::Union{Solution,Nothing}=nothing; path=nothing
)
    folium = pyimport("folium")

    ## Global map

    mean_latitude =
        sum(junction.latitude for junction in city.junctions) / length(city.junctions)
    mean_longitude =
        sum(junction.longitude for junction in city.junctions) / length(city.junctions)
    m = folium.Map(;
        tiles="OpenStreetMap", location=[mean_latitude, mean_longitude], zoom_start=12
    )

    ## City layer

    streets_map = folium.FeatureGroup(; name="streets", show=true)
    streets_segments = Vector{Tuple{Float64,Float64}}[]
    for street in city.streets
        junctionA = city.junctions[street.endpointA]
        junctionB = city.junctions[street.endpointB]
        endpoint_coords = [
            (junctionA.latitude, junctionA.longitude),
            (junctionB.latitude, junctionB.longitude),
        ]
        push!(streets_segments, endpoint_coords)
    end
    folium.PolyLine(streets_segments; color="black", weight=1).add_to(streets_map)

    start_latitude = city.junctions[city.starting_junction].latitude
    start_longitude = city.junctions[city.starting_junction].longitude
    folium.Marker(
        (start_latitude, start_longitude);
        icon=folium.Icon(; icon="flag", color="black", icon_color="white"),
        popup="Departure",
    ).add_to(
        streets_map
    )

    streets_map.add_to(m)

    if solution !== nothing
        cars_maps = [
            folium.FeatureGroup(; name="car $c", show=true) for c in 1:(city.nb_cars)
        ]
        colors = [
            "blue", "green", "red", "purple", "orange", "pink", "lightblue", "lightgreen"
        ]
        for c in 1:(city.nb_cars)
            itinerary = solution.itineraries[c]
            car_segments = Vector{Tuple{Float64,Float64}}[]
            for v in 1:(length(itinerary) - 1)
                junctionA = city.junctions[itinerary[v]]
                junctionB = city.junctions[itinerary[v + 1]]
                endpoint_coords = [
                    (junctionA.latitude, junctionA.longitude),
                    (junctionB.latitude, junctionB.longitude),
                ]
                push!(car_segments, endpoint_coords)
            end
            car_color = colors[(c - 1) % length(colors) + 1]
            folium.PolyLine(car_segments; color=car_color).add_to(cars_maps[c])

            folium.Marker(
                last(last(car_segments));
                icon=folium.Icon(; icon="user", color=car_color, icon_color="white"),
                popup="Car $c",
            ).add_to(
                cars_maps[c]
            )

            cars_maps[c].add_to(m)
        end
    end

    folium.LayerControl().add_to(m)

    if path !== nothing
        m.save(path)
    end
    return m
end

end
