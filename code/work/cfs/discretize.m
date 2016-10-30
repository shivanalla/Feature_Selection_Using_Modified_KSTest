function y=discretize(dataset,a,k)
% dataset- input dataset
% a - attribute number
% k - No; of bins

list=dataset(:,a);

list=sort(list);
size1=size(list,1);

min=list(1);
max=list(size1);


width=(max-min)/k;
binedges=zeros(k,2);

low=min;
for i=1:k
    binedges(i,1)=low;
    if low<max-width
        low=low+width;
    else
        low=max;
    end
    binedges(i,2)=low;
end

binedges

[m n]=size(dataset);

for i=1:m
    b=dataset(i,a);
    for j=1:k
        if b>binedges(j,2)
            continue;
        else
            c=binedges(j,1);
            d=binedges(j,2);
            dif1=b-c;
            dif2=d-b;
            if dif1>dif2
                dataset(i,a)=d;
            else
                dataset(i,a)=c;
            end
            break;
        end
    end
end

y=dataset;

    