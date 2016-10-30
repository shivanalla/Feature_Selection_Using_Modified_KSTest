function irrelevant(dataset)

[m,n]=size(dataset);

% Remove irrelevant features

%k=input('Enter the no: of bins for discretization of features:');
%for i=1:n
%   discretize(dataset,i,k);
%end
    
entropies=zeros(n,1);
gain=zeros(n-1,2);

for i=1:n
    entropies(i)=entropy(dataset,i);
end
entropies
for i=1:n-1
    gain(i,1)=i;
    gain(i,2)=entropies(n)-entropies(i);
end

sortrows(gain,2);
save gain;
gain


%Calculating Symmetrical uncertainities
su=zeros(n-1,2);
for i=1:n-1
    su(i,1)=i;
    su(i,2)=2*gain(i,2)/(entropies(i)+entropies(n));
end;

save su;
su=sortrows(su,-2);
su

display('In the dataset u have passed,we have no: of features= ');
n-1
k=input('Enter the no: of features u want to pass to next stage:');

for i=1:k 
    p(i)=su(i,1);        
end
%p=fliplr(p);
p(i+1)=n;

%reldataset=dataset(:,[su(n-1,1) su(n-2,1) su(n-3,1) su(n-4,1) su(n-5,1) su(n-6,1) su(n-7,1) su(n-8,1) su(n-9,1) su(n-10,1) su(n-11,1) su(n-12,1) su(n-13,1) su(n-14,1) su(n-15,1) su(n-16,1) su(n-17,1) su(n-18,1) su(n-19,1) su(n-20,1) su(n-21,1) su(n-22,1) su(n-23,1) su(n-24,1) su(n-25,1)]);

reldataset=dataset(:,p);
save reldataset;

index=redundant(reldataset,p);

newdata=dataset(:,index);
save newdata;
load newdata;
display('the newdataset has been saved in newdata.m');

labels=dataset(:,n);
display('the class labels have been saved in labels.m');
save labels;


