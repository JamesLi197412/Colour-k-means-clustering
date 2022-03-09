function[imgOut,mu] = kmean(k,mu,imagefloat)

R = imagefloat(:,:,1);
G = imagefloat(:,:,2);
B = imagefloat(:,:,3);
imgOut = zeros(size(imagefloat));
[rows,columns] = size(R);
d = rows*columns;
% distance = zeros(1,k);

iteration = 1;
while(1)
    for r = 1:k
                % Calcuate distance
    %             distance1 = meanR(r) - R(i,j);
    %             Eucdist1 = sum(distance1.^2,2);
    %             distance2 = meanB(r) - B(i,j);
    %             Eucdist2 = sum(distance2.^2,2);
    %             distance3 = meanG(r) - G(i,j);
    %             Eucdist3 = sum(distance3.^2,2);
        distance(:,:,r) = sqrt(sum((imagefloat-mu(r,1,:)).^2,3));
    end
    % Find out minimum distance
    [~,index] = min(distance,[],3);


    for i = 1:k
        clusterIndex = find(index ==i);

        % get image valus for all 3 RGB values
        clusterValues =[imagefloat(clusterIndex) imagefloat(clusterIndex+d) imagefloat(clusterIndex+2*d)];

        % update the mean values
        mu(i,1,:) = reshape(mean(clusterValues),[],1,3);

        % update the colored output
        for j = 0:2
            temp = mean(clusterValues);
            imgOut(clusterIndex+j*d) =temp(j+1);
        end

    end

    % Plotting the image and cluster, dots
    figure(2);
    imshow(uint8(imgOut));
    title('Clustered Image')


    % imgOut(:,:,1) = result_R;
    % imgOut(:,:,2) = result_G;
    % imgOut(:,:,3) = result_B;
    % 
    % figure(2);
    % title("resotred image");
    % imshow(uint8(imgOut));
    % 
    % figure(3);
    % sublot(1,2,1);image(uint8(imgOut),'CDataMapping','scaled');
    % 
    % 
    % % Task 3: Plotting
    % for m = 1 : k
    %     countR = 0;
    %     countG = 0;
    %     countB = 0;
    %     
    %     scatterR = 0;
    %     scatterB = 0;
    %     scatterG = 0;
    %     
    %     for i = 1:rows
    %         for j = 100 : 100 :columns
    %                 if result_R(i,j) == meanR(h)
    %                     countR = countR + 1;
    %                     scatterR(countR) = R(i,j);
    %                 end
    %                 if result_G(i,j) == meanG(h)
    %                     countG = countG + 1;
    %                     scatterG(countG) = R(i,j);
    %                 end
    %                 if result_B(i,j) == meanB(h)
    %                     countB = countB + 1;
    %                     scatterB(countB) = R(i,j);
    %                 end
    %                 
    %            
    %         end
    %     end
    % end

    % scatter plot
    scatterrows = 1:rows;
    scattercolumns = 1:100:columns;
    scatterplot = zeros(length(scatterrows) * length(scattercolumns),3);
    for i = 1:3
        scatterplot(:,i) = reshape(imagefloat(scatterrows,scattercolumns,i),[],1);
    end

    scatterlabels = (reshape(imgOut(scatterrows,scattercolumns,:),[],3))/255;
    figure(3);
    scatter3(scatterplot(:,1),scatterplot(:,2),scatterplot(:,3),8,scatterlabels,'filled');
    hold on;
    scatter3(mu(:,:,1),mu(:,:,2),mu(:,:,3),'*','r','filled');
    xlabel('Red');
    ylabel('Green');
    zlabel('Blue');
    title("Iteration:" + num2str(iteration));
    pause();
    iteration = iteration + 1;
end

end