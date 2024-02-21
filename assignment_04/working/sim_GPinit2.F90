subroutine sim_GPinit2()
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
  !integer (kind=4), parameter :: N = 2*gr_radius+1+1
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

  print *, 'stencil: '
  do i = 1, N
     stencil(i) =  REAL(i - gr_radius - 1)       !0.5*REAL(2*(i-gr_radius)-1)
     print *, stencil(i)
     !stencil(i) = (i-gr_radius-1)*gr_dx
  end do

  !first thing is to calculate the covariance matrix according to eq. 15
  !since C is symmetric only bother with one side of the diaganol
  do i = 1,N
     do j = 1,N
        C(i,j) = SE(stencil(i), stencil(j))     
     end do
     T(1, i) = SE_der_cov_dxy(0., (stencil(i)))
     T(2, i) = SE_der_cov_dxy(0., (stencil(i)))
     print *, T(1, i), T(2,i)
  end do
  !now we need to solve the linear eqns for v & Z (see eqs 30-32)
  do i = 1,N
     print *, C(i,:)
  end do
  !print *,
  
  call chol(C, N, L)
  call solve_Axb(C, gr_GPv, u, L, N)
  call solve_CZT(C, gr_GPZ, T, L, N)

  !LU factorization method
!!$  L = C
!!$  call dgetrf(N, N, C, N, IPIV, INFO)
!!$  print *, INFO
!!$  gr_GPv = 1.
!!$  call dgetrs('N', N, 1, C, N, IPIV, gr_GPv2, N, INFO)
!!$  print *, INFO
!!$  print *, matmul(L, gr_GPv2)
!!$  gr_GPZ2 = T
!!$  call dgetrs('N', N, 1, C, N, IPIV, T(1,:), N, INFO)
!!$  call dgetrs('N', N, 1, C, N, IPIV, T(2,:), N, INFO)
!!$  print *, INFO
!!$  print *, matmul(L, T(2,:))
!!$  print *, 
!!$  print *, gr_GPZ2(2,:)
!!$  gr_GPZ2 = T
  
end subroutine sim_GPinit2

