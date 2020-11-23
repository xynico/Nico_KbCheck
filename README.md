# Nico_KbCheck
Aimed: solving MULTI-Key tasks.
## V3.1 alpha
<br>if keyisdown = 0
<br>  RT = 0

## V3.0 alpha
<br>Aimed: solving double-Key tasks.

<br> Updated: it can output as KbCheck() in PTB3 with secs correctly , however it includes 2 rows
<br>    rather than 1.
<br> Updated: sorting the output as same as the input.
<br> Updated: enabling to detect more than 2 keys.
<br> Updated: output Reaction time

********Make sure that you have installed PTB3(in Matlab 2020a)********

***Example***
<br> clc;clear;
<br> keyName = {'s','a','t'};
<br> max_time =5;
<br> max_number = 3;
<br> [Output_secs,Output_keyCode,Output_keyIsDown,Output_keyIndex,Output_keyName,Output_ReactionTime] = Nico_KbCheck(keyName,max_time,max_number);
<br> KbName(Output_keyCode(:,1))
<br> KbName(Output_keyCode(:,2))
<br> KbName(Output_keyCode(:,3))
——————————————————————————————————————————————————
<br>Output_secs: real time of each key
<br>Output_keyCode: 256 code od key
<br>Output_keyIsDown: is down or not
<br>Output_keyIndex: which index is 1 rather than 0 in 256 code(Output_keyCode)
<br>Output_keyName: Name directly of each key
<br>Output_ReactionTime:real Reaction Time
