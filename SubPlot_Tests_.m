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
            'yyOn',true;
            'zOn',true;
            'cOn',true;
            ...
            %% X
            'xlOn',bXY(1);
            'xlBy',true;
            'xlCtr',true;
            'xlCtr',XYMargin(1);
            'xlTxt','xlTxt';
            %% Y
            'ylOn',bXY(2);
            'ylBy',true;
            'ylCtr',true;
            'ylCtr',XYMargin(2);
            'ylTxt','ylTxt';
            %% XX
            'xxlOn',bXY(3);
            'xxlBy',true;
            'xxlCtr',true;
            'xxlCtr',XYMargin(3);
            'xxlTxt','xxlTxt';
            'yytMargin',3;
            %% CTicks
            'ctOn',true;
            'ctBy',true;
            'ctCtr',true;
            'ctMargin',3;
            'ctLoc','right';
            %% C
            'cLoc','left';
            'cMargin',.5;
            ...
            %% L
            % XXX
            'llOn',bRC(1);
            'llMargin',RCMargin(1);
            'llTxtB','lTxtB';
            'llTxt',{'lTxt 1','2','3','4','5'};
            %% R
            % XXX
            'rlOn',bRC(2);
            'rlMargin',RCMargin(2);
            'rlTxtB','rTxtB';
            'rlTxt',{'rTxt 1','2','3','4','5'};
            %% B
            'tlOn',bRC(3);
            'tlMargin',RCMargin(3);
            'tlTxtB','tTxtB';
            'tlTxt',{'1','2','3','4','5','6','7','8'};
            %% T
            'blOn',bRC(4);
            'blMargin',RCMargin(4);
            'blTxtB','bTxtB';
            'blTxt',{'1','2','3','4','5','6','7','8'};
            ...
            %% S
            'slOn',bSu(1);
            'slMargin',suMargin(1);
            'slTxt','slTxt';
            %% U
            'ulOn',bSu(2);
            'ulMargin',suMargin(2);
            'ulTxt','ulTxt';
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
