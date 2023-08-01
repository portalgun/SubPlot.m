classdef SubPlot_AxesL < handle
properties(Hidden)
    lblFlds
    obsList % in subLabels

    sL
    uL

    lL
    rL
    tL
    bL

    yL
    xL
    xxL
    yyL

    childList
    parentList
    childNames
    bind % base
    cind % center
    pind % parent
end
methods(Static)
end
methods
%- INIT
    function init_AL(obj)
        obj.AL_construct();
        %obj.AL_get_flds();
        %obj.AL_set_setters();
        %obj.AL_first_update();
        obj.AL_set_position(); % Defined in SubPlot_AxesL
    end
    function AL_construct(obj);
        % sL uL
        % lL rL tL bL
        % yL xL xxL yyL

        %% CONSTRUCT
        F={};
        flds={'sl' 'ul'};
        for i = 1:length(flds)
            fld=flds{i};
            fldf=fld;
            fldf(end)=upper(fldf(end));
            obj.(fldf)=SubLabels(obj,fld,'sup');
        end
        F=[F flds];

        flds={'ll' 'rl','tl','bl'};
        for i = 1:length(flds)
            fld=flds{i};
            fldf=fld;
            fldf(end)=upper(fldf(end));
            obj.(fldf)=SubLabels(obj,fld,'rc');
        end
        F=[F flds];

        flds={'xl' 'yl','xxl','yyl'};
        for i = 1:length(flds)
            fld=flds{i};
            fldf=fld;
            fldf(end)=upper(fldf(end));
            obj.(fldf)=SubLabels(obj,fld,'xy');
        end
        obj.lblFlds=[F flds];
    end
    function AL_get_flds(obj);
        parentList=obj.getObservables('SubPlot');
        childNames=parentList;
        childList=parentList;
        bind=false(length(parentList),1);
        cind=false(length(parentList),1);
        pind=false(length(parentList),1);
        for i = 1:length(parentList)
            fld=parentList{i};

            bB=endsWith(fld,'By') || endsWith(fld,'Ctr');
            if bB
                rFld=lower(fld(2:end));
            else
                rFld=lower(fld);
            end

            if startsWith(rFld,'xx')
                cFld='xx';
            elseif startsWith(rFld,'yy')
                cFld='yy';
            elseif startsWith(rFld,'sup')
                cFld='s';
                rFld=strrep(rFld,'sup','s');
            elseif startsWith(rFld,'sub')
                cFld='u';
                rFld=strrep(rFld,'sub','u');
            else
                cFld=rFld(1);
            end
            childNames{i}=[cFld 'L'];
            childList{i}=rFld((length(cFld)+1):end);
            if strcmp(childList{i},'ctr')
                childList{i}='bByDim';
                pind(i)=true;
                continue
            elseif strcmp(childList{i},'by')
                childList{i}='bCtrOnly';
                pind(i)=true;
                continue
            end

            bind(i)=startsWith(childList{i},'btxt');
            cind(i)=startsWith(childList{i},'ctxt');
            if bind(i) || cind(i)
                childList{i}=childList{i}(2:end);
            end

        end
        obj.childList=childList;
        obj.parentList=parentList;
        obj.childNames=childNames;
        obj.bind=bind;
        obj.cind=cind;
        obj.pind=pind;
    end
    function AL_set_setters(obj);
        obsList=[obj.parentList obj.childList];
        [u,~,CC]=unique(obj.childNames);

        %[parentList childList childNames]
        for ic=1:numel(u)
            IND=CC==ic;
            i=find(IND,1,'first');

            ind=IND & obj.pind;
            cnames=obj.childNames(i);
            if any(ind)
                obj.setChildSetter(obsList(ind,:),cnames);
            end

            ind=IND & obj.bind;
            cnames=[obj.childNames(i) 'All'];
            if any(ind)
                obj.setChildSetter(obsList(ind,:),cnames,-1);
            end
            ind=IND & obj.cind;
            if any(ind)
                obj.setChildSetter(obsList(ind,:),cnames,0);
            end
            ind=IND & ~obj.bind & ~obj.cind & ~obj.pind;
            if any(ind)
                obj.setChildSetter(obsList(ind,:),cnames,1:obj.n);
            end
        end
    end
    function AL_first_update(obj)
        return
        for i = 1:length(obj.parentList)
            fld=obj.parentList{i};
            if ~isempty(obj.(fld))
                obj.(fld)=obj.(fld);
            end
        end
        %for i = 1:length(obj.lblFlds);
        %    fld=[obj.lblFlds{i} 'L'];
        %    obj.(fld).get_position();
        %end

    end
%- UPDATE
    function AL_set_position(obj)
        for i = 1:length(obj.lblFlds);
            fld=[obj.lblFlds{i}];
            fld(end)=upper(fld(end));

            obj.(fld).set_text();
            obj.(fld).set_position();
        end
    end
end
end
