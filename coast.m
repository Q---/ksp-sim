

function dZ = coast(~,Z)
    
    global PLANET ATMOSPHERE
        R  = PLANET(2);
        RS = PLANET(3);
        S  = PLANET(4);
        D  = ATMOSPHERE(1);
        H  = ATMOSPHERE(3);

    x = Z(1);
    y = Z(2);
    vx = Z(3);
    vy = Z(4);
    
    p = [x,y];
    v = [vx,vy];
    
    pang = 90-atan2d(y,x);
    vr = [vx-cosd(pang)*RS, vy-sind(pang)*RS];
    
    d = norm(p);
    h = d-R;
    
    ap = exp(-h/H);

    grav = -S/d^3*p;
    drag = -D*ap*norm(vr)*vr;

%    a = grav+drag;
    a = grav+drag;

    ax = a(1);
    ay = a(2);
    
    dZ = [vx; vy; ax; ay; 0];

end