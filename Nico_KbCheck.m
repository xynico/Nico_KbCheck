
function [Output_secs,Output_keyCode,Output_keyIsDown,Output_keyIndex,Output_keyName]= Nico_KbCheck(keyName,max_time,max_number)
%V2.1 beta
% Aimed: solving double-Key tasks.
% Updated: it can output as KbCheck() in PTB3 with secs correctly , however it includes 2 rows
%    rather than 1.
% Updated: sorting the output as same as the input.
% Updated: enabling to detect more than 2 keys.
% Make sure that you have installed PTB3(in Matlab 2020a)
%% Example
% clc;clear;
% keyName = {'s','a','t'};
% max_time =5;
% max_number = 2;
% [Output_secs,Output_keyCode,Output_keyIsDown,Output_keyIndex,Output_keyName] = Nico_KbCheck(keyName,max_time,max_number);
% KbName(Output_keyCode(:,1))
% KbName(Output_keyCode(:,2))
% KbName(Output_keyCode(:,3))


% Created by JiangXiaoWei(jiangxiaowei@aipsycho.com) in Henu(Kaifeng, China)


index_Key = 1;
index_Key_used = 1;
All_Key = {};
Number_keyName = length(keyName);
Check = zeros(1,Number_keyName);
OP_secs=zeros(1,Number_keyName);
OP_keyCode=zeros(256,Number_keyName);
OP_keyIsDown=zeros(1,Number_keyName);
[~,initial_time,~]=KbCheck();
while true
    [keyIsDown,secs, keyCode] = KbCheck();
    time_judge=secs-initial_time;
    if time_judge>max_time
%         disp('time_out')
        break
    elseif sum(OP_keyIsDown)>=max_number    
                disp('number_enough')
        break
    elseif keyIsDown
        switch class(KbName(keyCode))
            case 'char'
                All_Key(index_Key) = {KbName(keyCode)};%#ok
                index_Key = index_Key + 1;
            case 'cell'
                Length_KbCode = length(KbName(keyCode));
                All_Key(index_Key:index_Key + Length_KbCode - 1) = KbName(keyCode);
                index_Key = index_Key + Length_KbCode;
        end
%         All_Key(cellfun('isempty',All_Key)) = [];%#ok
        for index_keyName = 1:Number_keyName
            if sum(ismember(All_Key,keyName(index_keyName)))
                if ~Check(index_keyName)
                    Check(index_keyName) = 1;
                    OP_secs(1,index_Key_used) = secs; 
                    OP_keyCode(:,index_Key_used) = keyCode;
                    OP_keyIsDown(1,index_Key_used) = keyIsDown;
                    index_Key_used = index_Key_used + 1;
                end
            end
        end

        if index_Key_used > Number_keyName
            break
        end
    end
end
[OupKbIndex,OupSecs,OupKeyIsDown] = split_KbCode(OP_keyCode,OP_keyIsDown,OP_secs);
[Output_secs,Output_keyCode,Output_keyIsDown,Output_keyIndex,Output_keyName] = sort_as_key(OupKbIndex,OupSecs,OupKeyIsDown,keyName);
end
function [OupKbIndex,OupSecs,OupKeyIsDown] = split_KbCode(OP_keyCode,OP_keyIsDown,OP_secs)
t = 1;
for i = 1:size(OP_keyCode,2)
    L = length(find(OP_keyCode(:,i) == 1));
    if L == 0
        OupKbIndex(t,1) = 0;
        OupSecs(t,1) = 0;
        OupKeyIsDown(t,1) = 0;
        t = t +1;
    else
        I = find(OP_keyCode(:,i) == 1);
        OupKbIndex(t:t+L-1,1) = I;
        OupSecs(t:t+L-1,1) = OP_secs(i);
        OupKeyIsDown(t:t+L-1,1) = OP_keyIsDown(i);
        t = t + length(I);
    end
end
[~,ia] = unique(OupKbIndex,'first');
OupKbIndex = OupKbIndex(ia);
OupSecs = OupSecs(ia);
OupKeyIsDown = OupKeyIsDown(ia);
end 
function [Output_secs,Output_keyCode,Output_keyIsDown,Output_keyIndex,Output_keyName] = sort_as_key(OupKbIndex,OupSecs,OupKeyIsDown,keyName)
Output_keyCode = zeros(256,length(keyName));
Output_secs = zeros(1,length(keyName));
Output_keyIsDown = zeros(1,length(keyName));
Output_keyIndex = zeros(1,length(keyName));
Output_keyName = {};
for i = 1:length(keyName)
    Key = KbName(keyName{i});
    keyindex = find(OupKbIndex==Key);
    if ~isempty(keyindex)
        Output_secs(i) = OupSecs(keyindex);
        Output_keyIndex(i) = OupKbIndex(keyindex);
        Output_keyIsDown(i) = OupKeyIsDown(keyindex);
        Output_keyCode(Output_keyIndex(i),i) = 1;
    else
        Output_secs(i) = 0;
        Output_keyIndex(i) = Key;
        Output_keyIsDown(i) = 0;
    end
    Output_keyName{i} = KbName(Output_keyCode(:,i));
end
end