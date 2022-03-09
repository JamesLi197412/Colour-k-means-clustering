
% k++ means method
img = imread("mandrill.jpg");

% Present the image
figure(1);
imshow(img);
title("Original Image");

imagefloat = double(img);
sizeIm = size(imagefloat);
k = 4;

% initialisation
% means = zeros(k,2);

% randomly extract k points here.
% Random 4 pixels
clusters = [randperm(sizeIm(1),k);randperm(sizeIm(2),k)]';
mu = zeros(k,1,3);

% for i = 1:k
%     rng('shuffle')   % Control random number generator
%     means(i,1) = randi(sizeIm(1));
%     means(i,2) = randi(sizeIm(2));
% end

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

% for i = 1:k
%     mean_R(i) = R(cluster(i,1),cluster(i,2));
%     mean_G(i) = G(cluster(i,1),cluster(i,2));
%     mean_B(i) = B(cluster(i,1),cluster(i,2));
% end

for i = 1:k
    % get initial mean values based on random value from image
    meanvalue(i,1,:) = imagefloat(clusters(i,1),clusters(i,2),:);
end

mean_R = meanvalue(:,:,1);
mean_B = meanvalue(:,:,2);
mean_G = meanvalue(:,:,3);

% Perform k means algorithm and visualisation
[imgOut1,mu1] = kmean(k,meanvalue,imagefloat);

%[imgOut2,mu2] = kmeansplus(k,imagefloat);



