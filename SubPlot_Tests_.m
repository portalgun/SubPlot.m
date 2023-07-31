classdef SubPlot_Tests_ < handle
% SLOW
% yyaxis
% enable default interactivity
%
% TODO
% By ticklabels
% ctr ticklabels
%
% flip base side
%  loc
%
%  Z
%  C
%    by rows or cols or none or all
%
%  'b' to 'on'
%  sup loc

properties
end
methods(Static)
    function test()
        iMargin=[0 0 0 0];
        oMargin= [0 0 0 0];

        bRC=[1 1 1 1];
        RCMargin=[2 2 2 2];

        bXY=[1 1 1 1];
        XYMargin=[1 1 1 1];

        bSu=[1 1];
        suMargin=[1 1];

        Siz=[5,8];
        Args={...
            'bTest',false;
            'bSelectAll',true;
            'iMargin',iMargin;
            'oMargin',oMargin;
            ...
            'bYY',true;
            ...
            'bYCtr',true;
            'bXCtr',true;
            'bYBy',true;
            'bXBy',true;
            'bXXBy',true;
            ...
            'bXTicksBy',false;
            'bYTicksBy',true;
            'bYYTicksBy',true;
            ...
            'bXTicksCtr',true;
            'bYTicksCtr',true;
            'bYYTicksCtr',true;
            ...
            %% X
            'bXLabel',bXY(1);
            'xMargin',XYMargin(1);
            'xTxt','xTxt';
            %% Y
            'bYLabel',bXY(2);
            'yMargin',XYMargin(2);
            'yTxt','yTxt';
            %% XX
            'bXXLabel',bXY(3);
            'xxMargin',XYMargin(3);
            'xxTxt','xxTxt';
            %% YY
            'bYYLabel',bXY(4);
            'yyMargin',XYMargin(4);;
            'yyTxt','yyTxt';
            ...
            %% XTicks
            'bXTicks',true;
            'xticksMargin',1;
            %% YTTicks
            'bYTicks',true;
            'yticksMargin',3;
            ...
            %% YTTicks
            'bYYTicks',true;
            'yyticksMargin',3;
            ...
            %% L
            % XXX
            'bLLabel',bRC(1);
            'lMargin',RCMargin(1);
            'lBTxt','lBTxt';
            'lTxt',{'lTxt 1','2','3','4','5'};
            %% R
            % XXX
            'bRLabel',bRC(2);
            'rMargin',RCMargin(2);
            'rBTxt','rBTxt';
            'rTxt',{'rTxt 1','2','3','4','5'};
            %% B
            'bTLabel',bRC(3);
            'tMargin',RCMargin(3);
            'tBTxt','tBTxt';
            'tTxt',{'1','2','3','4','5','6','7','8'};
            %% T
            'bBLabel',bRC(4);
            'bMargin',RCMargin(4);
            'bBTxt','bBTxt';
            'bTxt',{'1','2','3','4','5','6','7','8'};
            ...
            %% S
            'bSupLabel',bSu(1);
            'supMargin',suMargin(1);
            'supTxt','supTxt';
            %% U
            'bSubLabel',bSu(2);
            'subMargin',suMargin(2);
            'subTxt','subTxt';
        };
        Args=Args';
        SP=SubPlot(Siz,Args{:});

        %o.iMargin=[0 0 0 0];
        X=(1:10)-500;
        Y=(1:10)-500;
        SP.select([3,7]);
        plot(X,Y);
        return

        SP.sel([8,2]);
        plot(X,Y);

        SP.sel([8,3]);
        plot(X,Y);

        SP.sel([7,3]);
        plot(X,Y);

        SP.sel([1,2],1,1);
        plot(X,Y);

    end
end
end
