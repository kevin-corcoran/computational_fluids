subroutine soln_GP(dt, V)
#include "definition.h"

  use grid_data
  use sim_data
  use eigensystem
  use char_tracing
  use slopeLimiter

  implicit none
  real, intent(IN) :: dt
  real, dimension(NUMB_VAR,gr_imax), intent(IN) :: V

  integer :: i, var, s, N
  logical :: conservative

  real :: vim2, vim1, vi, vip1, vip2, f0, delV, delL, delR, GL, GR
  real, dimension(NSYS_VAR) :: vecL, vecR, vL, vR, C0, C1, C2

  real, dimension(NUMB_WAVE) :: lambda
  real, dimension(NSYS_VAR,NUMB_WAVE) :: reig0, leig0
  real, dimension(2*gr_radius+1) :: G, un


  conservative = .false.
  N = 2*gr_radius+1
  

  do i = gr_ibeg-1,gr_iend+1
     !copy cell-centered values to left and right states
     gr_vL(DENS_VAR:NUMB_VAR,i) = V(DENS_VAR:NUMB_VAR,i)
     gr_vR(DENS_VAR:NUMB_VAR,i) = V(DENS_VAR:NUMB_VAR,i)

     !get eigen information
     call eigenvalues(V(DENS_VAR:GAME_VAR,i), lambda)
     call left_eigenvectors(V(DENS_VAR:GAME_VAR,i), conservative, leig0)
     call right_eigenvectors(V(DENS_VAR:GAME_VAR,i), conservative, reig0)
     do var = DENS_VAR, PRES_VAR
        do s = 1, N
           if (sim_charLimiting) then
              G(s) = dot_product(V(DENS_VAR:PRES_VAR, i+s-gr_radius-1), leig0(DENS_VAR:PRES_VAR, var))
           else
              G(s) = V(var, i+(s-gr_radius-1))
           end if
        end do
        !if (var == 1) print *, i, G

        !now we begin the GP reconstruction
        !G = (/ vim2, vim1, vi, vip1, vip2 /) !this is our sample
        un = 1.


        !calculate the most probable mean f0 (see eq 33)
        f0 = dot_product(gr_GPv, G)/dot_product(gr_GPv, un)
        !f0 = G(1+gr_radius)
        !print *, f0 - G
        !lets try a plm prior mean
!!$        delL = G(gr_radius + 1) - G(gr_radius)
!!$        delR = G(gr_radius+2) - G(gr_radius+1)
!!$        call vanLeer(delL, delR, delV)
!!$        GL = G(gr_radius + 1) - 0.5*delV
!!$        GR = G(gr_radius + 1) + 0.5*delV
!!$        do s = 1, N
!!$           un(s) = G(gr_radius+1) + delV*(s - gr_radius - 1)
!!$        end do
        !f0 = 1.
        !calculate the left and right states
        vecL(var) = f0 + dot_product(gr_GPZ(1, 1:N),G) - f0*dot_product(gr_GPZ(1, 1:N),un)
        vecR(var) = f0 + dot_product(gr_GPZ(2, 1:N),G) - f0*dot_product(gr_GPZ(2, 1:N),un)
!        print *, vim1, vecL(var), vi, vecR(var), vip1
     end do !var
      
     do var = DENS_VAR, PRES_VAR
        if (sim_charLimiting) then
           !project char vars back onto prim vars
           vL(var) = dot_product(reig0(var,1:NUMB_WAVE),vecL(1:NUMB_WAVE))
           vR(var) = dot_product(reig0(var,1:NUMB_WAVE),vecR(1:NUMB_WAVE))
        else
           vL(var) = vecL(var)
           vR(var) = vecR(var)
        end if

        !enforce monotonicity conditions
!!$        if ( (vR(var) - V(var,i))*(V(var,i)-vL(var)) <= 0.) then
!!$           vL(var) = V(var,i)
!!$           vR(var) = V(var,i)
!!$        end if
!!$        if (6.*(vR(var)-vL(var))*(V(var,i)-.5*(vL(var)+vR(var))) > (vR(var)-vL(var))**2 ) then
!!$           vL(var) = 3.*V(var,i) - 2.*vR(var)
!!$        end if
!!$        if ( 6.*(vR(var)-vL(var))*(V(var,i)-.5*(vL(var)+vR(var))) < -(vR(var)-vL(var))**2 ) then
!!$           vR(var) = 3.*V(var,i) - 2.*vL(var)
!!$        end if
!!$        
     end do !var

     C2(DENS_VAR:PRES_VAR) = 6.*( .5*(vR(DENS_VAR:PRES_VAR) + vL(DENS_VAR:PRES_VAR)) &
          - V(DENS_VAR:PRES_VAR,i))
     C1(DENS_VAR:PRES_VAR) = vR(DENS_VAR:PRES_VAR) - vL(DENS_VAR:PRES_VAR)
     C0(DENS_VAR:PRES_VAR) = V(DENS_VAR:PRES_VAR,i) - C2(DENS_VAR:PRES_VAR)/12.

     if (.not. sim_RK) then
        !do char tracing 
        call soln_PPMtracing(dt, V(DENS_VAR:GAME_VAR,i), C0(DENS_VAR:PRES_VAR), &
             C1(DENS_VAR:PRES_VAR), C2(DENS_VAR:PRES_VAR), vL, vR, lambda, leig0, reig0)
     else
        vL(DENS_VAR:PRES_VAR) = C0(DENS_VAR:PRES_VAR) - .5*C1(DENS_VAR:PRES_VAR) &
             + .25*C2(DENS_VAR:PRES_VAR)
        vR(DENS_VAR:PRES_VAR) = C0(DENS_VAR:PRES_VAR) + .5*C1(DENS_VAR:PRES_VAR) &
             + .25*C2(DENS_VAR:PRES_VAR)
     end if


     gr_vL(DENS_VAR:PRES_VAR, i) = vL(DENS_VAR:PRES_VAR)
     gr_vR(DENS_VAR:PRES_VAR, i) = vR(DENS_VAR:PRES_VAR)
  end do !i

end subroutine soln_GP
