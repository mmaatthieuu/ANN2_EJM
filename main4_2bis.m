%% Debug stuff
%rng(12)

%% Initialisation
% Number of hidden nodes
close all

animation=false;
plotWeight=false;

LearningRate=0.2;
% Number of hidden nodes
NodeNumber=20;
% % Number of epochs
MaxEpoch=10;

% "circle", "random" or "uniform"
InitialDistribution="circle";

% Neighbourhood
Neighbourhood=round(linspace(3,0,MaxEpoch));



cities=load('./datasets/cities.dat');
cities=cities(randperm(size(cities,1)),:);

% if InitialDistribution=="circle"
%     x_init=linspace(0,2*pi,NodeNumber+1)';
%     W=[cos(x_init(1:end-1)) sin(x_init(1:end-1))]./2+0.5;
% elseif InitialDistribution=="random"
%     W=rand(NodeNumber,2);
% elseif InitialDistribution=="uniform"
%     [X,Y]=meshgrid(linspace(0,1,round(sqrt(NodeNumber))));
%     W=[reshape(X,[],1) reshape(Y,[],1)];
% end



circ = @(x) (1 + mod(x-1, NodeNumber));

tour=zeros(size(cities)+[1 0]);
tour2=tour;
BestNodeArray=zeros(length(cities),1);

figure
hold on

W=rand(NodeNumber,2);

nb_param = 2;
nb_city = 10;

%% Training
for epoch=1:MaxEpoch+1
    BestNode=zeros(nb_city,1);
    BestPos=zeros(nb_city,2);
    for city=1:nb_city
        
        %         % Make the substraction of the line 'animal' to all the lines of W
%         difference=(W-cities(:,mp));
%         
% 
%         dist = sum(abs(difference),2);

        dist=sqrt((W(:,1)-cities(city,1)).^2+(W(:,2)-cities(city,2)).^2);

        [~,BestNode(city)]=min(dist);
       
%         i_best = floor((BestNode(city)-1)/NodeNumber) + 1;
%         j_best = mod((BestNode(city)-1),NodeNumber) + 1;
%         BestPos(city,:)=[i_best; j_best];
        if epoch <= MaxEpoch   %update not at the last time
            DeltaW=LearningRate*dist;

            
            W(circ(BestNode-Neighbourhood):circ(BestNode+Neighbourhood),:)=...
                
            
%             for ii=1:NodeNumber
%                 for jj = 1:NodeNumber
%                     if abs(circ(ii-i_best)) + abs(circ(jj-j_best)) <= Neighbourhood(epoch)
%                         ind = circ((ii -1)*NodeNumber + jj);
%                         W(ind,:) = W(ind,:) - DeltaW(ind,:);
%                     end
%                 end
%             end  
        end
    end
end



