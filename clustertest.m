%cluster hyperparameter testing

%% Hierarchy
hiervec = zeros(100,1);
for ii = 2:100
    S = silhouette(clustertest,clusterdata(clustertest,'MaxClust',ii));
    hiervec(ii) = sum(S);
end
[val,idx]=max(hiervec);
fprintf('Best performance of Hierarchical clustering is %f in %d number of clusters \n', val,idx)

%% Kmeans
kmeansvec = zeros(100,1);
for ii = 2:100
    S = silhouette(clustertest,kmeans(clustertest,ii));
    kmeansvec(ii) = sum(S);
end
[val,idx]=max(kmeansvec);
fprintf('Best performance of K-means clustering is %f in %d number of clusters \n', val,idx)

%% Spectral
spectralvec = zeros(100,1);
for ii = 2:100
    S = silhouette(clustertest,spectralcluster(clustertest,ii));
    spectralvec(ii) = sum(S);
end
[val,idx]=max(spectralvec);
fprintf('Best performance of Spectral clustering is %f in %d number of clusters \n', val,idx)

