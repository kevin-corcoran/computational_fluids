Program Driver_LinAl

  ! use LinAl, only: mat, msize, nsize, readMat, traceMat, twoNorm, printMat, partGaussElim, printMat2, choleskyDecom, backSubChol
  use LinAl

  implicit none
  
  character(len=100) :: myFileName

  ! From hw2
  integer :: i,j
  real :: traceA
  real :: norm
  integer, dimension(2) :: sizeA
  integer, dimension(2) :: sizeB
  real, dimension(:,:), allocatable :: A
  real, dimension(:,:), allocatable :: B
  real, dimension(:,:), allocatable :: B1
  real, dimension(:,:), allocatable :: B2
  real, dimension(:,:), allocatable :: C
  real, dimension(:,:), allocatable :: S

  ! Part 1 HW3 for Cholesky
  real, dimension(:,:), allocatable :: xs ! data points x
  real, dimension(:), allocatable :: xss ! evaluation points for polynomial interp. (I should change these names..)
  real, dimension(:,:), allocatable :: ys ! data points y
  real, dimension(:,:), allocatable :: yss ! data points y copy
  real, dimension(:), allocatable :: ysss ! f(xss) (terrible naming...what are you doing?)
  real, dimension(:,:), allocatable :: V !Vandermond matrix

  real, dimension(:,:), allocatable :: X ! Solution
  real, dimension(2) :: dimsV !test
  integer :: n, d ! n: number of data points; d: degree of polynomial
  real :: err

  ! Part 2 HW3 for qrHouseholder least squares
  real, dimension(:,:), allocatable :: E ! matrix to decompose (read from ExMat.dat file)
  real, dimension(:,:), allocatable :: E_copy !
  integer, dimension(2) :: dimsE
  real, dimension(:,:), allocatable :: dR ! diagonal elements of R
  real, dimension(:,:), allocatable :: y ! test
  real, dimension(:,:), allocatable :: z ! test
  real, dimension(:,:), allocatable :: Id ! identity matrix
  real, dimension(:,:), allocatable :: Q ! to store Q explicitly 
  real, dimension(:,:), allocatable :: R ! to store R explicitly

  logical :: SINGLR
  logical :: flag
  SINGLR = .FALSE.
  flag = .FALSE.

  print *, "1. Tridiagonal"
  myFileName = 'Amat.dat'
  call readMat2(A, myFileName)
  call printMat2(A)
  call hessenberg(A)
  call printMat2(A)


  print *, "2. Eigenvalues"
  print*, "i Without shift"
  myFileName = 'Bmat.dat'
  call readMat2(B1, myFileName)
  call printMat2(B1)
  call eigQR(B1)
  call printMat2(B1)
  
  print *, "ii With shift"
  call readMat2(B2, myFileName)
  call printMat2(B2)
  call eigQRshift(B2)
  call printMat2(B2)
  ! call hessenberg(A)
  ! call printMat2(A)

  print *, "3. Eigenvectors"
  myFileName = 'Cmat.dat'
  call readMat2(C, myFileName)
  call printMat2(C)
  print *, "est: -8"
  call inverseIter(C, -8.0)

  print *, "est: 7"
  call inverseIter(C, 7.0)

  print *, "est: 5"
  call inverseIter(C, 5.0)

end Program Driver_LinAl

! 
!   ! Read matrix B
!   myFileName = 'Bmat.dat' 
!   open(10,file=myFileName)
!   read(10,*) msize,nsize
!   close(10)
! 
! 
!   allocate(mat(msize,nsize))
!   allocate(B(msize,nsize))
!   mat = 0.0
!   
!   call readMat(myFileName)
!   B = mat
!   sizeB(1) = msize
!   sizeB(2) = nsize
!   deallocate(mat)
! 
!   ! Read matrix S
!   myFileName = 'Smat.dat'
! 
!   open(10,file=myFileName)
!   read(10,*) msize,nsize
!   close(10)
! 
! 
!   allocate(mat(msize,nsize))
!   allocate(S(msize,nsize))
!   ! Always initialize with zeros
!   mat = 0.0
!   
!   call readMat(myFileName)
!   S = mat
!   ! sizeA(1) = msize
!   ! sizeA(2) = nsize
!   deallocate(mat)
! 
! 
! ! Read atkinson data
!     myFileName = 'atkinson.dat'
!   
!     n = 21
!     allocate(xs(n,1))
!     allocate(ys(n,1))
!     ! Always initialize with zeros
!     xs = 0.0 ! data points xs
!     ys = 0.0 ! data points f(xs)
!     open (10, file=myFileName)
!     i=0
!     do while (.true.)
!       i=i+1
!       read (10, *, end=999) xs(i,1), ys(i,1)
!     enddo
!     999 continue
!   
!   ! Build vandermond matrix
!     d = 3 ! degree of polynomial
!     allocate(V(n, d+1))
! 
!     do i = 1,n
!       do j = 1,d+1
!         V(i,j) = xs(i,1)**(j-1)
!       enddo
!     enddo
! 
! 
! 
!   ! normal equations
!   S = matmul(transpose(V),V)
!   ! create a copy 
!   yss = ys
!   ys = matmul(transpose(V),ys)
! 
!   ! Solve normal equations for polynomial interpolation using cholesky decomposition and the vandermond matrix
!   call choleskyDecom(S, flag)
!   ! print *, "Cholesky decomp"
!   ! call printMat2(S)
!   ! call backSubChol(S,ys, size(S,dim=1))
! 
!   allocate(X(size(S,dim=1),size(ys,dim=2)))
!   X = 0.0 ! Solution
!   call backSubChol(S,ys, X, size(S,dim=1))
! 
!   print *, "Solution to Vx = y for polynomial interpolation (the coefficents)"
!   call printMat2(X)
! 
!   ! Error in Vx = y
!   err = 0.0
!   print *, "Error ||Vx-y||_2"
!   call twoNorm2(matmul(V,X)- yss, size(yss,dim=1), err)
!   print *, err
! 
!   ! Computes fitted curve and prints it to a file
!   ! f(x) = X(1)+X(2)x+X(3)x^2+X(4)x^3+X(5)x^4+X(6)x^5
!   allocate(xss(101))
!   allocate(ysss(101))
!   xss = 0.0
!   ysss = 0.0
!   do i = 1,101
!     ! (1-0)/100 ! step size
!     ! X(1)+X(2)x+X(3)x^2+X(4)x^3+X(5)x^4+X(6)x^5
!     xss(i) = 0 + (i-1)*(1.0-0.0)/100.0
!     do j = 1,d
!       ysss(i) = ysss(i) + X(j,1)*xss(i)**(j-1)
!     enddo
!   enddo
! 
!   ! call printMat2(ysss)
! 
!     open(10,file="interp.dat")
! 
!     do i=1,101
!        write(10,*) xss(i), ysss(i)
!     enddo
! 
!     close(10)
! 
! 
!   ! PART 1 (2)
!   ! Read matrix from lecture notes
!   myFileName = 'ExMat.dat'
! 
!   open(10,file=myFileName)
!   read(10,*) msize,nsize
!   close(10)
! 
! 
!   allocate(mat(msize,nsize))
!   allocate(E(msize,nsize))
!   allocate(E_copy(msize,nsize))
!   ! Always initialize with zeros
!   mat = 0.0
!   
!   call readMat(myFileName)
!   E = mat
!   dimsE(1) = msize
!   dimsE(2) = nsize
!   deallocate(mat)
!   
!   allocate(Id(msize, msize)) ! identity matrix
!   Id(1:msize,1:msize) = 0.0
!   forall (i = 1:msize) Id(i,i) = 1.0
!   allocate(Q(msize, msize)) ! Q matrix
!   Q = 0.0
!   allocate(R(msize, nsize)) ! R matrix
!   R = 0.0
! 
!   E_copy = E
! 
!   ! dimsV(1) = n
!   ! dimsV(2) = d
!   allocate(dR(nsize, 1))
! 
!   ! Perform QR decomposition on E
!   call householderQR(E, dR, dimsE)
! 
!   ! create Q and R explicitely (Make this a subroutine?)
!   do i = 1,msize
!     ! Apply Q onto the columns of the Identity matrix, using the orthonormal vectors, u,
!     ! from the Householder reflector, H = I-uu^T (which are stored in the lower part of E)
!     call householderQy(E, Id(:,i:i), dimsE)
!     Q(:,i:i) = Id(:,i:i)
!     if (i <= nsize) then
!       R(:, i) = E(1:i,i) ! upper triangular part of E stores R (excluding the diagonal part)
!       R(i,i) = dR(i,1) ! diagonal part of R
!     end if
!   enddo
! 
!   ! Compute
!   call printMat2(matmul(transpose(Q),Q))
!   call printMat2(R)
!   
!   call printMat2(E)
!   call printMat2(dR)
! 
