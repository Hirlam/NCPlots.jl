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
        collapselevel = 1,
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Examples" => [
            "Basic" => "examples/era5_pv.md",
            "Light" => "examples/light.md",
            "Animation" => "examples/animations.md",
            "Geopotential height" => "examples/geopotential.md",
            "Sliders and Menus" => "examples/sliders_menus.md",
            "Multiple plot in axis" => "examples/single_axis.md",
            "Limited Area plots" => "examples/lam.md"
        ], 
        "Getting data" => "cds.md",
        "Keyboard control" => "keyboard.md",
        "API reference" => "references.md"
    ],
)

deploydocs(;
    repo="github.com/Hirlam/NCPlots.jl",
    devbranch="main",
)
