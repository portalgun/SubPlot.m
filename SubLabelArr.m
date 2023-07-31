classdef SubLabelArr < handle
properties
end
properties
    parent
end
methods
    function obj=SubLabelArr(parent)
        obj.parent=parent;
    end
    function [varargout]=subsref(obj,s)
        varargout=cell(1,nargout);
        if numel(s.subs{1})==1 && s.subs{1}==-1
            varargout{1}=obj.parent.Ctr;
        elseif numel(s.subs{1})==1 && s.subs{1}==0
            varargout{1}=obj.parent.Bas;
        else
            [varargout{:}]=subsref(obj.parent.Arr,s);
        end
    end
end
end
