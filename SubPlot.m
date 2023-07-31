classdef SubPlot < handle
properties
    WH
    f
    bLockAxes=true

    RC
    n
    ctrs
    text

    %plotRatio=[1,1]
    iMargin
    oMargin
    iUnits
    oUnits
    axis

    % sup
    supTxt
    supLoc
    supMargin

    % sub
    subTxt
    subLoc
    subMargin

    % tile
    bTitles
    titles
    titleMargin
    titleFontSize

    % rc labels
    bRlabels
    bClabels
    rlabels
    clabels
    rNNewline
    cNNewline
    rlabelLoc='right'
    clabelLoc='top'
    clabelHA
    rlabelHA
    bRSup


    % rc base labels
    rlabelBase
    clabelBase
    titleBase
    rlabelBasePos=[0.0,0.99]
    clabelBasePos=[0.01, 0]
    titleBasePos=[0.01, 0]
    rlabelBaseHA
    clabelBaseHA
    titleBaseHA


    % xy lables
    titleByRow
    xlabelByRow
    ylabelByCol
    xlabelCtrOnly
    ylabelCtrOnly
    xlabelXYEdge % where to begin counting for ctr
    ylabelXYEdge

    %yy labels
    bYYlabels
    yylabelCtrOnly
    yylabelByCol
    yylabelColor
    yylabelXYEdge

    ticksFontSize
    xticksMargin
    yticksMargin
    yyticksMargin

    xlabelMargin
    ylabelMargin
    yylabelMargin


    clabelMargin % top or bottom
    rlabelMargin % left or right
    clabelBaseMargin % top or bottom
    rlabelBaseMargin % left or right
    titleBaseMargin



    supFontSize
    subFontSize
    RCFontSize
    FontSize
    XYFontSize

    cur
    bHold
end
properties(Hidden)
    obsList
    ax
    AX0

    sTitl=struct('loc',[],'ax',[],'tbox',[]);
    uTitl=struct('loc',[],'ax',[],'tbox',[]);

    rTitl=struct('loc',[],'ax',[],'tbox',[]);
    cTitl=struct('loc',[],'ax',[],'tbox',[]);
    %tTitl=struct('loc',[],'ax',[],'tbox',[]); NOTE unused

    tBTitl=struct('loc',[],'ax',[],'tbox',[],'txt','');
    rBTitl=struct('loc',[],'ax',[],'tbox',[]);
    cBTitl=struct('loc',[],'ax',[],'tbox',[]);

    yTitl=struct('ax',[],'tbox',[]);
    xTitl=struct('ax',[],'tbox',[]);
    yyTitl=struct('ax',[],'tbox',[]);

    bInit=true
    nPixWH
    nCharWH
    nCharWH_RC
    nCharWH_RC_rev
    nCharWH_rev

    bCtrOnly
    defFontSz

    bSuptitle_
    bSubtitle_
    bTitle_
    bRlabelBase_
    bClabelBase_
    bTitleBase_
    bRlabel_
    bClabel_
    titleBasePos_

    i
    c
    r
    h
    w

    % bFIRST
    W0
    H0
    TW
    TH
    mwh
    oMH
    oMW
    oML
    oMT

    % inner margins
    oM
    iM
    fWH

    ml
    mr
    mt
    mb
    aspectIdeal

    bResize=0
    bSelectAll=0
    bFirst=true
    % updateLegendMenuToolbar
end
properties(Constant)
    IMARGIN_NORM_DEF=[0.13 0.02 0.225 0.185]; % LRTB
    %OMARGIN_NORM_DEF=[0.02 0.02 0.02 0.02]; % LRTB
    OMARGIN_NORM_DEF=[0.02 0.02 0.02 0.09]; % LRTB
end
methods(Static)
    function P=getP()
        P={'iMargin',[],'';
           'iUnits','normalized','ischar_e';
           'iLM',[],'';
           'iRM',[],'';
           'iTM',[],'';
           'iBM',[],'';
           'oMargin',[],'';
           'oUnits','normalized','ischar_e';
           'oLM',[],'';
           'oRM',[],'';
           'oTM',[],'';
           'oBM',[],'';
           ...
           'rlabels',[],'';
           'clabels',[],'';
           'rlabelHA','Center','ischar_e';
           'clabelHA','Center','ischar_e';
           'clabelLoc','top','ischar_e';
           'rlabelLoc','right','ischar_e';
           'rNNewline',0,'Num.is_e';
           'cNNewline',0,'Num.is_e';
           'bRSup',false,'Num.isBinary';
           'RCFontSize',[],'';
           ...
           'xlabelByRow',true,'Num.isBinary';
           'ylabelByCol',true,'Num.isBinary';
           'titleByRow',true,'Num.isBinary';
           'xlabelCtrOnly','true','Num.isBinary';
           'ylabelCtrOnly','true','Num.isBinary';
           'xlabelXYEdge',[1 1],'Num.is';
           'ylabelXYEdge',[1 1],'Num.is';
           ...
           'bYYlabels',false,'Num.isBinary';
           'yylabelByCol',true,'Num.isBinary';
           'yylabelCtrOnly','true','Num.isBinary';
           'yylabelColor',[0 0 0],'';
           'yylabelXYEdge',[ 1  1],'Num.is';
           'XYFontSize',[],'';
           ...
           'ticksFontSize',18,'';
           ...
           'rlabelBase','','ischar_e';
           'clabelBase','','ischar_e';
           'titleBase','','ischar_e';
           'rlabelBasePos',[0.0,0.99],'Num.is_e';
           'clabelBasePos',[0.01,0],'Num.is_e';
           'titleBasePos',[0.01 0],'Num.is_e';
           'rlabelBaseHA','left','ischar_e';
           'clabelBaseHA','left','ischar_e';
           'titleBaseHA','left','ischar_e';
           'rlabelBaseMargin',0,'Num.is';
           'clabelBaseMargin',0,'Num.is';
           'titleBaseMargin',0,'Num.is';
            ...
           'xticksMargin',1,'Num.is';
           'yticksMargin',1,'Num.is';
           'yyticksMargin',1,'Num.is';
           'xlabelMargin',1,'Num.is';
           'ylabelMargin',1,'Num.is';
           'yylabelMargin',1,'Num.is';
           'rlabelMargin',1,'Num.is';
           'clabelMargin',1,'Num.is';
           'subMargin',1,'Num.is';
           'supMargin',1,'Num.is';
           'titleMargin',1,'Num.is';
           ...
           'supTxt','','';
           'supLoc','top','';
           'supFontSize',[],'';
           ...
           'subTxt','','';
           'subLoc','bottom','';
           'subFontSize',[],'';
           ...
           'bTitles',false,'';
           'bRlabels',false,'';
           'bClabels',false,'';
           'titles',[],'';
           'titleFontSize',[],'';
           ...
           'FontSize',22,'';
           ...
           'axis','','ischar';
           'bHold',false','';
           'bLockAxes',true','';
        };
    end
end
methods
    function obj=SubPlot(varargin)
        if nargin < 1 || isempty(varargin{1})
            return
        end
        isnum=cellfun(@isnumeric,varargin);
        ind=logical(cumprod(isnum));
        nums=cellfun(@numel,varargin(ind));
        n=sum(ind);
        N=varargin(ind);
        varargin(ind)=[];

        if nums(1)==2
            obj.RC=[N{1}];
            N(1)=[];
        elseif n > 1
            obj.RC=N{1:2};
            N(1:2)=[];
        end
        obj.parse(varargin{:});
        obj.n=prod(obj.RC);
        obj.ax=cell(obj.n,1);
        obj.text=cell(obj.n,1);
        obj.ctrs=cell(obj.n,1);
        if ~isempty(N)
            obj.select(N{:});
        end
        obj.f=gcf;
        if ~obj.bHold
            clf;
        end
        set(obj.f,'SizeChangedFcn',@obj.resize);
        obj.get_conversions();
        assignin('base','SP',obj);


        obj.AX0=gca;
        axis off;

        obj.get_margins();
        obj.bFirst=true;
        for r=1:obj.RC(1)
        for c=1:obj.RC(2)
            obj.cur=[r c];
            obj.i=sub2ind(obj.RC,r,c);
            obj.get_crwh(r,c,1,1);
            cl2=tmpSet(obj,'bFirst',false);
        end
        end
    end
%- SET GET
    % sub/sup
    function out=get.bSuptitle_(obj)
        out=~isempty(obj.supTxt);
    end
    function out=get.bSubtitle_(obj)
        out=~isempty(obj.subTxt);
    end
    % rct
    function out=get.bTitle_(obj)
        out=~isempty(obj.titles)  || obj.bTitles;
    end
    function out=get.bRlabel_(obj)
        out=~isempty(obj.rlabels) || obj.bRlabels || obj.bRlabelBase_;
    end
    function out=get.bClabel_(obj)
        out=~isempty(obj.clabels) || obj.bClabels || obj.bClabelBase_;
    end
    % rct base
    function out=get.bTitleBase_(obj)
        out=~isempty(obj.titleBase);
    end
    function out=get.bRlabelBase_(obj)
        out=~isempty(obj.rlabelBase);
    end
    function out=get.bClabelBase_(obj)
        out=~isempty(obj.clabelBase);
    end
    function out=get.titleBasePos_(obj)
        if ~isempty(obj.titleBasePos)
            out=obj.titleBasePos;
            return
        end

    end
    %
    function set.titles(obj,txt)
        if ~iscell(obj.titles)
            obj.titles=cell(1,obj.RC(1));
        end
        if iscell(txt)
            obj.titles=txt;
        else
            obj.titles{obj.cur(1)}=txt;
        end
    end
    function set.rlabels(obj,txt)
        if ~iscell(obj.rlabels)
            obj.rlabels=cell(1,obj.RC(1));
        end
        if iscell(txt)
            obj.rlabels=txt;
        else
            obj.rlabels{obj.cur(1)}=txt;
        end
    end
    function set.clabels(obj,txt)
        if ~iscell(obj.clabels)
            obj.clabels=cell(1,obj.RC(2));
        end
        if iscell(txt)
            obj.clabels=txt;
        else
            obj.clabels{obj.cur(2)}=txt;
        end
    end
end
%- PARSE
methods(Hidden)
    function parse(obj,varargin)
        P=obj.getP();
        Opts=Args.simple([],P,varargin{:});
        obj.bHold=Opts.bHold;
        Opts=rmfield(Opts,'bHold');

        def=cell(2,1);
        switch Opts.iUnits
            case {'normalized','norm','normal'}
                Opts.iUnits='normalized';
                def{1}=obj.IMARGIN_NORM_DEF;
            case {'characters','char'}
                Opts.iUnits='characters';
                def{1}=repmat(Opts.FontSize,1,4);
        end

        switch Opts.oUnits
            case {'normalized','norm','normal'}
                Opts.oUnits='normalized';
                def{2}=obj.OMARGIN_NORM_DEF;
            case {'characters','char'}
                Opts.oUnits='characters';
                def{2}=[2 1 1 2];
        end

        flds={'iMargin','oMargin'};
        for i = 1:length(flds)
            fld=flds{i};
            if isempty(Opts.(fld))
                Opts.(fld)=def{i};
            elseif ischar(Opts.(fld)) && ismember(Opts.(fld),{'none','None','NONE'})
                Opts.(fld)=[0 0 0 0];
            else
                ind=isnan(Opts.iMargin);
                Opts.(fld)(ind)=def{i}(ind);
            end
        end

        flds={ ...
            'iLM','iMargin',1;
            'iRM','iMargin',2;
            'iTM','iMargin',3;
            'iBM','iMargin',4;
            'oLM','oMargin',1;
            'oRM','oMargin',2;
            'oTM','oMargin',3;
            'oBM','oMargin',4;
        };
        for i = 1:size(flds,1)
            fld=flds{i,1};
            if ~isempty(Opts.(fld))
                Opts.(flds{i,2})(flds{i,3})=Opts.(fld);
            end
        end
        Opts=rmfield(Opts,flds(:,1));

        flds={'rlabels','clabels','rlabelBase','clabelBase','titles','supTxt',};
        for i =1:length(flds)
            fld=flds{i};
            if ~isempty(Opts.(fld))
                obj.(fld)=Opts.(fld);
            end
        end
        Opts=rmfield(Opts,flds);

        flds=fieldnames(Opts);
        for i =1 :length(flds)
            fld=flds{i};
            val=Opts.(fld);
            if endsWith(fld,'FontSize') && isempty(val)
                val=obj.FontSize;
            end
            obj.(fld)=val;
        end

        obj.bInit=false;
    end
end
methods
%- select
    function sel(obj,varargin)
        obj.select(varargin{:});
    end
    function obj=selectAll(obj)
        obj.bSelectAll=false;
        cl=tmpSet(obj,'bSelectAll',true);
        obj.bFirst=true;
        for i = 1:obj.n
            obj.select(i);
            cl2=tmpSet(obj,'bFirst',false);
        end
    end
    function obj=next(obj)
        if isempty(obj.cur)
            cur=[1,1];
            ind=1;
        else
            ind=sub2ind(obj.RC,obj.cur(1),obj.cur(2))+1;
        end
        if ind > obj.n
            error('exceeded n')
        end
        [n,m]=ind2sub(obj.RC,ind);
        obj.sel(n,m);
    end
    function obj=select(obj,varargin)
        if length(varargin{1})==1 && (length(varargin)==1 || ~isnumeric(varargin{2}))
            ind=varargin{1};
            [r,c]=ind2sub(obj.RC,ind);
            varargin(1)=[];
        elseif length(varargin{1})==2
            r=varargin{1}(1);
            c=varargin{1}(2);
            varargin(1)=[];
        else
            r=varargin{1};
            c=varargin{2};
            varargin(1:2)=[];
        end
        if ~isempty(varargin)
            if length(varargin{1})==1
                h=varargin{1};
                if length(varargin) > 1
                    if length(varargin{2})==1
                        w=varargin{2};
                    end
                end
            elseif length(varargin{1})==2
                h=varargin{2}(1);
                w=varargin{2}(1);
            end
        else
            h=1;
            w=1;
        end

        obj.cur=[r c];
        obj.i=sub2ind(obj.RC,r,c);

        %if ~obj.bResize
        %    obj.get_margins();
        %    obj.fWH=obj.f.Position(3:4);
        %end
        obj.get_crwh(r,c,h,w);
        obj.set_sub_pos();
    end
end
methods(Access=protected)
%- Postition
    function get_conversions(obj)
        %set(obj.f,'Units','normalized');
        %posNorm=get(obj.f,'Position');
        posNorm=[1 1 1 1];


        cl=tmpSet(obj.f,'Units','normalized');
        obj.fWH=obj.f.Position(3:4);

        set(obj.f,'Units','characters');
        posChar=obj.f.Position(3:4);

        def=get(groot,'defaultuicontrolFontSize');
        obj.defFontSz=def;

        set(obj.f,'Units','pixels');
        obj.nPixWH=obj.f.Position(3:4);

        obj.nCharWH   =(posChar.*def./obj.FontSize);
        obj.nCharWH_RC=(posChar.*def./obj.RCFontSize);
        obj.nCharWH_RC_rev=obj.nPixWH.*fliplr(obj.nCharWH_RC./obj.nPixWH);
        obj.nCharWH_rev=obj.nPixWH.*fliplr(obj.nCharWH./obj.nPixWH);

    end
    function set_sub_pos(obj)

        i=obj.i;
        v=[obj.c(i),obj.r(i),obj.w(i),obj.h(i)];

        if Axis.isInvalid(obj.ax{i})
            obj.ax{i}=axes(...
                'Units','normalized',...
                'Position',v...
            );
            enableDefaultInteractivity(obj.ax{i});
        else
            % ACTUAL SELECT
            if ~obj.bSelectAll && ~obj.bResize
                set(obj.f,'CurrentAxes',obj.ax{i}); % XXX SLOW 2
            end
            if obj.bResize
                set(obj.ax{i},'Position',v); % XXX SLOW
            else
                set(obj.ax{i},'Units','normalized','Position',v); % XXX SLOW
            end
        end

    end
    function get_crwh(obj,r,c,HH,WW)
        %i=sub2ind([obj.RC(2) obj.RC(1)],c,r);
        if obj.bFirst
            obj.oMW=sum(obj.oM(1:2));
            obj.oMH=sum(obj.oM(3:4));
            obj.oML=obj.oM(1);
            obj.oMT=obj.oM(3);

            % raw size of outer and inner
            [W0,H0,C0,R0]  =outer_fun(obj,1,1,WW,HH);
            [w0,h0,~,~,mwh]=inner_fun(obj,W0,H0,C0,R0);
            obj.mwh=mwh;

            % resize inner to fit aspect ratio
            [rW,rH]=ratio_fun(w0,h0);
            w = w0*rW;
            h = h0*rH;

            % resize both outer and inner to f
            TW=(w+sum(mwh(1:2)))*obj.RC(2)/WW + obj.oMW;
            TH=(h+sum(mwh(3:4)))*obj.RC(1)/HH + obj.oMH;
            bH=TH > TW;
            if bH
                TW=TW./TH;
                TH=1;
            else
                TH=TH./TW;
                TW=1;
            end
            obj.TW=TW;
            obj.TH=TH;
            obj.W0=(TW-obj.oMW) * WW/obj.RC(2);
            obj.H0=(TH-obj.oMH) * HH/obj.RC(1);
        else
            mwh=obj.mwh;
        end

        C0=  (  (c-1)*obj.W0 + obj.oML);
        R0=1-(  (r-1)*obj.H0 + obj.oMT);
        [w0,h0,c0,r0]=inner_fun(obj,obj.W0,obj.H0,C0,R0);
        [rW,rH]=ratio_fun(w0,h0);
        w = w0*rW;
        h = h0*rH;

        % size of each inner, after resizing
        rr = r0-(r-1)*abs(h-h0) - (h+mwh(4));
        cc = c0-(c-1)*abs(w-w0);

        % ideal aspect ratio
        if obj.bFirst
            if bH
                TH=1;
                TW=(w+sum(mwh(1:2)))*obj.RC(2)/WW + obj.oMW;
            else
                TH=(h+sum(mwh(3:4)))*obj.RC(1)/HH + obj.oMH;
                TW=1;
            end
            iFWH=obj.fWH.*[TW TH];
            obj.aspectIdeal=iFWH(1)/iFWH(2);


            obj.ml=mwh(1);
            obj.mr=mwh(2);
            obj.mt=mwh(3);
            obj.mb=mwh(4);
        end

        i=obj.i;
        obj.r(i) = rr;
        obj.c(i) = cc;
        obj.w(i) = w;
        obj.h(i) = h;


        obj.ctrs{i}=[rr+h/2 cc+w/2];

        function [W,H,C,R]=outer_fun(obj,TW,TH,WW,HH)
            W=(TW-obj.oMW) * WW/obj.RC(2);
            H=(TH-obj.oMH) * HH/obj.RC(1);
            C=  (  (c-1)*W + obj.oML);
            R=1-(  (r-1)*H + obj.oMT);
        end
        function [w,h,c,r,mwh]=inner_fun(obj,W,H,C,R)
            mwh=obj.iM.*[W W H H];
            w=W - sum(mwh(1:2));
            h=H - sum(mwh(3:4));
            r=R + mwh(4);
            c=C + mwh(1);
        end
        function [rW,rH]=ratio_fun(w,h);
            rWH=[w h] .* obj.fWH;
            if any(obj.RC==1)
                rF=1;
            else
                rF=rWH(1)./rWH(2);
            end

            if rF > 0
                rH=rF;
                rW=1;
            else
                rH=1;
                rW=1/rF;
            end
        end
    end
%- diminfo
    function I=dimInfo(obj,ind,xedge,yedge,xshift,yshift)
        RC=[obj.RC obj.RC(2)];
        curC=[obj.cur obj.cur(2)];

        if nargin < 3 || isempty(xedge)
            xedge=1;
        end
        if nargin < 4 || isempty(yedge)
            yedge=1;
        end
        if nargin < 5 || isempty(xshift)
            xshift=yedge-1;
        end
        if nargin < 6 || isempty(yshift)
            yshift=xedge-1;
        end

        RCR=[obj.RC obj.RC(1)];
        curR=[obj.cur obj.cur(1)];
        ctrs=(RCR+[yedge-1 xedge-1 yedge-1])/2;
        bEven=mod(ctrs,1)== 0;
        I.bCtrs=curR==ceil(ctrs + [0 0 0].*bEven);

        I.bByRC=curC==[1+yshift RC(1)-xshift RC(2)-yshift];
        bLoc=[curR(end-1:-1:1) obj.cur(2)]==[1+yshift RC(1)-xshift RC(2)-yshift];

        I.bEvenCtr=I.bCtrs & bEven;

        I.i=sub2ind([RC(2) RC(1)],obj.cur(2),obj.cur(1));

        if nargin >= 1 && ~isempty(ind)
            % e.g. X LABELLING DETERMINED BY Y
            if ind==2
                dim=1;
            else
                dim=2;
            end

            I.bBlankCtr= ~(I.bCtrs(ind) & bLoc(ind));
            I.bEvenCtr=  I.bCtrs(ind)   & bLoc(ind) & bEven(ind);
            I.bCtrs=     I.bCtrs(dim);
            I.bBlankBy=     ~bLoc(ind);
        end
    end
%- MARGINS
    function out=get_nCharWH(obj,fontSize)
        out=obj.nCharWH./obj.FontSize .* fontSize;
    end
    function oMarginN=get_oMarginN(obj)
        oM=obj.oMargin;
        switch obj.oUnits
            case 'normalized'
                oMarginN=oM;
            case 'characters'
                % x, y, w, h
                oMarginN=oM./obj.nCharWH_RC_rev(1);
            case 'pixels'
                TODO
        end
    end
    function out=get_iMarginN(obj)
        iM=obj.iMargin;
        switch obj.iUnits
            case 'normalized'
                out=iM;
            case 'characters'
                out=iM./repmat(obj.nCharWH,1,2);
            case 'pixels'
                TODO
        end
    end
    function out=get_marginN(obj,fld)
        if nargin < 2
            fld='iMargin';
        end
        iM=obj.(fld);
        switch obj.iUnits
            case 'normalized'
                iMarginN=iM;
            case 'characters'
                % x, y, w, h
                bFlip = false;
				switch fld
                case {'xlabelMargin','ylabelMargin','yylabelMargin'}
                    fsz=obj.XYFontSize;
                case {'clabelMargin','rlabelMargin','clabelBaseMargin','rlabelBaseMargin'}
                    fsz=obj.RCFontSize;
                case 'supMargin'
                    fsz=obj.supFontSize;
                case 'titleMargin'
                    fsz=obj.titleFontSize;
                case {'xticksMargin','yticksMargin','yyticksMargin'}
                    fsz=obj.ticksFontSize;
                otherwise
                    fld
				end
                nCharWH=obj.get_nCharWH(fsz);

                if ~any(strcmp(fld,{'yticksMargin','yyticksMargin'})) && startsWith(fld,{'y','r'});
                    ind=1;
                else
                    ind=2;
                end
                out=iM./nCharWH(ind);
            case 'pixels'
                TODO
        end
    end
    function [oM,iM]=get_margins(obj)
        oMarginN=obj.get_oMarginN();
        iMarginN=obj.get_iMarginN();

        oMW=sum(oMarginN(1:2));
        oMH=sum(oMarginN(3:4));
        iMW=sum(iMarginN(1:2));
        iMH=sum(iMarginN(3:4));

        oML=oMarginN(1);
        iML=iMarginN(1);
        oMT=oMarginN(3);
        iMT=iMarginN(3);


        % XY labels
        mx=obj.get_marginN('xlabelMargin');
        my=obj.get_marginN('ylabelMargin');
        mz=obj.get_marginN('yylabelMargin');
        mxt=obj.get_marginN('xticksMargin');
        myt=obj.get_marginN('yticksMargin');
        mzt=obj.get_marginN('yyticksMargin');

        if obj.xlabelByRow
            oMH=oMH+mx+mxt;
        else
            iMH=iMH+mx+mxt;
        end
        if obj.ylabelByCol
            oMW=oMW+my+myt;
            oML=oML+my+myt;
        else
            iMW=iMW+my+myt;
            iML=iML+my+myt;
        end
        if obj.yylabelByCol && obj.bYYlabels
            oMW=oMW+mz+mzt;
        elseif obj.bYYlabels
            iMW=iMW+mz+mzt;
        end

        % RC labels
        mc=0;
        mr=0;
        if obj.bClabel_
            mc=obj.get_marginN('clabelMargin'); % top or bottom
        end
        if obj.bRlabel_
            mr=obj.get_marginN('rlabelMargin'); % left or right
        end
        oMH=oMH+mc;
        oMW=oMW+mr;
        if strcmp(obj.clabelLoc,'top')
            oMT=oMT+mc;
        end
        if strcmp(obj.rlabelLoc,'left')
            oML=oML+mr;
        end

        % RC Base Labels
        mC=0;
        mR=0;
        if obj.bClabelBase_
            mC=obj.get_marginN('clabelBaseMargin'); % left or right
        end
        if obj.bRlabelBase_
            mR=obj.get_marginN('rlabelBaseMargin'); % top or bottom
        end
        oMW=oMW+mC;
        oMH=oMH+mR;
        if strcmp(obj.rlabelLoc,'top')
            oMT=oMT+mR;
        end
        if strcmp(obj.clabelLoc,'left')
            oML=oML+mC;
        end

        % TITLES
        ms=0;
        mt=0;
        mu=0;
        if obj.bSuptitle_
            ms=obj.get_marginN('supMargin');   % top or bottom (startswith)
        end
        if obj.bSubtitle_
            mu=obj.get_marginN('subMargin');   % top or bottom (startswith)
        end
        if obj.bTitle_
            mt=obj.get_marginN('titleMargin'); % top
        end

        oMH=oMH+mu;
        oMH=oMH+ms;
        oMH=oMH+mt;
        if startsWith(obj.supLoc,'top')
            oMT=oMT+ms;
        end
        oMT=oMT+mt;

        %oML=my+myt

        % COMBINE
        obj.oM=[oML oMW-oML oMT oMH-oMT];
        obj.iM=[iML iMW-iML iMT iMH-iMT];
    end
%- Labels
    function [ctrs,va]=set_clabel_axis_pos(obj,loc)
        if nargin < 2 || isempty(loc)
            loc=obj.cTitl.loc;
        else
            obj.cTitl.loc=loc;
        end
        if strcmp(loc,'bottom')
            va='bottom';
            pos=[0, 0.00, 1, 0.95];
        elseif strcmp(loc,'top')
            va='top';
            pos=[0, 1.00, 1, 0.95];
        else
            error('incorrect column label location')
        end
        ctrs=obj.get_col_ctrs;
        if Axis.isInvalid(obj.cTitl.ax)
            obj.cTitl.ax=axes('Position',pos,'Units','normalized','Color','None','XColor','None','YColor','None');
            obj.cTitl.tbox=cell(length(ctrs)+1,1);
        else
            set(obj.cTitle.ax,'Position',pos);
        end
    end
    function [ctrs,va,rot]=set_rlabel_axis_pos(obj,loc)
        if nargin < 2 || isempty(loc)
            loc=obj.rTitl.loc;
        else
            obj.rTitl.loc=loc;
        end
        if strcmp(loc,'left')
            va='top';
            pos=[0.00, 0.00, 1, 0.95];
            rot=90;
        elseif strcmp(loc,'right')
            va='top';
            pos=[1.00, 0.00, 0, 1.00];
            rot=270;
        end
        ctrs=obj.get_row_ctrs();
        if Axis.isInvalid(obj.rTitl.ax)
            obj.rTitl.ax=axes( 'Position', pos,'Units','normalized','Color','None','XColor','None','YColor','None');
            obj.rTitl.tbox=cell(length(ctrs)+1,1);
        else
            set(obj.rTitl.ax,'Position',pos);
        end
    end
    function set_clabel_tbox_pos(obj)
        ctrs=obj.get_col_ctrs();
        for i = 1:length(ctrs)
            pos=obj.cTitl.tbox{i}.Position;
            set(obj.cTitl.tbox{i},'Position',[ctrs(i) 0 pos(3)]);
        end
    end
    function set_rlabel_tbox_pos(obj)
        ctrs=obj.get_row_ctrs();
        for i = 1:length(ctrs)
            if ~Axis.isInvalid(obj.rTitl.tbox{i})
                set(obj.rTitl.tbox{i},'Position',[0 ctrs(i)]);
            end
        end
    end
%- Base Labels
    function set_clabelBase(obj,lbl,va,rot)
        t=['{\bf' lbl '}'];
        tpos=obj.clabelBasePos;
        ha=obj.clabelBaseHA;
        if Axis.isInvalid(obj.cBTitl.tbox)
            obj.cBTitl.tbox=text(tpos(1),tpos(2),t,...
                'FontSize',fontsize,...
                'HorizontalAlignment',ha,...
                'VerticalAlignment',va);
        else
            obj.cBTitl.tbox.String=t;
            %set(obj.cTitl.tbox{i},'FontSize',fontsize);
        end
    end
    function set_rlabelBase(obj,lbl,rot,va)
        t=['{\bf' lbl '}'];
        tpos=obj.rlabelBasePos;
        ha=obj.rlabelBaseHA;
        fontsize=obj.RCFontSize;

        %ha='center';
        if Axis.isInvalid(obj.rBTitl.tbox)
            obj.rBTitl.tbox=text(tpos(1),tpos(2),t,'FontSize',fontsize,'HorizontalAlignment',ha,'VerticalAlignment',va);
            set(obj.rBTitl.tbox,'Rotation',rot);
        else
            obj.rBTitl.tbox.String=t;
            %set(obj.cTitl.tbox{i},'FontSize',fontsize);
        end
    end
    function set_tBTitl_axis_pos(obj)
        myt=obj.get_marginN('yticksMargin');
        %my=obj.get_marginN('ylabelMargin');
        ml=myt;
        mt=obj.get_marginN('titleMargin');

        cpos=obj.c(1)-ml;
        rpos=obj.r(1)+obj.h(1) + mt;

        wh=obj.getCharWH(obj.tBTitl.txt,obj.titleFontSize);

        v=[cpos rpos wh];

        if Axis.isInvalid(obj.tBTitl.ax)
            obj.tBTitl.ax=axes(...
                'Units','normalized',...
                'Position',v,...
                'Color','None','XColor','None','YColor','None'...
            );
        else
            set(obj.tBTitl.ax,'Position',v);
        end

    end
    function set_titleBase(obj,lbl)
        t=['{\bf' lbl '}'];

        obj.tBTitl.txt=lbl;
        obj.set_tBTitl_axis_pos();

        tpos=obj.titleBasePos;
        ha=obj.titleBaseHA;
        fontsize=obj.titleFontSize;
        rot=0;
        va='top';
        ha='left';


        %ha='center';
        if Axis.isInvalid(obj.tBTitl.tbox)
            obj.tBTitl.tbox=text(tpos(1),tpos(2),t,'FontSize',fontsize,'HorizontalAlignment',ha,'VerticalAlignment',va);
            set(obj.rTitl.tbox,'Rotation',rot);
        else
            obj.tBTitl.tbox.String=t;
            %set(obj.cTitl.tbox{i},'FontSize',fontsize);
        end
    end
    function ctrs=get_row_ctrs(obj)
        ctrs=zeros(obj.RC(1),1);
        for r = 1:obj.RC(1)
            i=sub2ind(obj.RC,r,1);
            ctrs(r)=obj.ctrs{i}(1);
        end
    end
    function ctrs=get_col_ctrs(obj)
        ctrs=zeros(obj.RC(2),1);
        for c = 1:obj.RC(2)
            i=sub2ind(obj.RC,1,c);
            ctrs(c)=obj.ctrs{i}(2);
        end
    end

    function wh=getCharWH(obj,txt,fontsize)
        nCharWH=obj.get_nCharWH(fontsize);
        wh=[numel(txt) 1]./nCharWH;
    end
end
methods(Hidden)
%- resize
    function resize(obj,src,event)
        if ~obj.bLockAxes
            %builtin('resize',src,event);
            return
        end

        obj.bResize=0;
        cl=tmpSet(obj,'bResize',1);

        obj.get_conversions();
        obj.get_margins();
        obj.selectAll();

        obj.fWH=obj.f.Position(3:4);
        obj.bFirst=true;
        for i = 1:obj.n
            obj.select(i);
            obj.ylabel();
            obj.xlabel();
            if obj.bYYlabels
                obj.yylabel();
            end
            cl2=tmpSet(obj,'bFirst',false);
        end

        if ~isempty(obj.rTitl.ax)
            obj.set_rlabel_axis_pos();
            obj.set_rlabel_tbox_pos();
        end
        if ~isempty(obj.cTitl.ax)
            obj.set_clabel_axis_pos();
            obj.set_clabel_tbox_pos();
        end
        if ~isempty(obj.tBTitl.ax)
            obj.set_tBTitl_axis_pos();
        end
    end
    function fitFont(obj)
        %Units
        %normalized
        %pixels
        %inches
        %centimeters
        %points
        %
        %PaperUnits
        %
        %PaperOrientation
        %
        %PaperType
        %'usletter' | 'uslegal' | 'tabloid' | 'a0' | 'a1' | 'a2' | 'a3' | 
        %
        %PaperUnits
        %'inches' | 'centimeters' | 'normalized' | 'points'
    end
    function fitWin(obj)
        fWH=obj.f.Position(3:4);
        o=fWH(1)./fWH(2);
        e=obj.aspectIdeal;

        if o > e
            w=e*fWH(2);
            obj.f.Position(3)=w;
        else
            33
            h=fWH(1)/e;
            h
            obj.f.Position(4)=h;
        end
    end
%- label
    %function label(obj,xLabel,yLabel,bCtrOnly,bByRow,bByCol)
    %    % OR BOTH
    %    % ON EACH LOOP LABEL
    %    if nargin < 2
    %        bCtrOnly=obj.bCtrOnly;
    %        xLabel=[];
    %        yLabel=[];
    %    end
    %    if nargin < 4
    %        bCtrOnly=[false false];
    %    end
    %    if nargin < 5
    %        bByRow=false;
    %    end
    %    if nargin < 6
    %        bByCol=false;
    %    end
    %    if numel(bCtrOnly)==1
    %        bCtrOnly=[bCtrOnly bCtrOnly];
    %    end
    %    obj.xlabel(xLabel,bCtrOnly(1),bByRow);
    %    obj.ylabel(yLabel,bCtrOnly(2),bByCol);
    %end
    %function rlabel(obj,txt,loc,lbl,nnewline)
    function rlabel(obj,txt)
        fontsize=obj.RCFontSize;
        ha=obj.rlabelHA;

        if nargin < 2 || isempty(txt)
            txt=obj.rlabels;
        end
        % AFTER LOOP
        if nargin < 3 || isempty(loc)
            loc=obj.rlabelLoc;
        end
        if nargin < 4 || isempty(lbl)
            lbl=obj.rlabelBase;
        end
        if nargin < 5 || isempty(nnewline)
            nnewline=obj.rNNewline;
        end

        [ctrs,va,rot]=obj.set_rlabel_axis_pos(loc);

        if nnewline==0
            nnew='';
        else
            nnew=repmat(newline,1,abs(nnewline));
        end

        bSup=false; % XXX

        for i = 1:length(ctrs)
            if ischar(txt)
                t=txt;
            elseif iscell(txt)
                t=txt{i};
            end
            if nnewline > 0
                va='bottom';
                t=[t nnew];
            else
                t=[nnew t];
            end

            t=['{\bf' t '}'];

            if bSup
                t=[newline t];
            end

            tpos=[0,ctrs(i)];
            if isempty(obj.rTitl.tbox{i})
                obj.rTitl.tbox{i}=text(tpos(1),tpos(2),t,...
                    'Units','normalized',...
                    'FontSize',fontsize,...
                    'HorizontalAlignment',ha,...
                    'VerticalAlignment',va);
                set(obj.rTitl.tbox{i},'Rotation',rot);
                %enableDefaultInteractivity(obj.rTitl.tbox{i});
            else
                obj.rTitl.tbox{i}.String=t;
            end
        end
        if ~isempty(lbl)
            obj.set_rlabelBase(lbl,rot,va);
        end
    end
    function clabel(obj,txt)
    %function clabel(obj,txt,loc,lbl,nnewline)
        % AFTER LOOP
        fontsize=obj.RCFontSize;
        ha=obj.clabelHA;

        if nargin < 2 || isempty(txt)
            txt=obj.clabels;
        end
        if nargin < 3 || isempty(loc)
            loc=obj.cLabelLoc;
        end
        if nargin < 4 || isempty(lbl)
            lbl=obj.clabelBase;
        end
        if nargin < 5 || isempty(nnewline)
            nnewline=obj.cNNewline;
        end

        [ctrs,va]=obj.set_clabel_axis_pos(loc);

        if nnewline==0
            nnew='';
        else
            nnew=repmat(newline,1,abs(nnewline));
        end

        bSup=false; % XXX


        for i = 1:length(ctrs)
            if ischar(txt)
                t=txt;
            elseif iscell(txt)
                t=txt{i};
            end
            if nnewline > 0
                t=[t nnew];
                va='bottom';
            else
                t=[nnew t];
            end

            t=['{\bf' t '}'];
            if bSup
                t=[newline t];
            end

            tpos=[ctrs(i),0];
            if Axis.isInvalid(obj.cTitl.tbox{i})
                obj.cTitl.tbox{i}=text(tpos(1),tpos(2),t,...
                    'Units','normalized',...
                    'FontSize',fontsize,...
                    'HorizontalAlignment',ha,...
                    'VerticalAlignment',va);
            else
                obj.cTitl.tbox{i}.String=t;
            end

        end
        if ~isempty(lbl)
            obj.set_clabelBase(lbl,va,rot);
        end
    end
    %function xlabel(obj,txt,bCtrOnly,bByRow,xedge,yedge)
    function xlabel(obj,txt)
        if nargin < 2
            bCtrOnly=obj.xlabelCtrOnly;
            txt='';
        end
        if nargin < 3 || isempty(bCtrOnly)
            bCtrOnly=obj.xlabelCtrOnly;
        end
        if nargin < 4 || isempty(bByRow)
            bByRow=obj.xlabelByRow;
        end
        if nargin < 5 || isempty(xedge)
            xedge=obj.xlabelXYEdge(1);
        end
        if nargin < 6 || isempty(yedge)
            yedge=obj.xlabelXYEdge(2);
        end

        I=obj.dimInfo(2,xedge,yedge);

        if (I.bBlankCtr && bCtrOnly)
            txt=' ';
        elseif I.bBlankBy & bByRow
            txt=' ';
        elseif isempty(txt)
            xl=get(gca,'XLabel');
            txt=xl.String;
        end

        i=sub2ind(obj.RC,obj.cur(1),obj.cur(2));
        c=obj.c(i);
        r=obj.r(i);
        w=obj.w(i);
        h=obj.get_marginN('xticksMargin');
        if I.bEvenCtr
            c=c+w/2-(obj.ml+obj.mr)/2;;
        end
        pos=[c r-h w h];

        if isempty(obj.xTitl.tbox)
            obj.xTitl.tbox=cell(obj.RC);
        end
        cl=tmpSet(obj.f,'CurrentAxes',gca);

        if isempty(obj.xTitl.tbox{i})

            % init ax
            obj.xTitl.ax{i}=axes('Position', pos,'Units','normalized','Color','None','XColor','None','YColor','None');

            set(obj.f,'CurrentAxes',obj.xTitl.ax{i});

            % init tbox
            obj.xTitl.tbox{i}=text(...
                 0.5,0,txt,...
                'Units','normalized',...
                'FontSize',obj.XYFontSize,...
                'HorizontalAlignment','center',...
                'VerticalAlignment','top');
        elseif obj.bResize
            set(obj.xTitl.ax{i},'Position',pos);
        else
            obj.xTitl.tbox{i}.String=txt;
        end

        delete(cl);
        if ~obj.bResize
            xlabel('');
        end
    end
    function ylabel(obj,txt)
    %function ylabel(obj,txt,bCtrOnly,bByCol,xedge,yedge)
        if nargin < 2
        %if nargin < 2 && obj.bResize
            txt='';
        end
        bCtrOnly=obj.ylabelCtrOnly;
        bByCol=obj.ylabelByCol;
        xedge=obj.ylabelXYEdge(1);
        yedge=obj.ylabelXYEdge(2);

        I=obj.dimInfo(1,xedge,yedge);

        if I.bBlankCtr & bCtrOnly
            txt=' ';
        elseif I.bBlankBy & bByCol
            txt=' ';
        end
        if isempty(txt)
            yl=get(gca,'YLabel');
            txt=yl.String;
        end


        % pos
        i=sub2ind(obj.RC,obj.cur(1),obj.cur(2));
        c=obj.c(i);
        r=obj.r(i);
        w=obj.get_marginN('yticksMargin');
        h=obj.h(i);
        if I.bEvenCtr
            r=r-h/2-(obj.mb+obj.mt)/2;
        end
        w
        pos=[c-w r w h];

        if isempty(obj.yTitl.tbox)
            obj.yTitl.tbox=cell(obj.RC);
        end
        cl=tmpSet(obj.f,'CurrentAxes',gca);

        if isempty(obj.yTitl.tbox{i})

            % init ax
            obj.yTitl.ax{i}=axes('Position', pos,'Units','normalized','Color','k','XColor','None','YColor','None');

            set(obj.f,'CurrentAxes',obj.yTitl.ax{i});

            % init tbox
            obj.yTitl.tbox{i}=text(...
                 0.5,0.5,txt,...
                'Units','normalized',...
                'FontSize',obj.XYFontSize,...
                'HorizontalAlignment','center',...
                'Rotation',90,...
                'VerticalAlignment','bottom');
        elseif obj.bResize
            set(obj.yTitl.ax{i},'Position',pos);
        else
            obj.yTitl.tbox{i}.String=txt;
        end

        delete(cl);
        if ~obj.bResize
            ylabel(''); % XXX SLOW
        end

    end
    %function yylabel(obj,txt,bCtrOnly,bByCol,xedge,yedge)
    function yylabel(obj,txt)
        if nargin < 2 && obj.bResize
            txt='';
        end
        if nargin < 3
            bCtrOnly=obj.bCtrOnly;
            xLabel=[];
        end
        if nargin < 4 || isempty(bCtrOnly)
            bCtrOnly=obj.yylabelCtrOnly;
        end
        if nargin < 5 || isempty(bByCol)
            bByCol=obj.yylabelByCol;
        end
        if nargin < 6 || isempty(xedge)
            xedge=obj.yylabelXYEdge(1);
        end
        if nargin < 7 || isempty(yedge)
            yedge=obj.yylabelXYEdge(2);
        end

        I=obj.dimInfo(3,xedge,yedge);
        %if obj.cur(1)==1 && obj.cur(2)==4
        %    I
        %end

        axset=false;
        if I.bBlankCtr & bCtrOnly
            txt=' ';
        elseif I.bBlankBy & bByCol
            txt=' ';
        else
            axset=true;
        end

        if ~(axset || I.bEvenCtr)
            return
        end

        % pos
        i=sub2ind(obj.RC,obj.cur(1),obj.cur(2));
        c=obj.c(i);
        r=obj.r(i);
        W=obj.w(i);
        w=obj.get_marginN('yticksMargin');
        h=obj.h(i);
        if I.bEvenCtr
            r=r-h/2-(obj.mb+obj.mt)/2;
        end
        pos=[c+W+w r w h];

        if isempty(obj.yyTitl.tbox)
            obj.yyTitl.tbox=cell(obj.RC);
        end
        cl=tmpSet(obj.f,'CurrentAxes',gca);

        if isempty(obj.yyTitl.tbox{i})

            % init ax
            obj.yyTitl.ax{i}=axes('Position', pos,'Units','normalized','Color','None','XColor','None','YColor','None');

            set(obj.f,'CurrentAxes',obj.yyTitl.ax{i});

            % init tbox
            obj.yyTitl.tbox{i}=text(...
                 -0.5,0.5,txt,...
                'Units','normalized',...
                'FontSize',obj.XYFontSize,...
                'HorizontalAlignment','center',...
                'Rotation',270,...
                'Color',obj.yylabelColor,...
                'VerticalAlignment','bottom');
        elseif obj.bResize
            set(obj.yyTitl.ax{i},'Position',pos);
        else
            obj.yyTitl.tbox{i}.String=txt;
        end

    end
    function title(obj,txt,lbl)
        if nargin < 2 || (isempty(txt) && ~ischar(txt))
            txt=obj.titles{obj.cur};
        end
        if nargin < 3 || (isempty(lbl) && ~ischar(lbl))
            lbl=obj.titleBase;
        end

        if ~obj.titleByRow || (obj.titleByRow && obj.cur(1)==1)
            title(txt);
            if ~isempty(lbl)
                obj.set_titleBase(lbl);
            end
        else
            title('');
        end
    end
%- ticks
    %function xticks(obj,xtiks,xedge,inds)
    %    % NOTE DO AFTER XLIM
    %    if nargin < 3 || isempty(xedge)
    %        xedge=obj.xlabelXYEdge(1);
    %    end
    %    bInds=nargin >= 4 && ~isempty(inds);

    %    if nargin >= 2 && ~isempty(xticks)
    %        xticks(xtiks);
    %        if bInds
    %            lbls=xticklabels;
    %            binds=false(size(lbls));
    %            binds(inds)=true;
    %            lbls(~binds)={''};
    %            xticklabels(lbls);
    %        end
    %    end
    %    if obj.cur(1)~=(obj.RC(1)-(xedge-1))
    %        l=xticklabels;
    %        xticklabels(repmat({''},length(l),1));
    %    end
    %end
    function xticks(obj,xtiks,indsORlbls)
        % NOTE DO AFTER XLIM

        % xticks
        if nargin < 2 || isempty(xtiks)
            xtiks=xticks();
        end

        % xedge
        xedge=obj.xlabelXYEdge(1);

        % lbls
        if nargin < 3 || isempty(indsORlbls)
            lbls=xticklabels();
        elseif isnumeric(indsORlbls)
            lbls=xticklabels();
            inds=indsORlbls;
            binds=false(size(lbls));
            binds(inds)=true;
            lbls(~binds)={''};
        else
            lbls=indsORlbls;
        end


        % ticks
        xticks(xtiks);

        % labels
        if obj.xlabelByRow && obj.cur(1)~=obj.RC(1)-(xedge-1)
            xticklabels(repmat({''},length(lbls),1));
        else
            xticklabels(lbls);
        end
    end
    function yticks(obj,ytiks,indsORlbls)
        % NOTE DO AFTER YLIM

        % yticks
        if nargin < 2 || isempty(ytiks)
            ytiks=yticks();
        end

        % yedge
        yedge=obj.ylabelXYEdge(2);

        % lbls
        if nargin < 3 || isempty(indsORlbls)
            lbls=yticklabels();
        elseif isnumeric(indsORlbls)
            lbls=yticklabels();
            inds=indsORlbls;
            binds=false(size(lbls));
            binds(inds)=true;
            lbls(~binds)={''};
        else
            lbls=indsORlbls;
        end


        % ticks
        yticks(ytiks);

        % labels
        if obj.ylabelByCol && obj.cur(2)~=yedge
            yticklabels(repmat({''},length(lbls),1));
        else
            yticklabels(lbls);
        end
    end
    function yyticks(obj,ytiks,yedge,inds)
        % NOTE DO AFTER YLIM
        cl=onCleanup(@() yyaxis('left'));
        yyaxis right;

        if nargin < 3 || isempty(yedge)
            yedge=obj.RC(2)-obj.yylabelXYEdge(2)+1;
        end
        bInds=nargin >= 4 && ~isempty(inds);

        if nargin >= 2 && ~isempty(ytiks)
            yticks(ytiks);
            if bInds
                lbls=yticklabels;
                binds=false(size(lbls));
                binds(inds)=true;
                lbls(~binds)={''};
                yticklabels(lbls);
            end
        end

        if obj.cur(2)~=yedge
            l=yticklabels;
            yticklabels(repmat({''},length(l),1));
        end
    end
%- SupTitle
    function supTitle(obj,varargin)
        obj.suptitle(varargin{:});
    end
    function subtitle(obj,txt,fontsize,loc)
        if nargin < 2 || isempty(txt)
            txt=obj.subTxt;
        end
        if isempty(txt)
            return
        end
        if nargin < 3 || isempty(fontsize)
            fontsize=obj.supFontSize;
        end
        if nargin < 4 || isempty(loc)
            loc=obj.supLoc;
        end
        if Axis.isInvalid(obj.uTitl.ax)
            obj.uTitl.ax=axes();
        else
            axes(obj.uTitl.ax);
        end
        switch loc
            case 'top'
                pos=[0, 1, 1, 0];
                ha='Center';
                va='top';
                tpos=[0.5 1];
            case 'topleft'
                pos=[0, 1, 1, 0];
                ha='Left';
                va='top';
                tpos=[0.01 0];
            case 'bottom'
                pos=[0, 0, 1, 0];
                ha='Center';
                va='bottom';
                tpos=[0.5,0];
            case 'bottomleft'
                pos=[0, 0, 1, 0];
                ha='Left';
                va='bottom';
                tpos=[0.01,0];
        end
        if Axis.isInvalid(obj.uTitl.tbox)
            set(obj.uTitl.ax,...
                'Position',pos,...
                'Color','None',...
                'XColor','None',...
                'YColor','None');

            obj.uTitl.tbox=text(tpos(1),tpos(2),txt,...
                'FontSize',fontsize,...
                'HorizontalAlignment',ha,...
                'VerticalAlignment',va ...
            );
        else
            set(obj.uTitl.tbox,...
                'String',txt,'FontSize',fontsize,...
                'HorizontalAlignment',ha,...
                'VerticalAlignment',va);

            set(obj.uTitl.ax,'Position',pos);
        end
        function axisfun(obj,varargin)
            cellfun(fun,obj.axis,varargin{:});
        end
    end
    function suptitle(obj,txt,fontsize,loc)
        if nargin < 2 || isempty(txt)
            txt=obj.supTxt;
        end
        if isempty(txt)
            return
        end
        if nargin < 3 || isempty(fontsize)
            fontsize=obj.supFontSize;
        end
        if nargin < 4 || isempty(loc)
            loc=obj.supLoc;
        end
        if Axis.isInvalid(obj.sTitl.ax)
            obj.sTitl.ax=axes();
        else
            axes(obj.sTitl.ax);
        end
        switch loc
            case 'top'
                pos=[0, 1, 1, 0];
                ha='Center';
                va='top';
                tpos=[0.5 1];
            case 'topleft'
                pos=[0, 1, 1, 0];
                ha='Left';
                va='top';
                tpos=[0.01 0];
            case 'bottom'
                pos=[0, 0, 1, 0];
                ha='Center';
                va='bottom';
                tpos=[0.5,0];
            case 'bottomleft'
                pos=[0, 0, 1, 0];
                ha='Left';
                va='bottom';
                tpos=[0.01,0];
        end
        if Axis.isInvalid(obj.sTitl.tbox)
            set(obj.sTitl.ax,...
                'Position',pos,...
                'Color','None',...
                'XColor','None',...
                'YColor','None');

            obj.sTitl.tbox=text(tpos(1),tpos(2),txt,...
                'FontSize',fontsize,...
                'HorizontalAlignment',ha,...
                'VerticalAlignment',va ...
            );
        else
            set(obj.sTitl.tbox,...
                'String',txt,'FontSize',fontsize,...
                'HorizontalAlignment',ha,...
                'VerticalAlignment',va);

            set(obj.sTitl.ax,'Position',pos);
        end
        function axisfun(obj,varargin)
            cellfun(fun,obj.axis,varargin{:});
        end
    end
    %function obj=get_margins(obj)
    %end

end
methods(Static)
    function test2()
        close all;
        o=SubPlot([8,3]);
        o.selectAll;
        o.suptitle('this1',[],'top');
        o.suptitle('this2',[],'bottom');
    end
    function test()
        close all;
        o=SubPlot([8,3]);
        %o.iMargin=[0 0 0 0];
        o.sel([8,1]);
        plot(3,3);

        o.sel([8,2]);
        plot(3,3);

        o.sel([8,3]);
        plot(3,3);

        o.sel([7,3]);
        plot(3,3);

        o.sel([1,2],1,1);
        plot(8,8);

        o.suptitle('this');


        %o.sel([3,2],2,2)
        %plot(8,8)
    end
end
end
