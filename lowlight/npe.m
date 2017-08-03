function I = npe(I)
if nargin == 0
   file = imgetfile,
   I = imload(file); 
   ezFig I lime(I) npe(I)
   %npe(I)
   clear I;
   return;
end

Require 'NPE'
% Require ../#include/TIP13NPE\NPE code and database\NPE
 I=NPEA(I);

end

% function I = imread(I) % overload the imread in NPEA
% end

% Run the following code:
% pic=NPEA('example.jpg');
% Then you can get the enhanced image.
% figure imshow(pic);






