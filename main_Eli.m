x_train=(0:0.1:2*pi)';    %train set
f1_train=sin(2*x_train);   %sin(2x)
f2_train=sign(f1_train);    %square(2x)

%% 3.1 without noise   uncomment to use 
% %test for sin(2x) without noise
% % construction of the RBF units
% error = zeros(1,50);
% for ii=1:50
%     nb_centers=ii;                %nb of units
%     max_step = 2*pi - 0.05;      %last unit center
%     step = (max_step-0.05) / (nb_centers-1) ; %step between 2 units
%     centers = (0.05:step:max_step);
% %     ind = round(linspace(1,63,nb_centers));
% %     centers = x_train(ind);
% %     imp_centers = [0 1/4*pi 3/4*pi 5/4*pi 7/4*pi 2*pi]; %important points
% %     disp(length(centers))
%     sigma=1.25;    
%     %width of the centers
%     W=least_squares_RBF(x_train,f1_train,centers,sigma);
%     Y = predict_RBF(x_train,W,centers,sigma);
%     error(ii)=mean(abs(f1_train-Y));   %absolute error
% end
% figure(1)
% plot(error)
% % % to be below 0.1 we need 6 units, below 0.01 : 8 and below 0.001:10
% % % units.

%test for square(2x) without noise
% error = zeros(1,30);
% for ii = 1:30
%     nb_centers=ii;
%     max_step = 2*pi  - 0.05;
%     step = (max_step-0.05) / (nb_centers-1);
% %     centers=(0.05:step:max_step);
%     ind = round(linspace(1,63,nb_centers));
%     centers = x_train(ind);
%  %   disp(length(centers))
%     sigma=0.3;
%     W=least_squares_RBF(x_train,f2_train,centers,sigma);
%     Y = predict_RBF(x_train(2:end),W,centers,sigma);
%     Y=sign(Y);
%     error(ii)=mean(abs(f2_train(2:end)-Y));
% end
% figure(1)
% 
% plot(error)
% set(gca,'fontsize',14)
% to be below 0.1 we need 37 units, if we want to keep N>n, we need to stop
% at 60.
% If we transform Y by sign(Y), much better results! For 10 units, we have
% 0 as absolute error (for that we excluded the first point in 0 which can
% be misunderstood.

%plotting of the figures
% figure(1)
% clf
% hold on
% plot(x_train(2:end),f2_train(2:end))
% plot(x_train(2:end),Y)
% % plot(x_train(2:end),sign(Y))
% plot(centers, sin(2*centers), '+')
% legend('True', 'predicted','centers')

%% 3.2 with noise
rng(20);
x_test = (0.05:0.1:2*pi)';
f1_test = sin(2*x_test);
sigma_noise = sqrt(0.1);
 
f1_train_noise = f1_train + normrnd(0.0, sigma_noise, size(x_train)); %data with noise
f1_test_noise = f1_test + normrnd(0.0, sigma_noise, size(x_test));
% 
% %batch approach
error=zeros(1,62);
for ii = 1:62
    nb_centers=ii;
    max_step = 2*pi-0.1;
    step = (max_step -0.05) / (nb_centers-1);
%     centers=(0.05:step:max_step);   %positions of the units
%     ind = round(linspace(1,63,nb_centers));
%     centers = x_train(ind);
    centers = rand(nb_centers,1)*2*pi;
    sigma =0.105;
    W=least_squares_RBF(x_train,f1_train_noise,centers,sigma);
    Y = predict_RBF(x_train,W,centers,sigma);
    error(ii)=mean(abs(f1_train_noise-Y));
    
end
figure(4)
%plot(0.005:0.005:0.3,error)
hold on
plot(error)
set(gca,'fontsize',14)
%for 0.1 we need : 9 ;

% % incremental approach
% error = zeros(1,60);
% for ii =65
%     
%     nb_centers=ii;
%     max_step = 2*pi  - 0.1;
%     step = (max_step - 0.05) / (nb_centers-1);
%     centers=(0.05:step:max_step);
% %     ind = round(linspace(1,63,nb_centers));
% %     centers = x_train(ind);
% %    disp(length(centers))
%     sigma=0.03;
%     max_epochs = 300;
%     eta = 0.1;
%     W=delta_rule_RBF(x_train,f1_train_noise,centers,sigma, max_epochs, eta);
%     Y = predict_RBF(x_train,W,centers,sigma);
% %     error(ii)=mean(abs(f1_train_noise-Y));
%     mean(abs(f1_train_noise-Y))
% end
% % plot(error)
% % set(gca,'fontsize',14)
% 
% figure(1)
% clf
% hold on
% plot(x_train,f1_train_noise)
% plot(x_train,Y)
% plot(centers, sin(2*centers), '+')
% legend('True', 'predicted','centers')
% title(sprintf('Epochs %d, sigma %d, eta %d',max_epochs, sigma, eta))