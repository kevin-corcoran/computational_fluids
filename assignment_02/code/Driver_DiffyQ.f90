Program Driver_DiffyQ
  use DiffyQ
    implicit none
    real, dimension(:,:), allocatable :: A ! size nxn
    real, dimension(:,:), allocatable :: Id
    real, dimension(:,:), allocatable :: L

    ! x0 = 0.0; x = 2.0;
    ! Δx = 0.01; L = x-x0; N = Int(L/Δx); 
    ! 
    ! A = 1/Δx^2 * spdiagm(-1=>ones(N-1),0=>-2.0*ones(N),1=>ones(N-1))

    integer :: n, j, i, m, tr
    real :: x0, x, delta_x, t0, t, delta_t, a_, CFL
    real, dimension(:,:), allocatable :: xs, u0
    ! Declare local constant Pi
    real, parameter :: pi = 3.1415927 



    ! U i n+1 = 1/2 (U_{i+1}^n + U_{i−1}^n) − ∆t/2∆x (f (U_{i+1}^n) − f (U_{i-1}^n)) .
    ! PROBLEM 4

    ! Implement the LF method in Eqn. (1) to numerically solve the
    ! sinusoidal advection problem
    !     u t + au x = 0,
    !     a = 1,
    ! (5) with an IC: u(x, 0) = sin(2πx), on x ∈ [0, 1]. 

    ! Use the periodic boundary condi- tion on both ends at x = 0 and x = 1.
    ! Run your code on two different grid resolutions of N = 32, 64, 128 with
    ! CFL numbers of 0.8, 1.0, and 1.2. Show your plots at t = t cycle1 at all two
    ! grid resolutions, where t cycle1 is the time the sinusoidal wave returns to the
    ! initial position (Hint: You can easily find t cycle1 analytically first). Describe
    ! your findings and compare the LF results with the first-order upwind method
    ! provided in the MATLAB code.

    a_ = 1.0; CFL = 1.2
    ! # Space
    ! A = 1/Δx^2 * spdiagm(-1=>ones(N-1),0=>-2.0*ones(N),1=>ones(N-1))
    x0 = 0.0; x = 1.0; N = 128; delta_x = (x-x0)/N

    ! # Time
    t0 = 0.0; t = 1.0; delta_t = (CFL * delta_x)/a_; m = (t-t0)/delta_t

    !n = 5
    allocate(L(n+1,n+1))
    L = 0.0
    ! subdiagonal
    forall (i = 1:n) L(i+1,i) = 1.0/2.0 + a_*delta_t/(2.0*delta_x)
    ! superdiagonal
    forall (i = 1:n) L(i,i+1) = 1.0/2.0 - a_*delta_t/(2.0*delta_x)

    ! # boundary condition
    L(1,n+1) = 1.0/2.0 + a_*delta_t/(2.0*delta_x)
    L(n+1, 1) = 1.0/2.0 - a_*delta_t/(2.0*delta_x)

    allocate(xs(N+1,1)) ! column vector
    forall (i = 1:n+1) xs(i,1) = x0 + (i-1)*delta_x

    ! # initial condition
    allocate(u0(N+1,1))
    !forall (i = 1:n+1) u0(i,1) = sin(2*pi*xs(i,1))
    u0 = g(xs) !

    call Lax_F(m, t-t0, u0, L)

contains
    ! # initial condition
    function g(x) result(w)
      implicit none
      ! make this take an array over partition of space
      real, dimension(:,:), intent(in) :: x
      real, dimension(size(x,dim=1),1) :: w
      ! return an array of sin over partition
      integer :: i, n
      n = size(x,dim=1)
      w = 0.0
      forall (i = 1:n) w(i,1) = sin(2*pi*x(i,1))
    end function g

    ! # initial condition
    ! function g2(x) result(w)
    !   implicit none
    !   ! make this take an array over partition of space
    !   real, dimension(:,:), intent(in) :: x
    !   real, dimension(size(x,dim=1),1) :: w
    !   ! return an array of sin over partition
    !   integer :: i, n
    !   n = size(x,dim=1)
    !   w = 0.0
    !   do i = 1,n
    !     if (abs(x(i,1)) < 1.0/3.0) then
    !       print *, "condition 1"
    !     else if (1.0/3.0 < abs(x(i,1)) < 1.0)
    !       print *, "condition 2"
    !     end if
    !   end do
    ! end function g2
end Program Driver_DiffyQ

! call readMat('Amat.dat')
! allocate(A(msize,nsize))
! A = mat
! deallocate(mat)
! print *, "Matrix A"
! call printMat(A)
! 
! 
! n = size(A, dim=1) 
! allocate(Id(n, n)) ! identity matrix
! Id(1:n,1:n) = 0.0
! forall (i = 1:n) Id(i,i) = 1.0
! 
! allocate(L(n,n))
! L = 0.0
! ! diagonal
! forall (i = 1:n) L(i,i) = -2.0
! ! subdiagonal
! forall (i = 1:n-1) L(i+1,i) = 1.0
! ! superdiagonal
! forall (i = 1:n-1) L(i,i+1) = 1.0
! 
! print *, "Laplacian"
! call printMat(L)
! 
