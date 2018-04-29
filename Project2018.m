
%Exploratory Data analysis data was loaded as Recalls

figure('Color',[1 1 1]);
figure1=wordcloud(Recalls.MANUFACTURER_RECALL_REASON);
%%

%Data for class type recalls from late 2017 to 2018
Classeighteen=Recalls.RECALL_CLASS;
Freqbyclasseighteen=histcounts(Classeighteen);
%Change this year as new data appears
Date2018=Recalls.CENTER_CLASSIFICATION_DT;
monthData=month(Date2018,'name');
Reason=Recalls(:,11);
classRNames=[1 2 3 0];
figure2=bar(classRNames,Freqbyclasseighteen);
xlabel('Class type');
ylabel('Number of Recalls');
title('Number of Recalls by Class Type in 2018');
%%

filename=Recalls(:,11);
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

