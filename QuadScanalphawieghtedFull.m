function [Dist,RM,QS]=QuadScanalphawieghtedFull(X,alpha)

%This function is to apply Recurrence plot and Quardant Scan analysis for
%transitions or boundaries detection. 
%X is the input data, X could be multivariate input where columns
%are the variables
%alpha is the threshold, it is for the recurrence analysis
%Dist is the distance (norm) matrix, RM is the recurrence matrix, QS is the quadrant scan curve
%If you use this code please read and cite our paper "Fast Automatic Detection of Geological Boundaries from Multivariate Log Data Using Recurrence
%Journal: Computers and Geosciences"

X=bsxfun(@rdivide,X,sum(X)); %normalisation (importnat when we have multi-variable input)

N = size(X,1);

Dist=zeros(N);

%%%% Norm Matrix %%%%
for i=1:N
    
    x0=i;
    for j=i:N
        y0=j;
        % Calculate the euclidean distance
        distance = norm(X(i,:)-X(j,:));
        % Store the minimum distance between the two points
        Dist(x0,y0) = distance;
        Dist(y0,x0) = distance;        
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Ploting the Distance (Norm) Matrix)%%%%%

    figure('Position',[100 100 550 400]);
    imagesc(Dist);
    colorbar;
    axis image;    
    xlabel('Depth Index','FontSize',10,'FontWeight','bold');
    ylabel('Depth Index','FontSize',10,'FontWeight','bold');
    title('Norm Matrix','FontSize',10,'FontWeight','bold');
    get(gcf,'CurrentAxes');
    set(gca,'YDir','normal')
    set(gca,'LineWidth',2,'FontSize',10,'FontWeight','bold');


%%%%% Define threshold %%%%
threshold=alpha*(mean(Dist(:))+3*std(Dist(:)));

%%%%% Recurrence plot matrix %%%%
RM=zeros(size(Dist,1),size(Dist,2));
for i=1:size(Dist,1)       
    for j=i+1:size(Dist,1)
        if Dist(i,j) <= threshold
            RM(i,j)=1;
            RM(j,i)=1;
        end
    end
end
RM = RM +eye(size(Dist,1));

%%%% Ploting the recurrence plot %%%
    figure('Position',[100 100 550 400]);
    imagesc(RM);
    axis image;    
    xlabel('Depth','FontSize',10,'FontWeight','bold');
    ylabel('Depth','FontSize',10,'FontWeight','bold');
    title('Recurrence Plot','FontSize',10,'FontWeight','bold');
    get(gcf,'CurrentAxes');
    set(gca,'YDir','normal')
    set(gca,'LineWidth',2,'FontSize',10,'FontWeight','bold');

%%%% Quadrant Scan: Two options: %%%%
% (1) Density QS 
% QS=quadrant(RM);   % Density Quadrant Scan: import Function "quadrant"

% (2) Weighted QS
QS=quadrantwieghted(RM); %Weighted Quadrant Scan: import Function "quadrantwieghted"

%%%% Ploting the quadrant scan %%%%
figure('Position',[100 100 550 400]);
plot(QS)
