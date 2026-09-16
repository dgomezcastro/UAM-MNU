using Plots, LaTeXStrings

ω = 2.0
square_wave(x) = sign(sin(ω * x))

function fourier_square_wave(x, N)
    s = 0.0
    for n = 1:2:N
        s += (4 / π) * (1 / n) * sin(n * ω * x)
    end
    return s
end

x = range(0, 2π, length = 1000)

plot(x, square_wave.(x), label = "Square Wave", lw = 2, color = :black)

for N in [5, 25, 125]
    plot!(x, fourier_square_wave.(x, N), label = "N = $N")
end

title!("Gibbs Phenomenon in Fourier Series")
xlabel!(L"x")
ylabel!(L"f(x)")

savefig("Gibbs.pdf")