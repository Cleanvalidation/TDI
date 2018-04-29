
%Exploratory Data analysis data was loaded as Recalls from 2013

figure('Color',[1 1 1]);
figure1=wordcloud(recalls2002.MANUFACTURER_RECALL_REASON);
%%

%Data for class type recalls from late 2002
classthirteen=recalls2002.RECALL_CLASS;
Freqbyclassotwo=histcounts(classthirteen);
%Change this value year as new data comes in
Date2002=recalls2002.CENTER_CLASSIFICATION_DT;
monthData=month(Date2002,'name');
Reason=recalls2002(:,11);
classRNames=[1 2 3];
figure3=bar(classRNames,Freqbyclassotwo);
xlabel('Class type');
ylabel('Number of Recalls');
title('Number of Recalls by Class Type in 2002');
%%

filename=recalls2002(:,11);
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

