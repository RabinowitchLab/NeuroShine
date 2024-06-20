% analyze fluoresence intensity of a cell body within a region of interest

% ParamAnalysisItemsStr = '{''FluoDifference'', ''FluoMain'', ''FluoBackground'', ''Area''}';
% ParamDisplayItemsStr = '{''dT''}';
Components(1).Name = 'PlotDropDown';
Components(1).Properties = {'Visible', 'Items', 'Value'};
PlotItemsStr = '{''FluoDifference'', ''FluoMain'', ''FluoBackground'', ''Area''}';
Components(1).Values = {'1', PlotItemsStr,'''FluoDifference'''};
% Components(2).Name = 'OutputButton1';
% Components(2).Properties = {'Visible','Text'};
% Components(2).Values = {'1','''Overlay'''};
% Components(3).Name = 'ParamAnalysisDropDown';
% Components(3).Properties = {'Items', 'Value'};
% Components(3).Values = {ParamAnalysisItemsStr, '''PlateDiam'''};
% Components(4).Name = 'ParamDisplayDropDown';
% Components(4).Properties = {'Items', 'Value'};
% Components(4).Values = {ParamDisplayItemsStr, '''dT'''};
% Components(5).Name = 'CalculateButton1';
% Components(5).Properties = {'Visible','Text'};
% Components(5).Values = {'1','''mm/pix'''};

RGapp = RecordGUI('TREX', Components);

% RGapp.Specs.Name = 'TREX';
RGapp.Specs.Records.FileType = 'jpg';
% RGapp.Specs.Records.FileType = 'czi';
RGapp.Specs.Records.uiget = 'file'; % get directory ('dir') or particular file ('file')
RGapp.Specs.Functions.RecordLoad = @NS_RecordLoad;
RGapp.Specs.Functions.RecordDisplay = @NS_RecordDisplay;
RGapp.Specs.Functions.RecordAnalyze = @NS_RecordAnalyze;
RGapp.Specs.Functions.RecordPlot = @NS_RecordPlot;
RGapp.Specs.Functions.ExportData = @NS_ExportData;
% RGapp.Specs.Functions.OutputButton1 = @TR_OverlayDisplay;
% RGapp.Specs.Functions.CalculateButton1 = @TR_PlateDiameter;

RGapp.Specs.Analysis.Parameters = [];
RGapp.Specs.Display.Parameters = [];
% RGapp.Specs.Display.Parameters.dT = 1; % default time in sec between displayed path points
% RGapp.Specs.Display.Parameters.Ttotal = 300; % default recording duration in sec
% RGapp.Specs.Analysis.Parameters.PlateDiam = 550; % default plate diameter (mm)
% RGapp.Specs.Analysis.Parameters.mm_pix = 1; % default mm per pixel
% RGapp.Specs.Analysis.Parameters.FPS = 1; % default frames per second
% RGapp.Specs.Analysis.Parameters.Window = 0; % smoothing (moving average) in sec (0 = no smoothing)
