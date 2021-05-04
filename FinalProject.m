function [] = FinalProject()

    %setting global variable to gui
    global gui;

    %creates figure with an empty plot and where the following uicontrol
    %elements will go as well
    gui.fig = figure('numbertitle', 'off', 'name', 'Final Project');
    hold on;
    plot(0,0);
    set(gca,'Position', [.30 .16 .60 .65]);

    %Initial message box that pops up instructing how to enter data
    %properly
    msgbox('You may enter the X and Y values with spaces or commas inbetween each value, with or without brackets. Or you may enter a vector ex: 0:10, with or without brackets as well. Enter X and Y Limits with a space or comma between minimum and maximum values. ','modal');

    %uicontrols that provide a place for the user to type in a title,
    %x-values, y-values, x-limits, y-limits, x-axis title, and y-axis title 
    gui.plotTitle = uicontrol('style','text','units','normalized','position',[.60 .90 .10 .05],'string','Plot Title:','horizontalalignment','right');
    gui.editPlotTitle = uicontrol('style','edit','units','normalized','position',[.70 .90 .18 .05]);
    gui.Title = uicontrol('style','text','units','normalized','position',[.30 .81 .60 .05],'string','','horizontalalignment','center');

    gui.xTitle = uicontrol('style', 'text', 'units', 'normalized', 'position', [0 .95 .10 .05], 'string','X-Values:','horizontalalignment','right');
    gui.editX = uicontrol('style', 'edit', 'units','normalized','position', [.10 .95 .18 .05]);
    gui.yTitle = uicontrol('style', 'text', 'units', 'normalized', 'position', [.30 .95 .10 .05], 'string', 'Y-Values:', 'horizontalalignment','right');
    gui.editY = uicontrol('style', 'edit', 'units','normalized','position', [.40 .95 .18 .05]);

    gui.xLimTitle = uicontrol('style', 'text', 'units', 'normalized', 'position', [.60 .95 .067 .05], 'string','X-Limit:','horizontalalignment','right');
    gui.editxLim = uicontrol('style', 'edit', 'units','normalized','position', [.667 .95 .09 .05]);
    gui.yLimTitle = uicontrol('style', 'text', 'units', 'normalized', 'position', [.757 .95 .067 .05], 'string','Y-Limit:','horizontalalignment','right');
    gui.edityLim = uicontrol('style', 'edit', 'units','normalized','position', [.824 .95 .09 .05]);

    gui.xAxisTitle = uicontrol('style', 'text', 'units', 'normalized', 'position', [0 .90 .10 .05], 'string','X-Axis Title:','horizontalalignment','right');
    gui.editxAxis = uicontrol('style', 'edit', 'units','normalized','position', [.10 .90 .18 .05]);
    gui.xAxis = uicontrol('style','text','units','normalized','position',[.30 .07 .60 .05],'string','','horizontalalignment','center');

    gui.yAxisTitle = uicontrol('style', 'text', 'units', 'normalized', 'position', [.30 .90 .10 .05], 'string','Y-Axis Title:','horizontalalignment','right');
    gui.edityAxis = uicontrol('style', 'edit', 'units','normalized', 'position', [.40 .90 .18 .05]);
    gui.yAxis = uicontrol('style','text','units','normalized','position',[.08 .485 .18 .05],'string','','horizontalalignment','right');

    %button group allows for the 3 options of line styles to be displayed
    gui.buttonGroup = uibuttongroup('unit', 'normalized', 'position', [0, .4 .15 .25]);
    gui.r1 = uicontrol(gui.buttonGroup, 'style', 'radiobutton', 'units', 'normalized', 'position', [.1 .8 1 .2],'string','bo');
    gui.r2 = uicontrol(gui.buttonGroup, 'style', 'radiobutton', 'units', 'normalized', 'position', [.1 .5 1 .2],'string','r--');
    gui.r3 = uicontrol(gui.buttonGroup, 'style', 'radiobutton', 'units', 'normalized', 'position', [.1 .2 1 .2],'string','g-');

    %when pressed, all data entered will be plotted, the function
    %plotPoints is called
    gui.plotButton = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position', [.50 .015 .18 .05], 'string', 'Plot', 'callback', {@plotPoints});
    %when pressed, all data is cleared and a cleared plot is shown
    gui.plotButton = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position', [.32 .015 .18 .05], 'string', 'Reset', 'callback', {@reset, 0, 0});
end

function [] = plotPoints(~,~)

    global gui;

    %sets the title, x-axis title, and y-axis title to the string entered
    %by the user previously
    gui.Title.String = gui.editPlotTitle.String;
    gui.xAxis.String = gui.editxAxis.String;
    gui.yAxis.String = gui.edityAxis.String;

    %converts the x and y value strings previously entered to arrays
    %assigned to the variables x and y
    x = str2num(gui.editX.String);
    y = str2num(gui.editY.String);

    %convertys the x and y limit strings previously entered into numbers 
    xlimits = str2num(gui.editxLim.String);
    ylimits = str2num(gui.edityLim.String);

        %finding the first and last element of the x and y arrays in case
        %no limits are entered
        firstX = x(1);
        lengthX = numel(x);
        lastX = x(lengthX);
    
        firstY = y(1);
        lengthY = numel(y);
        lastY = y(lengthY);
    
        %finding the length of the x and y limit arrays 
        lengthXLimit = numel(xlimits);
        lengthYLimit = numel(ylimits);
    
    %following if statements are used if bad data is given
    
    if lengthX == 1 || lengthY == 1 %if only one number is entered for either x or y
        msgbox('Please enter more than one X or Y value.', 'Plotting Error','error','modal');

        elseif lengthXLimit == 1 || lengthYLimit == 1 %if the lenghts of either of the limits are just one number and not a range
            msgbox('Please enter a range for the X and Y limits.', 'Plotting Error', 'error', 'modal');

            elseif lengthX ~= lengthY %if the x and y values are not the same length
                msgbox('X and Y Values are not the same length! Please enter x and y values of the same length.', 'Plotting Error','error','modal');
    end
        
    %if no limits are given, a new limit is formed from the first and last
    %number in the array
        if isempty(xlimits)
            xlimits = [firstX lastX];
        end
            if isempty(ylimits)
                ylimits = [firstY lastY];
            end
    
    %takes the selected button from the button group and assigns the string
    %to the type of line style
    type = gui.buttonGroup.SelectedObject.String;
  
    %plots the x values, y values, line type, x limit, and y limit
    plot(x,y,type)
    xlim(xlimits);
    ylim(ylimits);
    set(gca,'Position', [.30 .16 .60 .65]);

end

%reset function resets all uicontrols and the plot
function [] = reset(~,~, x, y)

    global gui

    hold off;
        plot(x,y);
        set(gca,'Position', [.30 .16 .60 .65]);
    
        gui.editX.String = '';
        gui.editY.String = '';
        
        gui.editxLim.String = '';
        gui.edityLim.String = '';

        gui.Title.String = '';
        gui.editPlotTitle.String = '';
        
        gui.xAxis.String = '';
        gui.editxAxis.String = '';
        gui.yAxis.String = '';
        gui.edityAxis.String = '';

end





