function Y = bsp07b(X,flag,Parmeter)
% Nonlinear Poisson equation
% - Delta(u0 + w) - f(mu0 + mu,u0 + w) = 0; UU'*w = 0;
% in unit square with u(0,:) = u(1,:) = 0 on boundary
% flag = 1: Funktion f(mu,xi,eta,x) = mu*(x + SIGN*c(xi,eta)*x^3)
% flag = 2: Gradient_x of f
% flag = 3: Right side for continuation
% flag = 4: Matrix B for bifurcation equation
% -------------------------------------------
% Gradient of f: R_n -> R_m is (m,n)-matrix
% A is discretization of negative Laplacian
% by finite differences
% --Parameters ---------------------------------
MU = Parmeter(1); NU = Parmeter(2); SIGN = Parmeter(3);
n  = Parmeter(4);
% ----------------------------------
global A
% -- funktion c(xi,eta) -----------
FALL = 1; % Set FALL correctly also in bsp07c.m !!!
switch FALL
case 1
   TT = linspace(0,pi,n+4); XA = 3*sin(TT);
   XA = XA(2:n+3);
   TT = linspace(0,pi,n+2); XB = 3*sin(TT);
   XB = XB(2:n+1);
   C = XA.'*XB; C = C(:);
case 2
   XA = ones(1,n);
   M = floor(n/4); XA(1:M) = 0;
   M = ceil(3*n/4); XA(M:n) = 0;
   C = XA.'*ones(1,n+2); C = C(:);
end
switch flag
case 1,  Y = A*X - (MU*X + SIGN*C.*X.*X.*X);
case 2
   D = MU + SIGN*3*C.*X.*X;
   Y  = A - diag(D); Y = sparse(Y);
case 3, Y =  SIGN*C.*X.*X.*X; 
case 4, Y = eye((n+2)*n);
end
