
%Exploratory Data analysis data was loaded as Recalls from 2013 This had to be imported as a string file*Change
%this per year*
figure('Color',[1 1 1]);
Recallsthirteen=tokenizedDocument(Recalls2013S);
data13 = removeWords(Recallsthirteen,stopWords);
data13=lower(data13);
data13 = removeShortWords(data13,4);
bag=bagOfWords(data13);
twothirteen=table(bag);
figure1=wordcloud(bag);
%%

%Data for class type recalls from 2013
classthirteen=Recalls2013.RECALL_CLASS;
Freqbyclassthirteen=histcounts(classthirteen);
%Change this value year as new data comes in
Date2013=Recalls.CENTER_CLASSIFICATION_DT;
monthData=month(Date2013,'name');
Reason=recalls2002(:,11);
classRNames=[1 2 3];
figure3=bar(classRNames,Freqbyclassthirteen);
xlabel('Class type');
ylabel('Number of Recalls');
title('Number of Recalls by Class Type in 2013');
%%
Recalls2013=Recalls2013.MANUFACTURER_RECALL_REASON;
filename=Recalls2013(:,11);
datathirt=table2cell(filename,'TextType','string');

%Find repeating (unique) recall reasons
reprecalls=unique(filename,'stable');
B=tokenizedDocument(datathirt);
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

