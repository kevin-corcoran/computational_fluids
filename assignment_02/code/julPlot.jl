using Plots
# gr()
# using Pkg
# ENV["GRDIR"]=""
# Pkg.build("GR")

# Read solution. Columns are each timestep
data = readlines("./C_a1-2N128.dat")
u = zeros( length(data), length(parse.(Float64,split(data[1]))) )
for i = 1:length(data)
    row = parse.(Float64,split(data[i]))
    u[i,:] = row
end

x0 = 0.0; x = 1.0; N = 128; Δx = (x-x0)/N
xs = collect(0:N)*Δx

# initial condition 
plot(xs,u[:, 1])

anim = @animate for i ∈ 1:size(u)[2]
    plot(xs, u[:,i],xlims=(0,1), ylims=(-1.3,1.3))
end
gif(anim, "C_a1-2N128.gif", fps = 20)
# plot(xs, ys, label="deg(3) interpolant")
# scatter!(x_act,y_act, label="data pts")
# title!("Degree 3 Vandermondke Interpolation")
# savefig("plot_3")
