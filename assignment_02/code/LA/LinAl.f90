module LinAl
  implicit none
  
  integer, save :: msize, nsize
  real, dimension(:,:), allocatable, save :: mat
  

contains

  !********************************************************

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
    !
    ! Note that the first 2 numbers in the first line are the matrix dimensions, i.e., 4x4,
    ! then the next msize lines are the matrix entries. This matrix is found in Eq. 2.18 of the lecture note.
    ! Note that entries must be separated by a tab.


    open(10,file=filename)

    ! Read the matrix dimensions
    read(10,*) i,j

    ! Read matrix
    do i=1,msize
       read(10,*) ( mat(i,j), j=1,nsize )
    enddo

    close(10)
    
  end subroutine readMat

  subroutine readMat2(A, myFileName)

    real, dimension(:,:), allocatable :: A
    character(len=100) :: myFileName
    ! Read matrix A
    ! myFileName = 'Amat.dat'

    open(10,file=myFileName)
    read(10,*) msize,nsize
    close(10)


    allocate(mat(msize,nsize))
    allocate(A(msize,nsize))
    ! Always initialize with zeros
    mat = 0.0
    
    call readMat(myFileName)
    A = mat
    ! sizeA(1) = msize
    ! sizeA(2) = nsize
    deallocate(mat)


  end subroutine

  subroutine traceMat(mat, msize, traceA)

    implicit none
    real :: traceA
    integer :: msize
    real, dimension(:,:), allocatable :: mat
    integer :: i

    ! A: m × m square matrix
    ! m: the first dimension of A
    ! traceA: return value

    do i=1,msize
       traceA = traceA + mat(i,i)
    enddo
    
  end subroutine traceMat

  subroutine printColumnNorm(A)

    implicit none
    real, dimension(:,:) :: A
    ! real, dimension(:), allocatable :: norm
    real :: norm
    integer :: j, nsize, msize
    nsize = size(A, dim=2)
    msize = size(A, dim=1)
    ! allocate(norm(nsize))
    norm = 0.0
    ! Calculate two norm of columns of A
    print *, ""
    do j = 1, nsize
      norm = 0.0
      call twoNorm(A(:,j), nsize,norm)
      write(*,*) "Norm column: ", j
      write(*,*) norm
    end do

  end subroutine printColumnNorm 

  subroutine twoNorm(vec, dim, norm)

    implicit none
    real :: norm
    integer :: dim
    real, dimension(:) :: vec
    integer :: i

    norm = 0.0

    ! Write a function (and/or subroutine) that takes three arguments. Two
    ! input arguments are a vector and its dimension, and one output argument
    ! is its Euclidean norm (i.e., 2-norm).

    do i=1,dim
       norm = norm + vec(i)**2
    enddo
    norm = sqrt(norm)

  end subroutine twoNorm

  subroutine twoNorm2(vec, dim, norm)

    implicit none
    real :: norm
    integer :: dim
    real, dimension(:,:) :: vec
    integer :: i

    norm = 0.0

    ! Write a function (and/or subroutine) that takes three arguments. Two
    ! input arguments are a vector and its dimension, and one output argument
    ! is its Euclidean norm (i.e., 2-norm).

    do i=1,dim
       norm = norm + vec(i,1)**2
    enddo
    norm = sqrt(norm)

  end subroutine twoNorm2

  subroutine printMat2(A)
    implicit none
    real, dimension(:,:) :: A
    integer :: i, j, n, m
    m = size(A, dim=1)
    n = size(A, dim=2)

    ! print '("Matrix A"/(mF8.2))', ((A(i,j), i = 1, m), j=1,n)
    ! print *, ""
    ! print *, m, "x",n
    ! do i = 1, m
    !   ! write(6,"(F8.2)") (A(i,j) , j = 1, n )

    !   write(*,*) (A(i,j) , j = 1, n )
    ! end do
    ! print *, ""

    print *
    print '(i5,a5,i5)', m, "x",n
    do i = 1, m
      do j = 1,n
        write(6,"(F8.4)", ADVANCE="NO") A(i,j)
      end do
      print *
    end do
    print *, ""

  end subroutine printMat2

  subroutine printMat(A, dims)

    ! Write a function (and/or subroutine) that takes two input arguments of
    ! (i) an m × n matrix A, and (ii) both of its dimensions. This routine then
    ! prints the matrix and its dimensions (i.e., m and n) to the screen in a
    ! human readable form (i.e., screen output).

    implicit none
    integer, dimension(:) :: dims
    real, dimension(:,:) :: A
    integer :: i, j

    write(*,*) "Dimensions"
    write(*,*) dims(1), "x", dims(2)
    write(*,*) "Matrix"
    do i = 1, dims(1)
      write(*,*) (A(i,j) , j = 1, dims(2) )
    end do

  end subroutine printMat

  subroutine LUdecomp(A, L, U)
    real, dimension(:,:) :: A
    real, dimension(:,:) :: L
    real, dimension(:,:) :: U
    real :: sum
    integer :: i, j, k, n
    L = 0.0
    U = 0.0
    n = size(A, dim=1)

    do i = 1, n

      ! upper triangular
      do k = i, n
        ! summation of L(i,j) * U(j,k)
        sum = 0.0
        do j = 1, i
          sum = sum + L(i,j) * U(j,k)
        enddo

        ! evaluating U(i,k)
        U(i,k) = A(i,k) - sum
      enddo

      ! lower triangular
      do k = i, n
        if (i == k) then
          L(i,i) = 1
        else
          ! summation of L(k,j) * U(j,i)
          sum = 0.0
          do j = 1, i
            sum = sum + L(k,j) * U(j,i)
          enddo
          L(k,i) = (A(k,i) - sum)/U(i,i)
        end if
      enddo

    enddo

  end subroutine LUdecomp


  subroutine partGaussElim(A, B, dimsA, dimsB, SINGLR)

    implicit none
    integer, dimension(:) :: dimsA
    integer, dimension(:) :: dimsB
    real, dimension(:,:) :: A
    real, dimension(:,:) :: B
    real, dimension(:,:), allocatable :: As ! copy of A
    real, dimension(:,:), allocatable:: Bs ! copy of B
    real, dimension(:,:), allocatable:: X ! solution 
    real, dimension(:,:), allocatable :: D ! augemented matrix
    real, dimension(:), allocatable :: temp ! for swapping rows
    integer :: i, j, m, kmax 
    integer, dimension(2) :: dimsD
    integer, dimension(2) :: dimsX
    real :: maximum
    logical :: SINGLR ! flag for whether matrix A is invertible 
  

    ! Should probably assert dimsA(1) = dimsA(2) = dimsB(1)
    m = dimsA(1)
    ! X = 0.0 ! set = to 0?

    ! Concatanate matrices (augmented matrix)
    dimsD(1) = dimsA(1)
    dimsD(2) = dimsA(2) + dimsB(2)

    allocate(As(dimsA(1),dimsA(2)))
    allocate(Bs(dimsB(1),dimsB(2)))
    allocate(X(dimsA(2), dimsB(2)))
    X = 0.0
    dimsX(1) = dimsA(2)
    dimsX(2) = dimsB(2)
    As = A ! copy A
    Bs = B ! copy B
    allocate(D(dimsD(1),dimsD(2)))
    allocate(temp(dimsD(2)))
    do i=1,dimsD(2)
      if (i <= dimsA(2)) then
        D(:,i)=A(:,i)
      else
        D(:,i)=B(:,i-dimsA(2))
      end if
    enddo

    ! Gaussian Elimination
    do i = 1,m
      ! need to add +(i-1) to account for the array "shrinking"
      kmax = maxloc(abs(D(i:m,i)), dim=1) + (i-1)
      maximum = D(kmax, i)
    !   ! if (maximum < 1e-14*norma) then !singular

      ! Swap rows so pivot is maximum
      if (i /= kmax) then 
        temp = D(kmax,:)
        D(kmax,:) = D(i,:)
        D(i,:) = temp
      end if

      ! Matrix is singular (stop)
      if (D(i, i) == 0) then
        SINGLR = .TRUE.
        stop
      end if

      ! Eliminiation step
      do j = i+1,m
        D(j,:) = D(j,:) - D(j,i)*(D(i,:)/D(i,i))
      enddo

    enddo

    A = D(:, 1:m)
    B = D(:, m+1:dimsB(2))
    deallocate(D)


    ! I still need to teach myself how these print statements work..
    ! print A
    print *, ""
    print *, ""
    print *, "matrix A after gauss"
    call printMat(A, dimsA)
    ! print B
    print *, ""
    print *, ""
    print * , "matrix B after gauss"
    call printMat(B, dimsB)
    print *, SINGLR
    call backSubstitution(A, B, X)
    print *, ""
    print *, ""
    print *, "solution X to AX = B"
    call printMat(X, dimsX)


    print *, ""
    print *, ""
    print *, "Error matrix"
    call printMat2(matmul(As,X)-Bs)

    call printColumnNorm(matmul(As,X)-Bs)

  end subroutine partGaussElim

  ! Back substitution when L is upper triangular
  subroutine backSubstitutionL(L,B,X)
    implicit none
    real, dimension(:, :) :: L
    real, dimension(:, :) :: B
    real, dimension(:, :) :: X
    integer :: n, i, j

    n = size(B,dim=1)

    do i=1,n ! start, stop [,step]

      X(i,:) = B(i,:)/L(i,i) 

      do j = i+1,n
        B(j,:) = B(j,:) - X(i,:)*L(j,i)
      enddo
      ! B(1:i-1,:) = B(1:i-1,:) - X(i,:)*U(1:i-1,i)
    enddo


  end subroutine backSubstitutionL


  ! Back substitution when U is upper triangular
  subroutine backSubstitution(U,B,X)
    implicit none
    real, dimension(:, :) :: U
    real, dimension(:, :) :: B
    real, dimension(:, :) :: X
    integer :: n, i, j

    n = size(B,dim=1)

    do i=n,1,-1 ! start, stop [,step]

      X(i,:) = B(i,:)/U(i,i) 

      do j = 1,i-1
        B(j,:) = B(j,:) - X(i,:)*U(j,i)
      enddo
      ! B(1:i-1,:) = B(1:i-1,:) - X(i,:)*U(1:i-1,i)
    enddo


  end subroutine backSubstitution

  subroutine choleskyDecom(A, flag)
    implicit none
    real, dimension(:,:) :: A
    real, dimension(:,:), allocatable :: R
    logical :: flag
    real, dimension(:,:), allocatable :: v
    real :: h
    integer :: n,j

    ! should probably assert n = m (square)
    n = size(A, dim=1)
    allocate(R(n,n))
    R = 0.0 ! always initialize to 0!
    allocate(v(1,n))

    do j =1,n
      v = A(j:j,j:n)
      if (j>1) then
        ! v = A(j,j:n) - matmul(R(j-1:1:-1,j),R(1:j-1,j:n)) ! Why can't we just use transpose()?
        v = A(j:j,j:n) - matmul(transpose(R(1:j-1,j:j)), R(1:j-1,j:n))
      end if
      if (v(1,1)<=0) then
        write(*,*) "matrix is not positive definite"
        flag = .TRUE.
        stop
      else
        h = 1/sqrt(v(1,1))
      end if
      R(j:j,j:n) = v*h
    enddo

    A = R
    deallocate(R)
    deallocate(v)


  end subroutine choleskyDecom

  subroutine backSubChol(A, B, X, dim)
    ! backsubstitution routine that solves LL T x = b. The routine
    ! takes as the following information as arguments:
    ! • the matrix A already Cholesky-decomposed (input)
    ! • its first dimension (input)
    ! • a vector b (Note : you can generalize this and input a matrix B containing
    ! n rhs vectors if you prefer, i.e., B = [b 1 t b 2 t · · · t b n ], b i ∈ R m ) (input)

    real, dimension(:,:) :: A ! L^t => upper triangular
    real, dimension(:,:) :: B ! AX=B
    real, dimension(:,:) :: X ! AX=B
    integer :: dim
    ! real, dimension(dim,size(B,dim=2)) :: X ! Solution
    real, dimension(dim,size(B,dim=2)) :: Y ! Solution

    
    ! First solve L(Y) = B
    call backSubstitutionL(transpose(A), B, Y)
    ! Then solve L^t(X) = Y
    call backSubstitution(A, Y, X)


    ! Solution
    ! print *, "X"
    ! call printMat2(X)

  end subroutine backSubChol


  subroutine householderQR(A, d, dimsA)

    ! Input A, d, dimensions of A
    ! Computes the implicit QR. Matrix A is replaced by the upper triangular matrix R and the normalized 
    ! householder vectors are
    ! stored in the lower half of A. The diagonal R is stored in d (column vector).

    implicit none
    real, dimension(:,:) :: A
    real, dimension(:,:) :: d ! size n?
    integer, dimension(:) :: dimsA
    integer :: m, n, j
    real :: alpha, nrm
    m = dimsA(1) 
    n = dimsA(2)

    ! Iterate over columns of A
    do j = 1,n
      call twoNorm(A(j:m,j), m-j+1, alpha) ! stores the norm in alpha

      if (A(j,j) >= 0) then
        d(j,1) = -alpha
      else
        d(j,1) = alpha
      end if

      nrm = sqrt(alpha*(alpha+abs(A(j,j)))) ! nrm = ||v||
      A(j,j) = A(j,j) - d(j,1);
      A(j:m,j) = A(j:m,j)/nrm ! store u = v/||v||
      ! A(j:m,j) = A(j:m,j) ! store v

      ! transform the rest of the matrix A := A-u*(u'*A)
      if (j < n) then
        A(j:m,j+1:n) = A(j:m, j+1:n) - matmul(A(j:m,j:j), matmul(transpose(A(j:m,j:j)), A(j:m, j+1:n)))
      end if 
    enddo
    
  end subroutine householderQR

  subroutine householderQy(A, y, dimsA)
    ! computes Qy using the Householder
    ! reflections Q stored as vectors in the matrix A by
    ! housholderQR(A). Replace input y with Qy
    implicit none
    real, dimension(:,:) :: A ! size mxn
    real, dimension(:,:) :: y ! size nx1
    integer, dimension(:) :: dimsA
    integer :: m, n, j
    m = dimsA(1) 
    n = dimsA(2)

    do j = n,1,-1 ! start, stop [,step]
      y(j:m,1) = y(j:m,1) - matmul(matmul(A(j:m,j:j),transpose(A(j:m,j:j))),y(j:m,1))
    enddo

  end subroutine householderQy

  subroutine hessenberg(A)

    ! uses householder transformations to compute hessenberg decomposition of A
    ! factors a symmetric matrix A into a tridiagonal matrix

    real, dimension(:,:) :: A ! size mxn
    real, dimension(:,:), allocatable :: v ! size mxn
    integer :: m, n, j
    real :: alpha, nrm
    m = size(A, dim=1) 
    n = size(A, dim=2) 

    allocate(v(m,1))

    ! Iterate over columns of A
    do j = 1,n-1
      v = 0.0

      call twoNorm(A(j+1:m,j), m-j, alpha) ! stores the norm in alpha
      if (A(j+1,j) >= 0) then
        alpha = -alpha
      end if

      ! compute householder vector
      v(j+1:m,1) = A(j+1:m,j)
      v(j+1,1) = A(j+1,j) - alpha
      ! normalize vector
      nrm = 0.0
      call twoNorm(v(1:m,1), m, nrm) ! nrm = ||v||
      v(1:m,1) = v(1:m,1)/nrm

      ! update A from the left
      A = A - 2 * matmul(matmul(v, transpose(v)),A)
      ! update A from the right
      A = A - 2 * matmul(matmul(A, v),transpose(v))
    enddo
    
    deallocate(v)
  end subroutine

  subroutine eQR(A, Q, R)
    ! explicitely calculate QR decomposition. Takes input A mxn, Q mxm, R mxn and outputs QR factorization
    ! store in Q and R. Leaves A unchanged.

    real, dimension(:,:) :: A ! mXn
    real, dimension(:,:) :: Q ! mXm
    real, dimension(:,:) :: R ! mXn
    real, dimension(:,:), allocatable :: dR, Id
    integer, dimension(2) :: dimsA
    integer :: msize, nsize, i

    dimsA(1) = size(A, dim=1)
    dimsA(2) = size(A, dim=2)
    msize = dimsA(1)
    nsize = dimsA(2)

    allocate(dR(nsize, 1))
    allocate(Id(msize, msize)) ! identity matrix
    Id(1:msize,1:msize) = 0.0
    forall (i = 1:msize) Id(i,i) = 1.0

    call householderQR(A, dR, dimsA)

    ! create Q and R explicitely (Make this a subroutine?)
    do i = 1,msize
      ! Apply Q onto the columns of the Identity matrix, using the orthonormal vectors, u,
      ! from the Householder reflector, H = I-uu^T (which are stored in the lower part of E)
      call householderQy(A, Id(:,i:i), dimsA)
      Q(:,i:i) = Id(:,i:i)
      if (i <= nsize) then
        R(:, i) = A(1:i,i) ! upper triangular part of E stores R (excluding the diagonal part)
        R(i,i) = dR(i,1) ! diagonal part of R
      end if
    enddo
    deallocate(Id)
    deallocate(dR)

  end subroutine

  subroutine eigQR(A)

    real, dimension(:,:) :: A ! size nxn
    real, dimension(:,:), allocatable :: Q
    real, dimension(:,:), allocatable :: R
    ! ! vector to store eigenvalues
    ! real, dimension(:,:), allocatable :: v ! size nx1
    integer :: n, j, i
    n = size(A, dim=1) 

!   allocate(Q(msize, msize)) ! Q matrix
    allocate(Q(n, n)) ! Q matrix
    Q = 0.0
  ! allocate(R(msize, nsize)) ! R matrix
    allocate(R(n, n)) ! R matrix
    R = 0.0

    do i = 1,100 ! loop until error is small
      ! calculate A = QR
      call eQR(A, Q, R)
      ! update A = RQ
      A = matmul(R, Q)
    enddo

    ! call printMat2(A)

  end subroutine


  subroutine eigQRshift(A)

    real, dimension(:,:) :: A ! size nxn
    real, dimension(:,:), allocatable :: Q
    real, dimension(:,:), allocatable :: R
    real, dimension(:,:), allocatable :: Id
    ! ! vector to store eigenvalues
    ! real, dimension(:,:), allocatable :: v ! size nx1
    integer :: n, j, i 
    real :: mu
    n = size(A, dim=1) 

!   allocate(Q(msize, msize)) ! Q matrix
    allocate(Q(n, n)) ! Q matrix
    Q = 0.0
  ! allocate(R(msize, nsize)) ! R matrix
    allocate(R(n, n)) ! R matrix
    R = 0.0
    allocate(Id(n, n)) ! identity matrix
    Id(1:n,1:n) = 0.0
    forall (i = 1:n) Id(i,i) = 1.0

    do i = 1,6 ! loop until error is small ( norm of super(sub) diagonal?)
      ! calculate A = QR
      mu = A(n, n)
      call eQR(A - mu*Id, Q, R)
      ! update A = RQ
      A = matmul(R, Q) + mu * Id
    enddo

end subroutine

subroutine inverseIter(A, mu)

  ! Calculates eigenvectors of a matrix A given a "guess" mu approximately equal to an eigenvalue

    real, dimension(:,:) :: A ! size nxn
    ! real, dimension(:,:), allocatable :: A_copy
    real, dimension(:,:), allocatable :: L
    real, dimension(:,:), allocatable :: U
    real, dimension(:,:), allocatable :: Id
    real, dimension(:,:), allocatable :: x ! guess
    real, dimension(:,:), allocatable :: xn ! eigenvector
    real, dimension(:,:), allocatable :: y ! temp
    real, dimension(:,:), allocatable :: err 
    real :: nrm, nrm_err


    integer :: n, j, i 
    real :: mu
    n = size(A, dim=1) 

  ! iterates to eigenvector
    allocate(x(n,1))
    allocate(xn(n,1))
    allocate(y(n,1))
    allocate(err(n,1))

    x = 1.0
    xn = 0.0

    err = xn - x
    call twoNorm2(err, n, nrm_err)

    allocate(Id(n, n)) ! identity matrix
    Id(1:n,1:n) = 0.0
    forall (i = 1:n) Id(i,i) = 1.0

    allocate(L(n,n))
    allocate(U(n,n))

    call LUdecomp(A - mu*Id, L, U)


    ! do while (nrm_err > 10.0**(-5.0))
    !   ! First solve L(y) = x
    !   call backSubstitutionL(L, x, y)
    !   ! Then solve L^t(xn) = y
    !   call backSubstitution(U, y, xn)
    !   nrm = 0.0
    !   call twoNorm2(xn, n, nrm)
    !   x = xn/nrm
    !   err = xn - x
    !   call twoNorm2(err, n, nrm_err)
    ! enddo
     
    ! call printMat2(x)

    do i = 1, 10
      ! First solve L(y) = x
      call backSubstitutionL(L, x, y)
      ! Then solve L^t(xn) = y
      call backSubstitution(U, y, xn)
      call twoNorm2(xn, n, nrm)
      x = xn/nrm
      err = xn - x
      call twoNorm2(err, n, nrm)
    enddo
     
    call printMat2(x)

  end subroutine

end module LinAl
