# ircbyhand
Fortran script for IRC using Freq calculation provide by Gaussian16
You need to compile the code:
gfortran ircbyhand.f90 -o ircbyhand.exe

For utilisation:
./ircbyhand.exe file.xyz file.log

The file.xyz contains the geometry of the transition state (or other specific geometries).
The file.log is provided after frequencies calculation using Gaussian16. 
The code ircbyhand.exe reads the first frequency in order to make the IRC path.
You are free to modify the logfile to put in the first position the frequency that you want.
