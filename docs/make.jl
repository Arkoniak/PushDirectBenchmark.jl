using Documenter, PushDirectBenchmark

makedocs(;
    modules=[PushDirectBenchmark],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/Arkoniak/PushDirectBenchmark.jl/blob/{commit}{path}#L{line}",
    sitename="PushDirectBenchmark.jl",
    authors="Andrey Oskin",
    assets=String[],
)

deploydocs(;
    repo="github.com/Arkoniak/PushDirectBenchmark.jl",
)
