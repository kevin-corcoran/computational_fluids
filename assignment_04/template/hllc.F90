subroutine hllc(vL,vR,Flux)

#include "definition.h"  

  use grid_data
  use primconsflux, only : prim2flux,prim2cons


  implicit none
  real, dimension(NUMB_VAR), intent(IN) :: vL,vR !prim vars
  real, dimension(NSYS_VAR), intent(OUT):: Flux 

  real, dimension(NSYS_VAR) :: FL,FR,uL,uR,uLS,uRS,FLS,FRS
  real :: sL,sR,aL,aR,ul_,ur_ 
  real :: sS, pLS, pRS,pL, pR, dL,dR,EL,ER,pS, dbar,abar,qL,qR,g

  call prim2flux(vL,FL)
  call prim2flux(vR,FR)
  call prim2cons(vL,uL)
  call prim2cons(vR,uR)

  
  ! left and right sound speed a
  aL = sqrt(vL(GAMC_VAR)*vL(PRES_VAR)/vL(DENS_VAR))
  aR = sqrt(vR(GAMC_VAR)*vR(PRES_VAR)/vR(DENS_VAR))

  ! fastest left and right going velocities
  ! sL = min(vL(VELX_VAR) - aL,vR(VELX_VAR) - aR)
  ! sR = max(vL(VELX_VAR) + aL,vR(VELX_VAR) + aR)
  ! gamma
  g = vL(GAMC_VAR)
  ! pressure
  pL = vL(PRES_VAR)
  pR = vR(PRES_VAR)
  ! density
  dL = vL(DENS_VAR)
  dR = vR(DENS_VAR)
  ! energy
  EL = uL(ENER_VAR)
  ER = uR(ENER_VAR)

  ! left velocity
  ul_ = vL(VELX_VAR)
  ! right velocity
  ur_ = vR(VELX_VAR)

  dbar = 0.5*(dL+dR)
  abar = 0.5*(aL+aR)
  ! star state pressure estimate 
  pS = max(0.0, 0.5*(pL+pR) - 0.5*(ur_-ul_)*dbar*abar)
  if (pS <= pL) then
    qL = 1.0
  else
    qL = sqrt(1.0+(g+1.0)/(2*g) * (pS/(pL-1.0)))
  endif

  if (pS <= pR) then
    qR = 1.0
  else
    qR = sqrt(1.0+(g+1.0)/(2*g) * (pS/(pR-1.0)))
  endif
  ! left and right going velocity estimates 
  sL = ul_ - aL*qL
  sR = ur_ + aR*qR

  ! star state velocity
  sS = (pR-pL+dL*ul_*(sL-ul_)-dR*ur_*(sR-ur_))/(dL*(sL-ul_)-dR*(sR-ur_))
  ! left star state for conservative variables
  uLS(DENS_VAR) = 1.0
  uLS(MOMX_VAR) = sS
  uLS(ENER_VAR) = EL/dL + (sS-vL(VELX_VAR))*(sS + pL/(dL*(sL-vL(VELX_VAR))))
  uLS(DENS_VAR:ENER_VAR) = dL*((sL-ul_)/(sL-sS))*uLS(DENS_VAR:ENER_VAR)

  ! right star state for conservative variables
  uRS(DENS_VAR) = 1.0
  uRS(MOMX_VAR) = sS
  uRS(ENER_VAR) = ER/dR + (sS-vR(VELX_VAR))*(sS + pR/(dR*(sR-vR(VELX_VAR))))
  uRS(DENS_VAR:ENER_VAR) = dR*((sR-ur_)/(sR-sS))*uRS(DENS_VAR:ENER_VAR)

  ! numerical flux
  if (sL >= 0.) then
     Flux(DENS_VAR:ENER_VAR) = FL(DENS_VAR:ENER_VAR)
  elseif ( (sL <= 0.) .and. (sS >= 0.) ) then
     Flux(DENS_VAR:ENER_VAR) = FL(DENS_VAR:ENER_VAR) &
                               +sL*(uLS(DENS_VAR:ENER_VAR)-uL(DENS_VAR:ENER_VAR))
  elseif ( (sS <= 0.) .and. (sR >= 0.) ) then
     Flux(DENS_VAR:ENER_VAR) = FR(DENS_VAR:ENER_VAR) &
                               +sR*(uRS(DENS_VAR:ENER_VAR)-uR(DENS_VAR:ENER_VAR))
  else
     Flux(DENS_VAR:ENER_VAR) = FR(DENS_VAR:ENER_VAR)
  endif

  return
end subroutine hllc
