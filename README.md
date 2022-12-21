# ircbyhand
Fortran script for IRC using Freq calculation provide by Gaussian16.

Github page: https://ctm-itodys.github.io/ircbyhand/

You need to compile the code:

gfortran ircbyhand.f90 -o ircbyhand.exe

For utilisation:

./ircbyhand.exe file.xyz file.log

The file.xyz contains the geometry of the transition state (or other specific geometries).
The file.log is provided after frequencies calculation using Gaussian16. 
The code ircbyhand.exe reads the first frequency in order to make the IRC path.
You are free to modify the logfile to put in the first position the frequency that you want.

The options on the IRC path are read in the file ircbyhand.inp:
dxyz= 0.001                           !Give the value of the scale 
nbstep= 50                            !Give the number of step
#head for gaussian calculation        ! The keywords for Gaussian single point energy calculation
mem= 24GB                             !Memory
nprocshared= 24                       ! Number of proc
CAMP-B3LYP/6-31G* SCF=(maxcyc=800) nosym
1 2                                   ! Charge and Spin


In this case, the ircbyhand code give 50 files in the forward direction and 50 files in the backward direction.
You can use these file to perform Gaussian16 single point energy calculation.
