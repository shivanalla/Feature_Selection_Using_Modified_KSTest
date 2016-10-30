function y=entropy(dataset,i)

[m n]=size(dataset);

rw=dataset(:,n);
    rw=sort(rw);
    
    prev=rw(1);
    nofclasses=1;
    class(nofclasses)=prev;
    for j=2:m
        if rw(j)~=prev
            nofclasses=nofclasses+1;
            prev=rw(j);
            class(nofclasses)=prev;
        end
    end

if i~=n
    rw=dataset(:,i);
    rw=sort(rw);
    
    prev=rw(1);
    count=1;
    att(count)=prev;
    for j=2:m
        if rw(j)~=prev
            count=count+1;
            prev=rw(j);
            att(count)=prev;
        end
    end
    
    count;
    att;
    
    countmat=zeros(count,nofclasses+2);
    
for j=1:count
    countmat(j,1)=att(j);
end;
countmat;


for p=1:m 
    % for each record check the occcurance of the distinct value
    
  
    for j=1:count %
        
        
       % countmat(j,1)
        
       
        if eq(dataset(p,i),countmat(j,1))
            
            
      % countmat
            attack=dataset(p,n);% get attack no .
          
              for a=1:nofclasses
                if class(a)==attack
                    countmat(j,a+2)=countmat(j,a+2)+ 1 ;
          
            % use attack no as the index into% 
            %the countmat to store the no of %
            %times the attack has been occured with this value%
             
                    countmat(j,2)=countmat(j,2)+ 1 ;
            % count the total no of times the distinct value appeared in the dataset
                    break;
                end
              end
        end
        end;
    end;



info=0;
sum1=0;%For maintaining the Info of an attribute
for k=1:count
    p=countmat(k,2);
    sum1=0;
    for j=3:nofclasses+2
        if countmat(k,j)~=0
            sum1=sum1+((countmat(k,j)/p)*log2(countmat(k,j)/p));
            info=info+(sum1*p);
        end;
    end;
end; 
info=-1*info/m;




else% only for class labels
    countmat=zeros(nofclasses); %maintains the no: of attacks for each attribute
for i=1:m
    for j=1:nofclasses
        if dataset(i,n)==class(j)
            countmat(j)=countmat(j)+ 1 ;
            break;
        end;
    end;
end;

info=0;
for i=1:nofclasses
    if countmat(i)~=0
        p=(-1)*(countmat(i)/m)*log2(countmat(i)/m);
        info=info + p;
    end;
end;
end

y=info;
