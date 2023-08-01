classdef SubLabel < handle
properties
    num
    name
    type

    style
end
properties(SetObservable)
    ax
    tbox

    color='k'
    pos
    % tbox
    loc
    txt
    fontsize
    bBold
end
properties(Hidden)
    pos_=[]
end
properties(Access=protected)
    SP
end
methods
    function obj=SubLabel(SP,num,name,type)
        if nargin < 1; return; end
        obj.SP=SP;
        obj.num=num;
        obj.name=name;
        obj.type=type;
        obj.tbox=SubTBox(obj,SP);

    end
    function init(obj,pos)
        if nargin < 2 || isempty(pos)
            pos=obj.pos_;
        end
        if obj.SP.bTest
            col='k';
            bbox='on';
        else
            col='none';
            bbox='off';
        end

        obj.ax=axes(...
                'Units','normalized',...
                'Position',pos,...
                'YColor',col,...
                'XColor',col,...
                'Color','none',...
                'XTick',[],...
                'YTick',[], ...
                'Box',bbox ...
        );
    end
    function set.pos(obj,pos)
        obj.pos_=pos;
        if Axis.isInvalid(obj.ax)
            obj.init(pos);
        else
            set(obj.ax,'Position',pos);
        end

        switch obj.name
        case {'sl','tl','xxl','xxlabel'}
            loc='top';
        case {'ul','bl','xl','xlabel'}
            loc='bottom';
        case {'rl','yyl'}
            loc='right';
        case {'ll','yl'}
            loc='left';
        otherwise
            obj.name
            dk
        end
        if obj.num==-1
            switch loc
            case 'top'
                loc=[loc 'left'];
            case 'bottom'
                loc=[loc 'left'];
            case 'left'
                loc=[loc 'top'];
            case 'right'
                loc=[loc 'top'];
            end
        end
        obj.loc=loc;

        %obj.tbox.pos=pos;
    end
    function get.pos(obj)
        out=obj.pos_;
    end
%- TBOX
    function set.style(obj,in)
        obj.tbox.style=in;
    end
    function out=get.style(obj)
        out=obj.tbox.style;
    end
    function set.color(obj,in)
        obj.tbox.fontcolor=in;
    end
    function out=get.color(obj,in)
        out=obj.tbox.fontcolor;
    end
    function set.bBold(obj,in)
        obj.tbox.bBold=in;
    end
    function out=get.bBold(obj)
        out=obj.tbox.bBold;
    end
    function set.loc(obj,in)
        obj.tbox.loc=in;
    end
    function out=get.loc(obj)
        out=obj.tbox.loc;
    end
    function set.txt(obj,in)
        obj.tbox.txt=in;
    end
    function out=get.txt(obj)
        out=obj.tbox.txt;
    end
    function set.fontsize(obj,in)
        obj.tbox.fontsize=in;
    end
    function out=get.fontsize(obj)
        out=obj.tbox.fontsize;
    end
%-
end
end
