function courseList = loadCourseList()
%GETMOVIELIST reads the fixed movie list in movie.txt and returns a
%cell array of the words
%   movieList = GETMOVIELIST() reads the fixed movie list in movie.txt 
%   and returns a cell array of the words in movieList.


%% Read the fixed movieulary list
fid = fopen('course_ids.txt');

% Store all movies in cell array movie{}
n = 43;  % Total number of movies 

courseList = cell(n, 1);
for i = 1:n
    % Read line
    line = fgets(fid);
    % Word Index (can ignore since it will be = i)
    [idx, courseName] = strtok(line, ' ');
    % Actual Word
    courseList{i} = strtrim(courseName);
end
fclose(fid);

end
