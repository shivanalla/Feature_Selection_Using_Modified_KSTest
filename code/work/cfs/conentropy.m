function y=conentropy(dataset,i,j)
%Calculates the conditional entropy H(i/j) for ith and jth features

[m,n]=size(dataset);

% Separating columns i and j into x and y
x=dataset(:,i);
y=dataset(:,j);

%Getting different values  of feature x into count1(count) and 
%att1(different x values)
x=sort(x);    
    prev=x(1);
    count1=1;
    att1(count1)=prev;
    px(count1)=1;
    for a=2:m
        if x(a)~=prev
            count1=count1+1;
            prev=x(a);
            att1(count1)=prev;
            px(count1)=1;
        else
            px(count1)=px(count1)+1;
        end
    end
    
    
%Getting different values  of feature y into count2(count) and 
%att2(different y values)
y=sort(y);    
    prev=y(1);
    count2=1;
    att2(count2)=prev;
    py(count2)=1;
    for a=2:m
        if y(a)~=prev
            count2=count2+1;
            prev=y(a);
            att2(count2)=prev;
            py(count2)=1;
        else
            py(count2)=py(count2)+1;
        end
    end
    
 %   count1
  %  count2
    %input('');
%mat maintains the number of occurences of values of feature x with respect to values of feature y    
mat=zeros(count1,count2);

x=dataset(:,i);
y=dataset(:,j);

%updates the 'mat' table by counting occurences of x w.r.t values of y
for a=1:m
    for b=1:count1
        if eq(x(a),att1(b))
            for c=1:count2
                if eq(y(a),att2(c))
                    mat(b,c)=mat(b,c)+1;
                end
            end
        end
    end
end

%mat
%input('');


%Calculating H(X/Y) done according to the equation in page 34(please refer)
sum2=0;%outer sum
for a=1:count2 
    sum1=0;%inner sum
    for b=1:count1
        p=mat(b,a);
        if p~=0
            sum1=sum1+(p*log2(p));
        end
    end
    var=py(a)/sum(py);
    sum2=sum2+(var*sum1);
end;
sum2=(-1)*sum2;


y=sum2;



