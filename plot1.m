 x = result(:,1); y = result(:,2); z = result(:,3);
 zi = griddata(x,y,z,xi,yi);
 surf(xi,yi,zi);