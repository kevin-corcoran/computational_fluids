%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AM 260, UC Santa Cruz
% Written by Prof. Dongwook Lee
% A template code for solving the 1D linear scalar equation
% u_t + a u_x = 0 using the upwind method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [uNew] = upwind(u,um,c,dt,dx);
    uNew = u-c*dt/dx*(u-um);
end