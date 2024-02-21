module grid_data
  implicit none
  real, allocatable, dimension(:), save :: gr_xCoord
  real, save :: gr_xbeg,gr_xend,gr_dx,gr_epsiln,gr_omega1,gr_omega2,gr_K
  integer, save :: gr_i0,gr_ibeg,gr_iend,gr_imax,gr_ngc,gr_nx,gr_radius

  real, allocatable, dimension(:,:) :: gr_U ! conservative vars
  real, allocatable, dimension(:,:) :: gr_V ! primitive vars
  real, allocatable, dimension(:,:) :: gr_W ! characteristic vars

  real, allocatable, dimension(:,:) :: gr_vL   ! left Riemann states
  real, allocatable, dimension(:,:) :: gr_vR   ! right Riemann states
  real, allocatable, dimension(:,:) :: gr_flux ! fluxes

  real, allocatable, dimension(:,:)   :: gr_eigval ! eigenvalues
  real, allocatable, dimension(:,:,:) :: gr_reigvc ! right eigenvectors
  real, allocatable, dimension(:,:,:) :: gr_leigvc ! left  eigenvectors

  !GP vars
  real, allocatable, dimension(:  ) :: gr_GPv, gr_GPv2
  real, allocatable, dimension(:,:) :: gr_GPZ, gr_GPZ2

end module grid_data
