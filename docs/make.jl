using GoogleHashCode2014
using Documenter

DocMeta.setdocmeta!(
    GoogleHashCode2014, :DocTestSetup, :(using GoogleHashCode2014); recursive=true
)

cp(
    joinpath(dirname(@__DIR__), "README.md"),
    joinpath(@__DIR__, "src", "index.md");
    force=true,
)

makedocs(;
    modules=[GoogleHashCode2014],
    authors="Guillaume Dalle",
    sitename="GoogleHashCode2014.jl",
    format=Documenter.HTML(),
    pages=["Home" => "index.md", "Tutorial" => "tutorial.md", "API reference" => "api.md"],
)

deploydocs(; repo="github.com/gdalle/GoogleHashCode2014.jl", devbranch="main")
