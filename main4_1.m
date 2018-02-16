%% Debug stuff
rng(1)

%% Initialisation
NodeNumber=100;
MaxEpoch=20;
LearningRate=0.05;

%--------------------------------------------
W=rand(NodeNumber,84);
NextW=W;
Neighbourhood=round(linspace(NodeNumber/2,0,MaxEpoch));

%% Loading dataset
props=load('./datasets/animals.dat');
props=reshape(props,[32,84]);

fid=fopen('./datasets/animalnames.txt');
animals = textscan(fid,'%q');
animals=animals{1};
fclose(fid);

% BestNode=zeros(size(animals));

%% Training
for epoch=1:MaxEpoch+1  % +1 for the final classification
    BestNode=zeros(size(animals));
    for animal=1:length(animals)
      
        % Make the substraction of the line 'animal' to all the lines of W
        difference=W-props(animal,:);
        
        % Sum the the columns
        dist=sum(difference.^2,2);
        
        % Just to avoid picking the one of the considered animal
        %   (which is 0 so minimal)
        dist(animal)=max(dist);
        
%         [~,closestNeighbour(animal)]=min(dist);
        [~,BestNode(animal)]=min(dist);
        disp(BestNode(animal))
        if epoch<=MaxEpoch
            % To avoid overbound
            iMin=max([1,BestNode(animal)-Neighbourhood(epoch)]);
            iMax=min([NodeNumber,BestNode(animal)+Neighbourhood(epoch)]);

            DeltaW=LearningRate*(props(animal)-W);
            NextW(iMin:iMax,:)=NextW(iMin:iMax,:)+DeltaW(iMin:iMax,:);
        end
    end
    W=NextW;
end

animalsxxx=[animals,num2cell(BestNode)];
out=sortrows(animalsxxx,2)