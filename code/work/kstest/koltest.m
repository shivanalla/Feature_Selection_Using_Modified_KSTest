function y=koltest(dataset)
%Performs KS-test for the inner partitioned datset and returns redundant
%features to koltest.m

[n r]=size(dataset);
for i= 1: r-1
 for j=i+1:r
	s(i,j)=kstest(dataset(:,i),dataset(:,j));
end
end

y=s;
