subroutine sim_GPinit()
  !want to initialize all the GP parameters that do not depend on the data, and only on the grid geometries.
  !I am using sig/del = 2
  !This includes calculating the following:
  !****** the covariance matrix C 
  !****** the cross-correlation matrix T 
  !****** The corresponding vectors and matrices to be used in actual calculations (see eqs 30-32) v & Z
  !******  ****** C.v  = u  (gr_GPv)
  !******  ****** C.Z* = T* (gr_GPZ)
#include "definition.h"

  use grid_data
  use linalg
  use GP

  implicit none
  !integer (kind=4), parameter :: N = 2*gr_radius+1
  real, dimension(2*gr_radius+1,2*gr_radius+1) :: C, L, W, Vt, Sigmai
  real, dimension(2,2*gr_radius+1) :: T
  real, dimension(2*gr_radius+1,2) :: B
  real, dimension(2*gr_radius+1)   :: stencil, u, S
  integer :: i,j,N
  real :: small
  !for dgetrf/s
  integer :: INFO
  integer, dimension(2*gr_radius+1):: IPIV
  
  !initialize
  N = 2*gr_radius+1
  C = 0.
  T = 0.
  u = 1.
  
  do i = 1, N
     stencil(i) = (i-gr_radius-1)
     !stencil(i) = (i-gr_radius-1)*gr_dx
  end do

  !first thing is to calculate the covariance matrix according to eq. 15
  !since C is symmetric only bother with one side of the diaganol
  do i = 1,N
     do j = 1,N
        !off diaganol terms
        !C(i,j) = intg_kernel(stencil(i), stencil(j))  !simpson's rule only
        C(i,j) = int_SEcov(stencil(i), stencil(j))     !can do exact quad. SE only
        !C(i,j) = int_EXPcov(stencil(i), stencil(j))
        !C(j,i) = C(i,j)
     end do
     !C(i,i) = int_SEcov(stencil(i), stencil(i))
     !print *, C(i,1), C(i,2), C(i,3), C(i,4), C(i,5)
     !whiel we're here lets take care of T
     !T(1:2, i) = intg_predvec(stencil(i)) !simpson's rule only
     T(1:2, i) = cross_cor(stencil(i))     !can do exact quad. SE only
     !T(1:2, i) = cross_EXP(stencil(i))
  end do
  !now we need to solve the linear eqns for v & Z (see eqs 30-32)
  do i = 1,N
     print *, C(i,:)
  end do
  !  print *
  do i = 1,N
     do j = 1, i-1
        print *, i, j, C(i,j) - C(j,i), 1. - C(i,j)
     end do
  end do
  
!!$  call chol(C, N, L)
!!$  call solve_Axb(C, gr_GPv, u, L, N)
!!$  call solve_CZT(C, gr_GPZ, T, L, N)

  !LU factorization method
  L = C
  call dgetrf(N, N, C, N, IPIV, INFO)
  print *, INFO
  gr_GPv = 1.
  call dgetrs('N', N, 1, C, N, IPIV, gr_GPv, N, INFO)
  print *, INFO
  print *, matmul(L, gr_GPv)
  gr_GPZ = T
  call dgetrs('N', N, 1, C, N, IPIV, T(1,:), N, INFO)
  call dgetrs('N', N, 1, C, N, IPIV, T(2,:), N, INFO)
  print *, INFO
  print *, matmul(L, T(2,:))
  ! print *, 
  print *, gr_GPZ(2,:)
  gr_GPZ = T
  
end subroutine sim_GPinit
