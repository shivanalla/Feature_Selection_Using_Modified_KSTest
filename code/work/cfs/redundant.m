function y=redundant(data1,p)
% Performs redundancy analysis and sends final featureset to irrelevant.m

dataset=data1;
index=p;

[m,n]=size(dataset);

%Calculating Individual entropies for all features
entropies=zeros(n,1);

for i=1:n
    entropies(i)=entropy(dataset,i);
end
entropies

%gainrxy=zeros(n-1,1);
for i=1:n-1
    gainrxy(i)=entropies(n)-entropies(i);
end
surxy=zeros(n-1,1);
for i=1:n-1
    if (entropies(i)+entropies(n))==0
        surxy(i)=1;
    else
        surxy(i)=gainrxy(i)/(entropies(i)+entropies(n));
    end
end
surxy

conentropies=zeros(n-1,n-1);

%calculating H(X/Y) for all features
for i=1:n-1
    for j=1:n-1
        if i~=j
            conentropies(i,j)=conentropy(dataset,i,j);
        end
    end
end
conentropies

%Calculating Information gain for all features(feature-to-feature)
gain=zeros(n-1,n-1);
su=zeros(n-1,n-1);

%for i=1:n
 %  gain(i,1)=i-1;
 %  gain(1,i)=i-1;
 %  su(i,1)=i-1;
 %  su(1,i)=i-1;
%end

for i=1:n-1
    for j=1:n-1
        if i~=j
            gain(i,j)=conentropies(i,j)-entropies(i);
             if (entropies(i) + entropies(j))==0
                su(i,j)=1;
            else
                su(i,j)=2*gain(i,j)/(entropies(i) + entropies(j));
            end
        end
    end
end

gain

su
        
sxx=sum(su')'

mur=mean(surxy)
mus=mean(sxx)
w=mus/mur;


r=zeros(n-1,2);
for i=1:n-1
    r(i,1)=index(i);
    r(i,2)= (w*surxy(i))-sxx(i);
end

format long
r=sortrows(r,-2)
[s,t]=size(r);    
f=input('Enter the no: of features needed :');

if f<s
    for i=1:f
        fno(i)=r(i,1);
    end
else
    for i=1:s
        fno(i)=r(i,1);
    end
end
%fno(i+1)=index(n);
display('Selected features:');
newatt=fno
save newatt;load newatt;
display('Selected features have been saved in the file newatt.m');
y=fno;
