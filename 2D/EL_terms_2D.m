function [ ELx, ELy ] = EL_terms(matrix, K11, K22, K33, deltax, deltay)

%         if nargin < 6
%             deltax = 1;
%             deltay = 1;
%             deltaz = 1;
%         else if nargin < 4
%             K11 = 1;
%             K22 = 1;
%             K33 = 1;
%         end


Nx = matrix(:,:,1);
Ny = matrix(:,:,2);

[dNxdx, dNxdy] = gradient(Nx, deltax, deltay);
[d2Nxdxdx, d2Nxdxdy] = gradient(dNxdx,deltax,deltay);
[~, d2Nxdydy] = gradient(dNxdy,deltax,deltay);

[dNydx, dNydy] = gradient(Ny, deltax, deltay);
[d2Nydxdx, d2Nydxdy] = gradient(dNydx,deltax,deltay);
[~, d2Nydydy] = gradient(dNydy,deltax,deltay);


%{ 
Oseen-Frank calculation:
ELx = ((-1).*d2Nxdxdx+(-1).*d2Nydxdy).*K11+K33.*((-1).*d2Nxdydy+ ...
  d2Nydxdy+(-1).*dNxdy.^2.*Nx+dNydx.^2.*Nx+(-2).*dNxdy.*dNydy.*Ny+ ...
  2.*dNydx.*dNydy.*Ny);

ELy = ((-1).*d2Nxdxdy+(-1).*d2Nydydy).*K11+K33.*(d2Nxdxdy+2.*dNxdx.*( ...
  dNxdy+(-1).*dNydx).*Nx+(-1).*d2Nydxdx.*Nx.^2+dNxdy.^2.*Ny+(-1).* ...
  dNydx.^2.*Ny+(-1).*d2Nydxdx.*Ny.^2);
%}

% Q-tensor calculation:
ELx = (-1).*K33.*((-1).*dNydx.^2.*Nx.^3+2.*d2Nxdxdx.*Nx.^4+dNydx.* ...
  dNydy.*Nx.^2.*Ny+4.*d2Nxdxdy.*Nx.^3.*Ny+d2Nydxdx.*Nx.^3.*Ny+2.* ...
  dNxdy.^2.*Nx.*Ny.^2+(-2).*dNydx.^2.*Nx.*Ny.^2+2.*dNydy.^2.*Nx.* ...
  Ny.^2+d2Nxdxdx.*Nx.^2.*Ny.^2+2.*d2Nxdydy.*Nx.^2.*Ny.^2+2.* ...
  d2Nydxdy.*Nx.^2.*Ny.^2+(-2).*dNydx.*dNydy.*Ny.^3+2.*d2Nxdxdy.*Nx.* ...
  Ny.^3+d2Nydydy.*Nx.*Ny.^3+d2Nxdydy.*Ny.^4+dNxdx.^2.*Nx.*(4.*Nx.^2+ ...
  Ny.^2)+dNxdx.*(2.*dNydy.*Nx.^3+6.*dNxdy.*Nx.^2.*Ny+2.*dNydx.* ...
  Nx.^2.*Ny+3.*dNydy.*Nx.*Ny.^2+dNxdy.*Ny.^3)+dNxdy.*(4.*dNydy.*Ny.* ...
  (Nx.^2+Ny.^2)+dNydx.*(2.*Nx.^3+3.*Nx.*Ny.^2)))+K11.*((-4).* ...
  d2Nxdxdx.*Nx.^2+(-2).*d2Nydxdy.*Nx.^2+(-1).*dNydx.^2.*Nx.^3+2.* ...
  d2Nxdxdx.*Nx.^4+(-2).*dNydx.*dNydy.*Ny+(-4).*d2Nxdxdy.*Nx.*Ny+(-1) ...
  .*d2Nydxdx.*Nx.*Ny+(-1).*d2Nydydy.*Nx.*Ny+dNydx.*dNydy.*Nx.^2.*Ny+ ...
  4.*d2Nxdxdy.*Nx.^3.*Ny+d2Nydxdx.*Nx.^3.*Ny+(-1).*d2Nxdxdx.*Ny.^2+( ...
  -1).*d2Nxdydy.*Ny.^2+(-2).*d2Nydxdy.*Ny.^2+2.*dNxdy.^2.*Nx.*Ny.^2+ ...
  (-2).*dNydx.^2.*Nx.*Ny.^2+2.*dNydy.^2.*Nx.*Ny.^2+d2Nxdxdx.*Nx.^2.* ...
  Ny.^2+2.*d2Nxdydy.*Nx.^2.*Ny.^2+2.*d2Nydxdy.*Nx.^2.*Ny.^2+(-2).* ...
  dNydx.*dNydy.*Ny.^3+2.*d2Nxdxdy.*Nx.*Ny.^3+d2Nydydy.*Nx.*Ny.^3+ ...
  d2Nxdydy.*Ny.^4+dNxdx.^2.*Nx.*((-4)+4.*Nx.^2+Ny.^2)+dNxdy.*(2.* ...
  dNydy.*Ny.*((-1)+2.*Nx.^2+2.*Ny.^2)+dNydx.*Nx.*((-2)+2.*Nx.^2+3.* ...
  Ny.^2))+dNxdx.*(dNydy.*Nx.*((-2)+2.*Nx.^2+3.*Ny.^2)+Ny.*(2.* ...
  dNydx.*((-1)+Nx.^2)+dNxdy.*((-2)+6.*Nx.^2+Ny.^2))));

 ELy = (-1).*K33.*(d2Nydxdx.*Nx.^4+2.*dNxdx.^2.*Nx.^2.*Ny+(-2).* ...
  dNxdy.^2.*Nx.^2.*Ny+2.*dNydx.^2.*Nx.^2.*Ny+dNydy.^2.*Nx.^2.*Ny+ ...
  d2Nxdxdx.*Nx.^3.*Ny+2.*d2Nydxdy.*Nx.^3.*Ny+2.*dNxdy.*dNydy.*Nx.* ...
  Ny.^2+2.*d2Nxdxdy.*Nx.^2.*Ny.^2+2.*d2Nydxdx.*Nx.^2.*Ny.^2+ ...
  d2Nydydy.*Nx.^2.*Ny.^2+(-1).*dNxdy.^2.*Ny.^3+4.*dNydy.^2.*Ny.^3+ ...
  d2Nxdydy.*Nx.*Ny.^3+4.*d2Nydxdy.*Nx.*Ny.^3+2.*d2Nydydy.*Ny.^4+ ...
  dNydx.*(dNydy.*Nx.^3+3.*dNxdy.*Nx.^2.*Ny+6.*dNydy.*Nx.*Ny.^2+2.* ...
  dNxdy.*Ny.^3)+dNxdx.*((-2).*dNxdy.*Nx.^3+4.*dNydx.*Nx.^3+3.* ...
  dNydy.*Nx.^2.*Ny+dNxdy.*Nx.*Ny.^2+4.*dNydx.*Nx.*Ny.^2+2.*dNydy.* ...
  Ny.^3))+K11.*((-2).*dNydx.*dNydy.*Nx+(-2).*d2Nxdxdy.*Nx.^2+(-1).* ...
  d2Nydxdx.*Nx.^2+(-1).*d2Nydydy.*Nx.^2+dNydx.*dNydy.*Nx.^3+ ...
  d2Nydxdx.*Nx.^4+(-4).*dNydy.^2.*Ny+(-1).*d2Nxdxdx.*Nx.*Ny+(-1).* ...
  d2Nxdydy.*Nx.*Ny+(-4).*d2Nydxdy.*Nx.*Ny+2.*dNxdx.^2.*Nx.^2.*Ny+2.* ...
  dNydx.^2.*Nx.^2.*Ny+dNydy.^2.*Nx.^2.*Ny+d2Nxdxdx.*Nx.^3.*Ny+2.* ...
  d2Nydxdy.*Nx.^3.*Ny+(-2).*d2Nxdxdy.*Ny.^2+(-4).*d2Nydydy.*Ny.^2+ ...
  6.*dNydx.*dNydy.*Nx.*Ny.^2+2.*d2Nxdxdy.*Nx.^2.*Ny.^2+2.*d2Nydxdx.* ...
  Nx.^2.*Ny.^2+d2Nydydy.*Nx.^2.*Ny.^2+4.*dNydy.^2.*Ny.^3+d2Nxdydy.* ...
  Nx.*Ny.^3+4.*d2Nydxdy.*Nx.*Ny.^3+2.*d2Nydydy.*Ny.^4+(-1).* ...
  dNxdy.^2.*Ny.*(2.*Nx.^2+Ny.^2)+dNxdy.*(2.*dNydy.*Nx.*((-1)+Ny.^2)+ ...
  dNydx.*Ny.*((-2)+3.*Nx.^2+2.*Ny.^2))+dNxdx.*(dNxdy.*Nx.*((-2)+(-2) ...
  .*Nx.^2+Ny.^2)+2.*dNydx.*Nx.*((-1)+2.*Nx.^2+2.*Ny.^2)+dNydy.*Ny.*( ...
  (-2)+3.*Nx.^2+2.*Ny.^2)));

return
end



