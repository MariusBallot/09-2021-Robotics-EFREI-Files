function getQCallback(hObject, eventdata)
    
    % Get the new value for q
    qGoalNew = eval(get(hObject, 'String'));
        
    if(~isempty(qGoalNew))
        if(isnumeric(qGoalNew))
            if(size(qGoalNew,1) == 6)
                assignin('base','qGoal',qGoalNew);
            end
        end
    end
end