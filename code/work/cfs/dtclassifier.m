function dtclassifier(newdata,labels,newatt,testdata,classnum)

t=treefit(newdata,labels);
sfit=treeval(t,testdata(:,newatt));
dr=mean(eq(sfit,testdata(:,classnum)));

display('Detection rate:');
dr