function h=draw_parallelepiped(H,l,gr_props)
%DRAW_PARALLELEPIPED Draw a parallelepiped
%
% h=draw_parallelepiped(H,l)
% h=draw_parallelepiped(H,l,gr_props)
%
% draw a parallelepiped of dimensions l, at the position and orientation
% given by the homeneous transform H. More precisely, the coordinates of the
% parallelepiped center are grouped in H(1:3,4), while the orientation of
% the parallelepiped axes is given by the rotation matrix H(1:3,1:3). 
%
% if l is scalar, draw a cube, if length(l)==3, draw a parallelepiped with
% a length l(1) along H(1:3,1), l(2) along H(1:3,2) and l(3) along H(1:3,3)
%
% If provided, the graphic properties specified in the gr_props cell are
% applied.
%
% The graphic handle h is returned

if nargin<3
    gr_props={};
end

vertices_matrix= 0.5 * diag(l) * [ 1  1  1
    1  1 -1
    1 -1  1
    1 -1 -1
    -1  1  1
    -1  1 -1
    -1 -1  1
    -1 -1 -1]';

vertices_matrix = H(1:3,1:3)*vertices_matrix +  H(1:3,4)*ones(1,8);


faces_matrix = [ 4 3 1 2
    1 2 6 5
    6 5 7 8
    7 8 4 3
    4 2 6 8
    3 1 5 7];

h=patch('Vertices',vertices_matrix','Faces',faces_matrix,'FaceColor','flat',...
    'FaceVertexCData',hsv(6),gr_props{:});
