%% Debug stuff

close all

animation=true;
plotWeight=true;

LearningRate=0.5;
% Number of hidden nodes
NodeNumber=100;
% % Number of epochs
MaxEpoch=10;

% "circle", "random" or "uniform"
InitialDistribution="uniform";

% Neighbourhood
Nbrhd=round(linspace(3,0,MaxEpoch));



cities=load('./datasets/cities.dat');

if InitialDistribution=="circle"
    x_init=linspace(0,2*pi,NodeNumber+1)';
    W=[cos(x_init(1:end-1)) sin(x_init(1:end-1))]./2+0.5;
elseif InitialDistribution=="random"
    W=rand(NodeNumber,2);
elseif InitialDistribution=="uniform"
    [X,Y]=meshgrid(linspace(0,1,round(sqrt(NodeNumber))));
    W=[reshape(X,[],1) reshape(Y,[],1)];
end



circ = @(x) (1 + mod(x-1, NodeNumber));

tour=zeros(size(cities)+[1 0]);
BestNodeArray=zeros(length(cities),1);

figure
hold on

for epoch=1:MaxEpoch
    hold on
    for city=1:length(cities)
        
        dist=sqrt((W(:,1)-cities(city,1)).^2+(W(:,2)-cities(city,2)).^2);
        
        [~,BestNode]=min(dist);
        BestNodeArray(city)=BestNode;
        
        difference=(W-cities(city,:));
        W(circ(BestNode-Nbrhd):circ(BestNode+Nbrhd),:)=...
            W(circ(BestNode-Nbrhd):circ(BestNode+Nbrhd),:)-...
            LearningRate*difference(circ(BestNode-Nbrhd):circ(BestNode+Nbrhd),:);
        
        tour(city,:)=W(BestNode,:)
        tour(end,:)=tour(1,:);
        
        
        if animation && epoch>1
            if plotWeight
                plot(W(:,1),W(:,2),'r+')
            end
            plot(tour(:,1),tour(:,2),'b-')
            scatter(cities(:,1), cities(:,2))
            title(sprintf('Epoch %d/%d',epoch,MaxEpoch))
            pause(0.1)
        end
        clf
        hold on
    end
%     tour(end,:)=tour(1,:);
    
end

            if plotWeight
                plot(W(:,1),W(:,2),'r+')
            end
            plot(tour(:,1),tour(:,2),'b-')
            scatter(cities(:,1), cities(:,2))
            

tour=sortrows([cities BestNodeArray],3);
tour(end+1,:)=tour(1,:);

figure;plot(tour(:,1),tour(:,2));hold on
scatter(cities(:,1), cities(:,2))


