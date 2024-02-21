subroutine soln_PLM(dt, V)

#include "definition.h"  

  use grid_data
  use sim_data
  use slopeLimiter
  use eigensystem

  implicit none
  real, intent(IN) :: dt
  real, dimension(NUMB_VAR,gr_imax), intent(IN) :: V
  integer :: i

  real, dimension(NUMB_WAVE) :: lambda
  real, dimension(NSYS_VAR,NUMB_WAVE) :: reig, leig
  logical :: conservative
  real, dimension(NSYS_VAR) :: vecL,vecR,sigL,sigR
  integer :: kWaveNum
  real :: lambdaDtDx, pL, pR
  real, dimension(NUMB_VAR)  :: delV,delL,delR
  real, dimension(NUMB_WAVE) :: delW
  integer :: nVar
  

  
  ! we need conservative eigenvectors
  conservative = .false.

  do i = gr_ibeg-1, gr_iend+1

     call eigenvalues(V(DENS_VAR:GAME_VAR,i),lambda)
     call left_eigenvectors (V(DENS_VAR:GAME_VAR,i),conservative,leig)
     call right_eigenvectors(V(DENS_VAR:GAME_VAR,i),conservative,reig)

     ! primitive limiting
     if (.not. sim_charLimiting) then
        do kWaveNum = 1, NUMB_WAVE
           ! slope limiting
           ! deltas in primitive vars
           delL(DENS_VAR:PRES_VAR) = V(DENS_VAR:PRES_VAR,i  )-V(DENS_VAR:PRES_VAR,i-1)
           delR(DENS_VAR:PRES_VAR) = V(DENS_VAR:PRES_VAR,i+1)-V(DENS_VAR:PRES_VAR,i  )
           do nVar = DENS_VAR,PRES_VAR
              if (sim_limiter == 'minmod') then
                 call minmod(delL(nVar),delR(nVar),delV(nVar))
              elseif (sim_limiter == 'vanLeer') then
                 call vanLeer(delL(nVar),delR(nVar),delV(nVar))
              elseif (sim_limiter == 'mc') then
                 call mc(delL(nVar),delR(nVar),delV(nVar))
              endif
           enddo
           ! project primitive delta to characteristic vars 
           delW(kWaveNum) = dot_product(leig(DENS_VAR:PRES_VAR,kWaveNum),delV(DENS_VAR:PRES_VAR))
        enddo
     elseif (sim_charLimiting) then
        do kWaveNum = 1, NUMB_WAVE
           delL(DENS_VAR:PRES_VAR) = V(DENS_VAR:PRES_VAR,i  )-V(DENS_VAR:PRES_VAR,i-1)
           delR(DENS_VAR:PRES_VAR) = V(DENS_VAR:PRES_VAR,i+1)-V(DENS_VAR:PRES_VAR,i  )
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
        
     endif


     if (sim_RK) then
        !no char tracing
        ! Let's make sure we copy all the cell-centered values to left and right states
        ! this will be just FOG
        gr_vL(DENS_VAR:NUMB_VAR,i) = V(DENS_VAR:NUMB_VAR,i)
        gr_vR(DENS_VAR:NUMB_VAR,i) = V(DENS_VAR:NUMB_VAR,i)
        do nVar = DENS_VAR, PRES_VAR
           !get slope in prim vars from slope in char vars
           delV(nVar) = dot_product(reig(nVar, 1:NUMB_WAVE), delW(1:NUMB_WAVE))
        end do
        gr_vL(DENS_VAR:PRES_VAR,i) = V(DENS_VAR:PRES_VAR,i) - .5*delV(DENS_VAR:PRES_VAR)
        gr_vR(DENS_VAR:PRES_VAR,i) = V(DENS_VAR:PRES_VAR,i) + .5*delV(DENS_VAR:PRES_VAR)
        
     else if (.not. sim_RK) then
        !do char tracing
        ! set the initial sum to be zero
        sigL(DENS_VAR:ENER_VAR) = 0.
        sigR(DENS_VAR:ENER_VAR) = 0.
        vecL(DENS_VAR:ENER_VAR) = 0.
        vecR(DENS_VAR:ENER_VAR) = 0.

        do kWaveNum = 1, NUMB_WAVE
           ! lambdaDtDx = lambda*dt/dx
           lambdaDtDx = lambda(kWaveNum)*dt/gr_dx


           if (sim_riemann == 'roe') then
              if (lambda(kWaveNum) > 0) then
                 vecR(DENS_VAR:PRES_VAR) = 0.5*(1.0 - lambdaDtDx)*reig(DENS_VAR:PRES_VAR,kWaveNum)*delW(kWaveNum)
                 sigR(DENS_VAR:PRES_VAR) = sigR(DENS_VAR:PRES_VAR) + vecR(DENS_VAR:PRES_VAR)
              elseif (lambda(kWaveNum) < 0) then
                 vecL(DENS_VAR:PRES_VAR) = 0.5*(-1.0 - lambdaDtDx)*reig(DENS_VAR:PRES_VAR,kWaveNum)*delW(kWaveNum)
                 sigL(DENS_VAR:PRES_VAR) = sigL(DENS_VAR:PRES_VAR) + vecL(DENS_VAR:PRES_VAR)
              end if
           elseif (sim_riemann == 'hll') then
              vecR(DENS_VAR:PRES_VAR) = 0.5*(1.0 - lambdaDtDx)*reig(DENS_VAR:PRES_VAR,kWaveNum)*delW(kWaveNum)
              sigR(DENS_VAR:PRES_VAR) = sigR(DENS_VAR:PRES_VAR) + vecR(DENS_VAR:PRES_VAR)

              vecL(DENS_VAR:PRES_VAR) = 0.5*(-1.0 - lambdaDtDx)*reig(DENS_VAR:PRES_VAR,kWaveNum)*delW(kWaveNum)
              sigL(DENS_VAR:PRES_VAR) = sigL(DENS_VAR:PRES_VAR) + vecL(DENS_VAR:PRES_VAR)
           endif

           ! Let's make sure we copy all the cell-centered values to left and right states
           ! this will be just FOG
           gr_vL(DENS_VAR:NUMB_VAR,i) = V(DENS_VAR:NUMB_VAR,i)
           gr_vR(DENS_VAR:NUMB_VAR,i) = V(DENS_VAR:NUMB_VAR,i)

           ! Now PLM reconstruction for dens, velx, and pres
           gr_vL(DENS_VAR:PRES_VAR,i) = V(DENS_VAR:PRES_VAR,i) + sigL(DENS_VAR:PRES_VAR)
           gr_vR(DENS_VAR:PRES_VAR,i) = V(DENS_VAR:PRES_VAR,i) + sigR(DENS_VAR:PRES_VAR)


        end do
     end if
  end do
  
  return
end subroutine soln_PLM
