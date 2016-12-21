clear all;
load('project1.mat');
load('para.mat');
X = reference';

V = primary';
%   X(45000:70000,:)=[];
%     V(45000:70000,:)=[];
%  
% Size_X = size(reference',1);
%     Size_V = size(primary',1);
    Size_X = size(X,1);
    Size_V = size(V,1);
order = [2,10,20,50];
cost = 0;
count =1;
% for order_index =1:5;
    
    red_x = X;
red_v = V;
%   o=order(order_index);
o =40;

     %Para = (rand(1,o))'; % Initialize parameters
      Para1 = zeros(1,o)';
    red_x(1:o-1,:)=[];
red_v(1:o-1,:)=[];
Design_X = zeros(Size_X - o+1,o);
Design_V = zeros(Size_V - o+1,o);

 for i = o  : Size_X; 
     for j = 1:o
       Design_X(i-o+1,j)= X(i+1-j);
    end
 end    %Constructed Design Matrix
    for i = o : Size_V
    for j = 1:o
       Design_V(i-o+1,j)= V(i+1-j);
    end
    end    

       for iteration = 1: size(red_x,1)
           Var = Design_X(iteration,:)*Design_X(iteration,:)';
           
           step_size = 0.01/(0.01 + Var);
           
           Para1 = Para1 + step_size * (red_v(iteration,:)- Design_X(iteration,:)*Para1)*(Design_X(iteration,:))';
          
         %cost = sum((((red_x(1:iteration,:) -(Design_X(1:iteration,:)*Para)).^2)))/iteration; % with iteration sum
%          temp = sum((((red_x(1:size(red_x,1),:) -(Design_X(1:size(red_x,1),:)*Para)).^2)));
%         cost = sum((((red_x(1:size(red_x,1),:) -(Design_X(1:size(red_x,1),:)*Para)).^2)))/size(red_x,1); % divided by all
%         cost1 = temp/iteration;
%      result (iteration,:) = [Para(1), Para(2),cost];
%         cost_matrix(iteration,:) = [iteration,cost1];
           
       end
        cost = sum((((red_x(1:size(red_x,1),:) -(Design_X(1:size(red_x,1),:)*Para1)).^2)))/size(red_x,1);
       errormat(1:(iteration),:) = ((red_v(1:(iteration),:)-(Design_X(1:(iteration),:)*0.5*(Para1+Para))));
    

% figure;
%  plot(cost_matrix(:,1),cost_matrix(:,2));
%  xlabel('Iterations');
% ylabel('Mean Square Error');
% title('Learning curve for MSE vs Iterations for NLMS Algorithm');
% 
%  figure
%  [xi,yi] = meshgrid(min(result(:,1)):0.1:max(result(:,1)), min(result(:,2)):0.1:max(result(:,2)));
% % 
% % 
%   x = result(:,1); y = result(:,2); z =result(:,3) ;
%    zi = griddata(x,y,z,xi,yi);
%   surf(xi,yi,zi);
%  xlabel('Weight1')
%  ylabel('Weight2')
%  zlabel('mean square error')
 
 

   % A_predicted = (Design_V)* Para(:,1);
%    Y = (Design_X)* Para(:,1);
%    
%  error = primary'-Y;
% error_square = 0;
% for e =1:size(error,1)
%     error_square = error(e)*error(e) + error_square;
% end
% mean_error = error_square/size(error,1);
% 
% Result(count,:)= [o;step_size;mean_error]; % instead of l using step size
% count = count +1;
% end
%  end

   

%scatter3(Result(:,1),Result(:,2),Result(:,3));
% xlabel('Regularization parameter');
% ylabel('Filter order');
% zlabel('Mean Square Error');
% title('Scatter plot for validation set (Mean Square Error and Hyperparameters)');




    



    
