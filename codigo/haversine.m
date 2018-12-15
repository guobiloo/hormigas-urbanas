function d = haversine(lat1,lon1,lat2,lon2)
    R = 6371; %Radio de la tierra
    la1=deg2rad(lat1);
    la2=deg2rad(lat2);
	d_la = deg2rad(lat2)-deg2rad(lat1); %Delta de latitud
    d_lo = deg2rad(lon2)-deg2rad(lon1); %Delta de longitud
    d = (sin(d_la/2))^2 + (cos(la1) * cos(la2) * (sin(d_lo/2))^2);
    d = 2*atan2(sqrt(d),sqrt(1-d));
    d = R * d;
end