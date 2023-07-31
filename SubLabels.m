classdef SubLabels < handle & ChildSetter & SubLabel
properties

    %- Children
    All

    %- Self Props
    bByDim
    bCtr
    Position
    baseStyle=0

    %- num
    i
    rc
    % num
    % axx
    % ... and everything else
end
properties(Hidden)
    W
    pos0

    % children
    Bas
    Ctr
    Arr

    Child
    bSet=false
    fldInd

    nums
    szdim
    dims
    sub
    baseSign
    dir

    bArr_
    bCtr_
    bBas_

    AFld
    BFld
    CFld

    % X
    edgesFld
    % Y
    ctrsFld
    ctrFld
    % WH
    szFld
    bSup=false;
end
methods
%- INIT
    function obj=SubLabels(SP,name,typ)
        if nargin < 1; return; end
        obj.SP=SP;
        obj.name=name;
        obj.type=typ;
        obj.fldInd=find(ismember(SP.flds,name));

        obj.parse();
        obj.init_children();
    end
    function parse(obj)

        switch obj.name
        case {'u','s'}
            obj.bSup=true;
            obj.szdim=0;
            obj.dims=[2 1];
            %obj.ctrFld='oCCtrs';
            obj.szFld='iC';
            obj.ctrsFld='iCT';
            obj.ctrFld='iCT';
        case {'t','b','x','xx'}
            obj.szdim=2;
            obj.dims=[2 1];
            obj.szFld='iC';;
            obj.ctrsFld='iC';
            obj.ctrFld='iCTm';
        case {'l','r','y','yy'}
            obj.szdim=1;
            obj.dims=[1 2];
            obj.szFld='iR';
            obj.ctrsFld='iR';
            obj.ctrFld='iRTm';
        end


        switch obj.SP.lFlds{obj.fldInd};
        case 'L'
            obj.sub=1;
            obj.baseSign=1;

            obj.edgesFld='iT';
            obj.dir=-1;
        case 'R'
            obj.sub=2;
            obj.baseSign=1;

            obj.edgesFld='oT';
            obj.dir=1;
        case 'T'
            obj.sub=3;
            obj.baseSign=-1;

            obj.edgesFld='oT';
            obj.dir=1;
        case 'B'
            obj.sub=4;
            obj.baseSign=-1;

            obj.edgesFld='iT';
            obj.dir=-1;
        end

        %fld=obj.SP.get_fld(obj.name);
        fld=obj.SP.get_fld(obj.name);
        AFld=[fld 'Txt'];
        if isprop(obj.SP,AFld)
            obj.AFld=AFld;
        end
        if obj.bSup
            BFld=AFld;
        else
            BFld=[fld 'BTxt'];
        end
        if isprop(obj.SP,BFld)
            obj.BFld=BFld;
        end
        CFld=[fld 'CTxt'];
        if isprop(obj.SP,CFld)
            obj.CFld=CFld;
        end


    end
    function init_children(obj);

        nums=obj.nums;
        obj.All=SubLabelArr(obj);
        obj.Arr=cell(nums,1);
        obj.Ctr=SubLabel(obj.SP, 0,obj.name,obj.type);
        obj.Bas=SubLabel(obj.SP,-1,obj.name,obj.type);

        for i =1:nums
            obj.Arr{i}=SubLabel(obj.SP,i,obj.name,obj.type);
        end
        obj.setListeners();
    end
    function setListeners(obj)
        if isempty(obj.SP.obsList)
            obj.SP.obsList=obj.getObservables('SubLabel');
        end
        obj.setChildSetter(obj.SP.obsList,'Child',[]);
    end
%- SET/GET
    function nums=get.nums(obj)
        if obj.szdim==0
            nums=1;
        else
            nums=obj.SP.RC(obj.szdim);
        end
    end
    function set.rc(obj,val)
        obj.rc=val;
        r=val(1);
        c=val(2);
        if obj.bSet
            return
        else
            cl=tmpSet(obj,'bSet',true);
            obj.i=sub2ind(obj.SP.RC,r,c);
        end
    end
    function set.i(obj,i)
        obj.i=i;

        switch i
        case -1
            obj.Child=obj.Bas;
        case  0
            obj.Child=obj.Ctr;
        otherwise
            if numel i > 1
                obj.Child=obj.Arr(i);
            else
                obj.Child=obj.Arr{i};
            end
        end

        if obj.bSet
            return
        else
            cl=tmpSet(obj,'bSet',true);
            [r,c]=ind2sub(obj.SP.RC,i);
            obj.rc=[r c];
        end
    end
    function out=get.bByDim(obj)
        out=obj.SP.get_bBy(obj.name);
    end
    function out=get.bCtr(obj)
        out=obj.SP.get_bCtr(obj.name);
        if isempty(out)
            out=false;
        end
    end
    %-
    function out=get.bArr_(obj)
        out=~obj.bSup && ~isempty(obj.AFld) && ~obj.bCtr;
    end
    function out=get.bBas_(obj)
        out=obj.bSup || ~isempty(obj.BFld);
    end
    function out=get.bCtr_(obj)
        out=~obj.bSup && obj.bCtr;
    end
%- SLECT
    function select(obj,i)
        if nargin < 2
            i=obj.SP.i;
        end
        obj.i=i;
    end
%- Position
    function edges=get_edges(obj)
        if ~isempty(obj.edgesFld)
            edges=obj.SP.Edges.(obj.edgesFld);
        elseif obj.SP.bInner(obj.fldInd)
            edges=obj.SP.Edges.i;
        else
            edges=obj.SP.Edges.oT;
        end
    end
    function set_position(obj)
        ef=obj.get_pos0();
        if ef; return; end

        if obj.bArr_ && obj.bCtr_
            obj.bCtr
            obj.name
        end
        if obj.bArr_
            obj.set_pos_arr();
        end
        if obj.bBas_
            obj.set_pos_bas();
        end
        if obj.bCtr_
            obj.set_pos_ctr();
        end
    end
    function exitflag=get_pos0(obj)
        exitflag=false;
        H=obj.SP.m.(obj.name);
        if H==0
            exitflag=true;
            return
        end

        % X
        edges=obj.get_edges();
        pad=obj.SP.MC.(obj.name);
        X=edges(obj.sub) - pad - H;

        % W
        obj.W=obj.SP.WH.(obj.szFld);

        obj.pos0=[0 0 0 0];
        obj.pos0([obj.dims obj.dims+2])=[X 0 H obj.W];
    end
    function set_pos_arr(obj);
        ctrs=obj.SP.Ctrs.(obj.ctrsFld)- obj.W/2;
        pos=obj.pos0;
        for i = 1:obj.nums
            pos(obj.dims(2))=ctrs(i);
            obj.Arr{i}.pos=pos;
        end
    end
    function set_pos_ctr(obj);
        ctr=obj.SP.Ctrs.(obj.ctrFld)- obj.W/2;

        pos=obj.pos0;
        pos(obj.dims(2))=ctr;
        obj.Ctr.pos=pos;
    end
    function set_pos_bas(obj)
        ctrsi=obj.SP.Ctrs.(obj.ctrsFld)- obj.W/2;
        r=ctrsi(1);
        pos=obj.pos0;

        %ctrb=r+w*obj.baseSign;
        %if obj.baseStyle==0
        if true
            if obj.baseSign==-1
                w=r;
                ctrb=r-w;
            else
                T=obj.SP.Edges.oT(3);
                w=T-(r+obj.W);
                ctrb=T-w;
            end
            pos(obj.dims(2))=ctrb;
            pos(obj.dims(2)+2)=w;
        else
            c=pos(obj.dims(1));
            h=pos(obj.dims(1)+2);
            pos(obj.dims(1))=c+h*obj.dir;
            pos(obj.dims(2))=r;
        end

        obj.Bas.pos=pos;
    end
%- TEXT
    function set_text(obj)
        if obj.bArr_
            obj.set_text_arr();
        end
        if obj.bCtr_
            obj.set_text_ctr();
        end
        if obj.bBas_
            obj.set_text_bas();
        end
    end
    function set_text_arr(obj)
        Txt=obj.SP.(obj.AFld);
        for i = 1:obj.nums
            if isempty(Txt)
                continue
            elseif iscell(Txt)
                obj.Arr{i}.txt=Txt{i};
            elseif ischar(Txt)
                obj.Arr{i}.txt=Txt;
            end
            obj.Arr{i}.fontsize=obj.SP.get_fontSize(obj.name);
        end
    end
    function set_text_ctr(obj)
        if isempty(obj.CFld)
            Txt=[];
        else
            Txt=obj.SP.(obj.CFld);
        end
        if isempty(Txt)
            Txt=obj.SP.(obj.AFld);
        end

        if isempty(Txt)
            ;
        elseif iscell(Txt)
            obj.Ctr.txt=Txt{1};
        elseif ischar(Txt)
            obj.Ctr.txt=Txt;
        end
        obj.Ctr.fontsize=obj.SP.get_fontSize(obj.name);
    end
    function set_text_bas(obj)
        Txt=obj.SP.(obj.BFld);
        obj.Bas.txt=Txt;
        obj.Bas.fontsize=obj.SP.get_fontSize(obj.name);
        obj.Bas.bBold=~obj.bSup;

        switch  obj.type
        case 'rc'
            m=obj.SP.get_margin(obj.name,true);
            obj.baseStyle=m > 1;
        case 'sup'
            obj.baseStyle=0;
        case 'xy'
            obj.baseStyle=0;
        end

        obj.Bas.style=obj.baseStyle;
    end
end
end
