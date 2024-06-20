function IM = NS_RecordLoad(Experiment, IDs)

Group = Experiment.Groups(IDs.Group).Group;
Record = Group.Records(IDs.Record).Record;

FileName = fullfile(Record.Path, Record.Name);
IM = imread(FileName);
if size(IM,3) == 3
    IM = rgb2gray(IM);
end
