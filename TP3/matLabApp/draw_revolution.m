function sh=draw_revolution(H,r,z,varargin)
%DRAW_REVOLUTION Draw a revolution surface
%
% draw_revolution(H,r,z);
% draw_revolution(H,r,z,n);
% draw_revolution(H,r,z,gr_props);
% draw_revolution(H,r,z,n,gr_props);
%
% draw a cylinder by rotating r(z) around the z-axis. Where r and z are 2 vector
% of the same size.
% The transformation H is then applied to the cylinder. The cylinder 
% is eventually drawn as a surface element and its handle is returned.
% Tip: use r=[0 3 2 0]' ans z=[0 0 1 1]' to draw a truncated cone.
%
% If provided, the graphic properties specified in the gr_props are
% applied.


error(nargchk(3,5,nargin));
gr_props={};
n=20; %todo : choisir n en fct du rayon

switch nargin
    case 4
        if iscell(varargin{1})
            gr_props=varargin{1};
        else
            n=varargin{1};
        end
    case 5
        n=varargin{1};
        gr_props=varargin{2};
end



r = r(:); % Make sure r is a vector.
z = z(:); 

m = length(r); 
if length(z) ~= m, error('size'); end
if m==1, r = [r;r]; z = [0;1]; m = 2; end


theta = (0:n)/n*2*pi;
sintheta = sin(theta); 
sintheta(n+1) = 0;

X = r * cos(theta);
Y = r * sintheta;
Z = z * ones(1,n+1);

XYZ =H * [reshape(X,1,[]);
          reshape(Y,1,[]);
          reshape(Z,1,[]);
          ones(1,m*(n+1))];

X = reshape(XYZ(1,:),m,n+1);
Y = reshape(XYZ(2,:),m,n+1);
Z = reshape(XYZ(3,:),m,n+1);
   
sh = surface(X,Y,Z,gr_props{:});

end
