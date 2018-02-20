%% Debug stuff
%rng(12)

%% Initialisation
% Number of hidden nodes
NodeNumber=10;

% Number of epochs
MaxEpoch=50;

LearningRate=0.15;

NeighbourhoodMax=3;  %max radius of neighbourhood

%--------------------------------------------
W=rand(NodeNumber*NodeNumber,31);
Neighbourhood=round(linspace(NeighbourhoodMax,0,MaxEpoch));

%% Loading dataset
votes=load('./datasets/votes.dat');
votes=reshape(votes,[31,349])';

nb_param = 31;
nb_mp = 349;

parties=load('./datasets/mpparty.dat');
sex = load('./datasets/mpsex.dat');
district = load('./datasets/mpdistrict.dat');


%% Training
for epoch=1:MaxEpoch+1
    BestNode=zeros(nb_mp,1);
    BestPos=zeros(nb_mp,2);
    for mp=1:nb_mp
        
        %         % Make the substraction of the line 'animal' to all the lines of W
        difference=(W-votes(mp,:));
        

        dist = sum(abs(difference),2);
        [~,BestNode(mp)]=min(dist);
       
        i_best = floor((BestNode(mp)-1)/NodeNumber) + 1;
        j_best = mod((BestNode(mp)-1),NodeNumber) + 1;
        BestPos(mp,:)=[i_best; j_best];
        if epoch <= MaxEpoch   %update not at the last time
            DeltaW=LearningRate*difference;

            for ii=1:NodeNumber
                for jj = 1:NodeNumber
                    if abs(ii-i_best) + abs(jj-j_best) <= Neighbourhood(epoch)
                        ind = (ii -1)*NodeNumber + jj;
                        W(ind,:) = W(ind,:) - DeltaW(ind,:);
                    end
                end
            end  
        end
    end
end

% Should be the only output
BestPos = BestPos + (rand(size(BestPos)) - 0.5);
figure(1)
gscatter(BestPos(:,1), BestPos(:,2),parties);
legend('no party','m','fp','s','v','mp','kd','c');
figure(2)
gscatter(BestPos(:,1), BestPos(:,2),sex);
legend('male','female')
figure(3)
gscatter(BestPos(:,1), BestPos(:,2),district);

