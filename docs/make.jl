using NCPlots
using Documenter

# DocMeta.setdocmeta!(NCPlots, :DocTestSetup, :(using NCPlots); recursive=true)

makedocs(;
#     modules=[NCPlots],
    authors="Roel Stappers <roels@met.no> and contributors",
    sitename="NCPlots.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Hirlam.github.io/NCPlots.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Examples" => "example.md",
        "Getting data" => "cds.md",
        "Keyboard control" => "keyboard.md",
        "API reference" => "references.md"
    ],
)

deploydocs(;
    repo="github.com/Hirlam/NCPlots.jl",
    devbranch="main",
)
