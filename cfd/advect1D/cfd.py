import numpy as np
from scipy.sparse import diags
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

class Transport1D:

    # define decorator for the Flux of the solution to the local Riemann
    # problem
    class __Flux(object):

        def __init__(self, flux = None, dx = None, dt = None): # decorator arguments
            # self.func = func # limiter function
            self.flux = flux
            self.dx = dx
            self.dt = dt

        # arguments, and keyword aguments for limiter function
        def __call__(self, func): 
            """TODO: Docstring for Flux.

            :cls: TODO
            :args: u[0] and u[1]
            :kargs: a and b
            :returns: TODO

            """
            f = self.flux; dt = self.dt
            s = np.mean([u[0], u[1]])
            F = 0; dx = self.dx
            C = s*dt/dx
            if u[0] >= u[1]:
                if s > 0:
                    F = f(u[0] + 0.5*dx*self.func(**kargs)*(1-C))
                else:
                    F = f(u[1] - 0.5*dx*self.func(**kargs)*(1+C))
            else:
                if 0 <= u[0]:
                    F = f(u[0] + 0.5*dx*self.func(**kargs)*(1-C))
                elif (u[0] < 0 < u[1]):
                    F = f(0)
                elif 0 >= u[1]:
                    F = f(u[1] - 0.5*dx*self.func(**kargs)*(1+C))
            return F
    
    
            

    """Docstring for Godunov. """

    def __init__(self, flux, g, tspan, xspan, a = 1.0, cfl = 1.0, N = 64):
        self.flux = flux
        self.__limiter = lambda a,b: 0
        self.u0 = g
        self.tspan = tspan
        self.xspan = xspan
        self.cfl = cfl
        self.N = N + 4

        self.dx = (xspan[1] - xspan[0])/N

        # self.u0 = loop i = 0:N g(xspan[0] + dx*i)
        
        # using guard cells
        self.u0 = np.zeros((N+4), dtype = np.double)
        for i in range(N+4):
           self.u0[i] = g(xspan[0] + ((i+1)-5/2)*self.dx)

        self.a = np.max(self.u0)
        # self.xs = [xspan[0] + (i-5/2)*self.dx for i in range(1,N+5)]
        self.s = max([abs((self.u0[i] + self.u0[i+1])/2) for i in range(N-1)])
        self.dt = (cfl * self.dx)/self.s
        self.M = int((tspan[1]-tspan[0])/self.dt)

    def godunov(self):

        """TODO: Docstring for function.

        :arg1: TODO
        :returns: TODO

        """
        dt = self.dt; dx = self.dx; N = self.N; M = self.M; cfl = self.cfl
        t_max = self.tspan[1]
        f = self.flux

        # flux for solution to local riemann problem
        # F = np.zeros((N), dtype = np.double)

        u = [self.u0]

        t = self.tspan[0]; n = 0
        # self.Cs = [self.s*self.dt/dx]

        while t < t_max:
            ui = np.zeros((N), dtype = np.double)
            u.append(ui)
            s_max = max([abs((u[n][i] + u[n][i+1])/2) for i in range(N-1)])

            dt = (cfl * dx)/s_max
            # self.Cs.append(s_max*dt/dx)
            self.dt = dt
            # space solve local riemann problem
            for i in range(1,N-2):
                Fi = self.__F_PLM(u[n][i:i+2])
                Fi_1 = self.__F_PLM(u[n][i-1:i+1])

                # dt = (cfl * dx)/u[i,n]
                u[n+1][i] = u[n][i] - dt/dx * (Fi - Fi_1)
            t += dt
            n += 1

        return u[-1][2:-2]

    def F_(self, u):
        s = np.mean([u[0], u[1]])

        f = self.flux
        F = 0
        if u[0] >= u[1]:
            if s > 0:
                F = f(u[0])
            else:
                F = f(u[1])
        else:
            if 0 <= u[0]:
                F = f(u[0])
            elif (u[0] < 0 < u[1]):
                F = f(0)
            elif 0 >= u[1]:
                F = f(u[1])
        return F

    def PLM_godunov(self):
        dx = self.dx; N = self.N; M = self.M; cfl = self.cfl
        t_max = self.tspan[1]
        f = self.flux

        # flux for solution to local riemann problem
        # F = np.zeros((N), dtype = np.double)

        u = [self.u0]

        t = self.tspan[0]; n = 0
        # self.Cs = [self.s*self.dt/dx]

        while t < t_max:
            ui = np.zeros((N), dtype = np.double)
            u.append(ui)
            s_max = max([abs((u[n][i] + u[n][i+1])/2) for i in range(N-1)])

            dt = (cfl * dx)/s_max
            # self.Cs.append(s_max*dt/dx)
            self.dt = dt
            # space solve local riemann problem
            for i in range(1,N-2):
                a = (u[n][i+1] - u[n][i])/dx; b = (u[n][i+2] - u[n][i+1])/dx
                Fi = self.__F_PLM(u[n][i:i+2], a = a, b = b)

                a = (u[n][i] - u[n][i-1])/dx; b = (u[n][i+1] - u[n][i])/dx
                Fi_1 = self.__F_PLM(u[n][i-1:i+1], a = a, b = b)

                # dt = (cfl * dx)/u[i,n]
                u[n+1][i] = u[n][i] - dt/dx * (Fi - Fi_1)

            t += dt
            n += 1

        return u[-1][2:-2]


    def __F_PLM(self, u, a = 0, b = 0):
        f = self.flux; dt = self.dt
        s = np.mean([u[0], u[1]])
        F = 0; dx = self.dx
        C = s*dt/dx
        if u[0] >= u[1]:
            if s > 0:
                F = f(u[0] + 0.5*dx*self.__limiter(a,b)*(1-C))
            else:
                F = f(u[1] - 0.5*dx*self.__limiter(a,b)*(1+C))
        else:
            if 0 <= u[0]:
                F = f(u[0] + 0.5*dx*self.__limiter(a,b)*(1-C))
            elif (u[0] < 0 < u[1]):
                F = f(0)
            elif 0 >= u[1]:
                F = f(u[1] - 0.5*dx*self.__limiter(a,b)*(1+C))
        return F

    def setLimiter(self, limiter):
        if limiter == "vanleer":
            self.__limiter = self.__vanLeer
        # sel = input("a: Van Leer\n").lower()
        # if sel == "a":
        #     self.__limiter = self.__vanLeer

    def __vanLeer(self, a, b):
        if a*b <= 0:
            return 0
        else:
            return (2*a*b)/(a+b)


    def lax_f(self):
        """TODO: Docstring for lax_f.
        :returns: TODO

        """
        dt = self.dt; dx = self.dx; N = self.N; M = self.M; a = self.a

        uL = [1.0/2.0 + a*dt/(2.0*dx)]
        uR = [1.0/2.0 - a*dt/(2.0*dx)]
        diagonals = [[1/2 - a*dt/(2.0*dx) for _ in range(N-1)], [1/2 + a*dt/(2.0*dx) for _ in range(N-1)], uL, uR] 
        # boundary 
        L = diags(diagonals, [1, -1, N-1, -(N-1)], dtype = np.double)
        # ! # boundary condition

        self.u = np.zeros((N,M), dtype = np.double)
        self.u[:, 0] = self.u0

        for i in range(M-1):
            self.u[:,i+1] = L @ self.u[:,i]
        return self.u
        
    def plot_(self, u):
        """TODO: Docstring for print.

        :arg1: TODO
        :returns: TODO

        """
        x0 = self.xspan[0]; x = self.xspan[1]; N = self.N - 4
        xs = np.linspace(x0, x, N)
        # plot final solution
        plt.plot(xs, self.u[:,-1])
        plt.show()

        # data which the line will
        # contain (x, y)
    def init(self):
        self.line.set_data([], [])
        return self.line,

    def update(self, i):
        x0 = self.xspan[0]; x = self.xspan[1]; N = self.N
        xs = np.linspace(x0, x, N)

        # plots a sine graph
        # y = np.sin(2 * np.pi * (x - 0.01 * i))
        y = self.u[:, i]
        self.line.set_data(xs, y)

        return self.line,

    def animate(self, u):
        # which the graph will be plotted
        plt.close('all')
        fig = plt.figure()

        # marking the x-axis and y-axis
        axis = plt.axes(xlim =(0, 1), ylim =(-1.5, 2.5))

        # initializing a line variable
        self.line, = axis.plot([], [], lw = 1)

        anim = FuncAnimation(fig, self.update, init_func = self.init, \
                frames = self.M, interval = 1, blit = True)


        anim.save('anim.mp4', writer = 'ffmpeg', fps = 5)
