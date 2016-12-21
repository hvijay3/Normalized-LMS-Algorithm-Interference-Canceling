
load('project1.mat');
X = reference';

V = primary';
%   X(45000:70000,:)=[];
%    V(45000:70000,:)=[];
 
% Size_X = size(reference',1);
%     Size_V = size(primary',1);
    Size_X = size(X,1);
    Size_V = size(V,1);
order = [4,8,15,22,30];
cost = 0;
count =1;
% for order_index =1:5;
    
    red_x = X;
red_v = V;
%   o=order(order_index);
o =2;

     %Para = (rand(1,o))'; % Initialize parameters
     Para1 = Para;
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
    end    %Find 1st Eigen value of design X and then 1/eigen
   
%    R = Design_X'*Design_X;   % Eigen value and limit found
%    lambda = eig(R);
%    lambda_limit = 1/(lambda(o)+lambda(1));
% %     step_size =1/(lambda(o) + lambda(1));
%     step_size = 2*lambda_limit/trace(R);

    


%    lambda_initial = 0.1*lambda_limit;
%    for step_size = lambda_initial : lambda_initial: lambda_limit

%        for iteration = 1: size(red_x,1)
%            Var = Design_X(iteration,:)*Design_X(iteration,:)';
%            variance ( iteration) = Var;
%            step_size = 0.5/(0.001 + Var);
%            
%            Para = Para + step_size * (red_v(iteration,:)- Design_X(iteration,:)*Para)*(Design_X(iteration,:))';
% %         cost =  cost + ((Design_X(iteration,:)*Para(:,1) - red_x(iteration))*(Design_X(iteration,:)*Para(:,1) - red_x(iteration)));
%           cost = sum((((red_x(1:iteration,:) -(Design_X(1:iteration,:)*Para)).^2)))/iteration;
% %         
% %           
%          cost_matrix(iteration,:) = [iteration,cost];
%            
%        end
%        para = para1;
       %errormat(1:(iteration),:) = ((red_v(1:(iteration),:)-(Design_X(1:(iteration),:)*Para)));
       errormat(1:(68000),:) = ((red_v(1:(68000),:)-(Design_X(1:(68000),:)*Para1)));
%       cost = sum((((red_x(1:iteration,:) -(Design_X(1:iteration,:)*Para)).^2)))/iteration;
%        sound(errormat,fs);
%    

figure;
 plot(cost_matrix(:,1),cost_matrix(:,2));
 xlabel('Iterations');
ylabel('Mean Square Error');
title('Learning curve for MSE vs Iterations for NLMS Algorithm');



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




    



    
