module DiffyQ
  implicit none

  integer, save :: msize, nsize
  real, dimension(:,:), allocatable, save :: mat

  !********************************************************

contains

  subroutine readMat(filename)
    implicit none
    character(len=*) :: filename

    integer :: i,j

    ! Reads a file containing the matrix A 
    ! Sample file:
    !
    ! 4 4 
    ! 2.0 1.0 1.0 0.0
    ! 4.0 3.0 3.0 1.0
    ! 8.0 7.0 9.0 5.0
    ! 6.0 7.0 9.0 8.0

    open(10,file=filename)
    read(10,*) msize,nsize

    allocate(mat(msize,nsize))
    ! Always initialize with zeros
    mat = 0.0

    ! Read matrix
    do i=1,msize
       read(10,*) ( mat(i,j), j=1,nsize )
    enddo

    close(10)
  end subroutine

  subroutine printMat(A)
    implicit none
    real, dimension(:,:) :: A
    integer :: i, j, n, m
    m = size(A, dim=1)
    n = size(A, dim=2)

    print *
    print '(i5,a5,i5)', m, "x",n
    do i = 1, m
      do j = 1,n
        write(6,"(F16.5)", ADVANCE="NO") A(i,j)
      end do
      print *
    end do
    print *, ""
  end subroutine printMat

  subroutine Lax_F(m,t,u0,L)

    implicit none
    real, dimension(:,:), intent(in) :: u0
    real, dimension(:,:), intent(in) :: L
    integer, intent(in) :: m
    real, intent(in) :: t
    ! Write solution to file to save memory
    real, dimension(size(u0,dim=1),m+1) :: u
    real :: dt !, f!(u)
    integer :: i

    u = 0.0
    u(:,1) = u0(:,1)
    dt = t/m
    do i = 1,m
      !u(:,i+1) = 0.5 * (u(:,i) + u(:,i)) - dt * (u(:,i) - u(:,i))
      u(:,i+1) = matmul(L,u(:,i))
    end do

    call printMat(u)
    
  end subroutine Lax_F

end module DiffyQ
