module slopeLimiter
  
#include "definition.h"
  
  !use grid_data


contains

  subroutine minmod(a,b,delta)
    implicit none
    real, intent(IN) :: a, b
    real, intent(OUT) :: delta

    delta = 0.5 * (sign(1.0,a) + sign(1.0,b))*min(abs(a),abs(b))

    return
  end subroutine minmod

  
  subroutine mc(a,b,delta)
    implicit none
    real, intent(IN) :: a, b
    real, intent(OUT) :: delta
    real :: c, temp

    ! STUDENTS: PLEASE FINISH THIS MC LIMITER
    temp = 0.
    c = 0.5*(b+a)
    call minmod(2*a, 2*b, temp)
    call minmod(temp, c, delta)
    
    return
  end subroutine mc

  
  subroutine vanLeer(a,b,delta)
    implicit none
    real, intent(IN) :: a, b
    real, intent(OUT) :: delta

    ! STUDENTS: PLEASE FINISH THIS VAN LEER'S LIMITER
    if (a*b <= 0.) then
      delta = 0.
    else
      delta = 2*a*b/(a+b)
    endif
    
    return
  end subroutine vanLeer
  
end module slopeLimiter
