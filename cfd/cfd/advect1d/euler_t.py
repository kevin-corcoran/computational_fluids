import numpy as np
from scipy.sparse import diags
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
np.seterr('raise')

class Euler:

    """Docstring for Euler. """


    def __init__(self, g, tspan, xspan, gamma, cfl = 0.9, N = 64):
        # V = [rho, u, p] or U = [rho, rho*u, rho*E]
        # Flux using primative variables
        self.small_p = 1e-12
        self.flux_p = lambda V: self.Fp(V)
        self.flux_c = lambda U: self.Fc(U)
        # 
        # self.AU = np.array

        self.__limiter = lambda a,b: 0
        self.tspan = tspan
        self.xspan = xspan
        self.cfl = cfl
        self.gamma = gamma

        self.N = N + 4
        self.dx = (xspan[1] - xspan[0])/N

        # using guard cells
        self.xs = [xspan[0] + (i-5/2)*self.dx for i in range(1,N+5)]
        self.u0 = np.zeros((3, N+4), dtype = np.double)
        for i in range(N+4):
            self.u0[:, i] = g(xspan[0] + ((i+1)-5/2)*self.dx)

        # outflow boundary condition
        self.u0[:,0] = self.u0[:,2]
        self.u0[:,1] = self.u0[:,2]
        self.u0[:,-1] = self.u0[:,-3]
        self.u0[:,-2] = self.u0[:,-3]

        # calculate initial timestep using all eigenvalues
        # self.s = np.max([abs(self.lambda_p(self.u0[:,i])) for i in range(N-1)])
        self.s = np.max([abs(self.u0[1,i]) + self.cs_p(self.u0[:,i]) for i in range(2,N-1)])

        # self.s = max([abs((self.u0[i] + self.u0[i+1])/2) for i in range(N-1)])
        self.dt = (cfl * self.dx)/self.s
        # self.dt = 0.01
        self.M = int((tspan[1]-tspan[0])/self.dt)
        # breakpoint()

    # sound speed
    def cs_p(self, V):
        gamma = self.gamma # Given - specific heats
        rho = V[0]
        p = V[2]
        return np.sqrt((gamma*p)/rho)


    # eigenvalues using primative variable form
    def lambda_p(self, V):
        cs = self.cs_p(V)
        u = V[1]
        return np.array([u-cs, u, u+cs])

    # Flux using primative variable form
    def Fp(self,V):
        gamma = self.gamma # Given - specific heats
        rho = V[0] # density
        u = V[1] # velocity
        p = V[2] # pressure
        e = p/((gamma-1)) # /rho (internal energy)
        E = (rho*0.5*(u**2) + e) # !rho*
        # return np.array([rho*u, rho*(u**2) + p, u*(rho*E+p)]) # or?
        return np.array([rho*u, rho*(u**2) + p, u*(E+p)])


    # sound speed using conservative variables
    def cs_c(self, U):
        gamma = self.gamma # Given - specific heats
        rho = U[0] # density
        mom = U[1] # rho*u
        E = U[2] # total energy
        # u = V[1]**2 # velocity
        u = mom/rho # velocity
        kin = rho*0.5*u**2 # kinetic energy
        e = np.max([E - kin, self.small_p])
        # e = e/rho # internal energy
        p = self.eos_cell(e, self.gamma)

        return np.sqrt((gamma*p)/rho)


    # eigenvalues using conservative variable form
    def lambda_c(self, U):
        cs = self.cs_p(U)
        rho = U[0] # density
        mom = U[1] # rho*u
        # u = V[1]**2 # velocity
        u = mom/rho # velocity
        return np.array([u-cs, u, u+cs])

    # Flux using conservative variable form
    def Fc(self,U):
        gamma = self.gamma # Given - specific heats
        rho = U[0] # density
        mom = U[1] # rho*u
        E = U[2] # total energy
        # u = V[1]**2 # velocity
        u = mom/rho # velocity
        kin = rho*0.5*u**2 # kinetic energy
        e = np.max([E - kin, self.small_p])
        # e = e/rho # internal energy
        p = self.eos_cell(e, self.gamma)
        # return np.array([rho*u, rho*(u**2) + p, u*(rho*E+p)]) # or?
        return np.array([rho*u, rho*(u**2) + p, u*(E+p)])


    def cons2prim(self, U):
        # U = [rho, rho*u, rho*E] => V = [rho, u, p]
        rho = U[0] # density
        mom = U[1] # rho*u
        E = U[2] # total energy
        # u = V[1]**2 # velocity
        u = mom/rho # velocity
        kin = rho*0.5*u**2 # kinetic energy
        e = np.max([E - kin, self.small_p])
        # e = e/rho # internal energy
        p = self.eos_cell(e, self.gamma)
        return np.array([rho, u, p])

    def eos_cell(self, e, gamma):
        pres = np.max([(gamma-1.0)*e, self.small_p])
        return pres


    def prim2cons(self, V):
        # V = [rho, u, p] => U = [rho, rho*u, rho*E]
        gamma = self.gamma
        rho = V[0]
        u = V[1] # velocity
        p = V[2] # pressure
        e = p/((gamma-1)) # /rho (internal energy)
        E = (rho*0.5*(u**2) + e) # !rho* (total energy)
        # return np.array([rho, rho*u, rho*E]) # or?
        return np.array([rho, rho*u, E])
    
    def godunov(self):
        dt = self.dt; dx = self.dx; N = self.N; M = self.M; cfl = self.cfl
        t_max = self.tspan[1]
        f = self.flux_p

        u = [self.u0]

        t = self.tspan[0]; n = 0
        # self.Cs = [self.s*self.dt/dx]

        while t < t_max:
            ui = np.zeros((3,N), dtype = np.double)
            u.append(ui)
            s_max = np.max([abs(u[n][1,i]) + self.cs_p(u[n][:,i]) for i in range(N)]) # OR
            # s_max = np.max([abs(SL), abs(SR)])

            # ls = []
            # for i in range(N):
            #     l = self.lambda_p(u[n][:,i])
            #     ls.append(abs(l[0]))
            #     # ls.append(abs(l[1]))
            #     ls.append(abs(l[2]))
            #     # ll = self.lambda_p(u[n][:,i])
            #     # lr = self.lambda_p(u[n][:,i+1])
                    # use abs()
            #     # ls.append(np.min([ll[0],lr[0]]))
            #     # ls.append(np.max([ll[2],lr[2]]))
            # s_max = np.max(ls)

            dt = (cfl * dx)/s_max
            self.dt = dt

            # space solve local riemann problem
            for i in range(2,N-1):
                # F_PLM converts to conservative variables
                Fi = self.F_PLM(u[n][:,i:i+2])
                Fi_1 = self.F_PLM(u[n][:,i-1:i+1])

                u[n+1][:,i] = u[n][:,i] - dt/dx * (Fi - Fi_1)

                # convert back to primative variables
                u[n+1][:,i] = self.cons2prim(u[n+1][:,i])


            # outflow boundary condition
            u[n+1][:,0] = u[n+1][:,2]
            u[n+1][:,1] = u[n+1][:,2]
            u[n+1][:,-1] = u[n+1][:,-3]
            u[n+1][:,-2] = u[n+1][:,-3]

            # convert back to primative variables
            for i in range(2,N-1):
                u[n+1][:,i] = self.cons2prim(u[n+1][:,i])

            t += dt
            n += 1

        return u[-1][:,2:-2]

    def F_PLM(self, u):
        vL, vR = u[:,0], u[:,1]
        # convert to conservative variables
        uL = self.prim2cons(vL)
        uR = self.prim2cons(vR)

        f = self.flux_p; dt = self.dt
        # s = np.mean([u[0], u[1]])
        F = 0; dx = self.dx
        # C = s*dt/dx
        # uL, uR = u[:,0], u[:,1]
        FL, FR = f(vL), f(vR)
        lambda_L = self.lambda_p(vL)
        lambda_R = self.lambda_p(vR)
        SL = np.min([lambda_L[0], lambda_R[0]])
        SR = np.max([lambda_L[2], lambda_R[2]])

        if 0 <= SL:
            F = FL
        elif SL <= 0 <= SR:
            F = (SR*FL - SL*FR + SL*SR*(uR - uL))/(SR - SL)
        elif 0 >= SR:
            F = FR

        return F


