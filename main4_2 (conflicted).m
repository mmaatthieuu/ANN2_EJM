%% Debug stuff

close all

animation=false;
plotWeight=true;

LearningRate=0.2;
% Number of hidden nodes
NodeNumber=1000;
% % Number of epochs
MaxEpoch=20;

% "circle", "random" or "uniform"
InitialDistribution="circle";

% Neighbourhood
Nbrhd=round(linspace(NodeNumber*0.2,0,MaxEpoch));



cities=load('./datasets/cities.dat');
cities=cities(randperm(size(cities,1)),:);

if InitialDistribution=="circle"
    x_init=linspace(0,2*pi,NodeNumber+1)';
    W=[cos(x_init(1:end-1)) sin(x_init(1:end-1))]./2+0.5;
elseif InitialDistribution=="random"
    W=rand(NodeNumber,2);
elseif InitialDistribution=="uniform"
    [X,Y]=meshgrid(linspace(-1,2,round(sqrt(NodeNumber))));
    W=[reshape(X,[],1) reshape(Y,[],1)];
end


NextW=W;

circ = @(x) (1 + mod(x-1, NodeNumber));

tour=zeros(size(cities)+[1 0]);
tour2=tour;
BestNodeArray=zeros(length(cities),1);

figure
hold on

for epoch=1:MaxEpoch+1
    hold on
    for city=1:length(cities)
        
        dist=sqrt((W(:,1)-cities(city,1)).^2+(W(:,2)-cities(city,2)).^2);
        
        [~,BestNode]=min(dist);
        BestNodeArray(city)=BestNode;
        
        if epoch<=MaxEpoch
            difference=(W-cities(city,:));
            NextW(circ((BestNode-Nbrhd):(BestNode+Nbrhd)),:)=...
                NextW(circ((BestNode-Nbrhd):(BestNode+Nbrhd)),:)-...
                LearningRate*difference(circ((BestNode-Nbrhd):(BestNode+Nbrhd)),:)./...
                (1+dist(circ((BestNode-Nbrhd):(BestNode+Nbrhd)),:));

            tour(city,:)=W(BestNode,:);

            tour(end,:)=tour(1,:);
        end
        
        
        if animation && epoch>1
            tour2=sortrows([cities BestNodeArray],3);
            tour2(end+1,:)=tour2(1,:);
            scatter(cities(:,1), cities(:,2),'bo')
            scatter(cities(city,1), cities(city,2),'ro')
            plot(tour2(:,1),tour2(:,2),'b-')
%             pause(0.5)
            if plotWeight
                plot(W(:,1),W(:,2),'r+')
            end
            

            title(sprintf('Epoch %d/%d',epoch,MaxEpoch))
            pause(0.02)
        end
        clf
        hold on
    end
    W=NextW;
%     tour(end,:)=tour(1,:);
        disp(BestNodeArray)
end

tour2=sortrows([cities BestNodeArray],3);
tour2(end+1,:)=tour2(1,:);
if plotWeight
    plot(W(:,1),W(:,2),'r+')
end
plot(tour2(:,1),tour2(:,2),'b-')
scatter(cities(:,1), cities(:,2))
            

tour=sortrows([cities BestNodeArray],3);
tour(end+1,:)=tour(1,:);

figure;
set(gca,'FontSize',14)
plot(tour(:,1),tour(:,2));
hold on
scatter(cities(:,1), cities(:,2))


