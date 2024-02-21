subroutine sim_initBlock()

#include "definition.h"
  
  use sim_data
  use grid_data, only : gr_V,gr_U,gr_i0,gr_imax,gr_xCoord,gr_dx,gr_ngc
  use primconsflux, only : prim2cons
  
  implicit none

  integer :: i
  real :: ekin, eint
  
  ! generate x-coordinate
  do i = gr_i0,gr_imax
     gr_xCoord(i) = (real(i-gr_ngc)-0.5)*gr_dx
  end do

  do i = gr_i0,gr_imax
     if (gr_xCoord(i) < sim_shockLoc) then
        gr_V(DENS_VAR,i) = sim_densL
        gr_V(VELX_VAR,i) = sim_velxL
        gr_V(PRES_VAR,i) = sim_presL
     else
        gr_V(DENS_VAR,i) = sim_densR
        gr_V(VELX_VAR,i) = sim_velxR
        gr_V(PRES_VAR,i) = sim_presR
     end if

     gr_V(GAMC_VAR,i) = sim_gamma
     gr_V(GAME_VAR,i) = sim_gamma
     gr_V(EINT_VAR,i) = gr_V(PRES_VAR,i)/(gr_V(GAME_VAR,i)-1.)/gr_V(DENS_VAR,i)
  end do

  ! also initialize conservative vars
  do i = gr_i0,gr_imax
     call prim2cons(gr_V(:,i), gr_U(DENS_VAR:ENER_VAR,i))
  end do

  
end subroutine sim_initBlock
