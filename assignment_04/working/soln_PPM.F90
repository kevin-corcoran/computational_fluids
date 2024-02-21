subroutine soln_PPM(dt, V)

#include "definition.h"  

  use grid_data
  use sim_data
  use eigensystem
  use char_tracing

  implicit none
  real, intent(IN) :: dt
  real, dimension(NUMB_VAR,gr_imax), intent(IN) :: V

  integer :: i, var
  real, dimension(NUMB_WAVE) :: lambda
  real, dimension(NSYS_VAR,NUMB_WAVE) :: reig, leig
  logical :: conservative
  real, dimension(NSYS_VAR) :: vL, vR, delVimo, delVi, delVipo, C0, C1, C2
  

  ! we need primitive eigenvectors
  conservative = .False.
  do i = gr_ibeg-1, gr_iend+1

     call eigenvalues(V(DENS_VAR:GAME_VAR,i),lambda)
     call left_eigenvectors (V(DENS_VAR:GAME_VAR,i),conservative,leig)
     call right_eigenvectors(V(DENS_VAR:GAME_VAR,i),conservative,reig)

     !get TVD slopes
     call del_V_i(i-1, delVimo, V)
     call del_V_i(i,   delVi,   V)
     call del_V_i(i+1, delVipo, V)

     vL(DENS_VAR:PRES_VAR) = 0.5*(V(DENS_VAR:PRES_VAR, i-1) + V(DENS_VAR:PRES_VAR, i)) &
          + (delVimo(DENS_VAR:PRES_VAR) - delVi(DENS_VAR:PRES_VAR))/6.
     vR(DENS_VAR:PRES_VAR) = 0.5*(V(DENS_VAR:PRES_VAR, i) + V(DENS_VAR:PRES_VAR, i+1)) &
          + (delVi(DENS_VAR:PRES_VAR) - delVipo(DENS_VAR:PRES_VAR))/6.

     !enforce monotonicity conditions
     do var = DENS_VAR, PRES_VAR
        if ( (vR(var) - V(var,i))*(V(var,i)-vL(var)) <= 0.) then
           vL(var) = V(var,i)
           vR(var) = V(var,i)
        end if
        if (6.*(vR(var)-vL(var))*(V(var,i)-.5*(vL(var)+vR(var))) > (vR(var)-vL(var))**2 ) then
           vL(var) = 3.*V(var,i) - 2.*vR(var)
        end if
        if ( 6.*(vR(var)-vL(var))*(V(var,i)-.5*(vL(var)+vR(var))) < -(vR(var)-vL(var))**2 ) then
           vR(var) = 3.*V(var,i) - 2.*vL(var)
        end if
     end do

     C2(DENS_VAR:PRES_VAR) = 6.*( .5*(vR(DENS_VAR:PRES_VAR) + vL(DENS_VAR:PRES_VAR)) &
          - V(DENS_VAR:PRES_VAR,i))
     C1(DENS_VAR:PRES_VAR) = vR(DENS_VAR:PRES_VAR) - vL(DENS_VAR:PRES_VAR)
     C0(DENS_VAR:PRES_VAR) = V(DENS_VAR:PRES_VAR,i) - C2(DENS_VAR:PRES_VAR)/12.

     if (.not. sim_RK) then
        !do char tracing 
        call soln_PPMtracing(dt, V(DENS_VAR:GAME_VAR,i), C0(DENS_VAR:PRES_VAR), &
             C1(DENS_VAR:PRES_VAR), C2(DENS_VAR:PRES_VAR), vL, vR, lambda, leig, reig)
     else
        vL(DENS_VAR:PRES_VAR) = C0(DENS_VAR:PRES_VAR) - .5*C1(DENS_VAR:PRES_VAR) + .25*C2(DENS_VAR:PRES_VAR)
        vR(DENS_VAR:PRES_VAR) = C0(DENS_VAR:PRES_VAR) + .5*C1(DENS_VAR:PRES_VAR) + .25*C2(DENS_VAR:PRES_VAR)
     end if
     
     ! Let's make sure we copy all the cell-centered values to left and right states
     ! this will be just FOG
     gr_vL(DENS_VAR:NUMB_VAR,i) = V(DENS_VAR:NUMB_VAR,i)
     gr_vR(DENS_VAR:NUMB_VAR,i) = V(DENS_VAR:NUMB_VAR,i)
     
     !Now do PPM reconstruction for left and right states
     gr_vL(DENS_VAR:PRES_VAR, i) = vL(DENS_VAR:PRES_VAR)
     gr_vR(DENS_VAR:PRES_VAR, i) = vR(DENS_VAR:PRES_VAR)

  end do

  return
end subroutine soln_PPM

subroutine del_V_i(j, delV, V)

  use grid_data
  use sim_data
  use slopeLimiter
  use eigensystem

  implicit none

  integer, intent(IN) :: j
  real, dimension(NSYS_VAR), intent(OUT) :: delV
  real, dimension(NUMB_VAR,gr_imax), intent(IN) :: V

  real, dimension(NSYS_VAR,NUMB_WAVE) :: reig, leig
  real, dimension(NUMB_WAVE) :: delW
  integer :: kWaveNum
  real, dimension(NUMB_VAR)  :: del,delL,delR
  real :: pL, pR
  integer :: nVar
  logical :: conservative

  conservative = .false.
  call left_eigenvectors (V(DENS_VAR:GAME_VAR,j),conservative,leig)
  call right_eigenvectors(V(DENS_VAR:GAME_VAR,j),conservative,reig)

  
  delL(DENS_VAR:PRES_VAR) = V(DENS_VAR:PRES_VAR,j  )-V(DENS_VAR:PRES_VAR,j-1)
  delR(DENS_VAR:PRES_VAR) = V(DENS_VAR:PRES_VAR,j+1)-V(DENS_VAR:PRES_VAR,j  )
  
  ! primitive limiting
  if (.not. sim_charLimiting) then
     do kWaveNum = 1, NUMB_WAVE
        ! slope limiting
        do nVar = DENS_VAR,PRES_VAR
           if (sim_limiter == 'minmod') then
              call minmod(delL(nVar),delR(nVar),delV(nVar))
           elseif (sim_limiter == 'vanLeer') then
              call vanLeer(delL(nVar),delR(nVar),delV(nVar))
           elseif (sim_limiter == 'mc') then
              call mc(delL(nVar),delR(nVar),delV(nVar))
           endif
        enddo
     enddo
  elseif (sim_charLimiting) then
     do kWaveNum = 1, NUMB_WAVE
        ! project onto characteristic vars
        pL = dot_product(leig(DENS_VAR:PRES_VAR,kWaveNum), delL(DENS_VAR:PRES_VAR))
        pR = dot_product(leig(DENS_VAR:PRES_VAR,kWaveNum), delR(DENS_VAR:PRES_VAR))
        if (sim_limiter == 'minmod')then
           call minmod(pL, pR, delW(kWaveNum))
        elseif (sim_limiter == 'vanLeer') then
           call vanLeer(pL, pR, delW(kWaveNum))
        elseif (sim_limiter == 'mc') then
           call mc(pL, pR, delW(kWaveNum))
        endif
     enddo
     !set initial sum to 0
     delV(DENS_VAR:PRES_VAR)   = 0.

     do kWaveNum = 1, NUMB_WAVE
        delV(DENS_VAR:PRES_VAR) = delV(DENS_VAR:PRES_VAR) +&
             delW(kWaveNum)*reig(DENS_VAR:PRES_VAR, kWaveNum)
     end do
  endif
  return
end subroutine del_V_i

