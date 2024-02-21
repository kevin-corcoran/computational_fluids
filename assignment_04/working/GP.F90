module GP
#include "definition.h"

  use grid_data
  use sim_data
  use linalg

  


contains

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!! Quadrature Rules for Integrated Kernel!!!!!!

  function intg_kernel(x, y) result(f)
    implicit none
    real, intent(IN) :: x, y
    real :: f

    f = 0.
    if (sim_quad == 'midpt') then
       f = K(x, y)
    elseif (sim_quad == 'trap') then
       f = 1./4. * ( &
            K(x + 0.5, y + 0.5) + K(x - 0.5, y + 0.5) + &
            K(x + 0.5, y - 0.5) + K(x - 0.5, y - 0.5) )
    elseif (sim_quad == 'simpson') then
       f = 1./36. * ( &
            K(x+0.5,y+0.5) + 4.*K(x,y+0.5) + K(x-0.5,y+0.5) + 4.*( &
            K(x+0.5,y    ) + 4.*K(x,y    ) + K(x-0.5,y    ) ) + &
            K(x+0.5,y-0.5) + 4.*K(x,y-0.5) + K(x-0.5,y-0.5) )
    end if
    return
  end function intg_kernel

  function quad_cross(x, t) result(f)
    implicit none
    real, intent(IN) :: x, t
    real :: f
    f = 0.
    if (sim_quad == 'midpt') then
       f = K(x, t)
    elseif (sim_quad == 'trap') then
       f = 0.5*( K(x-0.5, t) + K(x+0.5, t) )
    elseif (sim_quad == 'simpson') then
       f = 1./6. * ( K(x-0.5, t) + 4.*K(x,t) + K(x+0.5,t) )
    end if
    return
  end function quad_cross

  function intg_predvec(x) result(T)
    implicit none
    real, intent(IN) :: x
    real, dimension(2) :: T

    T(1) = quad_cross(x, -0.5)
    T(2) = quad_cross(x,  0.5)
    return
  end function intg_predvec

  

  function K(x, y) result(f)
    implicit none
    real, intent(IN) :: x, y
    real :: f

    if (sim_gp_kernel == 'matern') then
       f = matern(x,y)
    elseif (sim_gp_kernel == 'SE') then
       f = SE(x,y)
    elseif (sim_gp_kernel == 'RQ') then
       f = RQ(x,y)
    end if
    return
  end function K
  
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!! Kernel Functions !!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!! Squared Exponential!!!!!!!!!!!!!!!!!!
  
 
  function SE(x, y) result(f)
    implicit none
    real, intent(IN) :: x, y
    real :: f, r
    r = abs(x-y)
    f = EXP( -0.5*(r/sim_sigdel)**2 )
    return
  end function SE

  function SE_der_cov_dxy(x, y) result(f)
    !this is the covariance of the derivative at x and the data at y use SE kernel
    implicit none
    real, intent(IN) :: x, y
    real :: f
    f = SE(x,y)*(y - x)*gr_dx/(sim_sigma**2)
    return
  end function SE_der_cov_dxy
  
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!! Rational Quad. !!!!!!!!!!!!!!!!!!

  function RQ(x, y) result(f)
    implicit none
    real, intent(IN) :: x, y
    real :: f, r
    r = abs(x-y)
    f = (1. + r**2/(2.*sim_RQ_alpha*sim_sigdel**2))**(-sim_RQ_alpha)
    return
  end function RQ

!!!!!!!!!!!!!!!! Matern Kernel!!!!!!!!!!!!!!!!!!!!

  function matern(x,y) result(f)
    implicit none
    real, intent(IN) :: x, y
    real :: f
    if (sim_matern_nu == 0.5) then
       f = mat_1h(x,y)
    elseif (sim_matern_nu == 1.5) then
       f = mat_3h(x,y)
    elseif (sim_matern_nu == 2.5) then
       f = mat_5h(x,y)
    elseif (sim_matern_nu == 3.5) then
       f = mat_7h(x,y)
    elseif (sim_matern_nu == 4.5) then
       f = mat_9h(x,y)
    elseif (sim_matern_nu == 5.5) then
       f = mat_11h(x,y)
    end if
    return
  end function matern
  
!!!!!! half integer matern kernels!!!!!!!!!!!!!!!!
  

  function mat_1h(x, y) result(f)
    implicit none
    real, intent(IN) :: x, y
    real :: f, r
    r = abs(x-y)
    f = EXP(-r/sim_sigdel)
    return
  end function mat_1h

  function mat_3h(x, y) result(f)
    implicit none
    real, intent(IN) :: x, y
    real :: f, r, rt3li
    r = abs(x-y)
    rt3li = SQRT(3.)/sim_sigdel
    f = (1 + rt3li*r)*EXP(-rt3li*r)
    return
  end function mat_3h

  function mat_5h(x, y) result(f)
    implicit none
    real, intent(IN) :: x, y
    real :: f, r, rt5li
    r = abs(x-y)
    rt5li = SQRT(5.)/sim_sigdel
    f = (1 + rt5li*r + 5./3. * (r/sim_sigdel)**2)*EXP(-rt5li*r)
    return
  end function mat_5h

  function mat_7h(x, y) result(f)
    implicit none
    real, intent(IN) :: x, y
    real :: f, r, rt7li
    r = abs(x-y)
    rt7li = SQRT(7.)/sim_sigdel

    f = ( 1 + rt7li*r + 14./5.*(r/sim_sigdel)**2 + 7.*SQRT(7.)/15.*(r/sim_sigdel)**3 )*EXP(-rt7li*r)

    return
  end function mat_7h

  function mat_9h(x, y) result(f)
    implicit none
    real, intent(IN) :: x, y
    real :: f, r, rli
    r = abs(x-y)
    rli = r/sim_sigdel
    
    f = ( 1. + 3.*rli + 27./7.*rli**2 + 18./7.*rli**3 + 27./35.*rli**4 )*EXP(-3.*rli)
    
    return
  end function mat_9h

  function mat_11h(x,y) result(f)
    implicit none
    real, intent(IN) :: x, y
    real :: f, r, rli
    r = abs(x-y)
    rli = r/sim_sigdel

    f = ( 1. + SQRT(11.)*rli + 44./9.*rli**2 + 11./9.*SQRT(11.)*rli**3 + 121./63.*rli**4 + &
         121./945.*SQRT(11.)*rli**5 )*EXP(-SQRT(11.)*rli)

    return
  end function mat_11h
  


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!! Exponential Kernel !!!!!!!!!!
  
  function intg_exp(x, t) result(f)
    !prediction vector for exponential kernel
    implicit none
    real, intent(IN) :: x,t
    real :: f
    f = 0.
    if (x < t) then
       f = sim_sigdel*(EXP((x+0.5)/sim_sigdel) - EXP((x-0.5)/sim_sigdel) )*EXP(-t/sim_sigdel)
    elseif (x > t) then
       f = sim_sigdel*(EXP(-(x-0.5)/sim_sigdel) - EXP(-(x+0.5)/sim_sigdel) )*EXP(t/sim_sigdel)
    end if
    return
  end function intg_exp

  function EXP_exact(x1,x2) result(Integ)
    !exact quadrature for exponential kernel
    implicit none
    real, intent(IN) :: x1, x2
    real :: Integ, x, y
    Integ = 0.
    if (x1 .ne. x2) then
       x = MAX(x1, x2)
       y = MIN(x1, x2)

       Integ = sim_sigdel**2 *( EXP(-(x-0.5)/sim_sigdel) - EXP(-(x+0.5)/sim_sigdel) )*&
            ( EXP((y+0.5)/sim_sigdel) - EXP((y-0.5)/sim_sigdel) )
    elseif (x1 == x2) then
       x = x1
       y = x2
       Integ = sim_sigdel*( &
            2. + sim_sigdel*(&
            EXP( (y-0.5)/sim_sigdel)*( EXP(-(x+0.5)/sim_sigdel) - EXP(-(x-0.5)/sim_sigdel) ) - &
            EXP(-(y+0.5)/sim_sigdel)*( EXP( (x+0.5)/sim_sigdel) - EXP( (x-0.5)/sim_sigdel) )   &
            )&
            )
    end if
    return
  end function EXP_exact

  function int_EXPcov(x1, x2) result(Integ)

    implicit none
    real, intent(IN) :: x1, x2
    real :: Integ
    Integ = 0.
    if (sim_quad == 'exact') then
       Integ = EXP_exact(x1,x2)
    end if
    return
  end function int_EXPcov

  function cross_EXP(x) result(T)
    !cross correlation for the prediction using the exponential kernel
    implicit none
    real, intent(IN) :: x
    real, dimension(2) :: T

    T(1) = intg_EXP(x, -0.5)
    T(2) = intg_EXP(x, 0.5)
    return
  end function cross_EXP

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!! SE Kernel !!!!!!!!!!!!!!!!!!!

  function int_egrand(x, t) result(f)
    implicit none
    real, intent(IN) :: x, t
    real :: f, sigdel
    sigdel = sim_sigdel*SQRT(2.)

    f = ERF( (x + .5 - t)/sigdel) - ERF( (x - .5 - t)/sigdel )
    !f = ERF( (x + .5*gr_dx - t)/sigdel) - ERF( (x - .5*gr_dx - t)/sigdel )

  end function int_egrand

  function quad_exact(x1,x2) result(Integ)
    
    !exact quadrature, only good for SE kernel
    real, intent(IN) :: x1, x2

    real :: Integ, yxp, yxn, yxm, sigdel
    sigdel = sim_sigdel*SQRT(2.)

    yxp = (x1 - x2 + 1.)/sigdel
    yxn = (x1      -x2)/sigdel
    yxm = (x1 - x2 -1.)/sigdel
    
    
    Integ = 0.5*SQRT(PI)*(sigdel)**2 *( yxp*ERF(yxp) + yxm*ERF(yxm) &
         - 2.*( yxn*ERF(yxn) + 1./SQRT(PI) *EXP(-yxn**2) ) &
         + 1./SQRT(PI) * ( EXP(-yxp**2) + exp(-yxm**2) ) )
    return
  end function quad_exact

  function quad_mid(x1, x2) result(Integ)
    !midpoint quadrature rule
    implicit none
    real, intent(IN) :: x1, x2
    real :: Integ, sigdel
    sigdel = sim_sigdel*SQRT(2.)

    Integ = 0.5*SQRT(PI)*sigdel*int_egrand(x2, x1)
    return
  end function quad_mid

  function quad_simps(x1,x2) result(Integ)
    !simpson's quadrature rule
    implicit none
    real, intent(IN) :: x1, x2
    real :: Integ, sigdel
    sigdel = sim_sigdel*SQRT(2.)

    Integ = 0.5*SQRT(PI)*sigdel*( int_egrand(x2,x1-0.5) + 4.*int_egrand(x2,x1) + int_egrand(x2,x1+0.5) )/6.
    return
  end function quad_simps

  function quad_trap(x1,x2) result(Integ)
    !trapezoidal quadrature rule
    implicit none
    real, intent(IN) :: x1, x2
    real :: Integ, sigdel
    sigdel = sim_sigdel*SQRT(2.)

    Integ = 0.25*SQRT(PI)*sigdel*( int_egrand(x2,x1-0.5) + int_egrand(x2,x1+0.5) )
    return
  end function quad_trap
    
  function int_SEcov(x1, x2) result(Integ)
    !integrates the covariance between cells centered at x1 & x2 in units of x/delta (see eq 15)
    !cell ranges from x-1/2 to x+1/2
    implicit none
    real, intent(IN) :: x1, x2
    real :: Integ, dN, t, fa, fb, yxp, yxn, yxm
    integer :: i,N
    Integ = 0.
    if (sim_quad == 'exact') then
       Integ = quad_exact(x1,x2)
    elseif (sim_quad == 'midpt') then
       Integ = quad_mid(x1,x2)
    elseif (sim_quad == 'trap') then
       Integ = quad_trap(x1,x2)
    elseif (sim_quad == 'simpson') then
       Integ = quad_simps(x1,x2)
    end if
    return
  end function int_SEcov

  function cross_cor(x) result(T)
    !returns the cross-correlation between the left and right states and the cell centered at x
    !see eq 24
    implicit none
    real, intent(IN) :: x
    real, dimension(2) :: T
    real :: sigdel
    sigdel = sim_sigdel*SQRT(2.)
    !sim_sigdel = sim_sigma/gr_dx
    T(1) = int_egrand(x, -.5)
    T(2) = int_egrand(x, 0.5)
    T = T*.5*sigdel*SQRT(PI)

  end function cross_cor

  
end module GP
