function RunStop_Callback(hObject, eventdata,running)
% Callback for the Run and Stop buttons. The simulation is run from within
% this script if the run button is pressed and stopped if the stop button is 
% pressed. This file also contains the functions that support the event
% listener, which takes data from simulink while the model is running and
% ports it to the GUI plot in real-time. Imported variables hObject and
% eventdata are standard for callback function syntax and are unused.
%
% Author: Emma France
% Last Update: 6/30/16

global SimLength ModelName currentCall sampleRate ph

    if running
        %% Run simulation
        % Sets up the simulink model so that real-time data can be sent to Matlab
        % during the simulation. 
        if exist('ph','var')
            delete(ph) % Ensures plotter window is clear of old data
        end
        ph = line([0],[0]); %generic handle for graph
        currentCall=0; %Initialization, will count # of calls to listener callback
        sampleRate=250; %# of listenser callbacks between each plot point

        % Opens the Simulink model
        open_system(ModelName);

        % Simulink may optimise your model by integrating all your blocks. To
        % prevent this, you need to disable the Block Reduction in the Optimisation
        % settings.
        set_param(ModelName,'BlockReduction','off');

        % When the model starts, call the localAddEventListener function
        set_param(ModelName,'StartFcn','localAddEventListener');
        set_param(ModelName,'StopFcn','OutputCalculations,Graphs');

        % Start the model, run for input time SimLength
        set_param(ModelName, 'StopTime', num2str(SimLength));
        set_param(ModelName, 'SimulationCommand', 'start');

    else
        set_param(ModelName, 'SimulationCommand', 'stop');
    end

%% Listener functions

% When simulation starts, Simulink will call this function in order to
% register the event listener to the block 'Divide' (in which heart rate
% data is coverted to BPM). The function localEventListener will execute 
% everytime after the block 'Divide' has returned its output.
function eventhandle = localAddEventListener
eventhandle = add_exec_event_listener('CV_Sys_Model_with_Exercise_4_4_16/Cardiac Pacemaker/Divide', ...
                                        'PostOutputs', @localEventListener);
 
% The function to be called when event is registered.
function localEventListener(block, eventdata)
global ph currentCall sampleRate

    % Updates how many times the listener has been called
    currentCall=currentCall+1;
    % Save time. If get data and plot every call program is very slow.
    if rem(currentCall,sampleRate)==0   %If this is the (sample rate)th call
        % Gets the time and output value
        simTime = block.CurrentTime;
        simData = block.OutputPort(1).Data;

        % Gets handles to the point coordinates
        xData = get(ph,'XData');
        yData = get(ph,'YData');

        xData = [xData simTime];
        yData = [yData simData];

        % Update point coordinates

        set(ph,...
            'XData',xData,...
            'YData',yData);

        % The axes limits need to change as you scroll
            drawnow;
    end
