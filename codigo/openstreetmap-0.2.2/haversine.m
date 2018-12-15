function d = haversine(lat1,lon1,lat2,lon2)
    R = 6371; %Radio de la tierra
    la1 = deg2rad(lat1);%Convertimos a radianes
	la2 = deg2rad(lat2);
	d_la = la2-la1; %Delta de latitud
    d_lo = deg2rad(lon2-lon1); %Delta de longitud
    a = sin(d_la/2)^2 + cos(la1) * cos(la2) * sin(d_lo/2)^2;
    c = 2 * atan2(sqrt(a),sqrt(1-a));
    d = R * c;
end