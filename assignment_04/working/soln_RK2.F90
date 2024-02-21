subroutine soln_RK2(dt, j, Vj, Flux)
  !performs the jth step of the RK2 algorithm
  !Total Flux = (k1 + k2)/2

#include "definition.h"

  use grid_data
  use primconsflux

  implicit none
  real, intent(IN) :: dt
  integer, intent(IN) :: j
  real, dimension(NUMB_VAR,gr_imax), intent(INOUT) :: Vj
  real, dimension(NSYS_VAR,gr_imax), intent(INOUT) :: Flux

  real :: dtx
  integer :: i, var
  real, dimension(NUMB_VAR,gr_imax) :: Uj

  call soln_reconstruct(dt, Vj)
  call soln_getFlux()

  dtx = dt/gr_dx

  if (j == 1) then
     do i = gr_ibeg, gr_iend
        !get the U1 state
        !U1 = U0 + k1
        Uj(DENS_VAR:ENER_VAR,i) = gr_U(DENS_VAR:ENER_VAR,i) - &
             dtx *(gr_flux(DENS_VAR:ENER_VAR,i+1) - gr_flux(DENS_VAR:ENER_VAR,i))

        call cons2prim(Uj(DENS_VAR:ENER_VAR,i),Vj(DENS_VAR:GAME_VAR,i))
     end do
  end if

  Flux(DENS_VAR:ENER_VAR,gr_ibeg:gr_iend+1) = Flux(DENS_VAR:ENER_VAR,gr_ibeg:gr_iend+1) + &
       .5*gr_flux(DENS_VAR:ENER_VAR,gr_ibeg:gr_iend+1)
end subroutine soln_RK2
