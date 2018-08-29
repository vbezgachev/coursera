function [X, y] = readFeatures(directory, isSpam)

X = [];
y = [];

spam_email_files = readdir(directory);
for i = 1:numel(spam_email_files)
  if (regexp (spam_email_files{i}, "^\\.\\.?$"))
    continue;
  endif
    
  spam_email_files{i}
  filename = [directory '\\' spam_email_files{i}]
  
  file_contents = readFile(filename);
  word_indices = processEmailFull(file_contents);
  features = emailFeatures(word_indices);
  y = [y; isSpam];
  X = [X; features'];
end


end

