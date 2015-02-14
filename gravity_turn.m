

function dZ = gravity_turn(~,Z)
    
    global CRAFT PLANET ATMOSPHERE TARGET
        T  = CRAFT(1);
        II = CRAFT(2);
        IF = CRAFT(3);
        G  = PLANET(1);
        R  = PLANET(2);
        RS = PLANET(3);
        S  = PLANET(4);
        D  = ATMOSPHERE(1);
        H  = ATMOSPHERE(3);
        TI = TARGET(1);
        TF = TARGET(2);
        TS = TARGET(3);
        AF = TARGET(4);

    x = Z(1);
    y = Z(2);
    vx = Z(3);
    vy = Z(4);
    m = Z(5);
    
    p = [x,y];
    v = [vx,vy];
    vr = v-RS;
    d = norm(p);
    h = d-R;
    
    ap = exp(-h/H);
    ang = (90-((h-TI)/(TF-TI))^TS)*(90-AF)-8100+atan2d(y,x);
%    ang = atan2d(y,x); 

    grav = -S/d^3*p;
    drag = -D*ap*norm(vr)*vr;
    thrust = T/m*[cosd(ang), sind(ang)];

    a = grav+drag+thrust;
    dm = T/(((IF-II)*ap-IF)*G);

    ax = a(1);
    ay = a(2);
    
    dZ = [vx; vy; ax; ay; dm];

end