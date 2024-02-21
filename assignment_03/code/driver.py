import cfd # cfd.function() in cfd/cfd/__init__.py
from cfd.cfd import Transport1D # Transport1D class in /cfd/cfd/cfd.py
import numpy as np
from scipy.sparse import diags

a = 1.0; CFL = 1.0
# ! # Space
# ! A = 1/Δx^2 * spdiagm(-1=>ones(N-1),0=>-2.0*ones(N),1=>ones(N-1))
x0 = 0.0; x = 1.0; N = 64; delta_x = (x-x0)/N
# ! # Time
t0 = 0.0; t = 1.0; delta_t = (CFL * delta_x)/a; m = (t-t0)/delta_t
# ! subdiagonal
# forall (i = 1:n) L(i+1,i) = 1.0/2.0 + a_*delta_t/(2.0*delta_x)
# ! superdiagonal
# forall (i = 1:n) L(i,i+1) = 1.0/2.0 - a_*delta_t/(2.0*delta_x)

# ! # boundary condition
# L(1,n+1) = 1.0/2.0 + a_*delta_t/(2.0*delta_x)
# L(n+1, 1) = 1.0/2.0 - a_*delta_t/(2.0*delta_x)


# # ! # Initial Condition
# g = lambda x : np.sin(2*np.pi*x)
# 
# # Space
# xspan = (0.0, 1.0); N = 128
# 
# # Time
# tspan = (0.0, 1.0)
# a = 1.0; CFL = 1.0
# 
# prob = Transport1D("flux fn", g, tspan, xspan, a, CFL, N)
# u = prob.lax_f()


# Godunov

# Space
xspan = [0.0, 1.0]; N = 32

# Time
tspan = [0.0, 0.1]
CFL = 0.9; a = 2.5

# initial condition
def g(x):
    x_d = 0.5
    if x < x_d:
        return -1
    return 2

# flux
def f(u):
    return (u**2)/2

prob1 = Transport1D(f, g, tspan, xspan, a, CFL, N)
# prob2 = Transport1D(f, g, tspan, xspan, a, CFL, N)
u1 = prob1.godunov()
prob1.setLimiter("vanleer")
u2 = prob1.PLM_godunov()


# exact solution
x_d = 0.5; uL = -1; uR = 2
xL = lambda t: x_d + uL*t; xR = lambda t: x_d + uR*t
def u_exact(x,t):
    if x <= xL(t):
        return uL
    elif xL(t) < x < xR(t):
        return (x-x_d)/t
    elif x >= xR(t):
        return uR
dx = (xspan[1] - xspan[0])/N
xs = [xspan[0] + (i-5/2)*dx for i in range(3,N+3)]
u_ex = np.zeros((N), dtype = np.double)
for i in range(N):
    u_ex[i] = u_exact(xs[i], tspan[1])

# plot numerical vs exact
import matplotlib.pyplot as plt
plt.figure()
# plt.plot(xs,prob.u[:,-1], label = "Numerical")
plt.scatter(xs,u1, label = "Godunov 1st")
plt.scatter(xs, u2, label = "Godunov 2nd")
plt.plot(xs,u_ex, label = "Exact")
plt.legend(loc="best")
plt.show()
