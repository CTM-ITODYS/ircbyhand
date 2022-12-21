program ircbyhand
implicit none
integer :: i,j,k,step, nbstep, procs, charge, spin
integer :: int1, int2 ! trash variables
integer :: nbatom ! nombre d'atome dans le fichier xyz
real*8 :: dxyz
real*8, dimension(:,:), allocatable :: xyzatom ! tableau coord atome
real*8, dimension(:,:), allocatable :: freqatom ! tableau coord atome
real*8, dimension(:,:), allocatable :: tmpxyz ! tmp tableau pour les nouvelles coord
character*128, dimension(:), allocatable :: charatom ! tableau charactère de l'atome
integer :: ierr
character*128 :: logfile, xyzfile  !variable des fichiers d'entrée
character*60:: chargespin, mem
character*60 :: keyword
character*60:: trashchar
character*128 :: coord, normal, txt1, txt2, dummy1, dummy2, dummy3,trash !variable pour la lecture des fichiers
character*128 :: outfile
!=============================================================================================!
!===============================lecture fichier .xyz==========================================!
!=============================================================================================!
call getarg(1,xyzfile)
xyzfile=trim(xyzfile)
open(10,file=xyzfile,status='old',action='read') 
read(10,*) nbatom
read(10,*)
allocate(xyzatom(3,nbatom), charatom(nbatom), freqatom(3,nbatom), tmpxyz(3,nbatom)) !allocation de la mémoire pour lire les infos des atomes
do i = 1, nbatom
   read(10,*) charatom(i), (xyzatom(j,i),j=1,3)
enddo
 close(10)
!do i = 1, nbatom
!write(*,*) charatom(i), (xyzatom(j,i),j=1,3)
!enddo
!=============================================================================================!
!===============================lecture fichier .log==========================================!
!=============================================================================================!
coord = "AN"
normal = "Atom"

call getarg(2,logfile)
logfile=trim(logfile)
open(10,file=logfile,status='old',action='read')
do
   read(10,*,iostat=ierr) dummy1, dummy2, dummy3
   read(dummy1,*) txt1
   read(dummy2,*) txt2
   
   if (txt2 == coord .and. txt1 == normal) then
!      write(*,*) txt1, txt2
      exit
   endif
enddo
do i = 1, nbatom
   read(10,*) int1, int2, (freqatom(j,i),j=1,3)
enddo
 close(10)
!=============================================================================================!
!===============================lecture fichier .inp==========================================!
!=============================================================================================!
open(10, file="irc_byhand.inp", status='old', action='read')
read(10,*) trash, dxyz
read(10,*) trash, nbstep
read(10,*)
read(10,*) trashchar, mem
read(10,*) trashchar, procs
read(10,'(a)') keyword
read(10,*) charge, spin 
 close(10)
mem=trim(mem)
keyword=adjustl(keyword)
!write(*,*) keyword
!===========================================================================================!
!============================écriture formats===============================================!
!===========================================================================================!
150 format("%mem=",A4)
151 format("%nprocshared=", I2)
152 format("#p", 1x, A60)
153 format("forward")
155 format("backward")
154 format(I1, 1x,  I1)

!===========================================================================================!
!===========================================================================================!
!============================écriture resultats=============================================!
!================================forward====================================================!
!===========================================================================================!
tmpxyz = xyzatom + dxyz*freqatom
step = 1
write (outfile, '("forward_00",i1,".com")') step
open(10,file="answer_forward.xyz")
open(20,file=outfile)
write(20,150) mem
write(20,151) procs
write(20,152) keyword
write(20,*)
write(20,153) 
write(20,*)
write(20,154) charge, spin
write(10,*) nbatom
write(10,*)
do j = 1, nbatom
   write(10,'(1x,a3,4x,f10.6,4x,f10.6,4x,f10.6)') charatom(j), (tmpxyz(k,j),k=1,3)
   write(20,'(1x,a3,4x,f10.6,4x,f10.6,4x,f10.6)') charatom(j), (tmpxyz(k,j),k=1,3)
enddo
write(20,*)
close(20)
do i =1, nbstep
   step = step + 1
   if (step .lt. 10) then
      write (outfile, '("forward_00",i1,".com")') step
   elseif (step .lt. 100) then
      write (outfile, '("forward_0",i2,".com")') step
   elseif ( step .lt. 1000) then
      write (outfile, '("forward_",i3,".com")') step
   endif
   tmpxyz = tmpxyz + dxyz*freqatom
   open(20,file=outfile)
   write(20,150) mem
   write(20,151) procs
   write(20,152) keyword
   write(20,*)
   write(20,153) 
   write(20,*)
   write(20,154) charge, spin
   write(10,*) nbatom
   write(10,*)
   do j = 1, nbatom
      write(10,'(1x,a3,4x,f10.6,4x,f10.6,4x,f10.6)') charatom(j), (tmpxyz(k,j),k=1,3)
      write(20,'(1x,a3,4x,f10.6,4x,f10.6,4x,f10.6)') charatom(j), (tmpxyz(k,j),k=1,3)
   enddo
   write(20,*) 
   close(20)
enddo
close(10)
!===========================================================================================!
!============================écriture resultats=============================================!
!================================backward===================================================!
!===========================================================================================!
tmpxyz = xyzatom - dxyz*freqatom
step = 1
write (outfile, '("backward_00",i1,".com")') step
open(10,file="answer_backward.xyz")
open(20,file=outfile)
write(20,150) mem
write(20,151) procs
write(20,152) keyword
write(20,*)
write(20,153) 
write(20,*)
write(20,154) charge, spin
write(10,*) nbatom
write(10,*)
do j = 1, nbatom
   write(10,'(1x,a3,4x,f10.6,4x,f10.6,4x,f10.6)') charatom(j), (tmpxyz(k,j),k=1,3)
   write(20,'(1x,a3,4x,f10.6,4x,f10.6,4x,f10.6)') charatom(j), (tmpxyz(k,j),k=1,3)
enddo
write(20,*) 
close(20)
do i =1, nbstep
   step = step + 1
   if (step .lt. 10) then
      write (outfile, '("backward_00",i1,".com")') step
   elseif (step .lt. 100) then
      write (outfile, '("backward_0",i2,".com")') step
   elseif ( step .lt. 1000) then
      write (outfile, '("backward_",i3,".com")') step
   endif
   tmpxyz = tmpxyz - dxyz*freqatom
   open(20,file=outfile)
   write(20,150) mem
   write(20,151) procs
   write(20,152) keyword
   write(20,*)
   write(20,153) 
   write(20,*)
   write(20,154) charge, spin
   write(10,*) nbatom
   write(10,*)
   do j = 1, nbatom
      write(10,'(1x,a3,4x,f10.6,4x,f10.6,4x,f10.6)') charatom(j), (tmpxyz(k,j),k=1,3)
      write(20,'(1x,a3,4x,f10.6,4x,f10.6,4x,f10.6)') charatom(j), (tmpxyz(k,j),k=1,3)
   enddo
   write(20,*)
   close(20)
enddo
close(10)
end program
