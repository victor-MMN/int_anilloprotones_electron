##
## Makefile
##  
## Made by Dupret Alberto Santana Bejarano
## Login   <dupretRhapsody>
##
## Started on  Tue Mar  6 01:01:51 2018 Dupret Alberto Santana Bejarano
## Last update Time-stamp: <13-abr-2019 12:09:28 victorito123>
##
#
# This makefile is intended for the program 
#
#      MassFuntion

#===============================================
# Fortran Parameters
#===============================================
FC = gfortran #Compiler
FFLAGS = -O3  #Optimization Flags (maybe tinker with these?)
FSRC =  ModFuncioncargado.f90 ModFuncionvectores.f90 anillo.f90 Interaccion_anillocargadoVsElectron.f90
FOBJECTS = $(FSRC:.f90=.o) #Objets

#===============================================
# C Parameters
#===============================================
CC = gcc #Compiler
CFLAGS = -O   #-ffixed-line-length-132 #Optimization Flags (maybe tinker with these?)
CSRC = 
COBJECTS = $(CSRC:.c=.u) # C Objets 
CHEAD = 

#===============================================
# General Parameters.  
#===============================================
OBJECTS =	$(FOBJECTS) $(COBJECTS)
EXEC =  InteraccionAvsE

#===============================================
# Compilation rules
#===============================================
default: $(EXEC)

clean:	
	rm -f *~ $(OBJECTS) *.pro *.ascii *.nat *.mod *.Gh

spotless:	
	rm -f *~ $(OBJECTS) $(EXEC)

$(EXEC): $(OBJECTS)
	$(FC) $(FFLAGS) $(FLFLAGS) -o $(EXEC) \
		 $(OBJECTS) -lm

%.o:  %.f90
	$(FC) $(FFLAGS) -c $< -o $@

%.u:	%.c $(CHEAD)	
	$(CC) $(CFLAGS) -c $< -o $@ 
