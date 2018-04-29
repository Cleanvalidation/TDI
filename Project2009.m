
%Exploratory Data analysis data was loaded as Recalls from 2009 This had to be imported as a string file*Change
%this per year*
figure('Color',[1 1 1]);
Recallsnine=tokenizedDocument(Recalls2009S);
data5 = removeWords(Recallsnine,stopWords);
data6=lower(data5);
data1 = removeShortWords(data6,4);
bag=bagOfWords(data1);
twonine=table(bag);
figure1=wordcloud(bag);

%%

%Data for class type recalls from 2006 *Change this per year*
Classfromonine=Recalls2009.RECALL_CLASS;
Freqbyclassonine=histcounts(Classfromonine);
%Change this value year as new data comes in
Date2009=Recalls2009.CENTER_CLASSIFICATION_DT;
monthData=month(Date2009,'name');
Reason=Recalls2009(:,11);
classRNames=[1 2 3 ];
figure2=bar(classRNames,Freqbyclassonine);
xlabel('Class type');
ylabel('Number of Recalls');
title('Number of Recalls by Class Type in 2009');
%%

filename=Recalls2009(:,11);
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

