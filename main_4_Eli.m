%% Debug stuff
% rng(400)

%% Initialisation
% Number of hidden nodes
NodeNumber=100;

% Number of epochs
MaxEpoch=50;

LearningRate=0.15;

% Ratio of the NodeNumber to be considered as neibourhood initially
%   i.e. 0.25 with NodeNumber=100 will give a neighbourhood of 
%   +/-25 hidden nodes. The neighbourhood always decrease linearly to 0
%   with the epochs
NeighbourhoodInitialRation=0.25;

% Choose the style of neighbourhood:
%         ____
% 1) _____|   |______
%          _
% 2)______/ \_______
%
NeighbourhoodStyle=1;

%--------------------------------------------
W=rand(NodeNumber,84);
NextW=W;
Neighbourhood=round(linspace(NodeNumber*NeighbourhoodInitialRation,1,MaxEpoch));

%% Loading dataset
props=load('./datasets/animals.dat');
props=reshape(props,[32,84]);

fid=fopen('./datasets/animalnames.txt');
animals = textscan(fid,'%q');
animals=animals{1};
fclose(fid);

% Mostly to debug, keep track of the winning nodes at every epochs
HISTORY=zeros(32,MaxEpoch+1);

%% Training
for epoch=1:MaxEpoch+1  % +1 for the final classification
    BestNode=zeros(size(animals));
    for animal=1:length(animals)
      
%         % Make the substraction of the line 'animal' to all the lines of W
        difference=(W-props(animal,:));
        
%         % Sum the columns squared
%        dist=sum(difference.^2,2);
        dist = sum(abs(difference),2);
%         [~,closestNeighbour(animal)]=min(dist);
        [~,BestNode(animal)]=min(dist);
%         disp(BestNode(animal))
        if epoch<=MaxEpoch
            % To avoid overbound
            iMin=max([1,BestNode(animal)-Neighbourhood(epoch)]);
            iMax=min([NodeNumber,BestNode(animal)+Neighbourhood(epoch)]);
            
            DeltaW=LearningRate*difference;
            
%             % To decrease deltaW the futherwe go from the winning node
%             % Not required in the instructions but I tried to try to
%             % compensate the bad results
                h1=linspace(0,1,Neighbourhood(epoch));
                h2=linspace(1,0,Neighbourhood(epoch));

                h1=h1(Neighbourhood(epoch)-(BestNode(animal)-iMin)+1:end);
                h2=h2(1:iMax-BestNode(animal));
                h=[ h1 1 h2];

            
            if NeighbourhoodStyle==1
%             % Without weighting the neighbourhood (it's necessary to use a
%             %   smaller LearningRate or NeighbourhoodInitialRation
                %NextW(iMin:iMax,:)=NextW(iMin:iMax,:)-DeltaW(iMin:iMax,:);
                W(iMin:iMax,:)=W(iMin:iMax,:)-DeltaW(iMin:iMax,:);
            elseif NeighbourhoodStyle==2
%             % Weighting the neighbourhood 
                NextW(iMin:iMax,:)=NextW(iMin:iMax,:)-DeltaW(iMin:iMax,:).*h';
            end
     
        end
    end
%     % To prevent updating when printing the result
%     if epoch<MaxEpoch
%         W=NextW;
%     end
%     %To debug
%         disp(epoch)
%         disp(iMin)
%         disp(iMax)
    %     disp(max(dist))
    %     disp(BestNode)
%         out=sortrows([animals,num2cell(BestNode)],2);
        HISTORY(:,epoch)=BestNode;
end

% Should be the only output
out=sortrows([animals,num2cell(BestNode)],2)