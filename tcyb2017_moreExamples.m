close all;

methodNames = {'multiscaleRetinex' 'dong' 'npe' 'lime' 'mf' 'srie'  'ours_caip2017'};  % 'dheci'

%% NPE-ex II
xywh = [
   860    77   301   195
    ];
result = show_methods_roi('#dataset\#lowlight\VV\P1010426.jpg', xywh, methodNames,...
    '%(path)/out\%(name)__%(method).PNG');
result.dump();close all; 
return;


%% NPE-ex II
xywh = [
   187   317   159    88
    ];
result = show_methods_roi('#dataset\#lowlight\LDR_TEST_IMAGES_DICM\13.JPG', xywh, methodNames,...
    '%(path)/out\%(name)__%(method).PNG');
result.dump();close all; 
return;



%% NPE-ex II
xywh = [
     7   285   115    75
%     35   196    77    53
    ];
result = show_methods_roi('#dataset\#lowlight\NPE-ex\Part II\Daybreak&Nightfall  (16).jpg', xywh, methodNames,...
    '%(path)/out\%(name)__%(method).PNG');
result.dump();close all; 
return;



%% NPE-ex
xywh = [
%    367   302   178   168
%    616   591   137   118
        1149         478          78          68
         211         516          68          50
         430         531          62          68
    ];
result = show_methods_roi('#dataset\#lowlight\NPE-ex\Part I\cloudy (6)_jpg.jpg', xywh, methodNames,...
    '%(path)/out\%(name)__%(method).PNG');
% result.dump();close all; 
return;

%% 头发和背景混合问题
xywh = [
    
        1046         451         408         297
1156        1431         408         297

%         1501         978         447         240 two people 
%                   1156        1431         447         240
%           35         631         173         148 cloth
%         1508         945         493         375
%                   17         862         300         216
    ];

result = show_methods_roi('#dataset\#lowlight\VV\test3453.jpg', xywh, methodNames,...
    '%(path)/out\%(name)__%(method).PNG');
% result.dump();close all;  
return;
%% 过曝光问题
% xywh = [
%    10   115    31    33
% %    366    14    75    85 window
% %    365   125    75    85 window
%    330   123    75    85
% %        70    74    47    58 % lamp
%    202   108    52    38
% %    242    62    47    58 window
%     ];
% result = show_methods_roi('#dataset\#lowlight\MEFDatabase\Farmhouse.png', xywh, methodNames,...
%     '%(path)/out\%(name)__%(method).PNG'); % Farmhouse.png BelgiumHouse
% % result.dump();close all;  
% return;




xywh = [
%           32        1230         204         192  lime
%           10         723         246         288
%         1007         585          92          61
%         1621         676         260         130
          10         723         408         288
%         1019         589          77          45
%         1567         676         251         130
    
];
result = show_methods_roi('#dataset\#lowlight\VV\P1010426.jpg', xywh, methodNames,...
    '%(path)/out\%(name)__%(method).PNG'); % Farmhouse.png BelgiumHouse
% result.dump();close all;  
return;
