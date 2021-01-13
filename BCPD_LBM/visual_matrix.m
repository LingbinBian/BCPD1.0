function []=visual_matrix(mat,name)
% Matrix visualization
% Input:
% mat: a matrix
% name: 1 Mean, 2 Variance
% t: time point
%
% Version 1.0
% 29-April-2020
% Copyright (c) 2020, Lingbin Bian

% -------------------------------------------------------------------------
L=length(mat);
imagesc(mat);            % visualize matrix

% Color of the matrix
if name==1
    colormap(pink);
    title('Mean','fontsize',16)
elseif name==2
    colormap(bone);
    title('Variance','fontsize',16)
end
%colormap(flipud(parula)); 
         
alpha(0.8)                         
textstrings = num2str(mat(:), '%0.3f');       % Create strings from the matrix values
textstrings = strtrim(cellstr(textstrings));  % Remove any space padding
[x, y] = meshgrid(1:L);  % Create x and y coordinates for the strings
hstrings = text(x(:), y(:), textstrings(:), ...  % Plot the strings
                'HorizontalAlignment', 'center');
midvalue = mean(get(gca, 'CLim'));  % Get the middle value of the color range
textcolor = repmat(mat(:) < midvalue, 1, 3);  % Choose the text color of the strings

set(hstrings, {'Color'}, num2cell(textcolor, 2));  % Change the text colors
set(gca, 'XTick', 1:L, ...                             % Change the axes tick marks
         'XTickLabel', {'1', '2', '3', '4', '5','6','7'}, ...  %   and tick labels
         'YTick', 1:L, ...
         'YTickLabel', {'1', '2', '3', '4', '5','6','7'}, ...
         'TickLength', [0 0]);     
set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')     
xlabel('k','fontsize',16)
ylabel('k','fontsize',16)     

end

