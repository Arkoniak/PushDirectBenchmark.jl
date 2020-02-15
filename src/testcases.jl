"""
This file contains descriptions of test cases of an array initialization.
Each test case has unique name and an implementation body.
The body is a function with the only argument - array size.
"""

register_test_case("direct") do n
    local x = Vector{Int}(undef, n)
    for i in 1:n
        x[i] = i
    end
    x
end

register_test_case("push_hint") do n
    local x = Int[]
    for i in 1:n
        push!(x, i)
    end
    x
end

register_test_case("push") do n
    local x = Int[]
    sizehint!(x, n)
    for i in 1:n
        push!(x, i)
    end
    x
end

register_test_case("f4", ignore = true) do n
    local x = Int[]
    sizehint!(x, n)
    for i in 1:n
        x[i] = i
    end
    x
end

register_test_case("f5", ignore = true) do n
    local x = Vector{Int}(undef, n)
    for i in 1:n
        push!(x, i)
    end
    x
end

register_test_case("direct_inbounds") do n
    local x = Vector{Int}(undef, n)
    for i in 1:n
        @inbounds x[i] = i
    end
    x
end
