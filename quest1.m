clear all;
load('project1.mat');
X = reference';

V = primary';
%     X(1:46000,:)=[];
%    V(1:46000,:)=[];
 
% Size_X = size(reference',1);
%     Size_V = size(primary',1);
    Size_X = size(X,1);
    Size_V = size(V,1);
 order = [2,18,10,20,40,50];
  for order_index =1;
cost = 0;
count =1;
    red_x = X;
red_v = V;
%o =40;
o=order(order_index);
   
     Para = zeros(1,o)';
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
   

       for iteration = 1: size(red_x,1)
           Var = Design_X(iteration,:)*Design_X(iteration,:)';
           
           step_size = 0.005/(0.001 + Var);
           
           Para = Para + step_size * (red_v(iteration,:)- Design_X(iteration,:)*Para)*(Design_X(iteration,:))';
          
         cost = sum((((red_x(1:iteration,:) -(Design_X(1:iteration,:)*Para)).^2)))/iteration; % with iteration sum
      % temp = sum((((red_x(1:size(red_x,1),:) -(Design_X(1:size(red_x,1),:)*Para)).^2)));
       % cost = sum((((red_x(1:size(red_x,1),:) -(Design_X(1:size(red_x,1),:)*Para)).^2)))/size(red_x,1); % divided by all
        %cost1 = temp/iteration;
        %cost = temp/size(red_x,1);
     %result (iteration,:) = [Para(1), Para(2),cost];
       cost_matrix(iteration,:) = [iteration,cost];
           
       end
        
       errormat(1:(iteration),:) = ((red_v(1:(iteration),:)-(Design_X(1:(iteration),:)*Para)));
    

figure;   % Plotting Learning curve
 plot(cost_matrix(:,1),cost_matrix(:,2));
 xlabel('Iterations');
ylabel('Mean Square Error');
title('Learning curve ( a = 0.005 , b = 0.001 )');

%  figure   % Plotting Performance surface
%  [xi,yi] = meshgrid(min(result(:,1)):0.1:max(result(:,1)), min(result(:,2)):0.1:max(result(:,2))); 
%   x = result(:,1); y = result(:,2); z =result(:,3) ;
%    zi = griddata(x,y,z,xi,yi);
%   surf(xi,yi,zi);
%  xlabel('Weight1')
%  ylabel('Weight2')
%  zlabel('Mean Square Error')
%  title('Performance Surface');
 
 


%SNR before

snr_before = mean( red_v .^ 2 ) / mean( red_x .^ 2 );
snr_before_db = 10 * log10( snr_before ) % in dB

% SNR after
residual_noise = red_v - errormat; 
snr_after = mean( red_v .^ 2 ) / mean( errormat .^ 2 ); 
snr_after_db = 10 * log10( snr_after )

snr(count,:) = [snr_before_db,snr_after_db];
   
 end

    



    
