# automatically detect .f90 files
SOURCES = $(wildcard *.f90)  
OBJECTS = $(subst .f90,.o,$(SOURCES))
# OBJECTS = DiffyQ.o Driver_DiffyQ.o

MODULES = DiffyQ.mod

# compile flags (-g debugger)
DFLAGS = -g -fdefault-real-8 -fdefault-double-8

output.txt: output
	./output > output.txt

output: $(MODULES) $(OBJECTS)
	gfortran $(OBJECTS) -o output

%.o: %.f90
	gfortran -c $(DFLAGS) $<

%.mod: %.f90
	gfortran -c $(DFLAGS) $<

clean:
	rm *.o
