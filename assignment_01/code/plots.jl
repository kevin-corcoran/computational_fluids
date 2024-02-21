using PlotlyJS
using LaTeXStrings
# plotlyjs()

# initial condition
trace1 = scatter(y=[-1,-1, 2,2, -1,-1], x=[-1,-1/2, -1/2,1/2, 1/2,1])
# trace2 = scatter(y=[], x=[])
# trace3 = scatter(y=[-1, -1], x=[1/2,1])

# latexstring("\\phi_", i))
layout = Layout(xaxis_title=L"x", yaxis_title=L"u(x,t)")

p = plot(trace1, layout)
savefig(p, "../figures/init_cond.png")
savefig(p, "../figures/init_cond.html")