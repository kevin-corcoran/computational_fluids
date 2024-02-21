import cfd # cfd.function() in cfd/cfd/__init__.py
# from cfd.cfd import Transport1D # Transport1D class in /cfd/cfd/cfd.py
# from advect1D.scalar import Transport1D
# import advect1D
from cfd.advect1d import *
import numpy as np
from scipy.sparse import diags

# Space
xspan = [0.0, 1.0]; N = 128

# Time
tspan = [0.0, 0.2]
CFL = 0.8; gamma = 1.4

# initial condition - project example 2.1
def V0(x): # g(x)
    x_d = 0.5
    if x <= x_d:
    #     return np.array([1.0,-2.0,0.4])
    # return np.array([1.0,2.0,0.4])
        return np.array([1.0,0.0,1.0])
    return np.array([0.125,0.0,0.1])

prob = Euler(V0, tspan, xspan, gamma, CFL, N)

u = prob.godunov()

import matplotlib.pyplot as plt
plt.figure()
# # plt.plot(xs,prob.u[:,-1], label = "Numerical")
dx = (xspan[1] - xspan[0])/N
xs = [xspan[0] + (i-5/2)*dx for i in range(3,N+3)]
plt.scatter(xs,u[0,:], label = "density")
plt.scatter(xs,u[1,:], label = "velocity")
# plt.scatter(xs,u[2,:], label = "pressure")
plt.legend(loc="best")
plt.show()

# primative or conservative
# V = [rho, u, p] or U = [rho, rho*u, rho*E]
# flux (momentum = rho*u, kinetic energy = rho*u**2/2, internal energy = rho*e)
gamma = 1.4 # Given - specific heats
def Fp(V):
    rho = V[0]
    u = V[1]
    p = V[2]
    e = p/((gamma-1)*rho)
    E = (u**2/2 + e)
    return np.array([rho*u, rho*(u**2) + p, u*(rho*E+p)])
