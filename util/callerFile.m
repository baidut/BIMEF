function out = callerFile(field)
%CALLERFILE infor of current function's caller file
%USAGE
% s = callerFile
% s
% .name
% .file
% .line
% .path
%
% c = callerFile(field)
%
%

% carry with some debug info
% st(1): funcName st(2): currently running function

ST = dbstack('-completenames', 1);
L = length(ST);

if L < 2
    out.file = [];
    out.name = [];
    out.line = [];
    out.path = cd;
else
    out = ST(2);
    out.path = fileparts(out.file);
end

if nargin ~= 0
	out = out.(field);
end

% carry with some debug info
% st(1): funcName st(2): currently running function
