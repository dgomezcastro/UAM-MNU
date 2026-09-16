using Polynomials, Plots, LaTeXStrings

runge(x) = 1 / (1 + 25x^2)

plot(runge, xlims = (-1, 1), label = "Runge Function", lw = 2, color = :black)

function interpolate_runge(n)
    x_nodes = range(-1, 1, length = n)
    y_nodes = runge.(x_nodes)
    p = Polynomials.fit(x_nodes, y_nodes, n - 1)
    return x_nodes, p
end


for n in [5, 10, 12]
    x_nodes, p = interpolate_runge(n)
    plot!(x -> p(x), label = "n = $n")
end

title!("Runge's Phenomenon in Polynomial Interpolation")
xlabel!(L"x")
ylabel!(L"f(x)")
ylims!(-0.5, 1.2)

savefig("Runge.pdf")
