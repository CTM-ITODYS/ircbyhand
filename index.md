## Description:
You need to compile the code:
```markdown
gfortran ircbyhand.f90 -o ircbyhand.exe
```
For utilisation:
```markdown
./ircbyhand.exe file.xyz file.log
```
The file.xyz contains the geometry of the transition state (or other specific geometries).<br />
The file.log is provided after frequencies calculation using Gaussian16. <br />
The code ircbyhand.exe reads the first frequency in order to make the IRC path.<br />
[freq_ts.png)]
You are free to modify the logfile to put in the first position the frequency that you want.<br />

The options on the IRC path are read in the file ircbyhand.inp:<br /> 
dxyz= 0.001 !Give the value of the scale <br />
nbstep= 50 !Give the number of step <br />
#head for gaussian calculation ! The keywords for Gaussian single point energy calculation <br />
mem= 24GB !Memory <br />
nprocshared= 24 ! Number of proc <br />
CAMP-B3LYP/6-31G* SCF=(maxcyc=800) nosym <br />
1 2 ! Charge and Spin <br />

In this case, the ircbyhand code give 50 files in the forward direction and 50 files in the backward direction.<br />
You can use these file to perform Gaussian16 single point energy calculation.<br />


## Contact:

Feel free to contact me if you have questions by clicking the email icon.

[![email](icone_email.png)](mailto:sylvain.pitie@u-paris.fr)

Author: Sylvain PITIE
