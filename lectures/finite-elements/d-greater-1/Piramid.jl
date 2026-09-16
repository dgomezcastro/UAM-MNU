P  = [0,0]
Q  = zeros(6,2)
scale_factor=0.75
Q[1,:] = scale_factor*[0,1]
Q[2,:] = scale_factor*[1,0]
Q[3,:] = scale_factor*[1,-1]
Q[4,:] = scale_factor*[0,-1]
Q[5,:] = scale_factor*[-1,0]
Q[6,:] = scale_factor*[-1,1]

using PyPlot
N=6
plot_trisurf(vec([Q[1:N,1]; P[1]]),
    vec([Q[1:N,2]; P[2]]),
    vec([zeros(N,1);1]),
    )
PyPlot.xticks([])
PyPlot.yticks([])
PyPlot.zticks([0,1])
savefig("Piramid.png")