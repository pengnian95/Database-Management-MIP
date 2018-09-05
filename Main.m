%% Main
% Match the files and grades table.
% Zhang Pengnian



clear;
close all;

% Make sure that there is only one sheet in this table. The sturcture is strictly requested.
[~,~,Tb.Targets] = xlsread('C:\Users\zhang\Desktop\������(�ֶ��ּ�).xlsx'); 
Targets = tb2st(Tb.Targets);
% [Files, Tb.Files] = InfoExt('D:\Project Files\7.16���·ּ�3'); % Folder of unclassified images
[Files, Tb.Files] = InfoExt('G:\����������\Data');
% ATTENTION: Errors occurs in Tb.Files.


% Tb.Files: 1.Name 2.LoR 3.Date 4.Filepath
% Tb.Grades: 3.Name 12.LoR 14.Nuclear Grades
% Targets: Name, Grade

% Tb.Rep_Grades = FindRep(Tb.Targets,3);
% Tb.Rep_File = FindRep(Tb.Files',[1 2 3]);

Rs = InfoMat2(Files,Targets);

% Close Results.xlsx while running.
ResultsOutput(Rs);