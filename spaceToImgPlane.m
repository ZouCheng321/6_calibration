% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation, version 2.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software Foundation,
% Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                 %
%     Calculates the full projection              %
%       (incl distortion) of a 3D point           %
%         to the image plane                      %
%                                                 %
%   Created : 2005                                %
%    Author : Christopher Mei                     %
%                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Input :
%          X : 3D point
%          V : camera parameters
%              (xi,k1,k2,k3,k4,k5,
%               alpha,gamma1,gamma2,u0,v0)
%
% Output :
%      P : point in the image plane
%   dPdX : Jacobian with repect to the 3D point X
%
function [P,dPdX] = spaceToImgPlane(X, V)

if nargin==0
  disp('Launching test...');
  test;
  return
end

switch nargout
 case 0
 case 1
  P = transform(X, V);
 case 2
  [P,dPdX] = transformFull(X, V);
 otherwise
  disp('Too many output args.')
end

function test
error=1e-4;
disp(['Error : 1e' slog10(error)]);

%%% Values %%%
X=randn(3,1);
dX=randn(3,1)*error;

V=randn(11,1);


[P,dPdX] = spaceToImgPlane(X,V);

Pp = spaceToImgPlane(X+dX,V);

dP = dPdX*dX;

gainP = norm(Pp-P)/norm(Pp-P-dP);

disp(['Estimate gain in X : 1e' slog10(gainP)]);

function P=transform(X, V)

P = spaceToNPlane(X, V(1));
P = distortion(P, V(2:6));
P = NPlaneToImgPlane(P, V(7:11));

function [P,dPdX]=transformFull(X, V)
[P,dmudP] = spaceToNPlane(X, V(1));
[P,dDdV2,dmddmu] = distortion(P, V(2:6));
[P,dPdV3,dpdmd] = NPlaneToImgPlane(P, V(7:11));

dPdX = dpdmd*dmddmu*dmudP;

function s=slog10(val)
s = num2str(floor(log10(val)));
