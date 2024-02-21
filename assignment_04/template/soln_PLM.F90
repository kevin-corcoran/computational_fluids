subroutine soln_PLM(dt)

#include "definition.h"  

  use grid_data
  use sim_data
  use slopeLimiter
  use eigensystem
  use primconsflux, only : cons2prim, prim2cons

  implicit none
  real, intent(IN) :: dt
  integer :: i

  real, dimension(NUMB_WAVE) :: lambda
  real, dimension(NSYS_VAR,NUMB_WAVE) :: reig, leig
  logical :: conservative
  real, dimension(NSYS_VAR) :: vecL,vecR,sigL,sigR
  integer :: kWaveNum
  real :: lambdaDtDx
  real, dimension(NUMB_VAR)  :: delV,delL,delR
  real, dimension(NUMB_WAVE) :: delW, delU
  integer :: nVar
  ! added for roe
  real, dimension(NUMB_VAR)  :: vAvg,vL,vR

  
  ! if (.not. sim_charLimiting) then
  !   conservative = .false.
  ! else
  !   conservative = .true.
  ! endif
  ! we need conservative eigenvectors?
  conservative = .false.

  do i = gr_ibeg-1, gr_iend+1 ! all points?
     call eigenvalues(gr_V(DENS_VAR:GAME_VAR,i),lambda)
     call left_eigenvectors (gr_V(DENS_VAR:GAME_VAR,i),conservative,leig)
     call right_eigenvectors(gr_V(DENS_VAR:GAME_VAR,i),conservative,reig)

     ! primitive limiting
     if (.not. sim_charLimiting) then
        do kWaveNum = 1, NUMB_WAVE ! 3
           ! slope limiting
           ! deltas in primitive vars
           delL(DENS_VAR:PRES_VAR) = gr_V(DENS_VAR:PRES_VAR,i  )-gr_V(DENS_VAR:PRES_VAR,i-1)
           delR(DENS_VAR:PRES_VAR) = gr_V(DENS_VAR:PRES_VAR,i+1)-gr_V(DENS_VAR:PRES_VAR,i  )
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
        !STUDENTS: PLEASE FINISH THIS CHARACTERISTIC LIMITING
        !(THE IMPLEMENTATION SHOULD NOT BE LONGER THAN THE PRIMITIVE LIMITING CASE)

        do kWaveNum = 1, NUMB_WAVE ! 3
           delL(kWaveNum) = dot_product(leig(DENS_VAR:PRES_VAR,kWaveNum), gr_V(DENS_VAR:PRES_VAR,i)-gr_V(DENS_VAR:PRES_VAR,i-1))
           delR(kWaveNum) = dot_product(leig(DENS_VAR:PRES_VAR,kWaveNum), gr_V(DENS_VAR:PRES_VAR,i+1)-gr_V(DENS_VAR:PRES_VAR,i  ))
           if (sim_limiter == 'minmod') then
              call minmod(delL(kWaveNum),delR(kWaveNum),delW(kWaveNum))
           elseif (sim_limiter == 'vanLeer') then
              call vanLeer(delL(kWaveNum),delR(kWaveNum),delW(kWaveNum))
           elseif (sim_limiter == 'mc') then
              call mc(delL(kWaveNum),delR(kWaveNum),delW(kWaveNum))
           endif
           ! project characteristic delta to primitive delta?
           delV(kWaveNum) = dot_product(reig(DENS_VAR:PRES_VAR,kWaveNum), delW(DENS_VAR:PRES_VAR))

        enddo
     endif



     ! set the initial sum to be zero
     sigL(DENS_VAR:ENER_VAR) = 0.
     sigR(DENS_VAR:ENER_VAR) = 0.
     vecL(DENS_VAR:ENER_VAR) = 0.
     vecR(DENS_VAR:ENER_VAR) = 0.
     
     do kWaveNum = 1, NUMB_WAVE ! 3?
        ! lambdaDtDx = lambda*dt/dx
        lambdaDtDx = lambda(kWaveNum)*dt/gr_dx

        
        if (sim_riemann == 'roe') then
           ! STUDENTS: PLEASE FINISH THIS ROE SOLVER CASE
           ! THIS SHOULDN'T BE LONGER THAN THE HLL CASE

              if (lambda(kWaveNum) > 0) then
                 vecR(DENS_VAR:PRES_VAR) = 0.5*(1.0 - lambdaDtDx)*reig(DENS_VAR:PRES_VAR,kWaveNum)*delW(kWaveNum)
                 sigR(DENS_VAR:PRES_VAR) = sigR(DENS_VAR:PRES_VAR) + vecR(DENS_VAR:PRES_VAR)
              elseif (lambda(kWaveNum) < 0) then
                 vecL(DENS_VAR:PRES_VAR) = 0.5*(-1.0 - lambdaDtDx)*reig(DENS_VAR:PRES_VAR,kWaveNum)*delW(kWaveNum)
                 sigL(DENS_VAR:PRES_VAR) = sigL(DENS_VAR:PRES_VAR) + vecL(DENS_VAR:PRES_VAR)
              end if
             ! ! Do I need this if statement?
             ! !if (lambda(kWaveNum) <= 0.) then
             ! vecL(DENS_VAR:PRES_VAR) = 0.5*dot_product(leig(DENS_VAR:PRES_VAR,kWaveNum),delV(DENS_VAR:PRES_VAR))*reig(DENS_VAR:PRES_VAR,kWaveNum)
             ! sigL(DENS_VAR:PRES_VAR) = sigL(DENS_VAR:PRES_VAR) + vecL(DENS_VAR:PRES_VAR)
             ! !endif

             ! !if (lambda(kWaveNum) >= 0.) then
             ! vecR(DENS_VAR:PRES_VAR) = -0.5*dot_product(leig(DENS_VAR:PRES_VAR,kWaveNum),delV(DENS_VAR:PRES_VAR))*reig(DENS_VAR:PRES_VAR,kWaveNum)
             ! sigR(DENS_VAR:PRES_VAR) = sigR(DENS_VAR:PRES_VAR) + vecR(DENS_VAR:PRES_VAR)
             ! !endif

        elseif (sim_riemann == 'hll') then

              vecR(DENS_VAR:PRES_VAR) = 0.5*(1.0 - lambdaDtDx)*reig(DENS_VAR:PRES_VAR,kWaveNum)*delW(kWaveNum)
              sigR(DENS_VAR:PRES_VAR) = sigR(DENS_VAR:PRES_VAR) + vecR(DENS_VAR:PRES_VAR)

              vecL(DENS_VAR:PRES_VAR) = 0.5*(-1.0 - lambdaDtDx)*reig(DENS_VAR:PRES_VAR,kWaveNum)*delW(kWaveNum)
              sigL(DENS_VAR:PRES_VAR) = sigL(DENS_VAR:PRES_VAR) + vecL(DENS_VAR:PRES_VAR)

        endif

        ! Let's make sure we copy all the cell-centered values to left and right states
        ! this will be just FOG
        gr_vL(DENS_VAR:NUMB_VAR,i) = gr_V(DENS_VAR:NUMB_VAR,i)
        gr_vR(DENS_VAR:NUMB_VAR,i) = gr_V(DENS_VAR:NUMB_VAR,i)

        ! Now PLM reconstruction for dens, velx, and pres
        gr_vL(DENS_VAR:PRES_VAR,i) = gr_V(DENS_VAR:PRES_VAR,i) + sigL(DENS_VAR:PRES_VAR)
        gr_vR(DENS_VAR:PRES_VAR,i) = gr_V(DENS_VAR:PRES_VAR,i) + sigR(DENS_VAR:PRES_VAR)

        
     end do
  end do
  
  return
end subroutine soln_PLM
