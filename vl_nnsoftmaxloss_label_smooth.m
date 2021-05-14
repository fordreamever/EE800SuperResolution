function Y = vl_nnsoftmaxloss_label_smooth(X,c,dzdy)
%VL_NNSOFTMAXLOSS CNN combined softmax and logistic loss.
%   **Deprecated: use `vl_nnloss` instead**
%
%   Y = VL_NNSOFTMAX(X, C) applies the softmax operator followed by
%   the logistic loss the data X. X has dimension H x W x D x N,
%   packing N arrays of W x H D-dimensional vectors.
%
%   C contains the class labels, which should be integers in the range
%   1 to D. C can be an array with either N elements or with dimensions
%   H x W x 1 x N dimensions. In the fist case, a given class label is
%   applied at all spatial locations; in the second case, different
%   class labels can be specified for different locations.
%
%   DZDX = VL_NNSOFTMAXLOSS(X, C, DZDY) computes the derivative of the
%   block projected onto DZDY. DZDX and DZDY have the same dimensions
%   as X and Y respectively.

% Copyright (C) 2014-15 Andrea Vedaldi.
% All rights reserved.
%
% This file is part of the VLFeat library and is made available under
% the terms of the BSD license (see the COPYING file).

%X = X + 1e-6 ;
sz = [size(X,1) size(X,2) size(X,3) size(X,4)] ;

if numel(c) == sz(4)
  % one label per image
  c = reshape(c, [1 1 1 sz(4)]) ;
end
if size(c,1) == 1 & size(c,2) == 1
  c = repmat(c, [sz(1) sz(2)]) ;
end

if isa(X,'gpuArray')
  dataType = classUnderlying(X) ;
else
  dataType = class(X) ;
end
switch dataType
  case 'double', toClass = @(x) double(x) ;
  case 'single', toClass = @(x) single(x) ;
end

% one label per spatial location
sz_ = [size(c,1) size(c,2) size(c,3) size(c,4)] ;
assert(isequal(sz_, [sz(1) sz(2) sz_(3) sz(4)])) ;
assert(sz_(3)==1 | sz_(3)==2) ;

% convert to indexes
% convert to indexes
c = c - 1 ;
c_ = 0:numel(c)-1 ;
c_ = 1 + ...
   mod(c_, sz(1)*sz(2)) + ...
  (sz(1)*sz(2)) * max(c(:), 0)' + ...
  (sz(1)*sz(2)*sz(3)) * floor(c_/(sz(1)*sz(2))) ;

weight = ones(1,sz(3)*sz(4),'single')*(1/sz(3))*0.001;
weight(c_) = 0.999;
weight = reshape(weight,sz(3),sz(4));

% compute softmaxloss
Xmax = max(X,[],3) ;
ex = exp(bsxfun(@minus, X, Xmax)) ;

%n = sz(1)*sz(2) ;
if nargin <= 2
  tt = bsxfun(@minus, Xmax, X); 
  t = tt + repmat(log(sum(ex,3)),1,1,sz(3),1);
  t = reshape(t,sz(3),sz(4));
  Y = sum(sum(t.*weight,1),2) ;
else
  Y = bsxfun(@rdivide, ex, sum(ex,3)) ; %px = softmax
  Y = Y - reshape(weight,1,1,sz(3),sz(4)); %px-qx
  Y = bsxfun(@times, Y, dzdy) ;
end