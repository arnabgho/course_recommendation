courseList = loadCourseList();

[n_courses dum]=size(courseList);

disp(n_courses);

arg_list=argv();
user=arg_list{nargin};

user_id=str2num(user);
disp(user_id);


course=arg_list{nargin-1};
course_id=str2num(course);
disp(course_id);


val=arg_list{nargin-2};
value=str2num(val);
disp(value);

% pause;

%  Initialize my ratings
% my_ratings = zeros(43, 1);

% Check the file movie_idx.txt for id of each movie in our dataset
% For example, Toy Story (1995) has ID 1, so to rate it "4", you can set
% my_ratings(course_id) = value;

% Or suppose did not enjoy Silence of the Lambs (1991), you can set
% my_ratings(98) = 2;

% % We have selected a few movies we liked / did not like and the ratings we
% % gave are as follows:
% my_ratings(7) = 3;
% my_ratings(12)= 5;
% my_ratings(50) = 0;
% my_ratings(64)= 5;
% my_ratings(66)= 3;
% my_ratings(69) = 5;
% my_ratings(183) = 4;
% my_ratings(226) = 5;
% my_ratings(355)= 5;


fprintf('\nTraining collaborative filtering...\n');

%  Load data
load('ex8_courses.mat');
% pause;

n_u = size(Y, 2);

 disp(n_u);
 % pause;
% disp(Y);
% pause;
% disp(R);
% pause;

if n_u>=user_id
    Y(course_id,user_id)=value;
    R(course_id,user_id)=1;
else
    my_ratings=zeros(n_courses,user_id-n_u);
    my_ratings(course_id,user_id-n_u)=value;
    Y=[Y my_ratings];
    R=[R (my_ratings ~= 0)];
end

% disp(Y);
% pause;
% disp(R);
% pause;


%  Y is a(43x943 matrix, containing ratings (1-5) of(43 movies by 
%  943 users
%
%  R is a(43x943 matrix, where R(i,j) = 1 if and only if user j gave a
%  rating to movie i

%  Add our own ratings to the data matrix
% Y = [my_ratings Y];
% R = [(my_ratings ~= 0) R];




 % pause;

%  Normalize Ratings
[Ynorm, Ymean] = normalizeRatings(Y, R);

%  Useful Values
num_users = size(Y, 2);
num_movies = size(Y, 1);
num_features = 10;

% Set Initial Parameters (Theta, X)
X = randn(num_movies, num_features);
Theta = randn(num_users, num_features);

initial_parameters = [X(:); Theta(:)];

% Set options for fmincg
options = optimset('GradObj', 'on', 'MaxIter', 100);

% Set Regularization
lambda = 10;
theta = fmincg (@(t)(cofiCostFunc(t, Y, R, num_users, num_movies, ...
                                num_features, lambda)), ...
                initial_parameters, options);

% Unfold the returned theta back into U and W
X = reshape(theta(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(theta(num_movies*num_features+1:end), ...
                num_users, num_features);

fprintf('Recommender system learning completed.\n');

fprintf('\nProgram paused. Press enter to continue.\n');
% pause;

%% ================== Part 8: Recommendation for you ====================
%  After training the model, you can now make recommendations by computing
%  the predictions matrix.
%

p = X * Theta';

[d1 d2]=size(X);

my_predictions = p(:,user_id) + Ymean;

courseList = loadCourseList();

[r, ix] = sort(my_predictions, 'descend');

[n_c dummy]=size(my_predictions);

fprintf('\nTop recommendations for you:\n');
% for i=1:10
%     j = ix(i);
%     fprintf('Predicting rating %.1f for course %s\n', my_predictions(j), ...
%             courseList{j});
% end

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

% fprintf('\n\nOriginal ratings provided:\n');
% for i = 1:length(my_ratings)
%     if my_ratings(i) > 0 
%         fprintf('Rated %d for %s\n', my_ratings(i), ...
%                  movieList{i});
%     end
% end

 % save ('-mat7-binary','ex8_movies_new.mat','R','Y');
  save ("-mat7-binary","ex8_courses.mat","R","Y","X","Theta","Ymean","p");

% save '-mat7-binary' ex8_movies.mat;