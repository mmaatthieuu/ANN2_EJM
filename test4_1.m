props=load('./datasets/animals.dat');
props=reshape(props,[84,32])';

fid=fopen('./datasets/animalnames.txt');
animals = textscan(fid,'%q');
animals=animals{1};
fclose(fid);

A=zeros(32);

for i=1:length(animals)
    for j=1:length(animals)
        
        A(i,j)=sum(abs(props(i,:)-props(j,:)));
        
    end
end
