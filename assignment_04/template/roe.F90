subroutine roe(vL,vR,Flux)

#include "definition.h"  

  use grid_data
  use primconsflux, only : prim2flux,prim2cons, cons2flux
  use eigensystem

  implicit none
  real, dimension(NUMB_VAR), intent(IN) :: vL,vR !prim vars !NUMB_VAR = 6
  real, dimension(NSYS_VAR), intent(OUT):: Flux  !NSYS_VAR = 3

  real, dimension(NSYS_VAR)  :: FL,FR,uL,uR,delU !NSYS_VAR = 3
  real, dimension(NUMB_VAR)  :: vAvg, vL_, vR_ ! NUMB_VAR= 6
  real, dimension(NUMB_WAVE) :: lambda,delW ! NUMB_WAVE = 3
  real, dimension(NSYS_VAR,NUMB_WAVE) :: reig, leig, h ! 3x3
  logical :: conservative
  real, dimension(NSYS_VAR) :: vec, sigma !NSYS_VAR = 3
  integer :: kWaveNum, k
  
  ! set the initial sum to be zero
  sigma(DENS_VAR:ENER_VAR) = 0.
  vec(DENS_VAR:ENER_VAR)   = 0.
  ! added
  delU(DENS_VAR:ENER_VAR) = 0.
  delW(DENS_VAR:ENER_VAR)   = 0.
  
  ! we need conservative eigenvectors
  conservative = .true.
  
  call averageState(vL,vR,vAvg)
  call eigenvalues(vAvg,lambda)
  call left_eigenvectors (vAvg,conservative,leig)
  call right_eigenvectors(vAvg,conservative,reig)

  call prim2flux(vL,FL)
  call prim2flux(vR,FR)
  call prim2cons(vL,uL)
  call prim2cons(vR,uR)

  do kWaveNum = 1, NUMB_WAVE
     ! STUDENTS: PLEASE FINISH THIS ROE SOLVER
     vec(DENS_VAR:ENER_VAR) = uR(DENS_VAR:ENER_VAR) - uL(DENS_VAR:ENER_VAR)
     sigma(DENS_VAR:ENER_VAR) = sigma(DENS_VAR:ENER_VAR) + dot_product(leig(DENS_VAR:ENER_VAR,kWaveNum), vec(DENS_VAR:ENER_VAR))*ABS(lambda(kWaveNum))*reig(DENS_VAR:ENER_VAR, kWaveNum)
          
  end do
  
  ! numerical flux
  Flux(DENS_VAR:ENER_VAR) = 0.5*(FL(DENS_VAR:ENER_VAR) + FR(DENS_VAR:ENER_VAR)) - 0.5*sigma
  ! delU(DENS_VAR:ENER_VAR) = uR(DENS_VAR:ENER_VAR) - uL(DENS_VAR:ENER_VAR)
  ! do kWaveNum = 1, NUMB_WAVE
  !    ! STUDENTS: PLEASE FINISH THIS ROE SOLVER
  !    delW(kWaveNum) = dot_product(leig(kWaveNum,DENS_VAR:ENER_VAR), delU(DENS_VAR:ENER_VAR))

  !    vec(DENS_VAR:ENER_VAR) = delW(kWaveNum)*abs(lambda(kWaveNum))*reig(DENS_VAR:ENER_VAR,kWaveNum)
  !    sigma(DENS_VAR:ENER_VAR) = sigma(DENS_VAR:ENER_VAR) + vec(DENS_VAR:ENER_VAR)
  ! end do
  ! 
  ! ! numerical flux
  ! Flux(DENS_VAR:ENER_VAR) = 0.5*(FL(DENS_VAR:ENER_VAR) + FR(DENS_VAR:ENER_VAR)) - 0.5*sigma(DENS_VAR:ENER_VAR) ! sigma ! sigma(DENS_VAR:PRES_VAR)


  return
end subroutine roe
