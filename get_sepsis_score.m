function [scores, labels]  = get_sepsis_score(data1,model)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



data=data1;

xxx=find(data(:,4)<data(:,6));

for ii=1:length(xxx)
    uu=data(xxx(ii),4);
    vv=data(xxx(ii),6);
    data(xxx(ii),6)=uu;
    data(xxx(ii),4)=vv;
end

[data] = fillthenans1(data);

%traindata = (rawdata_A - x_mean)./x_std;
%    traindata(isnan(traindata)) = 0;



% mu1=[83.8996000000000,97.0520000000000,36.8055000000000,126.224000000000,86.2907000000000,66.2070000000000,18.7280000000000,33.7373000000000,-3.19230000000000,22.5352000000000,0.459700000000000,7.38890000000000,39.5049000000000,96.8883000000000,103.426500000000,22.4952000000000,87.5214000000000,7.72100000000000,106.198200000000,1.59610000000000,0.694300000000000,131.532700000000,2.02620000000000,2.05090000000000,3.51300000000000,4.05410000000000,1.34230000000000,5.27340000000000,32.1134000000000,10.5383000000000,38.9974000000000,10.5585000000000,286.540400000000,198.677700000000,60.8711000000000,0.543500000000000,0.0615000000000000,0.0727000000000000,-59.6769000000000,28.4551000000000];
% stdd1=[17.6494000000000,3.01630000000000,0.689500000000000,24.2988000000000,16.6459000000000,14.0771000000000,4.70350000000000,11.0158000000000,3.78450000000000,3.15670000000000,6.26840000000000,0.0710000000000000,9.10870000000000,3.39710000000000,430.363800000000,19.0690000000000,81.7152000000000,2.39920000000000,4.97610000000000,2.06480000000000,1.99260000000000,45.4816000000000,1.60080000000000,0.379300000000000,1.30920000000000,0.584400000000000,2.55110000000000,20.4142000000000,6.43620000000000,2.23020000000000,29.8928000000000,7.06060000000000,137.388600000000,96.8997000000000,16.1887000000000,0.498100000000000,0.796800000000000,0.802900000000000,160.884600000000,29.5367000000000];
% rawdata=(data-mu1)./stdd1;
% 
% 
% for clm=1:40
% % %     
% rawdata(isnan(rawdata(:,clm)),clm)=0;
% end

%for extened data--proposed features


 [labels,scores1]=newfeatcomb(data(end,:),model);

 scores=scores1(:,2);
 
 %labels=mode([labels1,labels2,labels3,labels4,labels5,labels6,labels7]);
 %scores=mode([scores1(:,2),scores2(:,2),scores3(:,2),scores4(:,2),scores5(:,2),scores6(:,2),scores7(:,2)])/sum([scores1(:,2),scores2(:,2),scores3(:,2),scores4(:,2),scores5(:,2),scores6(:,2),scores7(:,2)]);

 
end

function [labels1,scores1]=newfeatcomb(data,model)

% feat11=data(:,1)./(data(:,35).^2);%correct
% feat12=data(:,6)./(data(:,36).^2);
% feat13=data(:,8)./(data(:,31).^2);
% feat14=data(:,35)./(data(:,36).^2);
% 
% 
% 
% 
% feat=[feat11 feat12 feat13 feat14  ];

%feat=[feat11 feat12];

%traindata3=feat;
 traindata3=data(:,1)./data(:,4);
% for clm=1:9
% % %     
% traindata3(isnan(traindata3(:,clm)),clm)=0;
% end
% for clm=1:9
% % %     
% traindata3(isinf(traindata3(:,clm)),clm)=0;
% end

%mu1=[20.6943662309956,-5.50202839447286,0.831380544659131,0.0689243900330537,-0.290140146398514,-2.80330968396363e-06,100,100,100];
%stdd1=[4.20965824983989,2.53717060417119,0.185756932252486,0.00472611278201726,0.109055621852500,1.83913548671300e-07,1,1,1];
 

%traindata4=(traindata3-mu1)./stdd1;
traindataf1=[data(:,:) traindata3];
[labels1,scores1]=predict(model,traindataf1);
end

% function [outputdata] = fillthenans(data1)
% %UNTITLED2 Summary of this function goes here
% 
% outputdata=[];
% for t = 1:size(data1,1)
%             current_data = data1(1:t, :);
%             [outputdata1] = fillthenans1(current_data);
%             %[current_score, current_label] =shiventry(current_data,RUSboost,mutr,stddtr,template);
%            outputdata=[outputdata; outputdata1];
% end
% 
% %   Detailed explanation goes here
% end


function [outputdata] = fillthenans1(inputdata)
 outputdataf=[];
 if(size(inputdata,1)==1)
     outputdataf=inputdata;
 else
        
        for uu=1:40
        datata=fillmissing(inputdata(:,uu)','linear',2,'EndValues','nearest');
        outputdataf(:,uu)=datata';
        end
        
 end
outputdata=outputdataf(:,:);

end


