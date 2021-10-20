function GoCallback(hObject, eventdata)

qGoalLoc = evalin('base','qGoal');
qLoc = evalin('base','q');
dhLoc = evalin('base','dh');
hLoc = evalin('base','h');
h_qLoc = evalin('base','h_q');
h_TLoc = evalin('base','h_T');

deltaQ = mod(qGoalLoc,2*pi) - qLoc;

% shortest way to the desired configuration
for(j=1:size(qLoc,1))
    if(abs(deltaQ(j)) > pi)
        deltaQ(j) = deltaQ(j) - 2*sign(deltaQ(j))*pi;
    end
end

lim = ceil(max(abs(deltaQ))*100);

for(i=1:1:lim)
    for(j=1:size(qLoc,1))
        qLoc(j) = qLoc(j) + deltaQ(j)/lim;
    end
    MvtRobot(dhLoc,hLoc,qLoc);
    
    % Update the display of the current config and current EE pose
    TLoc = modele_geom(dhLoc,qLoc);    
    updateVal(qLoc,h_qLoc,TLoc,h_TLoc);
    
    pause(0.002);
end

assignin('base','q',qLoc);

end
