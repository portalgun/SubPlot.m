classdef SubPlot_Tests_ < handle

properties
end
methods(Static)
    function test()
        iMargin=[0 0 0 0];
        oMargin= [0 0 0 0];

        bRC=[1 1 1 1];
        RCMargin=[2 2 2 2];

        bXY=[1 1 1 0 1];
        XYMargin=[1 1 1 1 1];

        bSu=[1 1];
        suMargin=[1 1];

        Siz=[5,8];
        Args={...
            'bTest',true;
            'bSelectAll',true;
            'iMargin',iMargin;
            'oMargin',oMargin;
            ...
            'bYY',true;
            'bZ',true;
            ...
            %% X
            'xOn',bXY(1);
            'xBy',true;
            'xCtr',true;
            'xMargin',XYMargin(1);
            'xTxt','xTxt';
            %% Y
            'yOn',bXY(2);
            'yBy',true;
            'yCtr',true;
            'yMargin',XYMargin(2);
            'yTxt','yTxt';
            %% XX
            'xxOn',bXY(3);
            'xxBy',true;
            'xxCtr',true;
            'xxMargin',XYMargin(3);
            'xxTxt','xxTxt';
            %% YY
            'yyOn',bXY(4);
            'yyBy',true;
            'yyCtr',true;
            'yyMargin',XYMargin(4);
            'yyTxt','yyTxt';
            ...
            %% C
            'cOn',bXY(5);
            'cBy',true;
            'cCtr',true;
            'cMargin',XYMargin(5);
            'cTxt','cTxt';
            ...
            %% XTicks
            'xtOn',true;
            'xtBy',false;
            'xtCtr',true;
            'xtMargin',1;
            %% YTTicks
            'ytOn',true;
            'ytBy',true;
            'ytCtr',true;
            'ytMargin',3;
            %% YTTicks
            'yytOn',false;
            'yytBy',true;
            'yytCtr',true;
            'yytMargin',3;
            %% CTicks
            'ctOn',true;
            'ctBy',true;
            'ctCtr',false;
            'ctMargin',3;
            ...
            %% L
            % XXX
            'lOn',bRC(1);
            'lMargin',RCMargin(1);
            'lTxtB','lTxtB';
            'lTxt',{'lTxt 1','2','3','4','5'};
            %% R
            % XXX
            'rOn',bRC(2);
            'rMargin',RCMargin(2);
            'rTxtB','rTxtB';
            'rTxt',{'rTxt 1','2','3','4','5'};
            %% B
            'tOn',bRC(3);
            'tMargin',RCMargin(3);
            'tTxtB','tTxtB';
            'tTxt',{'1','2','3','4','5','6','7','8'};
            %% T
            'bOn',bRC(4);
            'bMargin',RCMargin(4);
            'bTxtB','bTxtB';
            'bTxt',{'1','2','3','4','5','6','7','8'};
            ...
            %% S
            'sOn',bSu(1);
            'sMargin',suMargin(1);
            'sTxt','sTxt';
            %% U
            'uOn',bSu(2);
            'uMargin',suMargin(2);
            'uTxt','uTxt';
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
