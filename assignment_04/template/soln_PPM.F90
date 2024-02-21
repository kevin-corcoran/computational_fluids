subroutine soln_PPM(dt)

#include "definition.h"  

  use grid_data
  use sim_data
  use slopeLimiter
  use eigensystem

  implicit none
  real, intent(IN) :: dt
  integer :: i

  real, dimension(NUMB_WAVE) :: lambda
  real, dimension(NSYS_VAR,NUMB_WAVE) :: reig, leig, C
  logical :: conservative
  logical, dimension(NUMB_WAVE) :: isfog
  real, dimension(NSYS_VAR) :: vecL,vecR,sigL,sigR,vecL2,vecR2,sigL2,sigR2,delVimo, delVi, delVipo
  integer :: kWaveNum
  real :: lambdaDtDx
  real, dimension(3,NUMB_VAR)  :: delL,delR! s = 0,1 ! ,delL,delR
  real, dimension(3,NUMB_VAR)  :: delV
  ! real, dimension(NUMB_VAR)  :: delL,delR
  ! delVi-1
  ! real, dimension(2,NUMB_VAR)  :: delV_1,delL_1,delR_1
  real, dimension(NUMB_WAVE) :: delW,vL,vR,vL2,vR2,delC1,delC2
  integer :: nVar, s
  
  ! STUDENTS: IMPLEMENT THE THIRD-ORDER PPM SCHEME

  conservative = .false.
  isfog(DENS_VAR:PRES_VAR) = .false.

  do i = gr_ibeg-1, gr_iend+1 ! get rid of +- 1?
     call eigenvalues(gr_V(DENS_VAR:GAME_VAR,i),lambda)
     call left_eigenvectors (gr_V(DENS_VAR:GAME_VAR,i),conservative,leig)
     call right_eigenvectors(gr_V(DENS_VAR:GAME_VAR,i),conservative,reig)

     !get TVD slopes
     call del_V_i(i-1, delVimo, gr_V)
     call del_V_i(i,   delVi,   gr_V)
     call del_V_i(i+1, delVipo, gr_V)

     vL(DENS_VAR:PRES_VAR) = 0.5*(gr_V(DENS_VAR:PRES_VAR, i-1) + gr_V(DENS_VAR:PRES_VAR, i)) &
          + (delVimo(DENS_VAR:PRES_VAR) - delVi(DENS_VAR:PRES_VAR))/6.
     vR(DENS_VAR:PRES_VAR) = 0.5*(gr_V(DENS_VAR:PRES_VAR, i) + gr_V(DENS_VAR:PRES_VAR, i+1)) &
          + (delVi(DENS_VAR:PRES_VAR) - delVipo(DENS_VAR:PRES_VAR))/6.

     !enforce monotonicity conditions
     do nVar = DENS_VAR, PRES_VAR
        if ( (vR(nVar) - gr_V(nVar,i))*(gr_V(nVar,i)-vL(nVar)) <= 0.) then
           vL(nVar) = gr_V(nVar,i)
           vR(nVar) = gr_V(nVar,i)
        end if
        if (6.*(vR(nVar)-vL(nVar))*(gr_V(nVar,i)-.5*(vL(nVar)+vR(nVar))) > (vR(nVar)-vL(nVar))**2 ) then
           vL(nVar) = 3.*gr_V(nVar,i) - 2.*vR(nVar)
        end if
        if ( 6.*(vR(nVar)-vL(nVar))*(gr_V(nVar,i)-.5*(vL(nVar)+vR(nVar))) < -(vR(nVar)-vL(nVar))**2 ) then
           vR(nVar) = 3.*gr_V(nVar,i) - 2.*vL(nVar)
        end if
     end do

     C(DENS_VAR:PRES_VAR,3) = 6.*( .5*(vR(DENS_VAR:PRES_VAR) + vL(DENS_VAR:PRES_VAR)) &
          - gr_V(DENS_VAR:PRES_VAR,i))
     C(DENS_VAR:PRES_VAR,2) = vR(DENS_VAR:PRES_VAR) - vL(DENS_VAR:PRES_VAR)
     C(DENS_VAR:PRES_VAR,1) = gr_V(DENS_VAR:PRES_VAR,i) - C(DENS_VAR:PRES_VAR,3)/12.

     !!!!!!!! Commented !!!!!!!!!!!!!!!
     ! primitive limiting
     ! if (.not. sim_charLimiting) then
     !    ! add a s = 0,1 loop for vL and vR
     !    ! do kWaveNum = 1, NUMB_WAVE ! 3
     !         ! s = 0
     !         ! delVi-1
     !         delL(1,DENS_VAR:PRES_VAR) = gr_V(DENS_VAR:PRES_VAR,i-1)-gr_V(DENS_VAR:PRES_VAR,i-2)
     !         delR(1,DENS_VAR:PRES_VAR) = gr_V(DENS_VAR:PRES_VAR,i)-gr_V(DENS_VAR:PRES_VAR,i-1)
     !         ! delVi
     !         delL(2,DENS_VAR:PRES_VAR) = gr_V(DENS_VAR:PRES_VAR,i)-gr_V(DENS_VAR:PRES_VAR,i-1)
     !         delR(2,DENS_VAR:PRES_VAR) = gr_V(DENS_VAR:PRES_VAR,i+1)-gr_V(DENS_VAR:PRES_VAR,i)
     !         ! s = 1
     !         ! delVi ^
     !         ! delVi+1
     !         delL(3,DENS_VAR:PRES_VAR) = gr_V(DENS_VAR:PRES_VAR,i+2)-gr_V(DENS_VAR:PRES_VAR,i+1)
     !         delR(3,DENS_VAR:PRES_VAR) = gr_V(DENS_VAR:PRES_VAR,i+1)-gr_V(DENS_VAR:PRES_VAR,i)

     !         ! slope limiting
     !         ! deltas in primitive vars

     !         do nVar = DENS_VAR,PRES_VAR
     !            if (sim_limiter == 'minmod') then
     !              ! delVi-1
     !               call minmod(delL(1,nVar),delR(1,nVar),delV(1,nVar))
     !              ! delVi
     !               call minmod(delL(2,nVar),delR(2,nVar),delV(2,nVar))
     !              ! delVi+1
     !               call minmod(delL(3,nVar),delR(3,nVar),delV(3,nVar))
     !            elseif (sim_limiter == 'vanLeer') then
     !               call vanLeer(delL(1,nVar),delR(1,nVar),delV(1,nVar))
     !               call vanLeer(delL(2,nVar),delR(2,nVar),delV(2,nVar))
     !               call vanLeer(delL(3,nVar),delR(3,nVar),delV(3,nVar))
     !            elseif (sim_limiter == 'mc') then
     !               call mc(delL(1,nVar),delR(1,nVar),delV(1,nVar))
     !               call mc(delL(2,nVar),delR(2,nVar),delV(2,nVar))
     !               call mc(delL(3,nVar),delR(3,nVar),delV(3,nVar))
     !            endif
     !         enddo
     !         ! project primitive delta to characteristic vars
     !         ! delW(kWaveNum) = dot_product(leig(DENS_VAR:PRES_VAR,kWaveNum),delV(s+1,DENS_VAR:PRES_VAR))
     !    ! enddo


     ! elseif (sim_charLimiting) then
     !    !STUDENTS: PLEASE FINISH THIS CHARACTERISTIC LIMITING
     !    !(THE IMPLEMENTATION SHOULD NOT BE LONGER THAN THE PRIMITIVE LIMITING CASE)
     !    stop

     !    ! do kWaveNum = 1, NUMB_WAVE ! 3
     !    !    delL(kWaveNum) = dot_product(leig(DENS_VAR:PRES_VAR,kWaveNum), gr_V(DENS_VAR:PRES_VAR,i)-gr_V(DENS_VAR:PRES_VAR,i-1))
     !    !    delR(kWaveNum) = dot_product(leig(DENS_VAR:PRES_VAR,kWaveNum), gr_V(DENS_VAR:PRES_VAR,i+1)-gr_V(DENS_VAR:PRES_VAR,i  ))
     !    !    if (sim_limiter == 'minmod') then
     !    !       call minmod(delL(kWaveNum),delR(kWaveNum),delW(kWaveNum))
     !    !    elseif (sim_limiter == 'vanLeer') then
     !    !       call vanLeer(delL(kWaveNum),delR(kWaveNum),delW(kWaveNum))
     !    !    elseif (sim_limiter == 'mc') then
     !    !       call mc(delL(kWaveNum),delR(kWaveNum),delW(kWaveNum))
     !    !    endif
     !    !    ! project characteristic delta to primitive delta?
     !    !    delV(kWaveNum) = dot_product(reig(DENS_VAR:PRES_VAR,kWaveNum), delW(DENS_VAR:PRES_VAR))

     !    ! enddo
     ! endif

     ! set the initial sum to be zero
     sigL(DENS_VAR:ENER_VAR) = 0.
     sigR(DENS_VAR:ENER_VAR) = 0.
     vecL(DENS_VAR:ENER_VAR) = 0.
     vecR(DENS_VAR:ENER_VAR) = 0.
     sigL2(DENS_VAR:ENER_VAR) = 0.
     sigR2(DENS_VAR:ENER_VAR) = 0.
     vecL2(DENS_VAR:ENER_VAR) = 0.
     vecR2(DENS_VAR:ENER_VAR) = 0.
     delC1(DENS_VAR:ENER_VAR) = 0.
     delC2(DENS_VAR:ENER_VAR) = 0.

     ! delC1(DENS_VAR:ENER_VAR) = 0.
     ! delC2(DENS_VAR:ENER_VAR) = 0.
     ! vL(DENS_VAR:ENER_VAR) = 0.
     ! vR(DENS_VAR:ENER_VAR) = 0.

     ! construct C matrix (can be moved after characteristic limiting case)
     ! for s = 0


     !!!!!!!! Commented !!!!!!!!!!!!!!!
     ! vL(DENS_VAR:PRES_VAR) = 0.5*(gr_V(DENS_VAR:PRES_VAR,i-1)+gr_V(DENS_VAR:PRES_VAR,i))-(1.0/6.0)*(delV(2,DENS_VAR:PRES_VAR)-delV(1,DENS_VAR:PRES_VAR))
     ! ! for s = 1
     ! vR(DENS_VAR:PRES_VAR) = 0.5*(gr_V(DENS_VAR:PRES_VAR,i)+gr_V(DENS_VAR:PRES_VAR,i+1))-(1.0/6.0)*(delV(3,DENS_VAR:PRES_VAR)-delV(2,DENS_VAR:PRES_VAR))
     ! ! vL2(DENS_VAR:PRES_VAR) = vL(DENS_VAR:PRES_VAR)
     ! ! vR2(DENS_VAR:PRES_VAR) = vR(DENS_VAR:PRES_VAR)

     ! do nVar = DENS_VAR,PRES_VAR
     !   ! fog
     !   if ((vR(nVar)-gr_V(nVar,i))*(gr_V(nVar,i)-vL(nVar))<=0.0) then
     !     vL(nVar) = gr_V(nVar,i)
     !     vR(nVar) = gr_V(nVar,i)
     !     ! isfog(nVar) = .true.
     !     ! gr_vL(nVar,i) = gr_V(nVar,i)
     !     ! gr_vR(nVar,i) = gr_V(nVar,i)
     !   endif
     !   if (-(vR(nVar)-vL(nVar))**2 > 6.0*(vR(nVar)-vL(nVar))*(gr_V(nVar,i)-0.5*(vR(nVar)+vL(nVar))) ) then
     !     vR(nVar) = 3.0*gr_V(nVar,i)-2.0*vL(nVar)
     !   endif
     !   if ((vR(nVar)-vL(nVar))**2 < 6.0*(vR(nVar)-vL(nVar))*(gr_V(nVar,i)-0.5*(vR(nVar)+vL(nVar))) ) then
     !     vL(nVar) = 3.0*gr_V(nVar,i)-2.0*vR(nVar)
     !   endif

     ! enddo
     ! C(DENS_VAR:PRES_VAR, 3) = (6.0)*(0.5*(vR(DENS_VAR:PRES_VAR)+vL(DENS_VAR:PRES_VAR)) - gr_V(DENS_VAR:PRES_VAR,i))
     ! C(DENS_VAR:PRES_VAR, 2) = (vR(DENS_VAR:PRES_VAR) - vL(DENS_VAR:PRES_VAR))
     ! C(DENS_VAR:PRES_VAR, 1) = gr_V(DENS_VAR:PRES_VAR,i) - (C(DENS_VAR:PRES_VAR, 3)/12.0)

     do kWaveNum = 1, NUMB_WAVE ! 3?
          delC1(kWaveNum) = dot_product(leig(DENS_VAR:PRES_VAR,kWaveNum),C(DENS_VAR:PRES_VAR,2))!*gr_dx
          delC2(kWaveNum) = dot_product(leig(DENS_VAR:PRES_VAR,kWaveNum),C(DENS_VAR:PRES_VAR,3))!*gr_dx**2
     enddo

     do kWaveNum = 1, NUMB_WAVE ! 3?
        ! lambdaDtDx = lambda*dt/dx
        lambdaDtDx = lambda(kWaveNum)*dt/gr_dx

        
        if (sim_riemann == 'roe') then
           ! STUDENTS: PLEASE FINISH THIS ROE SOLVER CASE
           ! THIS SHOULDN'T BE LONGER THAN THE HLL CASE
           if (lambda(kWaveNum) > 0.) then
              vecR(DENS_VAR:PRES_VAR) = &
                   0.5*( 1. -    lambdaDtDx                        )*reig(DENS_VAR:PRES_VAR, kWaveNum)*delC1(kWaveNum) + &
                   .25*( 1. - 2.*lambdaDtDx + 4./3.*(lambdaDtDx**2))*reig(DENS_VAR:PRES_VAR, kWaveNum)*delC2(kWaveNum)
              sigR(DENS_VAR:PRES_VAR) = sigR(DENS_VAR:PRES_VAR) + vecR(DENS_VAR:PRES_VAR)
           elseif (lambda(kWaveNum) < 0.) then
              vecL(DENS_VAR:PRES_VAR) = &
                   0.5*(-1. -    lambdaDtDx                        )*reig(DENS_VAR:PRES_VAR, kWaveNum)*delC1(kWaveNum) + &
                   .25*( 1. + 2.*lambdaDtDx + 4./3.*(lambdaDtDx**2))*reig(DENS_VAR:PRES_VAR, kWaveNum)*delC2(kWaveNum)
              sigL(DENS_VAR:PRES_VAR) = sigL(DENS_VAR:PRES_VAR) + vecL(DENS_VAR:PRES_VAR)
           end if

           ! vecL(DENS_VAR:PRES_VAR) = 0.5*dot_product(leig(DENS_VAR:PRES_VAR,kWaveNum),delV(2,DENS_VAR:PRES_VAR))*reig(DENS_VAR:PRES_VAR,kWaveNum)
           ! sigL(DENS_VAR:PRES_VAR) = sigL(DENS_VAR:PRES_VAR) + vecL(DENS_VAR:PRES_VAR)

           ! vecR(DENS_VAR:PRES_VAR) = -0.5*dot_product(leig(DENS_VAR:PRES_VAR,kWaveNum),delV(2,DENS_VAR:PRES_VAR))*reig(DENS_VAR:PRES_VAR,kWaveNum)
           ! sigR(DENS_VAR:PRES_VAR) = sigR(DENS_VAR:PRES_VAR) + vecR(DENS_VAR:PRES_VAR)

        elseif (sim_riemann == 'hll') then
           vecR(DENS_VAR:PRES_VAR) = &
                0.5*( 1. -    lambdaDtDx                        )*reig(DENS_VAR:PRES_VAR, kWaveNum)*delC1(kWaveNum) + &
                .25*( 1. - 2.*lambdaDtDx + 4./3.*(lambdaDtDx**2))*reig(DENS_VAR:PRES_VAR, kWaveNum)*delC2(kWaveNum)
           sigR(DENS_VAR:PRES_VAR) = sigR(DENS_VAR:PRES_VAR) + vecR(DENS_VAR:PRES_VAR)
           
           vecL(DENS_VAR:PRES_VAR) = &
                0.5*(-1. -    lambdaDtDx                        )*reig(DENS_VAR:PRES_VAR, kWaveNum)*delC1(kWaveNum) + &
                .25*( 1. + 2.*lambdaDtDx + 4./3.*(lambdaDtDx**2))*reig(DENS_VAR:PRES_VAR, kWaveNum)*delC2(kWaveNum)
           sigL(DENS_VAR:PRES_VAR) = sigL(DENS_VAR:PRES_VAR) + vecL(DENS_VAR:PRES_VAR)


          ! !if (lambda(kWaveNum) >= 0.) then
          ! vecR(DENS_VAR:PRES_VAR) = 0.5*(1.0 - lambdaDtDx)*reig(DENS_VAR:PRES_VAR,kWaveNum)*delC1(kWaveNum)
          ! sigR(DENS_VAR:PRES_VAR) = sigR(DENS_VAR:PRES_VAR) + vecR(DENS_VAR:PRES_VAR)

          ! vecR2(DENS_VAR:PRES_VAR) = 0.25*(1.0 - 2.0*lambdaDtDx+(4.0/3.0)*(lambdaDtDx**2))*reig(DENS_VAR:PRES_VAR,kWaveNum)*delC2(kWaveNum)
          ! sigR2(DENS_VAR:PRES_VAR) = sigR2(DENS_VAR:PRES_VAR) + vecR2(DENS_VAR:PRES_VAR)
          ! !endif

          ! !if (lambda(kWaveNum) <= 0.) then
          ! vecL(DENS_VAR:PRES_VAR) = 0.5*(-1.0 - lambdaDtDx)*reig(DENS_VAR:PRES_VAR,kWaveNum)*delC1(kWaveNum)
          ! sigL(DENS_VAR:PRES_VAR) = sigL(DENS_VAR:PRES_VAR) + vecL(DENS_VAR:PRES_VAR)

          ! vecL2(DENS_VAR:PRES_VAR) = 0.25*(1.0 + 2.0*lambdaDtDx+(4.0/3.0)*(lambdaDtDx**2))*reig(DENS_VAR:PRES_VAR,kWaveNum)*delC2(kWaveNum)
          ! sigL2(DENS_VAR:PRES_VAR) = sigL2(DENS_VAR:PRES_VAR) + vecL2(DENS_VAR:PRES_VAR)
          ! !endif

        endif
    enddo
        ! Let's make sure we copy all the cell-centered values to left and right states
      vL(DENS_VAR:PRES_VAR) =  C(DENS_VAR:PRES_VAR,1) + sigL(DENS_VAR:PRES_VAR)!  + sigL2(DENS_VAR:PRES_VAR)
      vR(DENS_VAR:PRES_VAR) =  C(DENS_VAR:PRES_VAR,1) + sigR(DENS_VAR:PRES_VAR)!  + sigR2(DENS_VAR:PRES_VAR)
        ! this will be just FOG
     gr_vL(DENS_VAR:NUMB_VAR,i) = gr_V(DENS_VAR:NUMB_VAR,i)
     gr_vR(DENS_VAR:NUMB_VAR,i) = gr_V(DENS_VAR:NUMB_VAR,i)
      ! This should be PPM
      gr_vL(DENS_VAR:PRES_VAR,i) = vL(DENS_VAR:PRES_VAR)
      gr_vR(DENS_VAR:PRES_VAR,i) = vR(DENS_VAR:PRES_VAR)
      ! This should be PPM

     ! do nVar = DENS_VAR,PRES_VAR
     !  if (.not. isfog(nVar)) then
     !    gr_vL(nVar,i) = C(nVar,1) + sigL(nVar) + sigL2(nVar)
     !    gr_vR(nVar,i) = C(nVar,1) + sigR(nVar) + sigR2(nVar)
     !  endif
     ! enddo

  enddo
  
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
