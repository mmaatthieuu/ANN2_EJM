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
% %     imp_centers = [0 1/4*pi 3/4*pi 5/4*pi 7/4*pi 2*pi]; %important points
% %     if nb_centers <=6
% %         centers = [imp_centers(1:floor(nb_centers/2)) imp_centers(6-floor(nb_centers/2):6)];
% %     else
% %         max_step = 2*pi - 0.01;      %last unit center
% %         step = (max_step-0.01) / (nb_centers-7) ; %step between 2 units
% %         centers = [imp_centers 0.01:step:max_step];
% %     end
%     %disp(length(centers))
%     sigma=1.25;    
%     %width of the centers
%     W=least_squares_RBF(x_train,f1_train,centers,sigma);
%     Y = predict_RBF(x_train,W,centers,sigma);
%     error(ii)=mean(abs(f1_train-Y));   %absolute error
% end
% plot(error)
% % % to be below 0.1 we need 6 units, below 0.01 : 8 and below 0.001:10
% % % units.

%test for square(2x) without noise
% error = zeros(1,50);
% for ii = 1:50
%     nb_centers=ii;
%     max_step = 2*pi  - 0.05;
%     step = (max_step-0.05) / (nb_centers-1);
%     centers=(0.05:step:max_step);
%  %   disp(length(centers))
%     sigma=0.3;
%     W=least_squares_RBF(x_train(2:end),f2_train(2:end),centers,sigma);
%     Y = predict_RBF(x_train(2:end),W,centers,sigma);
%     Y=sign(Y);
%     error(ii)=mean(abs(f2_train(2:end)-Y));
% end
% plot(error)
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
% plot(x_train(2:end),sign(Y))
% plot(centers, sign(sin(2*centers)), '+')
% legend('True', 'predicted', 'sign of predicted','centers')

%% 3.2 with noise
%rng();
x_test = (0.05:0.1:2*pi)';
f1_test = sin(2*x_test);
sigma_noise = sqrt(0.1);
 
f1_train_noise = f1_train + normrnd(0.0, sigma_noise, size(x_train)); %data with noise
f1_test_noise = f1_test + normrnd(0.0, sigma_noise, size(x_test));
% 
% %batch approach
% error=zeros(1,60);
% for ii = 1:60
%     nb_centers=ii;
%     max_step = 2*pi-0.1;
%     step = (max_step -0.05) / (nb_centers-1);
%     centers=(0.05:step:max_step);   %positions of the units
% %    centers = rand(nb_centers, 1)*2*pi;
%     %sigma=1/(ii+100)^(1.1);
% %    centers = x_train(1:nb_centers);
%     sigma =0.4;
%     W=least_squares_RBF(x_train,f1_train_noise,centers,sigma);
%     Y = predict_RBF(x_test,W,centers,sigma);
%     error(ii)=mean(abs(f1_test_noise-Y));
%     
% end
% figure(4)
% plot(error)
%for 0.1 we need : 9 ;

% incremental approach
error = zeros(1,60);
for ii =45
    
    nb_centers=ii;
    max_step = 2*pi  - 0.1;
    step = (max_step - 0.05) / (nb_centers-1);
    centers=(0.05:step:max_step);
%    disp(length(centers))
%     sigma=0.8;
    
    figure(1)
    hold on
%     plot(x_train,f1_train)
%     plot(x_train, f1_train_noise)
%     plot(centers, sin(2*centers), '+')
    for sigma =0.1:0.5:3
        W=delta_rule_RBF(x_train,f1_train_noise,centers,sigma, 50, 0.01);
        Y = predict_RBF(x_test,W,centers,sigma);
        plot(x_train,Y)
    end
    legend('0.1','0.6','1.1','1.6','2.1','2.6')
%     error(ii)=mean(abs(f1_test_noise-Y));
end
% plot(error)
% plot



% legend('True','noisy data','centers', 'predicted')