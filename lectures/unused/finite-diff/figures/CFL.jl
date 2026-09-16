using Plots, Kronecker, LaTeXStrings

a = 0.9; T = 1; 
log2Δt=-3:1:0
log2Δx=-3:1:1
cases = Base.product(log2Δt,log2Δx)  
plots = []
anim = @animate for case in cases
    log2Δt = case[1]
    log2Δx = case[2]
    Δt=2.0^log2Δt; Δx=2.0^log2Δx

    if Δt <= Δx/a
        inequality = "\\leq"
        color = :green
    else
        inequality = ">"
        color = :red
    end

    p = plot(ylim=(-.1,1.1), xlim=(-2.0,2.0),
        aspect_ratio=:equal,
        xlabel=L"x", ylabel=L"t", legend=:outerbottom, 
        title=latexstring("\\Delta t=$Δt " * inequality * " \\Delta x / a, \\Delta x = $(Δx), a = $a"),
        titlefontcolor=color)

    plot!(p, [0.0,-a],[1.0,0.0],label="Característica",color=:blue,
        linewidth=3.0)

	for i in -(2/Δx):(2/Δx), j in 0:(T/Δt)
	  scatter!(p, [i*Δx], [j*Δt],  color=:white , label="")
	end
	
	for i in 0:(T/Δt), j in 0:(T/Δt-i)
	  scatter!(p, [-j*Δx], [i*Δt],  color=:red , label="")
	end
	scatter!(p, [0], [1.0],  color=:red , label="Dependencia del método numérico")


end

gif(anim,"CFL-gif.gif", fps=0.5)