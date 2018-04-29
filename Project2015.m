
%Exploratory Data analysis data was loaded as Recalls from 2015 *Change
%this per year*

figure('Color',[1 1 1]);
figure1=wordcloud(Recalls2015.MANUFACTURER_RECALL_REASON);
%%

%Data for class type recalls from 2015 *Change this per year*
Classfromfifteen=Recalls2015.RECALL_CLASS;
Freqbyclassofifteen=histcounts(Classfromfifteen);
%Change this value year as new data comes in
Date2015=Recalls2015.CENTER_CLASSIFICATION_DT;
monthData=month(Date2015,'name');
Reason=Recalls2015(:,11);
classRNames=[1 2 3 ];
figure2=bar(classRNames,Freqbyclassofifteen);
xlabel('Class type');
ylabel('Number of Recalls');
title('Number of Recalls by Class Type in 2015');
%%

filename=Recalls2015(:,11);
data=table2cell(filename,'TextType','string');

%Find repeating (unique) recall reasons
reprecalls=unique(filename,'stable');
B=tokenizedDocument(data);
%Filter out unwanted words
data2 = removeWords(B,stopWords);
data3 = removeShortWords(data2,4);

%Extract information on word conts
bag=bagOfWords(data3);
%Predictive model for recalls due to sterility
numTopics = 20;
mdl = fitlda(bag,numTopics);
predsterility = tokenizedDocument(["sterility"]);
topicIdx = predict(mdl,predsterility);
figure;
subplot(1,2,1);
wordcloud(mdl,topicIdx(1));
%%

