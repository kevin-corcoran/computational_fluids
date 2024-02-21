subroutine soln_FOG(V)

#include "definition.h"  

  use grid_data

  implicit none
  real, dimension(NUMB_VAR,gr_imax), intent(IN) :: V
  integer :: i

  do i = gr_ibeg-1, gr_iend+1
     gr_vL(DENS_VAR:GAME_VAR,i) = gr_V(DENS_VAR:GAME_VAR,i)
     gr_vR(DENS_VAR:GAME_VAR,i) = gr_V(DENS_VAR:GAME_VAR,i)
  end do

  return
end subroutine soln_FOG
