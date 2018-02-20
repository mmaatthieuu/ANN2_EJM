function centers = competitive_learning(centers, inputpattern, neighborhood, stepsize)
% calculate distances in output space
distances = abs(sin(2*centers)-sin(2*inputpattern));
%% use if multiple areas in the input map to multiple areas in the output
% set to 1 for default
extreme_points = uint32(length(centers)/4);
potential_winners = zeros([1 extreme_points]);
for i=1:extreme_points
    [~, potential_winners(i)] = min(distances);
    distances(potential_winners(i)) = Inf;
end
% find closest potential winner in input space
[~, temp] = min(abs(centers(potential_winners)-inputpattern));
winner = potential_winners(temp);
%% find and update neighours
if neighborhood>0
    for i=1:length(centers)
        if abs(centers(winner)-centers(i)) <= neighborhood
            centers(i) = centers(i) + stepsize * (inputpattern-centers(i));
        end
    end
end
% update winner
centers(winner) = centers(winner) + stepsize * (inputpattern-centers(winner));
end