function [OPsecs,OPkeyCode,OPkeyIsDown] = Nico_KbCheck(keyName)
%V1.0 alpha
% Aimed: solving double-Key tasks.
% Updated:1. it can output as KbCheck() in PTB3 with secs correctly , however it includes 2 rows
%    rather than 1.
% For future:1. sorting the output as same as the input.
% For future:2. enabling to detect more than 2 keys.
% Make sure that you have installed PTB3(in Matlab 2020a)
%% Example
% clc;clear;
% run('D:\Toolbox_new\Psychtoolbox-3-PTB_Beta-2018-11-08_V3.0.15\Psychtoolbox\SetupPsychtoolbox.m')
% keyName = {'s','a'};
% [OPsecs,OPkeyCode,OPkeyIsDown] = Nico_KbCheck(keyName);
% KbName(OPkeyCode(1,:))
% KbName(OPkeyCode(2,:))
% Created by JiangXiaoWei(jiangxiaowei@aipsycho.com) in Henu(Kaifeng, China)



index_Key = 1;
index_Key_used = 1;
Check_1 = 0;
Check_2 = 0;
All_Key = {};
OPsecs=[];
OPkeyCode=[];
OPkeyIsDown=[];
while true
    [keyIsDown,secs, keyCode] = KbCheck();
    if keyIsDown
        All_Key(index_Key) = {KbName(keyCode)};
        All_Key(cellfun('isempty',All_Key)) = [];
        
        if ismember(All_Key,keyName(1))
            if ~Check_1
                Check_1 = 1;
                OPsecs(index_Key_used) = secs;
                OPkeyCode(index_Key_used,:) = keyCode;
                OPkeyIsDown(index_Key_used) = keyIsDown;
                index_Key_used = index_Key_used + 1;
            end
        end
        if ismember(All_Key,keyName(2))
            if ~Check_2
                Check_2 = 1;
                OPsecs(index_Key_used) = secs;
                OPkeyCode(index_Key_used,:) = keyCode;
                OPkeyIsDown(index_Key_used) = keyIsDown;
                index_Key_used = index_Key_used + 1;
            end
        end
        if index_Key_used > 2
            break
        end
    end
end
% for index_OP = 1:2
%     switch KbName(index_OP)
%         case keyName
%     [OPsecs,OPkeyCode,OPkeyIsDown] = 
% end

end
