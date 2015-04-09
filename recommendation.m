courseList = loadCourseList();

% %  Initialize my ratings
% my_ratings = zeros(1682, 1);

% % Check the file movie_idx.txt for id of each movie in our dataset
% % For example, Toy Story (1995) has ID 1, so to rate it "4", you can set
% my_ratings(1) = 4;

% % Or suppose did not enjoy Silence of the Lambs (1991), you can set
% my_ratings(98) = 2;

% % We have selected a few movies we liked / did not like and the ratings we
% % gave are as follows:
% my_ratings(7) = 3;
% my_ratings(12)= 5;
% my_ratings(54) = 4;
% my_ratings(64)= 5;
% my_ratings(66)= 3;
% my_ratings(69) = 5;
% my_ratings(183) = 4;
% my_ratings(226) = 5;
% my_ratings(355)= 5;

arg_list=argv();
user=arg_list{nargin};

user_id=str2num(user);
disp(user_id);

fprintf('\nTraining collaborative filtering...\n');

%  Load data
load('ex8_courses.mat');



my_predictions = p(:,user_id) + Ymean;

courseList = loadCourseList();

[r, ix] = sort(my_predictions, 'descend');
% fprintf('\nTop recommendations for you:\n');
% for i=1:10
%     j = ix(i);
%     fprintf('Predicting rating %.1f for course %s\n', my_predictions(j), ...
%             courseList{j});
% end

[n_c dummy]=size(my_predictions);

count=1;
i=1;


while true
    if count >10 
        break;
    end  
    if i > n_c
        break;
    end   
    j=ix(i);
    if R(j,user_id)==0
        count=count+1;
        fprintf('Predicting rating %.1f for course %s\n', my_predictions(j), ...
            courseList{j});       
    end
    i=i+1;
end