classdef SubPlot < handle & ChildSetter & SubPlot_AxesL & SubPlot_Tests_

%: special props
%:   bZ
%:   bYY
%:
%:  xBy
%:  yCtr
properties
    f
    n

    %- size
    RC

    %- shift
    % XXX rename to rc?
    xedge
    yedge
    yyedge
    zedge

    %- select (RO)
    cur
    i
    axis

    %- Figure
    aspectR
    bHold
    bSelectAll=false
    bLockAxes=true
    bgColor
    bZ % XXX
    bYY
    bC

    %- MARGIN
    iUnits
    oUnits

    %- margin
    iMargin
    oMargin
    %
    uMargin
    sMargin
    %
    lMargin
    rMargin
    tMargin
    bMargin
    %
    xMargin
    yMargin
    xxMargin
    yyMargin
    cMargin
    %
    xtMargin
    ytMargin
    xxtMargin
    yytMargin
    ztMargin
    ctMargin

    % XXX RM?
    tMarginB % top or bottom
    rMarginB % left or right
    xxMarginB

    %- Flag
    sOn
    uOn
    %
    lOn
    rOn
    tOn
    bOn
    %
    xOn
    yOn
    xxOn
    yyOn
    zOn
    cOn
    %
    xtOn
    ytOn
    xxtOn
    yytOn
    ztOn
    ctOn

    %- By
    % NOTE GENERAL IF OTHERS ARE EMPTY
    xBy
    yBy
    xxBy
    yyBy
    zBy
    cBy

    xtBy
    ytBy
    xxtBy
    yytBy
    ztBy
    ctBy

    %- bCtr
    % NOTE GENERAL IF OTHERS ARE EMPTY
    xCtr
    yCtr
    xxCtr
    yyCtr
    zCtr
    cCtr

    xtCtr
    ytCtr
    xxtCtr
    yytCtr
    ctCtr


   %- plot axes properties
    lineWidth
    tickLength
    fontSize
    fontWeight
    bBox
    %
    xScale
    yScale
    yyScale
    zScale
    %
    xColor
    yColor
    yyColor
    zColor
    %
    xDir
    yDir
    yyDir
    zDir
    cDir
    %
    ylims
    yylims
    xlims
    zlims
    clims
    %
    xt
    yt
    yyt
    zt
    ct
    %
    xtTxt
    xxtTxt
    ytTxt
    yytTxt
    ztTxt
    ctTxt

    %- General/Fallback
    SUFontSize
    RCFontSize
    XYFontSize
    ticksFontSize


end
properties(SetObservable)
    % TXT
    sTxt
    uTxt
    %
    rTxt %row/right
    lTxt %left row
    tTxt %ctr/col
    bTxt
    %
    xTxt
    yTxt
    xxTxt
    yyTxt
    zTxt
    cTxt
    %
    lTxtB
    rTxtB
    tTxtB
    bTxtB

    % LOC
    sLoc % top*
    uLoc % bottom*
    % others are intrinsic

    % Color
    yTxtColor
    yyTxtColor

    % fonts
    sFontSize
    uFontSize
    %
    tFontSize
    bFontSize
    rFontSize
    lFontSize
    %
    xFontSize
    yFontSize
    xxFontSize
    yyFontSize
    cFontSize
    %
    xtFontSize
    ytFontSize
    xxtFontSize
    yytFontSize
    ctFontSize



end
properties(Hidden)

    bTest
    initFlag=1
    Rs
    Cs
    Ws
    Hs


    %- plot axes
    AX0
    ax
    axl % lines
    axb % background
    axc % colorbar
    axib % innerbackground
    axibp % innerbackground plot
    bVisible

    %- Label axes
    %tTitl=struct('loc',[],'ax',[],'tbox',[]); NOTE unused

    % converstions
    fWH
    paperWH
    nCharWH_T
    nLineWH_T
    nPixWH_T
    defFontSize

    % bFlags
    bYY_
    bC_
    bZ_
    bS_
    bU_
    lOn_
    rOn_
    tOn_
    bOn_
    yyOn_
    xxOn_
    xOn_
    yOn_
    xtOn_
    ytOn_
    yytOn_
    xxtOn_

    titleBasePos_

    % Dim info
    D

    % flds
    flds
    AFlds
    revFlds
    nRevFlds
    topFlds
    botFlds
    rightFlds
    leftFlds

    bFlds
    rFlds
    lFlds
    aFlds

    bRev
    bNRev
    bLR
    bBy
    bInner

    % Margins
    oM0
    iM0
    iM0f
    oM0f
    iM0n
    oM0n
    oM
    iM

    m0
    MC0
    m  % length of padding pre-margin
    MC % length of margin


    % pos
    Pos
    pos
    pos0
    Pos0
    %
    %
    oPosT
    iPosT


    % edges
    WH
    Edges
    Ctrs

    aspectIdeal
end
properties(Hidden)
    bResize=0
    bFirst=true
    % updateLegendMenuToolbar
end
properties(Constant)
    IMARGIN_NORM_DEF=[0.13 0.02 0.225 0.185]; % LRTB
    OMARGIN_NORM_DEF=[0.02 0.02 0.02 0.09]; % LRTB
end
methods(Static)
    function P=getP()
        bB='Num.isBinary';
        bBE='Num.isBinary_e';
        bN='Num.is';
        bNE='Num.is_e';
        bCE='ischar_e';

        P={...
            %- FIGURE
           'bTest',false,bBE;
           'bYY',[],'';
           'bZ',[],'';
           'bC',[],'';
           'bHold',false,'';
           'bgColor',[1 1 1],'';
           'bSelectAll',false,'';
           'bLockAxes',true,'';
           %'aspectR',.75,bB;
           'aspectR',1,bB;

           'iUnits','char',bCE;
           'oUnits','char',bCE;

           %% - shift
           'xedge', [1 1],bN;
           'yedge', [1 1],bN;
           'yyedge',[1 1],bN;

           %% By
           'xBy',true,bB;
           'yBy',true,bB;
           'xxBy',true,bB;
           'yyBy',true,bB;
           'cBy',true,bB;
           %
           'xtBy',[],bBE;
           'ytBy',[],bBE;
           'xxtBy',[],bBE;
           'yytBy',[],bBE;
           'ctBy',[],bBE;

           %% Ctr
           'xCtr',true,bB;
           'yCtr',true,bB;
           'xxCtr',true,bB;
           'yyCtr',true,bB;
           'cCtr',true,bB;
           %
           'xtCtr',[],bBE;
           'ytCtr',[],bBE;
           'xxtCtr',[],bBE;
           'yytCtr',[],bBE;
           'ctCtr',[],bBE;

           %% - Margin
           'iMargin',[],'';
           'oMargin',[],'';

           'uMargin',1,bN;
           'sMargin',1,bN;
           %
           'tMargin',1,bN;
           'bMargin',1,bN;
           'lMargin',1,bN;
           'rMargin',1,bN;
           %
           'xMargin',1,bN;
           'yMargin',1,bN;
           'yyMargin',1,bN;
           'xxMargin',1,bN;
           'cMargin',1,bN;
            %
           'xtMargin',1,bN;
           'ytMargin',1,bN;
           'yytMargin',1,bN;
           'ztMargin',1,bN;
           'ctMargin',1,bN;


           % RM?
           'tMarginB',0,bN;
           'rMarginB',0,bN;
           'xxMarginB',0,bN;

           %- Labels
           %%  Flags
           'sOn',false,bB;
           'uOn',false,bB;
           %
           'lOn',[],bB;
           'rOn',[],bB;
           'tOn',[],bB;
           'bOn',[],bB;
           %
           'xOn',[],bB;
           'yOn',[],bB;
           'xxOn',[],bB;
           'yyOn',[],bB;
           'zOn',[],bB;
           'cOn',[],bB;
           %
           'xtOn',true,bB;
           'ytOn',true,bB;
           'xxtOn',[],bB;
           'yytOn',[],bB;
           'ctOn',[],bB;

           %% txt
           'sTxt',[],'';
           'uTxt',[],'';
           %
           'lTxt' ,[],'';
           'rTxt' ,[],'';
           'tTxt' ,[],'';
           'bTxt' ,[],'';
           %
           'xTxt' ,[],'';
           'yTxt' ,[],'';
           'xxTxt',[],'';
           'yyTxt',[],'';
           'cTxt',[],'';

           %% base txt
           'lTxtB',[],'';
           'rTxtB',[],'';
           'tTxtB',[],'';
           'bTxtB',[],'';

           %% fontsize
           'sFontSize',[],'';
           'uFontSize',[],'';
           'tFontSize',[],'';
           'bFontSize',[],'';
           'lFontSize',[],'';
           'rFontSize',[],'';
           'xFontSize',[],'';
           'yFontSize',[],'';
           'cFontSize',[],'';

           %% fallback fontsizes
           'SUFontSize',40,'';
           'RCFontSize',22,'';
           'XYFontSize',22,'';
           'ticksFontSize',18,'';

           %% txt loc
           'sLoc','top','';
           'uLoc','bottom','';

           %- plot axes
           'lineWidth',2,'';
           'tickLength',[0.03, 0.02],'';
           'fontSize',18,'';
           'fontWeight','normal','';
           'bBox',true,'';
           %
           'xScale','linear','';
           'yScale','linear','';
           'yyScale','linear','';
           'zScale','linear','';
           %
           'xColor',  [0 0 0],'';
           'yColor',  [0 0 0],'';
           'yyColor', [0 0 0],'';
           'zColor',  [0 0 0],'';
           %
           'xDir', 'normal','';
           'yDir', 'normal','';
           'yyDir', 'normal','';
           'zDir', 'normal','';
           'cDir', 'normal','';
           %
           'ylims',[],'';
           'yylims',[],'';
           'xlims',[],'';
           'zlims',[],'';
           'clims',[],'';
           %
           'yt',[],'';
           'yyt',[],'';
           'xt',[],'';
           'zt',[],'';
           'ct',[],'';
           %
           'ytTxt',[],'';
           'yytTxt',[],'';
           'xtTxt',[],'';
           'ztTxt',[],'';
           'ctTxt',[],'';

        };
    end
end
methods
    function obj=SubPlot(varargin)
        obj.get_flds();
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
            RC=[N{1}];
            %N(1)=[];
        elseif n > 1
            RC=N{1:2};
            %N(1:2)=[];
        end

        obj.parse(varargin{:});
        obj.init(RC);
        assignin('base','SP',obj);
    end
    function init(obj,RC)
        if nargin < 2 || isempty(RC)
            RC=obj.RC;
        end

        % figure
        obj.f=gcf;
        if ~obj.bHold
            clf;
        end
        set(obj.f,'SizeChangedFcn',@obj.resize_);

        % hidden main axis
        obj.AX0=gca;
        axis off;

        % all other axes
        obj.RC=RC;

        %obj.fitWin();
    end
    function init_children(obj)
        obj.get_dimInfo();
        obj.get_geometry();

        obj.set_background();
        if obj.bTest
            obj.set_ibackground();
        end
        obj.init_axes();
        obj.init_AL();
    end
    function set.RC(obj,val)
        obj.RC=val;
        obj.n=prod(obj.RC);
        [obj.Rs,obj.Cs]=ind2sub(obj.RC,(1:obj.n)');

        obj.Hs=ones(obj.n,1);
        obj.Ws=ones(obj.n,1);

        obj.init_children();
    end
    function get_dimInfo(obj)
        [n,m]=ind2sub(obj.RC,(1:obj.n)');
        curs=[n,m];
        z=zeros(obj.RC);
        o=ones(obj.RC);

        T=struct();
        T.xBy=z;
        T.yBy=z;
        T.yyBy=z;
        [X,Y]=meshgrid(1:obj.RC(2),1:obj.RC(1));


        xedge=obj.xedge;
        yedge=obj.yedge;
        yyedge=obj.yyedge;

        % By
        T.xBy(xedge(2),:)=true;
        T.yBy(:,yedge(1))=true;
        T.yyBy(:,yyedge(1))=true;
        T.xBy=  T.xBy  & (X >= obj.xedge(1));
        T.yBy=  T.yBy  & (Y >= obj.yedge(2));
        T.yyBy= T.yyBy & (Y >= obj.yyedge(2));
        T.xBy=flipud(T.xBy);
        T.yyBy=fliplr(T.yyBy);
        T.cBy=T.yyBy;

        T.xtBy=T.xBy;
        T.ytBy=T.yBy;
        T.yytBy=T.yyBy;
        T.ctBy=T.cBy;

        % XXX
        bYMod=true;
        bXMod=true;

        % Ctr
        r=mod(obj.RC,2)==0;
        if bYMod || r(1)
            T.yCtr=Y==obj.RC(1);
            T.yyCtr=Y==obj.RC(1);
        else
            T.yCtr=Y==ceil(obj.RC(1)/2);
            T.yyCtr=Y==ceil(obj.RC(1)/2);
        end
        T.cCtr=Y==1;
        if bXMod || r(2)
            T.xCtr=X==1;
        else
            T.xCtr=X==ceil(obj.RC(2)/2);
        end
        T.xtCtr=T.xCtr;
        T.ytCtr=T.yCtr;
        T.yytCtr=T.yyCtr;
        T.ctCtr=T.cCtr;


        obj.D=struct();
        flds={'x','y','yy','c',...
              'xt','yt','yyt','ct'};
        eind=[2 1 1 1 ...
              2 1 1 1];

        for i = 1:length(flds)
            fld=flds{i};
            bFld=[fld 'By'];
            cFld=[fld 'Ctr'];
            oFld=[fld 'On'];
            OFld=[fld 'On_'];
            eFld=[fld 'Even'];

            % general flag
            By_=obj.get_bBy(fld);
            Ctr_=obj.get_bCtr(fld);
            obj.D.(OFld)=By_ || Ctr_;

            % combine
            obj.D.(bFld)= T.(bFld) | (~By_ * o);
            obj.D.(cFld)= T.(cFld) | (~Ctr_ * o);
            obj.D.(oFld)=obj.D.(bFld) & obj.D.(cFld);


            % even
            obj.D.(eFld)=r(eind(i)) & Ctr_;
        end

    end
end
methods(Access=protected)
    function get_geometry(obj)

        % init
        obj.get_conversions();
        obj.get_margins();

        obj.get_positions();
        obj.get_WHs();
        obj.get_edges();
        obj.get_ctrs();
    end
    function init_axes(obj);
        obj.ax=cell(obj.n,1);
        obj.axc=cell(obj.n,1);
        obj.bVisible=false(obj.n,1);
        bYY_=obj.bYY_;
        bZ_=obj.bZ_;
        bC_=obj.bC_;

        % main axes
        if obj.bZ_
            args={...
                  'ZDir',obj.zDir,...
                  'ZScale',obj.zScale,...
                  'ZColor',obj.zColor ...
            };
        else
            args={};
        end
        yyargs={};
        cargs={};

        % LIMS
        if ~isempty(obj.ylims)
            args=['YLim',obj.ylims,'YLimMode','manual'];
        end
        if ~isempty(obj.xlims)
            args=['XLim',obj.xlims,'XLimMode','manual'];
        end
        if ~isempty(obj.zlims)
            args=['ZLim',obj.zlims,'ZLimMode','manual'];
        end
        if ~isempty(obj.yylims)
            yargs=['YLim',obj.yylims,'ZLimMode','manual'];
        end
        if ~isempty(obj.clims)
            cargs=['Limits',obj.clims,'LimitsMode','manual'];
        end

        % TICKS
        if ~isempty(obj.yt)
            args=[args 'YTick',obj.yt,'YTickMode','manual'];
            yBlnk=repmat({''},1,numel(obj.yt));
            yt=cellfun(@num2str,num2cell(obj.yt));
        else
            yt=obj.ytTxt;
        end
        if ~isempty(obj.xt)
            args=[args 'XTick',obj.xt,'XTickMode','manual'];
            xBlnk=repmat({''},1,numel(obj.xt));
            xt=cellfun(@num2str,num2cell(obj.xt));
        else
            xt=obj.xtTxt;
        end

        if ~isempty(obj.zt)
            args=[args 'ZTick',obj.zt,'ZTickMode','manual'];
            zBlnk=repmat({''},1,numel(obj.zt));
            zt=cellfun(@num2str,num2cell(obj.zt));
        elseif obj.bZ_
            zt=obj.ztTxt;
        else
            zt=[];
        end

        if ~isempty(obj.yyt)
            yyargs=[yyargs 'YTick',obj.yyt,'YTickMode','manual'];
            yyBlnk=repmat({''},1,numel(obj.yyt));
            yyt=cellfun(@num2str,num2cell(obj.yyt));
        elseif bYY_
            yyt=obj.yytTxt;
        else
            yyt=[];
        end
        if ~isempty(obj.ct)
            crgs=[cargs 'Ticks',obj.yyt,'TicksMode','manual'];
            cBlnk=repmat({''},1,numel(obj.yyt));
            ct=cellfun(@num2str,num2cell(obj.yyt));
        elseif bC_
            ct=obj.cTxt;
        else
            ct=[];
        end

        % XXX
        % xtick/ytick
        % ytTxt/ytTxt
        % callback


        bY=obj.get_b('yt');
        bX=obj.get_b('xt');
        bYY=obj.get_b('yyt');
        bC=obj.bC_;
        D=obj.D;

        for i = 1:obj.n

            %% left
            sargs={};
            % ytTxt
            if D.ytOn_ && D.ytOn(i)
                if ~isempty(yt)
                    sargs=[sargs,'YTickLabelMode','manual','YTickLabel',yt];
                end
                if D.ytEven
                end
            elseif D.ytOn_
                sargs=[sargs,'YTickLabelMode','manual','YTickLabel',{[]}];
            end
            % xtTxt
            if D.xtOn_ && D.xtOn(i)
                if ~isempty(xt)
                    sargs=[sargs,'XTickLabelMode','manual','XTickLabel',xt];
                end
                if D.xtEven
                end
            elseif D.xtOn_
                sargs=[sargs,'XTickLabelMode','manual','XTickLabel',{[]}];
            end
            % cTxt



            obj.ax{i}=axes(...
                           'Units','normalized',...
                           'Position',obj.Pos.i(i,:),...
                           'LineWidth',obj.lineWidth,...
                           'TickLength',obj.tickLength,...
                           'FontSize',obj.ticksFontSize,...
                           'FontWeight',obj.fontWeight,...
                           'XScale',obj.xScale,...
                           'YScale',obj.yScale,...
                           'XColor',obj.xColor,...
                           'YColor',obj.yColor,...
                           'Box',obj.logical2onoff(obj.bBox),...
                           ...
                           'Visible',obj.logical2onoff(obj.bSelectAll),...
                           'NextPlot','replaceChildren',...
                           args{:}, ...
                           sargs{:}...
            );
            %enableDefaultInteractivity(obj.ax{i});

            sargs={};
            % ctTxt
            if bC
                if D.ctOn_ && D.ctOn(i)
                    if ~isempty(xt)
                        sargs=[sargs,'TickLabelsMode','manual','TickLabels',ct];
                    end
                    if D.xtEven
                    end
                elseif D.xtOn_
                    sargs=[sargs,'TickLabelsMode','manual','XTickLabels',{[]}];
                end

                if (D.ctOn_ && D.ctOn(i)) || (D.cOn_ && D.cOn(i))
                    obj.axc{i}=colorbar(...
                        'AxisLocation','in',...
                        'Position',obj.Pos.c(i,:),...
                        cargs{:}...
                    );
                    obj.axc{i}.YAxisLocation='right';
                end
            end

            %% right
            if ~bYY
                continue;
            end
            sargs={};

            if D.yytOn_ && D.yytOn(i)
                if ~isempty(yyt)
                    sargs=[sargs,'YTickLabelMode','manual','YTickLabel',yyt];
                end
                if D.yytEven
                end
            elseif D.yytOn_
                sargs=[sargs 'YTickLabelMode','manual','YTickLabel',{[]}];
            end

            yyaxis('right');
            obj.ax{i}.YScale=obj.yyScale;
            obj.ax{i}.YColor=obj.yyColor;
            obj.ax{i}.YDir=obj.yyDir;
            if ~isempty(yyargs) || ~isempty(sargs)
                set(obj.ax{i},yyargs{:},sargs{:});
            end
            yyaxis('left');
            obj.ax{i}.YColor=obj.yColor;
        end
    end
    function set_background(obj)
        pos=obj.Pos.oT;
        if Axis.isInvalid(obj.axb)
            if isempty(obj.bgColor)
                bgColor='none';
                bbox='off';
            else
                bgColor=obj.bgColor;
                bbox='on';
            end
            obj.axb=axes(...
                'Units','normalized',...
                'Position',pos,...
                'Visible','on',...
                'YColor','none',...
                'XColor','none',...
                'YTick',[],...
                'XTick',[],...
                'Color',bgColor,...
                'Box',bbox...
            );
        else
            set(obj.axb,'Position',pos);
        end
    end
    function set_ibackground(obj)
        pos=obj.Pos.iT;
        if Axis.isInvalid(obj.axib)
            obj.axib=axes(...
                'Units','normalized',...
                'Position',pos,...
                'Visible','on',...
                'YTick',[],...
                'XTick',[],...
                'Color','green',...
                'Box','on'...
            );
        else
            set(obj.axib,'Position',pos);
        end

        pos=obj.Pos.iTp;
        if Axis.isInvalid(obj.axibp)
            obj.axibp=axes(...
                'Units','normalized',...
                'Position',pos,...
                'Visible','on',...
                'YTick',[],...
                'XTick',[],...
                'Color','red',...
                'Box','on'...
            );
        else
            set(obj.axibp,'Position',pos);
        end

    end
    function set_linesd(obj);
        ind=sub2ind(obj.RC,obj.RC(end,1),1);
        pos=obj.Pos.o(ind,:);
        if isempty(obj.axl)
            obj.axl{1}=axes(...
                'Units','normalized',...
                'Position',pos,...
                'Visible','on'...
            )
        else
            set(obj.axl{1},'Position',pos);
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

        %% MARGINS
        % iunits
        def=cell(2,1);
        switch Opts.iUnits
            case {'normalized','norm','normal'}
                Opts.iUnits='normalized';
                def{1}=obj.IMARGIN_NORM_DEF;
            case {'characters','char'}
                Opts.iUnits='characters';
                def{1}=repmat(obj.fontSize,1,4);
        end
        switch Opts.oUnits
            case {'normalized','norm','normal'}
                Opts.oUnits='normalized';
                def{2}=obj.OMARGIN_NORM_DEF;
            case {'characters','char'}
                Opts.oUnits='characters';
                def{2}=[0 0 0 0];
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

        flds=fieldnames(Opts);
        for i =1 :length(flds)
            fld=flds{i};
            val=Opts.(fld);
            if isempty(val)
                continue
            end
            obj.(fld)=val;
        end
    end
end
methods
%- GETTERS
    function out=get.bYY_(obj)
        if ~isempty(obj.bYY)
            out=obj.bYY;
        else
            out=obj.get_b('yy') || obj.get_b('yyt');
        end
    end
    function out=get.bC_(obj)
        if ~isempty(obj.bC)
            out=obj.bC;
        else
            out=obj.get_b('c') || obj.get_b('ct');
        end
    end
    function out=get.bZ_(obj)
        % XXX
        % need also to create z lable properties
        out=false; % XXX

        if ~isempty(obj.bZ)
            out=obj.bZ;
        else
            out=obj.get_b('z') || obj.get_b('zt');
        end
    end
    function sel(obj,varargin)
        obj.select(varargin{:});
    end
%- select
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
        obj.select(n,m);
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
            h=[];
            w=[];
        end
        obj.select_(r,c,h,w,true);
    end
    function select_(obj,r,c,h,w,bPub)
        if nargin < 4 || isempty(h)
            h=1;
        end
        if nargin < 5 || isempty(w)
            w=1;
        end
        if nargin < 6 || isempty(bPub)
            bPub=false;
        end

        obj.cur=[r c];
        obj.i=sub2ind(obj.RC,r,c);

        obj.axis=obj.ax{obj.i};
        if  bPub
            set(obj.f,'CurrentAxes',obj.axis); % XXX SLOW 2
        end
        if ~obj.bVisible(obj.i)
            set(obj.axis,'Visible','on');
        end
    end
    function draw(obj)
        for i = 1:obj.n
            set(obj.ax{i},'Visible','on');
            obj.bVisible=true;
        end
    end
end
methods(Access=protected)
%- Postition
    function get_conversions(obj)
        fld='Position';

        set(obj.f,'Units','normalized');
        obj.fWH=obj.f.(fld)(3:4);

        obj.paperWH=obj.f.OuterPosition(3:4);

        %fld='Position';
        tmpSet(obj.f,'Units','characters');
        nCharW=obj.f.(fld)(3); % width in char widht, height in line width
        nLineH=obj.f.(fld)(4);

        set(obj.f,'Units','pixels');
        obj.nPixWH_T=obj.f.(fld)(3:4);

        obj.defFontSize=get(groot,'defaultuicontrolFontSize');

        pixPerChar=obj.nPixWH_T(1)./nCharW;
        pixPerLine=obj.nPixWH_T(2)./nLineH;
        nCharH=obj.nPixWH_T(2)./pixPerChar;
        nLineW=obj.nPixWH_T(1)./pixPerLine;
        obj.nLineWH_T=[nLineW nLineH];
        obj.nCharWH_T=[nCharW nCharH];

        %obj.nCharWH   =(charWH.* obj.defFontSize./obj.fontSize);
        %obj.nCharWH   =([1 1] ./ obj.defFontSize);
        %obj.nCharWH_rev=obj.nPixWH.*fliplr(obj.nCharWH_RC./obj.nPixWH);

    end
    function get_positions(obj)
        obj.normalize_margins();

        aP=obj.paperWH(1)/obj.paperWH(2);
        aF=obj.fWH(1)./obj.fWH(2);
        %R=aP./aF*obj.aspectR;
        R=obj.aspectR*0.84;
        %R=obj.aspectR;

        fWH=obj.fWH;

        P=struct();
        [P.i,P.o,P.iT,P.oT,P.iTm]=obj.get_crwh0(obj.RC, obj.Rs,obj.Cs, obj.oM,obj.iM, fWH,R);

        oMN=obj.get_marginN('oM');
        P.iTp=P.iT;
        P.iT(1)=P.iT(1)+oMN(1);
        P.iT(2)=P.iT(2)+oMN(4);

        P.c=P.i;
        P.c(:,1)=P.c(:,1)+P.c(:,3)+obj.m.yyt;
        P.c(:,3)=obj.m.c;
        obj.Pos=P;

        iFWH=fWH.*obj.Pos.iT(3:4);
        obj.aspectIdeal=iFWH(1)/iFWH(2);


    end
    function get_WHs(obj)
        WH=struct();
        P=obj.Pos;
        WH.iC=unique(P.i(:,3),'stable');
        WH.iR=unique(P.i(:,4),'stable');
        WH.oC=unique(P.o(:,3),'stable');
        WH.oR=unique(P.o(:,4),'stable');
        WH.oCT=P.oT(3);
        WH.oRT=P.oT(4);

        obj.WH=WH;
    end
    function get_edges(obj)
        E=struct();
        P=obj.Pos;
        E.i=pos2edges(P.i);
        E.o=pos2edges(P.o);
        E.iT=pos2edges(P.iT);
        E.iTp=pos2edges(P.iT);
        E.oT=pos2edges(P.oT);
        E.iTm=pos2edges(P.iTm);

        obj.Edges=E;
        function edges=pos2edges(Pos)
            edges=[Pos(:,1) Pos(:,1)+Pos(:,3) Pos(:,2)+Pos(:,4) Pos(:,2)];
        end
    end
    function get_ctrs(obj)
        E=obj.Edges;
        C=struct();

        % ctrs
        C.i = edge2ctr(E.i);
        C.o = edge2ctr(E.o);

        C.iC=unique(C.i(:,1),'stable');
        C.iR=unique(C.i(:,2),'stable');
        C.oC=unique(C.o(:,1),'stable');
        C.oR=unique(C.o(:,2),'stable');

        C.iT=edge2ctr(E.iT);
        C.oT=edge2ctr(E.oT);
        C.iTm=edge2ctr(E.iTm);

        C.iCT=C.iT(1);
        C.iRT=C.iT(2);
        C.oCT=C.oT(1);
        C.oRT=C.oT(2);
        C.iCTm=C.iTm(1);
        C.iRTm=C.iTm(2);

        obj.Ctrs=C;


        function out=edge2ctr(edge)
            out=[mean(edge(:,1:2),2) mean(edge(:,3:4),2)];
        end
    end
    function [pos,Pos,iPosT,oPosT,iPosTm]=get_crwh0(obj,RC,ir,ic,oM,iM,fWH,aspectR)
        bRelInner=false;

        %i=sub2ind([obj.RC(2) obj.RC(1)],c,r);
        oMW=sum(oM(1:2));
        oMH=sum(oM(3:4));
        sz=size(ir);

        % 1 is the wdith and height here
        WW=1/RC(2);
        HH=1/RC(1);

        %% 0
        % OUTER
        W0=(1-oMW) * WW;
        H0=(1-oMH) * HH;

        % INNER
        if bRelInner
            im0=iM.*[W0 W0 H0 H0];
        else
            im0=iM;
        end
        iw=sum(im0(:,1:2),2);
        ih=sum(im0(:,3:4),2);
        w0=W0 - iw;
        h0=H0 - ih;

        % resize inner to fit aspect ratio
        [rW0,rH0]=ratio_fun(fWH,RC,w0,h0,aspectR);
        w01 = w0*rW0;
        h01 = h0*rH0;

        % GET TOTAL, WITHOUT EXTRA FIGURE SPACE
        % (inner + innerMargin) * N + outerMargin
        TW=(w01 + sum(im0(:,1:2),2)) .* 1./WW + oMW;
        TH=(h01 + sum(im0(:,3:4),2)) .* 1./HH + oMH;
        if TH(1) > TW(1);
            TW=TW./TH;
            TH=1;
        else
            TH=TH./TW;
            TW=1;
        end

        %% 1
        % OUTER WITH NEW TOTAL
        W=(TW-oMW) .* WW;
        H=(TH-oMH) .* HH;
        C=  (  (ic-1).*W + oM(1));
        R=  (  (ir-1).*H + oM(4));

        % INNER WIT NEW TOTAL
        if bRelInner
            im=iM.*[W W H H];
        else
            im=iM;
        end
        iw=sum(im(:,1:2),2);
        ih=sum(im(:,3:4),2);
        il=im(:,1);
        ir=im(:,2);
        it=im(:,3);
        ib=im(:,4);
        w1=W - iw;
        h1=H - ih;
        r1=R - ib;
        c1=C - il;

        % resize to fit aspect ratio
        [rW,rH]=ratio_fun(fWH,RC,w1,h1,aspectR);
        w = w1*rW;
        h = h1*rH;

        % NEEDED ???
        TW=(w + iw) .* 1./WW + oMW;
        TH=(h + ih) .* 1./HH + oMH;
        if TH(1) > TW(1);
            TW=TW./TH;
            TH=1;
        else
            TH=TH./TW;
            TW=1;
        end

        % size of each inner, after resizing
        r = r1-(ir-1).*abs(h-h1)+ib*2;
        c = c1-(ic-1).*abs(w-w1)+il*2;


        %a= h + im(:,4);
        %A= H;

        % get rid of mysterious space ???
        r=flipud(r+1-TH);

        R=flipud(R+1-TH);

        %% SAVE
        pos=[c  r repmat(w,sz) repmat(h,sz)];
        Pos=[C  R repmat(W,sz) repmat(H,sz)];

        % TOTAL WH
        oPosT=[0 1-TH(1) TW(1) TH(1)];

        b=0;
        %iPosT =[c(1)-il r(end)-ib c(end)-c(1)+w+il+ir r(1)-r(end)+h+it+ib];
        iPosT =[c(1)-il r(end)-ib c(end)-c(1)+w+il+ir r(1)-r(end)+h+it+ib];
        iPosTm=[c(1) r(end) c(end)-c(1)+w r(1)-r(end)+h];

        function [rW,rH]=ratio_fun(fWH,RC,w,h,aspectR);
            rWH=[w h] .* fWH;
            if any(RC==1)
                rF=1;
            else
                rF=rWH(1)./rWH(2)/aspectR;
            end

            if rF < 1
                rH=rF;
                rW=1;
            else
                rH=1;
                rW=1./rF;
            end
        end
    end
    function set_sub_pos(obj,i,h,w)
        pos=obj.Pos.i(i,:);
        posc=obj.Pos.c(i,:);
        if nargin < 3
            h=obj.Hs(i);
            w=obj.Ws(i);
        end
        if h~=1 || w~=1
            pos(3)=pos(3)*w + (w-1)*sum(obj.iM(1:2));
            pos(4)=pos(4)*h + (h-1)*sum(obj.iM(3:4));
        end

%'Units','normalized',
        set(obj.ax{i},'Position',pos);
        if obj.D.ctOn_
            set(obj.axc{i},'Position',posc);
        end
        obj.Hs(i)=h;
        obj.Ws(i)=w;
    end
end
%- GENERAL GET
%methods(Access=?SubLabels)
methods(Hidden)
    function out=get_bBy(obj,name)
        out=obj.propFun('By',name);
    end
    function out=get_bCtr(obj,name)
        out=obj.propFun('Ctr',name);
    end
    function out=propFun(obj,ffld,name,bRecurse)
        if ~any(strcmp(name(1),{'x','y','z','c'}))
            out=[];
            return
        end

        % get field that negates the other
        switch ffld
        case 'Ctr'
            nffld='By';
        case 'By'
            nffld='Ctr';
        otherwise
            nffld='';
        end

        % base fld
        bfld=strrep(name,'t','');
        tfld=[bfld 't'];

        % eval fld
        bFld=[bfld ffld];
        tFld=[bfld 't' ffld];

        if ~isempty((nffld))
            nbFld=[bfld nffld];
            ntFld=[bfld 't' nffld];
        end

        % actual
        if numel(name) > 1 && endsWith(name,'t');
            fld=tfld;
            ofld=bFld;

            Fld=tFld;
            oFld=bFld;
            nFld=ntFld;
        else
            fld=bfld;
            ofld=tFld;

            Fld=bFld;
            oFld=tFld;
            nFld=nbFld;
        end

        out=obj.(Fld);
        if ~isempty(out); return; end

        % fallback to negating fld
        if ~isempty(nffld)
            out=~obj.(nFld);
            if ~isempty(out); return; end
        end

        % fallback to other
        out=obj.(oFld);
        if ~isempty(out); return; end

        % fallback to flag
        out=obj.get_b(fld);
        if ~isempty(out); return; end

        out=obj.get_b(ofld);
        if ~isempty(out); return; end
    end
    function out=get_fontSize(obj,name)
        if strcmp(name,'oM')
            ffld='fontSize';
        elseif strcmp(name,'iM')
            ffld='fontSize';
        else
            ffld=[name 'FontSize'];
        end
        out=obj.(ffld);
        if ~isempty(out)
            return
        end

        switch name
        case {'s','u'}
            out=obj.SUFontSize;
        case {'l','r','t','b'}
            out=obj.RCFontSize;
        case {'x','y','xx','yy'}
            out=obj.XYFontSize;
        case {'xt','yt','xxt','yyt'}
            out=obj.ticksFontSize;
        case {'iM','oM'}
            out=obj.fontSize;
        end
        if isempty(out)
            out=obj.fontSize;
        end
    end
    function out=get_b(obj,name)
        bfld=[ name 'On'];
        if numel(name) > 1 && endsWith(name,'t')
            if strcmp(name,'yt') && obj.iMargin(1) > 0
                out=false;
            elseif strcmp(name,'yyt') && obj.iMargin(2) > 0
                out=false;
            elseif strcmp(name,'xxt') && obj.iMargin(3) > 0
                out=false;
            elseif strcmp(name,'xt') && obj.iMargin(4) > 0
                out=false;
            else
                out=obj.(bfld);
            end
        else
            lfld=[name 'Txt'];
            if ~isempty(obj.(bfld))
                out=obj.(bfld);
            else
                out=~isempty(obj.(lfld));
            end
        end
        if isempty(out)
            out=false;
        end
    end
    function iM=get_margin(obj,fld,bRaw)
        if nargin < 3  || isempty(bRaw)
            bRaw=false;
        end
        units=obj.get_units(fld);
        if any(strcmp(fld,{'iM','oM'}))
            Fld=[fld(1) 'Margin'];
        else
            Fld=[fld 'Margin'];
        end
        iM=obj.(Fld);

        if bRaw
            return
        end
        if any(strcmp(fld,{'yt','yyt'}))
            iM=iM+1;
        elseif any(strcmp(fld,{'xt','xxt','ct'}))
            iM=iM+.15;
        end
        if strcmp(units,'characters')
            fsz=obj.get_fontSize(fld);
            %iM=iM.*(fsz/obj.defFontSize);
            iM=iM.*(fsz/obj.defFontSize);
        end
    end
    function out=get_marginN(obj,fld)
        iM=obj.get_margin(fld,false);
        L0=obj.nLineWH_T;
        C0=obj.nCharWH_T;
        L=repelem(L0,1,2);
        C=repelem(C0,1,2);
        out=iM./L;
    end
end
methods(Access=protected)
%- Margins
    function units=get_units(obj,fld)
        if strcmp(fld,'iM')
            units=obj.iUnits;
        elseif strcmp(fld,'oM')
            units=obj.oUnits;
        elseif any('xyzc'==fld(1))
            units=obj.iUnits;
        else
            units=obj.oUnits;
        end
    end
    function get_flds(obj)
        % flds
        %flds={'xt';'yt';'xxt';'yyt';...
        %      'x';'y';'xx';'yy';...
        %      't';'b';'l';'r';...
        %      's';'u'};
        flds={...
              'oT';'s';'t';'xx';'xxt';'iT';... % GOOD
              'oR';'r';'yy';'ct';'c';'yyt';'iR';... % GOOD
              'iB';'xt';'x';'b';'u';'oB';...  % GOOD
              'iL';'yt';'y';'l';'oL';...
        };

              %'yyt';'yy';'r';...
        N=numel(flds);

        % by flds
        bFlds=cell(N,1);
        byFlds={'xt','yt','xxt','yyt','ct'...
                'x','y','xx','yy','c'};
        bBy=ismember(flds,byFlds);


        % rev flds
        rFlds=cell(N,1);
        revFlds={'iL','yL','oL','iL','y','yy','l','r','c'};
        nRevFlds={'yt','yyt','ct'};
        bRev=ismember(flds,revFlds);
        bNRev=ismember(flds,nRevFlds);
        rFlds(bRev)={'f'};
        rFlds(bNRev)={'n'};
        rFlds(~bRev & ~bNRev)={''};

        % loc flds
        lFlds=cell(N,1);
        topFlds={'oT','iT','xxt','xx','t','s'};
        botFlds={'oB','iB','xt','x','b','u'};
        leftFlds={'oL','iL','yt','y','l'};
        rightFlds={'oR','iR','yyt','yy','r','ct','c'};
        lFlds(ismember(flds,topFlds))={'T'};
        lFlds(ismember(flds,botFlds))={'B'};
        lFlds(ismember(flds,leftFlds))={'L'};
        lFlds(ismember(flds,rightFlds))={'R'};
        bLR=ismember(flds,[leftFlds rightFlds]);

        % aflds
        locs={'o','i'};
        dirs={'L','R','T','B'};
        fflds=Set.distribute(locs,dirs);
        aFlds=strcat(fflds(:,1), fflds(:,2))';
        aFlds=[aFlds; num2cell(zeros(size(aFlds)))];

        % Inner
        bInner=false(N,1);

        obj.flds=flds;
        obj.topFlds=topFlds;
        obj.botFlds=botFlds;
        obj.leftFlds=leftFlds;
        obj.rightFlds=rightFlds;

        obj.bBy=bBy;
        obj.bNRev=bNRev;
        obj.bRev=bRev;
        obj.bInner=bInner;
        obj.bLR=bLR;

        obj.rFlds=rFlds;
        obj.lFlds=lFlds;
        obj.aFlds=aFlds;
    end
    function [oM,iM]=get_margins(obj)
        % Margins pre-normalized

        % aflds
        oM=obj.get_margin('oM');
        iM=obj.get_margin('iM');

        oM=obj.get_margin('oM');
        iM=obj.get_margin('iM');
        %m.iM=iM;
        %m.oM=oM;
        m=struct();
        for i = 1:length(obj.flds)
            m.(obj.flds{i})=0;
        end
        m.iL=iM(1);
        m.iR=iM(2);
        m.iT=iM(3);
        m.iB=iM(4);

        m.oL=oM(1);
        m.oR=oM(2);
        m.oT=oM(3);
        m.oB=oM(4);

        N=length(obj.flds);
        obj.AFlds=cell(N,1);
        for i = 1:N
            fld=obj.flds{i};
            if startsWith(fld,{'i','o'})
                ;
            elseif obj.get_b(fld)
                m.(fld)=obj.get_margin(fld);
            else
                m.(fld)=0;
            end

            % AFLD
            obj.bInner(i)=startsWith(fld,'i') || (obj.bBy(i) && ~obj.get_bBy(fld));
            if obj.bInner(i)
                obj.bFlds{i}='i';
            else
                obj.bFlds{i}='o';
            end
            %aFld=[obj.bFlds{i} obj.lFlds{i} obj.rFlds{i}];
            aFld=[obj.bFlds{i} obj.lFlds{i}];
            obj.AFlds{i}=aFld;

        end
        obj.m0=m;
    end
    function normalize_margins(obj);
        L0=obj.nLineWH_T;
        C0=obj.nCharWH_T;
        L=repelem(L0,1,2);
        C=repelem(C0,1,2);


        flds=fieldnames(obj.m0);
        c=struct();
        m=struct();
        a=struct(obj.aFlds{:});
        for i = 1:numel(flds)
            fld=flds{i};
            aFld=obj.AFlds{i};

            % swap w & h of text
            if obj.bNRev(i)
                T0=C0;
            elseif obj.bRev(i)
                T0=L0;
            else
                T0=L0;
            end

            % swap r & c of figure
            if obj.bLR(i)
                ind=1; % reverse of what you think
            else
                ind=2;
            end
            m.(fld) =obj.m0.(fld)  ./T0(ind);

            c.(fld)=a.(aFld);
            a.(aFld)=a.(aFld) + m.(fld);

        end
        obj.m=m;

        obj.oM=[a.oL a.oR a.oT a.oB];
        obj.iM=[a.iL a.iR a.iT a.iB];
        obj.MC=c;

        %obj.oM=obj.oM0./L + obj.oM0f./L + obj.oM0n./C;
        %obj.iM=obj.iM0./L + obj.iM0f./L + obj.iM0n./C;
    end

end
methods(Hidden)
%- resize
    function resize_(obj,src,event)
        if ~obj.bLockAxes
            %builtin('resize',src,event);
            return
        end

        obj.bResize=0;
        cl=tmpSet(obj,'bResize',1);

        obj.get_geometry();

        obj.set_background();
        if obj.bTest
            obj.set_ibackground();
        end

        for i = 1:obj.n
            obj.set_sub_pos(i);
        end
        obj.AL_set_position();

        %obj.AL_draw(); % in SubPlot_AxesL
    end
    function fitFont(obj)
        % TODO
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
        o=obj.fWH(1)./obj.fWH(2);
        e=obj.aspectIdeal;
        fld='PaperPosition';

        if o > e
            w=e*obj.fWH(2);
            obj.f.(fld)(3)=w;
        else
            h=obj.fWH(1)/e;
            h
            obj.f.(fld)(4)=h;
        end
    end
%- label
    %function yylabel(obj,txt,bCtrOnly,bByCol,xedge,yedge)
end
methods(Static,Hidden)
    function out=logical2onoff(varargin)
        if nargin == 2
            in=varargin{2};
        else
            in=varargin{1};
        end
        if in
            out='on';
        else
            out='off';
        end
    end
end
end
