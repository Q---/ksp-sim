
% 1: turnInitial height reached
% 2: Out of fuel
% 3: Surface collision
% 4: Exit atmosphere
% 5: Dropped below turnFinal
% 6: Projected apoapsis reached (TODO)

function [value, isterminal, direction] = gravity_turn_events(~,Z)
    
    global CRAFT PLANET ATMOSPHERE TARGET
        MF = CRAFT(5);
        R  = PLANET(2);
        AH = ATMOSPHERE(2);
        TI = TARGET(1);
        TF = TARGET(2);
    
    h = hypot(Z(1),Z(2))-R;
    m = Z(5);
    
    value = [h-TF; m-MF; h; h-AH; h-TI];
    isterminal = [1; 1; 1; 1; 1];
    direction = [1; -1; -1; 1; -1];
    
end