

%Exploratory Data analysis data was loaded as Recalls from 2009 This had to be imported as a string file*Change
%this per year*
figure('Color',[1 1 1]);
Recallssix=tokenizedDocument(Recalls2006S);
data5 = removeWords(Recallssix,stopWords);
data5 = removeShortWords(data5,4);
data5= lower(data5);
bag=bagOfWords(data5);
twosix=table(bag);
figure1=wordcloud(bag);

%%

%Data for class type recalls from 2006 *Change this per year*
Classfromosix=Recalls2006.RECALL_CLASS;
Freqbyclassosix=histcounts(Classfromosix);
%Change this value year as new data comes in
Date2006=Recalls.CENTER_CLASSIFICATION_DT;
monthData=month(Date2006,'name');
Reason=Recalls2006(:,11);
classRNames=[1 2 3 ];
figure2=bar(classRNames,Freqbyclassosix);
xlabel('Class type');
ylabel('Number of Recalls');
title('Number of Recalls by Class Type in 2006');
%%

filename=Recalls2006(:,11);
data=table2cell(filename,'TextType','string');

%Find repeating (unique) recall reasons
reprecalls=unique(filename,'stable');
B=tokenizedDocument(data);
%Filter out unwanted words
data2 = removeWords(B,stopWords);
data3 = removeShortWords(data2,4);

%Extract information on word conts
bag=bagOfWords(data4);
%Predictive model for recalls due to sterility
numTopics = 20;
mdl = fitlda(bag,numTopics);
predsterility = tokenizedDocument(["sterility"]);
topicIdx = predict(mdl,predsterility);
figure;
subplot(1,2,1);
wordcloud(mdl,topicIdx(1));
%%

