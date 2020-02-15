module PushDirectBenchmark

using BenchmarkTools
using StatsBase: median
using DataFrames
using VegaLite
using Dates
using InteractiveUtils

export plot_benchmarks, name_helper

test_cases = Vector{Tuple{String, Function}}()

function register_test_case(f::Function, title::String; ignore = false)
    if !ignore
        push!(test_cases, (title, f))
    end
end

register_test_case("direct") do n
    x = Vector{Int}(undef, n)
    for i in 1:n
        x[i] = i
    end
    x
end

register_test_case("push_hint") do n
    x = Int[]
    for i in 1:n
        push!(x, i)
    end
    x
end

register_test_case("push") do n
    x = Int[]
    sizehint!(x, n)
    for i in 1:n
        push!(x, i)
    end
    x
end

register_test_case("f4", ignore = true) do n
    x = Int[]
    sizehint!(x, n)
    for i in 1:n
        x[i] = i
    end
    x
end

register_test_case("f5", ignore = true) do n
    x = Vector{Int}(undef, n)
    for i in 1:n
        push!(x, i)
    end
    x
end

register_test_case("direct_inbounds") do n
    x = Vector{Int}(undef, n)
    for i in 1:n
        @inbounds x[i] = i
    end
    x
end

name_helper(name) = Dates.format(now(), dateformat"yyyymmddTHHMMSS_")*name

function plot_benchmarks(; dir = joinpath(@__DIR__, "..", "images"),
        maxn = 200_000,
        name = name_helper(gethostname()))

    maxn = Int(floor(log2(maxn)))
    paths = Dict{String, String}(
        "version" => "versioninfo.txt",
        "comparison" => "push_direct_comparison.png",
        "rel_max" => "push_direct_comparison_rel_max.png",
        "rel_min" => "push_direct_comparison_rel_min.png")

    for (k, v) in paths
        paths[k] = joinpath(dir, join([name, v], "_"))
    end

    open(paths["version"], "w") do f
       versioninfo(f)
    end

    df = DataFrame(n = Int[], val = Float64[], type = String[])
    for n in 2 .^ collect(0:maxn)
        for tc in test_cases
            local title = first(tc)
            local func = last(tc)
            @info "Benchmarking: $title($n)"
            local b = @benchmark $func($n)
            push!(df, (n, median(b.times)/1000, title))
        end
    end

    df |> @vlplot(
        :line,
        background="white",
        x={field=:n, scale={type="log"}, axis={gridWidth=0.5}},
        y={field=:val, scale={type="log"}, axis={gridWidth=0.5, title="Median time, μs"}},
        color=:type,
        width=600,
        height=600
    ) |> x -> save(paths["comparison"], x)

    df2 = by(df, :n) do d
        DataFrame(
            val = d[!, :val],
            type = d[!, :type],
            val_max = maximum(d[!, :val]),
            val_min = minimum(d[!, :val])
        )
    end

    df2[!, :rel_max] = df2[!, :val] ./ df2[!, :val_max]
    df2[!, :rel_min] = df2[!, :val] ./ df2[!, :val_min]

    df2 |> @vlplot(
        :line,
        background="white",
        x={field=:n, scale={type="log"}, axis={gridWidth=0.5}},
        y={field=:rel_max, axis={gridWidth=0.5, title="Median time, μs"}},
        color=:type,
        width=600,
        height=600
    ) |> x -> save(paths["rel_max"], x)

    df2 |> @vlplot(
        :line,
        background="white",
        x={field=:n, scale={type="log"}, axis={gridWidth=0.5}},
        y={field=:rel_min, axis={gridWidth=0.5, title="Median time, μs"}},
        color=:type,
        width=600,
        height=600
    ) |> x -> save(paths["rel_min"], x)
end
end # module
