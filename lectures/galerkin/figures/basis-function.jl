using Plots, LaTeXStrings
p = plot(
    [-1, -0.5, 0, 0.25, 1],
    [0, 0, 1, 0, 0],
    label = latexstring("\\varphi_{i}"),
    xlim = (-1, 1),
    thickness_scaling = 1.5,
    linewidth = 2,
    legend = :topright,
    #xlabel=L"x",
    xticks = ([-0.5, 0, 0.25], [L"x_{i-1}", L"x_{i}", L"x_{i+1}"]),
    yticks = [0, 1],
)
savefig("./basis-function.pdf")
