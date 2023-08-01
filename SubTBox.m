classdef SubTBox < handle
properties
    ax

    loc
    % set by loc
    pos
    ha
    va
    rot

    txt=[]
    fontsize=22
    fontcolor=[0 0 0]
    bBold=0
    style
end
properties(Hidden)
    pos_
    txt_
end
properties(Access=protected)
    parent
    SP
end
methods(Static)
end
methods
    function obj=SubTBox(parent,SP)
        obj.parent=parent;
        obj.SP=SP;
    end
    function init(obj,txt)
        if isempty(obj.pos) || (isempty(obj.txt) && ~ischar(obj.txt))
            return
        end
        cl=tmpSet(obj.SP.f,'CurrentAxes',obj.parent.ax);
        obj.ax=text(obj.pos(1),obj.pos(2),obj.txt,...
            'FontSize',obj.fontsize,...
            'HorizontalAlignment',obj.ha,...
            'VerticalAlignment',obj.va, ...
            'Rotation',obj.rot,...
            'Color',obj.fontcolor ...
        );
        %pos,ha,va,rot
    end
    function set.rot(obj,in)
        if isempty(in)
            return
        end
        obj.rot=in;
    end
    function set.fontsize(obj,fontsize)
        obj.fontsize=fontsize;

        if Axis.isInvalid(obj.ax)
            obj.init();
        else
            obj.ax.String=obj.txt;
        end
    end
    function out=get.txt(obj)
        out=obj.txt_;
        if obj.bBold
            out=['{\bf' out '}'];
        end
    end
    function set.txt(obj,txt)
        obj.txt_=txt;

        if Axis.isInvalid(obj.ax)
            obj.init();
        else
            obj.ax.String=obj.txt;
            %set(obj.ax,'Sting',obj.txt);
        end
    end
    function set.pos(obj,in)
        obj.pos_=in;
        if Axis.isInvalid(obj.ax)
            obj.init();
        else
            set(obj.ax,'Position',in);
        end
    end
    function out=get.pos(obj)
        out=obj.pos_;
    end
    function set.loc(obj,in)


        obj.loc=in;
        switch obj.loc
        case 'left'
            va='bottom';
            ha='center';
            tpos=[1 0.5];
            rot=90;
        case 'right'
            va='bottom';
            ha='center';
            tpos=[0.00 0.5];
            rot=270;
        case 'top'
            ha='Center';
            va='bottom';
            tpos=[0.5 0];
            rot=0;
        case 'bottom'
            ha='Center';
            va='top';
            tpos=[0.5,.9];
            rot=0;

        case 'topleft'
            switch obj.style
            case 0
                ha='Left';
                va='bottom';
                tpos=[0.01 0];
            case 1
                ha='left';
                va='top';
                tpos=[1 .9];
            case 2
                ha='Center';
                va='top';
                tpos=[1 .9];
            end
            rot=0;
        case 'bottomleft'

            switch obj.style
            case 0
                ha='Left';
                va='top';
                tpos=[0.01,.9];
            case 1
                ha='left';
                va='bottom';
                tpos=[1,0];
            case 2
                ha='Center';
                va='bottom';
                tpos=[1,0];
            end

            %va='bottom';
            %tpos=[1,0];

            rot=0;
        case 'topright'
        case 'bottomright'
        case 'rightbottom'
        case 'leftbottom'

        case 'lefttop'
            switch obj.style
            case 0
                va='bottom';
                ha='right';
                tpos=[1 1];
            case 1
                va='top';
                ha='right';
                tpos=[0.1 0];
            case 2
                va='top';
                ha='Center';
                tpos=[0.1 0];
            end

            rot=90;
        case 'righttop'
            switch obj.style
            case 0
                va='bottom';
                ha='center';
                tpos=[0.001 1];
            case 1
                va='top';
                ha='left';
                tpos=[.9 0];
            case 2
                va='top';
                ha='center';
                tpos=[1 0];
            end

            rot=270;
        otherwise
            return
        end
        obj.ha=ha;
        obj.va=va;
        obj.rot=rot;
        obj.pos=tpos;

    end
end
end
