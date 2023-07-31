classdef Label < handle
properties
    labels
    text
end
methods(Static)
end
methods
    function obj=Label()
    end
    function set.label(obj,txt)
        if ~iscell(obj.rlabels)
            obj.labels=cell(1,obj.RC(1));
        end
        if iscell(txt)
            obj.rlabels=txt;
        else
            obj.rlabels{obj.cur(1)}=txt;
        end
    end
end
end
