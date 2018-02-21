function new_centers = comp3(centers, x, y, W, sigma)
n = size(centers,1);
projected = predict_RBF(centers, W, centers, sigma);
distances = zeros(n,1);
for i = 1:n
    distances(i) = norm(projected(i,:)-y);
end
[~, winner] = min(distances);
new_centers = centers;
new_centers(winner,:) = new_centers(winner,:) + 0.2 * (x-new_centers(winner,:));
end