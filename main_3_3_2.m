% initial set up of NN
sigma = 1.0;
number_centers = 5;
centers = zeros(number_centers, 2);
for i = 1:number_centers
    centers(i,:) = rand([1 2]);
end
% read data which is stored in a shitty way
[x_train, y_train] = readData(importdata("datasets/ballist.dat"));
[x_test, y_test] = readData(importdata("datasets/balltest.dat"));
W = least_squares_RBF(x_train, y_train, centers, sigma);

disp(centers)
rounds = 100;
for i = 1:rounds
    next_index = uint8(rand*99)+1;
    centers = comp3(centers,x_train(next_index,:),y_train(next_index,:),W,sigma);
    W = least_squares_RBF(x_train, y_train, centers, sigma);
end
disp(centers)

predict = predict_RBF(x_train, W, centers, sigma);

figure(2);
clf;
plot(predict(:,1), predict(:,2), '*');

figure(1);
clf;
plot(y_train(:,1), y_train(:,2), '*');

figure(3);
clf;
plot(x_train(:,1), x_train(:,2), '*');

function [x, y] = readData(data)
x1 = str2double(string(cell2mat(data.textdata(:,1))));
temp = cell2mat(data.textdata(:,2));
x2 = str2double(string(temp(:,1:5)));
y1 = str2double(string(temp(:,7:11)));
y2 = data.data;
x = [x1, x2];
y = [y1 y2];
end