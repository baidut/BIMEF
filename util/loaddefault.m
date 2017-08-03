function [cfg, newCfg ] = loaddefault(cfg, defaultCfg, appendStruct)
%loaddefault will be removed, use ezInput instead.
%
% keepStruct: recursive retain the struct
%LOAD DEFAULT CONFIG
% defaultCfg = struct('a',1,'b',2,'c',3);
% cfg = struct('b',0);
% [cfg, newCfg ] = loaddefault(cfg, defaultCfg)
%
% cfg = struct('b',0, 'd', 1, 'e', 2); % unknown paramvalue
% [cfg, newCfg ] = loaddefault(cfg, defaultCfg)

%     existingfields = isfield(cfg,fieldnames(defaultCfg));
    %if cfg 
    if nargin < 3
        appendStruct = false;
    end
    
     if iscell(cfg)
        cfg = struct(cfg{:});
     end
    if iscell(defaultCfg)
        defaultCfg = struct(defaultCfg{:});
    end
    
    newCfg = cfg;
    
    % both are struct
    
    % defaultCfg --> cfg
    fields = fieldnames(defaultCfg);
    nfields = numel(fields);
    for n = 1:nfields
        if ~isfield(cfg,fields(n))
            cfg.(fields{n}) = defaultCfg.(fields{n});
        else
            if appendStruct && isstruct(defaultCfg.(fields{n}))
                cfg.(fields{n}) = loaddefault(cfg.(fields{n}), ...
                                              defaultCfg.(fields{n}) );
            end
            newCfg = rmfield(newCfg, fields(n));
        end
    end
    
    % newCfg --> cell
    if nargout > 1
        newCfg = convertToCell(newCfg);
    end
end

function c = convertToCell(s)
    twoRow = [fieldnames(s), struct2cell(s)]';
    c = twoRow(:)';
end

% scatter3_args = rmfield(param, default(1:2:end));
% 