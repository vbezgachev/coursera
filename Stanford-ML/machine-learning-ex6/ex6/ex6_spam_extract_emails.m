%% Initialization
clear ; close all; clc

% directories with e-mails and their classifications
directories = ['D:\\emails\\spam'; 'D:\\emails\\spam_2';...
               'D:\\emails\\easy_ham'; 'D:\\emails\\easy_ham_2';...
               'D:\\emails\\hard_ham'];
directories = cellstr(directories);
isSpam = [1; 1; 0; 0; 0];

% read and process e-mails
X = [];
y = [];
for i = 1:size(directories, 1)
  [Xtmp, ytmp] = readFeatures(directories{i}, isSpam(i));
  X = [X; Xtmp];
  y = [y; ytmp];
end

% save processing results into the file
save email_data.mat X y
