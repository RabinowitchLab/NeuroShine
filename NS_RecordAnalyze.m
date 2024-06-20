function Score = NS_RecordAnalyze(app, displayH)

% imbinarize gives a good readout of a single object (gut) in a good image
% use this instead of the inaccurate method in FROI0

Group = app.Experiment.Groups(app.IDs.Group).Group;
Record = Group.Records(app.IDs.Record).Record;

IG = Record.Data.Source;
sz = size(IG);

% if size(IG,3) == 3
%     IG = rgb2gray(IG);
%     Record.Data.Source = IG;
% end

if Record.Flags.Anal==0
    ROIneuron = drawrectangle(displayH,'Position', [sz(1)/4 sz(2)/4 sz(1)/2 sz(2)/2], 'StripeColor','y');
%     msgbox({'Adjust the roi as close as possible to the neuron.';'Zoom in to fine-tune.';'Double click when done'});
    POSneuron = ROIwait(ROIneuron);
    POSneuron = round(POSneuron); % position values in descrete pixel coordinates
    delete(ROIneuron);
    rectangle(displayH, 'Position', POSneuron, 'EdgeColor', 'yellow');
%     zoom out
    ROIbgrnd = drawrectangle(displayH,'Position', POSneuron, 'Color','r', 'InteractionsAllowed', 'translate');
%     msgbox({'Move the background roi to a dark position in the worm.';'Zoom in to fine-tune.';'Double click when done'});
    POSbgrnd = ROIwait(ROIbgrnd);
    POSbgrnd = round(POSbgrnd); % position values in descrete pixel coordinates
    delete(ROIbgrnd);
    Record.Data.Variables.ROI.Main = POSneuron;
    Record.Data.Variables.ROI.Background = POSbgrnd;
%     zoom out
    NS_RecordDisplay(app, displayH);
end
Ineuron = imcrop(IG,Record.Data.Variables.ROI.Main);
Ibgrnd = imcrop(IG,Record.Data.Variables.ROI.Background);
% binarize using Otsu's method, which chooses the threshold value to minimize the intraclass variance of the thresholded black and white pixels [1]. imbinarize uses a 256-bin image histogram to compute Otsu's threshold.
BWneuron = imbinarize(Ineuron);
Score.Area = sum(sum(BWneuron));
Score.FluoMain = mean(Ineuron(BWneuron));
Score.FluoBackground = mean(Ibgrnd(BWneuron));
Score.FluoDifference = Score.FluoMain - Score.FluoBackground;

app.Experiment.Groups(app.IDs.Group).Group.Records(app.IDs.Record).Record = Record;

end



function pos = ROIwait(h)
    % Listen for mouse clicks on the ROI
    l = addlistener(h,'ROIClicked',@clickCallback);
    % Block program execution
    uiwait;
    % Remove listener
    delete(l);
    % Return the current position
    pos = h.Position;
end


function clickCallback(~,evt)
if strcmp(evt.SelectionType,'double')
    uiresume;
end
end