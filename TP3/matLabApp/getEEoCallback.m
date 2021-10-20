function getEEoCallback(hObject, eventdata)
    
    % Get the new value for orientation
    EEoGoalNew = eval(get(hObject, 'String'));

    if(~isempty(EEoGoalNew))
        if(isnumeric(EEoGoalNew))
            if(size(EEoGoalNew,1) == 3 && size(EEoGoalNew,2) == 3)

                % Check that the matrix entered is orthogonal
                if(rank(EEoGoalNew) == 3)
                    diff = abs(inv(EEoGoalNew)-EEoGoalNew');
                    if(max(max(diff)) < 0.0001)
                        assignin('base','EEoGoal',EEoGoalNew);
                    end
                end
                
            end
        end
    end
                
end