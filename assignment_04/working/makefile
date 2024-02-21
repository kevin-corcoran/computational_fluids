#FC	= gfortran-mp-4.8 -O2 -g
FC	= gfortran

FFLAGS_OPT = -ggdb -O3 -fdefault-real-8 -fdefault-double-8\
	-ffree-line-length-none -Wuninitialized

# LDFLAGS = -framework accelerate

FFLAGS_DEBUG = -ggdb  -g -fdefault-real-8 -fdefault-double-8\
	-ffree-line-length-none -Wuninitialized

EXE_FILE = slugEuler1d
OBJS  = driver_euler1d.o \
	read_initFile.o\
	sim_data.o  \
	sim_init.o \
	sim_initBlock.o \
	grid_data.o \
	grid_init.o \
	grid_finalize.o\
	io.o\
	eos.o\
	primconsflux.o \
	soln_ReconEvolveAvg.o \
	soln_RK4.o \
	soln_RK3.o \
	soln_RK2.o \
	soln_reconstruct.o \
	soln_getFlux.o \
	soln_update.o \
	soln_FOG.o \
	soln_PLM.o \
	soln_PPM.o \
	soln_WENO.o \
	soln_GP.o \
	soln_GP2.o \
	hll.o \
	roe.o \
	hllc.o \
	bc.o \
	cfl.o \
	eigensystem.o \
	averageState.o \
	char_tracing.o \
	slopeLimiter.o

# linalg.o \
# GP.o \
# sim_GPinit.o \
# sim_GPinit2.o \
########################################################################################
#COMPILING AND LINKING USING GENERIC SUFFIX RULE FOR F90

$(EXE_FILE) : $(OBJS)
	@$(FC) $(FFLAGS_DEBUG) $(OBJS) -o $(EXE_FILE) $(LDFLAGS)
	@echo "code is now linking..."

#LET'S APPLY GENERIC SUFFIX RULE HERE FOR FORTRAN 90
.SUFFIXES : 
.SUFFIXES : .F90 .o

.F90.o:
	$(FC) $(FFLAGS_DEBUG) -c $<

#######################################################################################
#SOME USEFUL COMMANDS
clean:
	@rm -f *.o *.mod *~ slugEuler1d

#######################################################################################
#LET'S DEFINE SOME MODULE DEPENDENCIES!
driver_euler1d.o: sim_data.o grid_data.o io.o bc.o eos.o

eos.o		: grid_data.o sim_data.o

grid_init.o	: grid_data.o read_initFile.o
grid_finalize.o : grid_data.o

hll.o		: grid_data.o primconsflux.o
roe.o		: grid_data.o primconsflux.o eigensystem.o

io.o		: grid_data.o sim_data.o


primconsflux.o  : grid_data.o eos.o

sim_init.o	: sim_data.o read_initFile.o
sim_initBlock.o : sim_data.o grid_data.o primconsflux.o

sim_GPinit.o 		: linalg.o GP.o sim_data.o

soln_update.o		: grid_data.o primconsflux.o
soln_ReconEvolveAvg.o 	: grid_data.o sim_data.o
soln_reconstruct.o 	: grid_data.o sim_data.o
soln_getFlux.o  	: grid_data.o sim_data.o
soln_FOG.o		: grid_data.o
soln_PLM.o		: grid_data.o sim_data.o slopeLimiter.o eigensystem.o
soln_PPM.o              : grid_data.o sim_data.o slopeLimiter.o eigensystem.o char_tracing.o
soln_WENO.o             : grid_data.o sim_data.o eigensystem.o  char_tracing.o
soln_GP.o		: grid_data.o sim_data.o eigensystem.o  char_tracing.o

#######################################################################################
