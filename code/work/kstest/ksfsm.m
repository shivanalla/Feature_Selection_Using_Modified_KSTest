function y = ksfsm(dataset,p)
%this function ksfsm(dataset,p) divides dataset into some k bins and then performs ks-test
%on each of them, finally finds the redundant features and gets u the 
%significant features.
%dataset: is the dataset containing only the relevant features(p)
%p: contains indices to relevant features(feature index as in the original
%dataset)

[n1 c1]=size(p);
for i=1:c1
    attindex(i,1)=i; %attindex maps the indices of those in p with those(1,2,3,4..) in the current dataset 
    attindex(i,2)=p(i);
end

attindex

[m n] = size(dataset); % m records with n attributes numbered 1,2,3..

k=input('Enter the no: of bins:');
a=floor(m/k);
features=zeros(k,n); % Create a matrix features that contains the set of redundant features for each bin
                     % k rows because for each bin
                     % n colums because n features are there and so atmost n of them can be redundant.
                     % the vacant spaces after filling will have appearances of 0's.


b=input('Enter the no: of inner partitions to be in each bin:');

low=1; % low is like an iterating variable on dataset. Every time, it is increased by 'a' times.
for i=1:k-1 % For each of the k bins
    s=ksfs(dataset(low:low+a-1,:),b); % Give 'a' records at a time to the function ksfs() along with the no: of inner partitions.Hold the result redundant features array into 's'.  
    [nr nc]=size(s);
    features(i,1:nc)=s; % Copy s(redundant array of features for a bin) into that corresponding bin of features matrix
    clear s; % Clear s as we have to use it again. otherwise initial content will again add up.
    low=low + a; 
end

    s=ksfs(dataset(low:m,:),b); % This is for the final bin present.
    [nr nc]=size(s);
    features(k,1:nc)=s;
    clear s;

display('List of redundant features in each bin');    
features

%Previously k and n indicate row size and col size of features matrix
count=1;
rdf(count)=0; %rdf is the list of redundant features obtained by intersection with various bins
for i= 1:k-1
    for j=1:n 
        a=features(i,j);
        t=0;
        for z=1:count
            if a==rdf(z)
                t=t+1;
            end
        end
        if t==0
            for r=i+1:k
                for l=1:n %&& features(r,l)<=a
                    if a==features(r,l)
                        t=t+1;
                    end
                end
            end
            if t==k || t==k-1 || t>k/2
                rdf(count)=a;
                count=count+1;
                rdf(count)=0;
            end
        end
    end
end


[n1 c1]=size(attindex);
[n2 c2]=size(rdf);

display('List of redundant features');
if c2==1
    rdf=features;
end

if c2>=2
    for i=1:c2
        for j=1:n1
            if rdf(i) == attindex(j,1)
                rdf1(i)=attindex(j,2);
                break;
            end
        end
    end
rdf1
end


[m n] = size(dataset);
[n1 c1]=size(rdf);
count=1;
for i=1:n
    t=0;        
    for j=1:c1
        if i==rdf(j)
            t=t+1;
        end
    end
    if t==0
        newatt(count)=i;
        newdata(:,count)=dataset(:,i);
        count=count+1;
    end
end


[n1 c1]=size(attindex);
[n2 c2]=size(newatt);
for i=1:c2
    for j=1:n1
        if newatt(i) == attindex(j,1)
            newatt(i)=attindex(j,2);
            break;
        end
    end
end            

display('New attribute list is:') 
newatt
save newatt;load newatt;
display('New attribute list is saved in file newatt.m:');
y=newdata;