%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AM 260, UC Santa Cruz
% Written by Prof. Dongwook Lee
% A template code for solving the 1D linear scalar equation
% u_t + a u_x = 0 using the upwind method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clf;
clear all;
disp('Solving a linear advection problem:');


% take user's input for grid resolution
N=input('How many grid cells? = ');

% domain x_beg
xa=0;

% domain x_end
xb=1;

% grid delta
dx = (xb-xa)/N;

% two guardcells on each side
ngc=2;

% initialize your grid
x(ngc+1:N+ngc)=linspace(xa+0.5*dx,xb-0.5*dx,N);
for i=1:ngc;
    x(i)       = x(ngc+1) - i*dx;
    x(i+N+ngc) = x(N+ngc) + i*dx;
end
    
%initialize to zero
u(1:N+2*ngc)=0.;
u_init = u;


% choose an initial profile
disp('Choose IC:');
disp('[1] Square or [2] sine wave');
ICtype = input('IC type= ');

% setup IC
if (ICtype == 1)
    %square wave
    for i=ngc+1:N+ngc;
        if abs(x(i)-0.5)<0.2;
            u(i) = 1;
        else
            u(i) = 0;
        end
    end
elseif (ICtype == 2)
    %sin wave
    u(ngc+1:N+ngc)=sin(2.*pi*x(ngc+1:N+ngc));
end


%periodic BC for both square and sine waves
u(1)=u(N+ngc-1);
u(2)=u(N+ngc);
u(N+ngc+1)=u(ngc+1);
u(N+ngc+2)=u(ngc+2);

% get ready
uNnew = u;
u_init = u;


% take user's input for the advection velocity
c   = input('advection velocity c = ');

% take user's input for CFL
cfl = input('CFL = ');


%compute dt based on the CFL number
dt=cfl*dx/abs(c);

% take user's input for a number of turns to simulate
Ncycle=input('How many cycles? = ');

% set your clock to zero
t=0;

% set tmax based on the number of turns
tmax=Ncycle*(xb-xa)/abs(c);

% plot the IC and wait
grid on;
plot(x(ngc+1:N+ngc),u(ngc+1:N+ngc),'r');
pause

while t<tmax;
    
    for i=ngc+1:N+ngc;

        uNew(i) = upwind(u(i),u(i-1),c,dt,dx);

    end
    
    % update the clock
    t=t+dt;

    % apply periodic BC
    uNew(1)=uNew(N+ngc-1);
    uNew(2)=uNew(N+ngc);
    uNew(N+ngc+1)=uNew(ngc+1);
    uNew(N+ngc+2)=uNew(ngc+2);
  
    % update the solution
    u=uNew;
    
    % plot
    grid on;
    plot(x(ngc+1:N+ngc),u(ngc+1:N+ngc),'ro-')
    
    % make a movie
    pause(0.1)
end

hold on
plot(x(ngc+1:N+ngc),u(ngc+1:N+ngc),'ro-')
plot(x(ngc+1:N+ngc),u_init(ngc+1:N+ngc),'b')



