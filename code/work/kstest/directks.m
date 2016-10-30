function y=directks(dataset,p)
% Performs simple KS-test and removes all redundant features

[m n]=size(dataset);

[n1 c1]=size(p);
for i=1:c1
    attindex(i,1)=i; %attindex maps the indices of those in p with those(1,2,3,4..) in the current dataset 
    attindex(i,2)=p(i);
end

count=0;
for i=1:n-2
    for j=i+1:n-1
        a=kstest2(dataset(:,i),dataset(:,j));
        if a==0
            count=count+1;
            rdf(count)=j;
        end
    end
end

newatt=[];
if count>0
    rdf=unique(rdf);
    rdf
    rdf=unique(rdf);
    count=size(rdf,2);
    z=0;
    for i=1:n-1
        t=0;            
        for j=1:count
            if i==rdf(j)
                t=t+1;
                break;
            end
        end
        if t==0
            z=z+1;
            newatt(z)=i;
        end
    end

    y=dataset(:,newatt);
    
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
else
    newatt=p;
    y=dataset(:,1:c1);
end

display('New Attribute list is:');
newatt
save newatt;load newatt;
display('New attribute list is saved in file newatt.m:');

