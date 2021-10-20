function h = draw_cylinder (H,r,h,varargin)
%
% DRAW_CYLINDER Draw a cylinder (in the common meaning; use draw_revolution
% to draw a cylinder in the mathematical meaning).
%
% draw_cylinder (H,r,h)
% draw_cylinder (H,r,h,n_theta)
% draw_cylinder (H,r,h,n_theta,n_z)
%
% draw_cylinder (H,r,h,gr_props)
% draw_cylinder (H,r,h,n_theta,gr_props)
% draw_cylinder (H,r,h,n_theta,n_z,gr_props)
%
% Mandatory input:
% r  cylinder's radius
% h  cylinder's height
% H  cylinder's position (homogeneous transformation)
%
% Optional input:
% n_theta   number of points around the circumference
% n_z       number of points along the height
% gr_props  graphic properties to apply to the cylinder
%
% Default values:
% n_theta = 20, use more to produce a smoother circumference
% n_z = 2, use more to produce better ligthning
% gr_props = {}
%
% Output:
% The cylinder is eventually drawn as a surface element in the main frame
% (that is, its center of mass is at the center of the frame), and its
% handle is returned.

error( nargchk(3,6,nargin) );
if size(H,1) ~= 4 || size(H,1) ~= 4
  error('First argument must be an homogeneous transformation');
end

% Default values:

n_theta = 20;            % TODO : choisir n_z et n_theta en fct de h et r
n_z = 2;
gr_props = {};

% User-specified values:

switch nargin

  case 4

    if iscell(varargin{1})
      gr_props = varargin{1};
    else
      n_theta = varargin{1};
    end

  case 5

    n_theta = varargin{1};
    if iscell(varargin{2})
      gr_props = varargin{2};
    else
      n_z = varargin{2};
    end

  case 6

    n_theta  = varargin{1};
    n_z      = varargin{2};
    gr_props = varargin{3};

end

R = [0  r*ones(1,n_z)  0];
Z = [-h/2  -h/2:h/(n_z-1):h/2  h/2];
 
h = draw_revolution (H,R,Z,n_theta,gr_props);