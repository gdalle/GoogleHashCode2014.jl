using HashCode2014
using Documenter

DocMeta.setdocmeta!(HashCode2014, :DocTestSetup, :(using HashCode2014); recursive=true)

makedocs(;
    modules=[HashCode2014],
    authors="Guillaume Dalle <22795598+gdalle@users.noreply.github.com> and contributors",
    repo="https://github.com/gdalle/HashCode2014.jl/blob/{commit}{path}#{line}",
    sitename="HashCode2014.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://gdalle.github.io/HashCode2014.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/gdalle/HashCode2014.jl",
    devbranch="main",
)
