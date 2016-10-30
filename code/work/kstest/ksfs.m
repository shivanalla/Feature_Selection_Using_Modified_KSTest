function y=ksfs(dataset,k)
%Performs KS-test individually for each bin

[n r] = size(dataset);


low=1;
count=0;
for i= 1:k
    s= koltest(dataset(low:i*floor(n/k),:));
    
    [l m]=size(s);
    for a=1:l
        for b=a+1:m
            if s(a,b)==0
                count=count+1;
                rd(count)=b;
            end
        end
    end
    
    low = i*floor(n/k)+1;
end

if count>0
rd=unique(rd);
[n1 c1]=size(rd);
count=1;
for i=1:r
    t=0;        
    for j=1:c1
        if i==rd(j)
            t=t+1;
        end
    end
    if t==0
        natt(:,count)=dataset(:,i);
        count=count+1;
    end
end

save natt;
natt;

y=rd;

else
  y=0;
end
  
