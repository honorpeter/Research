%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File:     data.m
% Author:   Jared Bold
% Date:     11.5.14
% Description:
%   Script to output put csv files and charts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
format long;
fig = 1;
header = {'Dimensions', 'Software(mSec)', 'Hardware(mSec)', 'Speedup'};
header2 = {'Dimensions', 'Software(mSec)', 'Hardware/Software(mSec)', 'Speedup'};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test Images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
widths = [512 1024 2048];
pixels = widths.^2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filter_3x3_soft = [17.335 69.047 275.657];
filter_3x3_hard = [5.270 21.102 83.975];
filter_9x9_soft = [78.117 317.231 1281.468];
filter_9x9_hard = [5.331 12.242 84.220];
bilinear_soft = [115.674 462.598];
bilinear_hard = [56.163 225.449];
filter_3x3_speedup = filter_3x3_soft ./ filter_3x3_hard;
filter_9x9_speedup = filter_9x9_soft ./ filter_9x9_hard;
bilinear_speedup = bilinear_soft ./ bilinear_hard;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig);
fig = fig + 1;
plot(pixels,vertcat(filter_3x3_soft, filter_3x3_hard), '-o','MarkerSize', 5);
title('3x3 Gaussian Blur Filter Results');
xlabel('Pixels');
ylabel('Time (mSec)');
legend('Software', 'Hardware');
xlim([0,pixels(3)*1.25]);
ylim([0,filter_3x3_soft(3)*1.25]);
print -depsc /home/jared/Research/paper/img/filter_3x3_res.eps

figure(fig);
fig = fig + 1;
plot(pixels,vertcat(filter_9x9_soft, filter_9x9_hard), '-o','MarkerSize', 5);
title('9x9 LoG Filter Results');
xlabel('Pixels');
ylabel('Time (mSec)');
legend('Software', 'Hardware');
xlim([0,pixels(3)*1.25]);
ylim([0,filter_9x9_soft(3)*1.25]);
print -depsc /home/jared/Research/paper/img/filter_9x9_res.eps

figure(fig);
fig = fig + 1;
bar(pixels(1:2),vertcat(bilinear_soft, bilinear_hard).');
%plot(pixels,vertcat(bilinear_soft, bilinear_hard), '-o','MarkerSize', 5);
title('Bilinear Interpolation Scaled by 2 Results');
xlabel('Pixels');
ylabel('Time (mSec)');
legend('Software', 'Hardware/Software', 'Location', 'northwest');
print -depsc /home/jared/Research/paper/img/bilinear_res.eps

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Write the CSV files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('/home/jared/Research/paper/data/filter_3x3_res.csv','w');
fprintf(fid, '%s,', header{1,1:end-1});
fprintf(fid, '%s\n', header{1,end});
fclose(fid);
dlmwrite('/home/jared/Research/paper/data/filter_3x3_res.csv', ...
    horzcat(pixels.', filter_3x3_soft.', filter_3x3_hard.', filter_3x3_speedup.'), '-append');

fid = fopen('/home/jared/Research/paper/data/filter_9x9_res.csv','w');
fprintf(fid, '%s,', header{1,1:end-1});
fprintf(fid, '%s\n', header{1,end});
fclose(fid);
dlmwrite('/home/jared/Research/paper/data/filter_9x9_res.csv', ...
    horzcat(pixels.', filter_9x9_soft.', filter_9x9_hard.', filter_9x9_speedup.'), '-append');

fid = fopen('/home/jared/Research/paper/data/bilinear_res.csv','w');
fprintf(fid, '%s,', header2{1,1:end-1});
fprintf(fid, '%s\n', header2{1,end});
fclose(fid);
dlmwrite('/home/jared/Research/paper/data/bilinear_res.csv', ...
    horzcat(pixels(1:2).', bilinear_soft.', bilinear_hard.', bilinear_speedup.'), '-append');

format shortEng;
format compact;

