  !Flattening algorithm for PPM
subroutine flatten(i, flatn)
#include "definition.h"
  use grid_data
  
  implicit none
  integer, Intent(IN) :: i
  Real, Intent(INOUT) :: flatn

  Integer :: si
  Real    :: wi, wis, dp, dp1dp2, min_dp, du, flatnjs, flatnj
  
  dp = gr_V(PRES_VAR, i+1) - gr_V(PRES_VAR, i-1)
  min_dp = Min(gr_V(PRES_VAR, i+1) , gr_V(PRES_VAR, i-1))
  du = gr_V(VELX_VAR, i-1) - gr_V(VELX_VAR, i+1)
  dp1dp2 = dp/(gr_V(PRES_VAR, i+2) - gr_V(PRES_VAR, i-2))

  if (dp > min_dp*gr_epsiln .AND. du > 0.) then
     wi = 1.
  else
     wi = 0.
  end if

  !print *, dp/(min_dp*gr_epsiln), du
  
  flatnj = 1 - wi*Max(0., gr_omega2*(dp1dp2 - gr_omega1))

  !determine which cell is upstream
  if (dp < 0.) then
     si = -1
  elseif (dp > 0.) then
     si = 1
  end if

  dp = gr_V(PRES_VAR, i+si+1) - gr_V(PRES_VAR, i+si-1)
  min_dp = Min(gr_V(PRES_VAR, i+si+1) , gr_V(PRES_VAR, i+si-1))
  du = gr_V(VELX_VAR, i+si-1) - gr_V(VELX_VAR, i+si+1)
  dp1dp2 = dp/(gr_V(PRES_VAR, i+si+2) - gr_V(PRES_VAR, i+si-2))

  if (dp > min_dp*gr_epsiln .AND. du > 0.) then
     wis = 1.
  else
     wis = 0.
  end if

  !calculate flattening coefficients
  flatnjs = 1 - wis*Max(0., gr_omega2*(dp1dp2 - gr_omega1))

  flatn = Max(flatnj, flatnjs)
  !print *, flatn, flatnj, flatnjs
  
  return
  
  
  
end subroutine flatten
