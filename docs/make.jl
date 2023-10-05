using HashCode2014
using Documenter

DocMeta.setdocmeta!(HashCode2014, :DocTestSetup, :(using HashCode2014); recursive=true)

cp(
    joinpath(dirname(@__DIR__), "README.md"),
    joinpath(@__DIR__, "src", "index.md");
    force=true,
)

makedocs(;
    modules=[HashCode2014],
    authors="Guillaume Dalle",
    sitename="HashCode2014.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://gdalle.github.io/HashCode2014.jl",
    ),
    pages=["Home" => "index.md", "Tutorial" => "tutorial.md", "API reference" => "api.md"],
)

deploydocs(; repo="github.com/gdalle/HashCode2014.jl", devbranch="main", push_preview=true)
