function newName = rename(oldName , format, varargin)
% rename(fileTest, '%s/<name>--DRIM.png', dirDrimResult) 

[path, name, ext] = fileparts(oldName);
if numel(varargin) ~= 0
    format = sprintf(format, varargin{:});
end
newName = strrep(format, '<path>', path);
newName = strrep(newName, '<name>', name);
newName = strrep(newName, '<ext>', ext(2:end)); % no . mark
end