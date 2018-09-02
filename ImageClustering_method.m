clc; clear all

load mnist_train

digits = digits(:, 1:10000);

group = randi(20, 1, 10000);


% Assign the random groups

for i=1:20
    I = find(group == i);
    for j=1:length(I)
        Z(:,i) = mean(digits(:,I),2);
    end
end

%evaluate the quality of the clustering using the clustering objective and
%reassign group numbers

for c = 1:10000
    [J , index] = min(sum(abs((digits(:,c)-Z).^2)));
    group(1,c) = index;
end

% use the new group numbers to create new Z matrix

for i=1:20
    I = find(group == i);
    for j=1:length(I)
        Z(:,i) = mean(digits(:,I),2);
    end
end

% display images

for k=1:20
    subplot(4,5,k)
    imshow(reshape(Z(:,k), 28, 28));
end