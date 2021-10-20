function getEEpCallback(hObject, eventdata)
    
    % Get the new value for q
    EEpGoalNew = eval(get(hObject, 'String'));
        
    if(~isempty(EEpGoalNew))
        if(isnumeric(EEpGoalNew))
            if(size(EEpGoalNew,1) == 3)
                assignin('base','EEpGoal',EEpGoalNew);
            end
        end
    end
end