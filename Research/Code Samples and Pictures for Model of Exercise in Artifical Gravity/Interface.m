%% Interface.m
% Run this script to bring up the main Graphical User Interface to control
% the simulation of the cardiac system during exercise in artificial
% gravity.
% Author: Emma France
% Latest version: 6/30/16
% See Readme for general comments and instructions. 


%% Initialization
% Imports script containing definitions for all variable values for MIT1G condition
DefaultParams

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               GUI INITIALIZATION                                           %   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create figure
f = figure('Visible','off','Position',[360,500,1000,800]);
% Assign the a name to appear in the window title.
f.Name = 'The Cardiovascular System in Artifical Gravity'; 
% Move the window to the center of the screen.
movegui(f,'center') 

%% Real-time Plotter 
% Create the real time plotter segment

subplot('Position',[.35 .05 .6 .55])
xlim([0 SimLength]);
ylim([0 200]);
xlabel('Time (seconds)','FontSize',14,'FontName','Times')
ylabel('Heart Rate (BPM)','FontSize',14,'FontName','Times')

%% Dropdown to select exercise variables
% Can be user-input or can set to default for MIT centrifuge

% Label
panel1 = uipanel(f,'Title','Exercise Variable Settings','FontSize',12,...
              'Units','pixels','Position',[225 500 600 290]);
% Dropdown box
ExerciseSelect = uicontrol('Style','popupmenu',...
           'String',{'MIT 1G (Default)','User Input'},...
           'Position',[250,720,150,50],'Callback',@dropdown_Callback);

%% Non-exercise variables, user entry
% Initialized to default values

% Creates outline around section 
panel2 = uipanel(f,'Title','Simulation variables','FontSize',12,...
              'Units','pixels','Position',[25 450 175 340]);

% Label followed by its entry box(es)
htext2  = uicontrol('Style','text','String','Total Blood Volume (mL)',...
           'Position',[50,725,130,42]);
TotalBloodVol = uicontrol('Style','edit',...
            'Position',[50,725,130,30],'String','5150','Callback',{@UserEntry_Callback,'TotalBloodVol'});
%
htext3  = uicontrol('Style','text','String','Simulation Length (s)',...
           'Position',[50,675,130,42]);
Simulation_Length = uicontrol('Style','edit',...
            'Position',[50,675,130,30],'String','1420','Callback',{@UserEntry_Callback,'Simulation_Length'});
%
htext7  = uicontrol('Style','text','String','Total Spin Time (s)',...
           'Position',[50,625,130,42]);
Total_Spin_Time = uicontrol('Style','edit',...
            'Position',[50,625,130,30],'String','1200','Callback',{@UserEntry_Callback,'TotalSpinTime'});
%        
htext4  = uicontrol('Style','text','String','Equilibration Time (s)',...
           'Position',[50,575,130,42]);
T_eq = uicontrol('Style','edit',...
            'Position',[50,575,130,30],'String','180','Callback',{@UserEntry_Callback,'T_eq'});
%            
htext5  = uicontrol('Style','text','String','Spin up, down time (s)',...
           'Position',[50,525,130,42]);
tspinup = uicontrol('Style','edit',...
            'Position',[50,525,60,30],'String','100','Callback',{@UserEntry_Callback,'tspinup'});
tspindown = uicontrol('Style','edit',...
            'Position',[120,525,60,30],'String','60','Callback',{@UserEntry_Callback,'tspindown'});
        
%        
htext6  = uicontrol('Style','text','String','Arterial Baroreflex Gain',...
           'Position',[50,475,130,42]);
ABR_Gain = uicontrol('Style','edit',...
            'Position',[50,475,130,30],'String','9','Callback',{@UserEntry_Callback,'ABR_Gain'});

%% Check boxes for graph selection

% Creates outline around section
panel3 = uipanel(f,'Title','Graphs','FontSize',12,...
              'Units','pixels','Position',[25 50 280 375]);
% Creates labeled checkboxes       
Graph1 = uicontrol('Style','checkbox',...
            'Position',[50,375,250,30],'String','Total Peripheral Resistance','Callback',{@checkbox_Callback,'Graph1'});
Graph2 = uicontrol('Style','checkbox',...
            'Position',[50,350,250,30],'String','Heart Rate','Callback',{@checkbox_Callback,'Graph2'});
Graph3 = uicontrol('Style','checkbox',...
            'Position',[50,325,250,30],'String','Venous Zero-Pressure Filling Volume','Callback',{@checkbox_Callback,'Graph3'});
Graph4 = uicontrol('Style','checkbox',...
            'Position',[50,300,250,30],'String','Total Leg Volume','Callback',{@checkbox_Callback,'Graph4'});
Graph5 = uicontrol('Style','checkbox',...
            'Position',[50,275,250,30],'String','Total Abdominal Volume','Callback',{@checkbox_Callback,'Graph5'});
Graph6 = uicontrol('Style','checkbox',...
            'Position',[50,250,250,30],'String','Blood Pressure','Callback',{@checkbox_Callback,'Graph6'});
Graph7 = uicontrol('Style','checkbox',...
            'Position',[50,225,250,30],'String','Cardiac Output','Callback',{@checkbox_Callback,'Graph7'});
Graph8 = uicontrol('Style','checkbox',...
            'Position',[50,200,250,30],'String','Pulse Pressure','Callback',{@checkbox_Callback,'Graph8'});
Graph9 = uicontrol('Style','checkbox',...
            'Position',[50,175,250,30],'String','Stroke Volume','Callback',{@checkbox_Callback,'Graph9'});
Graph10 = uicontrol('Style','checkbox',...
            'Position',[50,150,250,30],'String','Angular Velocity','Callback',{@checkbox_Callback,'Graph10'});
Graph11 = uicontrol('Style','checkbox',...
            'Position',[50,125,250,30],'String','Arterial Pressure Set-Point','Callback',{@checkbox_Callback,'Graph11'});
Graph12 = uicontrol('Style','checkbox',...
            'Position',[50,100,250,30],'String','Leg External Pressure (Exercise Pressure)','Callback',{@checkbox_Callback,'Graph12'});
Graph13 = uicontrol('Style','checkbox',...
            'Position',[50,75,250,30],'String','Intra-Abdominal Pressure','Callback',{@checkbox_Callback,'Graph13'});
        
%% Run and stop buttons, pause/continue button
RUN = uicontrol('Style','pushbutton','FontSize',18,'Position',...
    [840,720,150,70],'String','Run','BackgroundColor',[0,.8,0],'Callback',{@RunStop_Callback,true}); 
STOP = uicontrol('Style','pushbutton','FontSize',18, 'Position',...
    [840,520,150,70],'String','Stop','BackgroundColor',[.8,0,0],'Callback',{@RunStop_Callback,false});        
PAUSE_CONTINUE = uicontrol('Style','pushbutton','FontSize',18,'Position',...
    [840,600,150,70],'String','Pause','BackgroundColor',[1,.2,.2],'Callback',{@Pause_Callback, false}); 


% Displays the newly built GUI
f.Visible = 'on';



