function NS_RecordDisplay(app, displayH)

Group = app.Experiment.Groups(app.IDs.Group).Group;
Record = Group.Records(app.IDs.Record).Record;

IG = Record.Data.Source;

% if ~isempty(Param)
%     BW = zeros(size(IG));
%     BW(IG>=Param.MinIntensity) = 1;
%     imagesc(BW, 'parent', displayH);
% else
    imagesc(IG, 'parent', displayH);
% end
colormap(displayH, 'gray');
if Record.Flags.Anal == 1
    displayH.NextPlot = 'add';
    rectangle(displayH, 'Position', Record.Data.Variables.ROI.Main, 'EdgeColor', 'yellow');
    rectangle(displayH, 'Position', Record.Data.Variables.ROI.Background, 'EdgeColor', 'red');
    displayH.NextPlot = 'replacechildren';
end

