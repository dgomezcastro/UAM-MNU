using Plots, LaTeXStrings

P  = [0,0]
Q  = zeros(6,2)
scale_factor=0.75
Q[1,:] = scale_factor*[0,1]
Q[2,:] = scale_factor*[1,0]
Q[3,:] = scale_factor*[1,-1]
Q[4,:] = scale_factor*[0,-1]
Q[5,:] = scale_factor*[-1,0]
Q[6,:] = scale_factor*[-1,1]

p = plot(label="",thickness_scaling=1.5,color=:black,axis=false,grid=false,xticks=[],yticks=[],aspect_ratio=:equal,
    size = (400, 400),
    #title=latexstring("Triángulos alrededor del punto \$P_{ij}\$")
    )

for i=1:5
    global p
    p = plot!(Q[i:i+1,1],Q[i:i+1,2],color=:black,label="",linewidth=2)
end
for i=1:6
    global p
    p = plot!([P[1],Q[i,1]],[P[2],Q[i,2]],color=:black,label="",linewidth=2)
end
p = plot!([Q[1,1],Q[6,1]],[Q[1,2],Q[6,2]],color=:black,label="",linewidth=2)

p = annotate!(0.25, 0.25, text("1", :black, :center,15))
p = annotate!(-0.25, 0.5, text("2", :black, :center,15))
p = annotate!(-0.5, 0.25, text("3", :black, :center,15))
p = annotate!(-0.25, -0.25, text("4", :black, :center,15))
p = annotate!(0.25, -0.5, text("5", :black, :center,15))
p = annotate!(0.5, -0.25, text("6", :black, :center,15))

savefig(p,"UniformMesh2.png")



