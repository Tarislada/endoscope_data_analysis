dirname = 'C:\Users\endyd\OneDrive\Onedrive-CK\OneDrive\문서\카카오톡 받은 파일\walltaskclassifier\deleted_0\';
accuracy = zeros(22,2);
for i = 1:22
%     accuracy(i,2) = autoclass(shufflematcell{i});
%     autoclass(collmatcell{i});
    autoclass(collmatcell{i});
%     filename = append(dirname,list(i),'_sh','.fig');
    filename = append(dirname,list(i),'.fig');
    saveas(gcf,filename);
    close all
end

testcollmatcellidx = cellfun(@(x) find(~x(:,end)),collmatcell,'UniformOutput',false);

tmpmat = [];
tmpcell = collmatcell;
for ii = 1:length(collmatcell)
tmpcell{ii}(testcollmatcellidx{ii},:)=[];
end

testcollmatcellidx = cellfun(@(x) find(x(:,end)==1),collmatcell,'UniformOutput',false);
tmpmat = [];
for ii = 1:length(collmatcell)
tmpcell{ii}(testcollmatcellidx{ii},:)=[];
end
