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

        # primative variables
        self.v0 = np.zeros((3, N+4), dtype = np.double)
        self.u0 = np.zeros((3, N+4), dtype = np.double)
        for i in range(N+4):
            self.v0[:, i] = g(xspan[0] + ((i+1)-5/2)*self.dx)
            self.u0[:, i] = self.prim2cons(self.v0[:, i])

        # outflow boundary condition
        self.v0[:,0] = self.v0[:,2]
        self.v0[:,1] = self.v0[:,2]
        self.v0[:,-1] = self.v0[:,-3]
        self.v0[:,-2] = self.v0[:,-3]

        
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


    def eos_cell(self, e, gamma):
        pres = np.max([(gamma-1.0)*e, self.small_p])
        return pres

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



    def prim2cons(self, V):
        # V = [rho, u, p] => U = [rho, rho*u, rho*E]
        gamma = self.gamma
        rho = V[0] # density
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

        v = [self.v0]
        u = [self.u0]

        t = self.tspan[0]; n = 0
        # self.Cs = [self.s*self.dt/dx]
        plm = False

        while t < t_max:
            ui = np.zeros((3,N), dtype = np.double)
            u.append(ui)
            vi = np.zeros((3,N), dtype = np.double)
            v.append(vi)
            s_max = np.max([abs(v[n][1,i]) + self.cs_p(v[n][:,i]) for i in range(N)]) # OR

            dt = (cfl * dx)/s_max
            self.dt = dt
            self.n = n # for debugging

            if plm:
                vL, vR = self.PLM(v[n])
                F = self.Flux(vL,vR)

            # space solve local riemann problem
            for i in range(2,N-2):
                self.i = i # for debugging
                # F_PLM converts to conservative variables
                # attempt 3
                if plm:
                    # a = (v[n][:,i] - v[n][:,i-1]); b = (v[n][:,i+1] - v[n][:,i])
                    # Fi = self.F_PLM(v[n][:,i-1], v[n][:,i+1], a, b, v[n][:,i]) #, a, b, v[n][:,i])

                    # # a = (v[n][:,i-1] - v[n][:,i-2]); b = (v[n][:,i] - v[n][:,i-i])
                    # Fi_1 = self.F_PLM(v[n][:,i-1], v[n][:,i+1], a, b, v[n][:,i])

                    # u[n+1][:,i] = u[n][:,i] - dt/dx * (Fi - Fi_1)

                    u[n+1][:,i] = u[n][:,i] - dt/dx * (F[:,i+1] - F[:,i])
                else:

                # attempt 2
                # Fi = self.F_PLM(vL[:,i], vR[:,i+1]) #, V = v[n][:,i+1])
                # Fi_1 = self.F_PLM(vL[:,i-1], vR[:,i]) #, V = v[n][:,i])

                # attempt 1
                # a = (v[n][:,i+1] - v[n][:,i]); b = (v[n][:,i+2] - v[n][:,i+1])
                    Fi = self.F_PLM(v[n][:,i], v[n][:,i+1]) #, a, b, v[n][:,i])

                    # # a = (v[n][:,i-1] - v[n][:,i-2])/dx; b = (v[n][:,i] - v[n][:,i-i])/dx
                    Fi_1 = self.F_PLM(v[n][:,i-1], v[n][:,i]) #, a, b, v[n][:,i])

                    u[n+1][:,i] = u[n][:,i] - dt/dx * (Fi - Fi_1)

                # convert back to primative variables
                v[n+1][:,i] = self.cons2prim(u[n+1][:,i])


            # outflow boundary condition on primative var
            v[n+1][:,0] = v[n+1][:,2]
            v[n+1][:,1] = v[n+1][:,2]
            v[n+1][:,-1] = v[n+1][:,-3]
            v[n+1][:,-2] = v[n+1][:,-3]

            # # convert back to primative variables
            # for i in range(2,N-1):
            #     u[n+1][:,i] = self.cons2prim(u[n+1][:,i])

            t += dt
            n += 1

        return v[-1][:,2:-2]

    def PLM(self, V):
        """
        Calculates vL, and vR using slope limiter for PLM
        V (np.array): primitive variables over grid for one timestep
        returns vL and vR over entire grid
        """
        N = self.N
        dt, dx = self.dt, self.dx
        vL = np.zeros((3,N), dtype = np.double)
        vR = np.zeros((3,N), dtype = np.double)
        for i in range(1, N-1):
            a = (V[:,i] - V[:,i-1]); b = (V[:,i+1] - V[:,i])
            deltaV = self.__minMod(a,b)
            L = self.L_p(V[:,i]) # left eigenvectors
            R = self.R_p(V[:,i]) # right eigenvectors
            # if deltaV[0] != 0:
            #     breakpoint()
            deltaW = L.T@deltaV
            D = self.lambda_p(V[:,i]) # eigenvalues
            vL[:,i] = V[:,i] + 0.5*np.sum([(-1.0-D[j]*dt/dx)*R[:,j]*deltaW[j] for j in range(3)])
            vR[:,i] = V[:,i] + 0.5*np.sum([(1.0-D[j]*dt/dx)*R[:,j]*deltaW[j] for j in range(3)])
        return vL, vR

    def Flux(self, vL, vR):
        N = self.N
        F = np.zeros((3,N), dtype = np.double)
        for i in range(2, N-1): # interior points +1
            F[:,i] = self.F_PLM(vR[:,i-1], vL[:,i])

        return F


    def F_PLM(self, vl, vr, a = 0, b = 0, V = 0):
    # def F_PLM(self, vl, vr, a = 0, b = 0, V = 0):
        # vL, vR = v[:,0], v[:,1]
        vL, vR = vl, vr
        f = self.flux_p; dt = self.dt
        # s = np.mean([u[0], u[1]])
        F = 0; dx = self.dx
        # limiter = True # uses FOG
        # if limiter: # calculate limiter
        #     deltaV = self.__minMod(a,b)
        #     L = self.L_p(V) # left eigenvectors
        #     R = self.R_p(V) # right eigenvectors
        #     deltaW = L.T @ deltaV
        #     D = self.lambda_p(V) # eigenvalues
        #     vL = V + 0.5*np.sum([(-1.0-D[i]*dt/dx)*R[:,i]*deltaW[i] for i in range(3)])
        #     vR = V + 0.5*np.sum([(1.0-D[i]*dt/dx)*R[:,i]*deltaW[i] for i in range(3)])

        # convert to conservative variables
        uL = self.prim2cons(vL)
        uR = self.prim2cons(vR)

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

    # def setLimiter(self, limiter):
    #     if limiter == "vanleer":
    #         self.__limiter = self.__vanLeer
    def __minMod(self, a, b):
        mm0 = 0.5 * (np.sign(a[0]) + np.sign(b[0]))*np.min([abs(a[0]),abs(b[0])])
        mm1 = 0.5 * (np.sign(a[1]) + np.sign(b[1]))*np.min([abs(a[1]),abs(b[1])])
        mm2 = 0.5 * (np.sign(a[2]) + np.sign(b[2]))*np.min([abs(a[2]),abs(b[2])])
        return np.array([mm0,mm1,mm2])

    def __vanLeer(self, a, b):
        """
        a, b  (np.array) delta V
        """
        lim = np.zeros((3), dtype = np.double)
        for i in range(3):
            if a[i]*b[i] > 0:
                lim[i] = 2*a[i]*b[i]/(a[i]+b[i])
                
        return lim
        # if a.T@b <= 0:
        #     return 0
        # else:
        #     return (2*a.T@b)@np.linalg.inv(a+b)

    # LA(V)R=D
    def L_p(self, V):
        cs = self.cs_p(V) # sound speed
        rho = V[0]
        L = [[0.0, 1.0, -1/(rho*cs)],
             [1.0, 0.0, -1/(cs**2)],
             [0.0, 1.0, 1/(rho*cs)]]
        return np.array(L)

    def R_p(self, V):
        cs = self.cs_p(V) # sound speed
        rho = V[0]
        R = [[-rho/(2*cs), 1.0, rho/(2*cs)],
             [0.5, 0.0, 0.5],
             [-0.5*rho*cs, 0.0, 0.5*rho*cs]]
        return np.array(R)

