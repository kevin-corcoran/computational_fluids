subroutine averageState(vL,vR,vAvg)

#include "definition.h"  

  implicit none
  real, dimension(NUMB_VAR), intent(IN) :: vL,vR !prim vars
  real, dimension(NUMB_VAR), intent(OUT) :: vAvg  !average state

  ! STUDENTS: PLEASE FINISH THIS SIMPLE AVERAGING SCHEME
  vAvg(DENS_VAR:NUMB_VAR) = 0.5*(vR(DENS_VAR:NUMB_VAR) + vL(DENS_VAR:NUMB_VAR))
  
  return
end subroutine averageState
