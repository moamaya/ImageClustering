% 
% Pb 1.10
%

clc; clear all; close all;  % reset matlab 

load mnist_train % load data

ns = 500;   % nb of images to be used
ng = 20;     % nb of groups

digits = digits(:, 1:ns);  % use the first ns images
group = randi(ng, 1, ns);  % randoml initial group assignment

z = []; DJ = 1; J0 = 0; it =0; cvg=[]; eps = 1e-5; ifg = 0; % Initialization

while DJ>eps

it = it+1; % iteration #

% step 2 of k-means algorithm 4.1
for i=1:ng
	I = find(group == i); 
        M = digits(:,I); 
        z(:,i) = mean(M,2);
end

%% plot the first 3 results
if (ifg<3) 

ifg = ifg+1;
figure(ifg)
for k=1:ng 
 subplot(4,5,k)
 imshow(reshape(z(:,k), 28, 28));
end

end

% step 1 of k-means algorithm 4.1
J = 0;
for i=1:ns 
u = [];
for j=1:ng
	u(j) = norm(digits(:,i)-z(:,j))^2;
end
[p,q] = min(u); 
J = J+p; 
group(i) = q;
end

J = J/ns;
DJ = abs(J-J0)/J; 
J0 = J;


cvg(it) = DJ;

end

%% plot final results
ifg = ifg+1;
figure(ifg)
for k=1:ng 
 subplot(4,5,k)
 imshow(reshape(z(:,k), 28, 28));
end

%% plot convergence of k-means algorithm

ifg=ifg+1;
figure(ifg)
semilogy(cvg,'o-')

%% plot 8 randomly selected images of group ig

ifg=ifg+1;
figure(ifg)

ig = 1;
I = find(group==ig);
is = randi(length(I),1,8); % 8 randomly selected images

for k=1:8
 subplot(3,3,k)
 ir = I(is(k));
 imshow(reshape(digits(:,ir), 28, 28));
end
subplot(3,3,9)
imshow(reshape(z(:,ig), 28, 28));

