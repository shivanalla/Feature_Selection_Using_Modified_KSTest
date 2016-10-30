function [H, pValue, KSstatistic] = kstest(x1, x2, alpha, tail)
 
if nargin < 2
    error('stats:kstest2:TooFewInputs','At least 2 inputs are required.');
end

%
% Ensure each sample is a VECTOR.
%

if ~isvector(x1) || ~isvector(x2) 
    error('stats:kstest2:VectorRequired','The samples X1 and X2 must be vectors.');
end

%
% Remove missing observations indicated by NaN's, and 
% ensure that valid observations remain.
%

x1  =  x1(~isnan(x1));
x2  =  x2(~isnan(x2));
x1  =  x1(:);
x2  =  x2(:);

if isempty(x1)
   error('stats:kstest2:NotEnoughData', 'Sample vector X1 contains no data.');
end

if isempty(x2)
   error('stats:kstest2:NotEnoughData', 'Sample vector X2 contains no data.');
end

%
% Ensure the significance level, ALPHA, is a scalar 
% between 0 and 1 and set default if necessary.
%

if (nargin >= 3) && ~isempty(alpha)
   if ~isscalar(alpha) || (alpha <= 0 || alpha >= 1)
      error('stats:kstest2:BadAlpha',...
            'Significance level ALPHA must be a scalar between 0 and 1.'); 
   end
else
   alpha  =  0.05;
end

%
% Ensure the type-of-test indicator, TAIL, is a scalar integer from 
% the allowable set, and set default if necessary.
%

if (nargin >= 4) && ~isempty(tail)
   if ischar(tail)
      tail = strmatch(lower(tail), {'smaller','unequal','larger'}) - 2;
      if isempty(tail)
         error('stats:kstest2:BadTail',...
               'Type-of-test indicator TAIL must be ''unequal'', ''smaller'', or ''larger''.');
      end
   elseif ~isscalar(tail) || ~((tail==-1) || (tail==0) || (tail==1))
      error('stats:kstest2:BadTail',...
            'Type-of-test indicator TAIL must be ''unequal'', ''smaller'', or ''larger''.');
   end
else
   tail  =  0;
end

%
% Calculate F1(x) and F2(x), the empirical (i.e., sample) CDFs.
%

binEdges    =  [-inf ; sort([x1;x2]) ; inf];

binCounts1  =  histc (x1 , binEdges, 1);
binCounts2  =  histc (x2 , binEdges, 1);

sumCounts1  =  cumsum(binCounts1)./sum(binCounts1);
sumCounts2  =  cumsum(binCounts2)./sum(binCounts2);

sampleCDF1  =  sumCounts1(1:end-1);
sampleCDF2  =  sumCounts2(1:end-1);

%
% Compute the test statistic of interest.
%

switch tail
   case  0      %  2-sided test: T = max|F1(x) - F2(x)|.
      deltaCDF  =  abs(sampleCDF1 - sampleCDF2);

   case -1      %  1-sided test: T = max[F2(x) - F1(x)].
      deltaCDF  =  sampleCDF2 - sampleCDF1;

   case  1      %  1-sided test: T = max[F1(x) - F2(x)].
      deltaCDF  =  sampleCDF1 - sampleCDF2;
end

KSstatistic   =  max(deltaCDF);

%
% Compute the asymptotic P-value approximation and accept or
% reject the null hypothesis on the basis of the P-value.
%

n1     =  length(x1);
n2     =  length(x2);
n      =  n1 * n2 /(n1 + n2);
lambda =  max((sqrt(n) + 0.12 + 0.11/sqrt(n)) * KSstatistic , 0);

if tail ~= 0        % 1-sided test.

   pValue  =  exp(-2 * lambda * lambda);

else                % 2-sided test (default).
%
%  Use the asymptotic Q-function to approximate the 2-sided P-value.
%
   j       =  (1:101)';
   pValue  =  2 * sum((-1).^(j-1).*exp(-2*lambda*lambda*j.^2));
   pValue  =  min(max(pValue, 0), 1);

end

H  =  (alpha >= pValue);
