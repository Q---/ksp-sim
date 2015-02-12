   
function main

    clear all
    % Single-stage rocket parameters
        T = 50; % thrust
        II = 300; % isp initial
        IF = 390; % isp final
        MI = 2.8; % mass initial
        MF = 0.8; % mass final
    global CRAFT
    CRAFT = [T,II,IF,MI,MF];
    
    % Planetary constants
        G = 9.82;
        R = 6E5; % radius of kerbin
        RS = 174.53; % rotation speed
        S = 3.5316E12; % standard gravitational parameter
    global PLANET
    PLANET = [G,R,RS,S];
    
    % Atmospheric constants
        D = 9.784758844E-4; % drag constant
        AH = 69077.553; % atmospheric height
        H = 5E3; % scale height
    global ATMOSPHERE
    ATMOSPHERE = [D,AH,H];
    
    % Orbital ascent parameters
        TI = 15E3; % height of initial gravity turn
        TF = 45E3; % height of end gravity turn
        TS = .3; % turn shape
        AF = 0; % final angle
        OT = 75E3; % orbital height target
    global TARGET
    TARGET = [TI,TF,TS,AF,OT];
    
    vertical_ascent_options = odeset('Events',@vertical_ascent_events,...
                                     'NonNegative',5); % mass > 0
                                 
    vertical_ascent_init = [0, R, RS, 0, MI];

    [vertical_ascent_time,...
        vertical_ascent_states,...
        vertical_ascent_event_time,...
        vertical_ascent_event_state,...
        vertical_ascent_event_type] = ode45(@vertical_ascent, [1 1000],...
                                             vertical_ascent_init,...
                                             vertical_ascent_options);

    if (numel(vertical_ascent_event_type)~=0)
        switch vertical_ascent_event_type(1)
            case 1
                fprintf('Success, vertical ascent height reached\n');
            case 2
                fprintf('Out of fuel\n');
            case 3
                fprint('Surface collision\n');
        end
    else
        fprintf('Simulation timed out\n');
    end

    
end