clc
close all
color = imread('C:\Users\nic\CodeStuff\CS3320\Images\Images\DSC_1355.tif'); %Path to image you want to compress
size(color);
[rows,cols,hues] = size(color);
x = color;
z = color;

%x = double(x);
%r = x(:,:,1); % red
%g = x(:,:,2); % green
%b = x(:,:,3); % blue
%xgray = 0.2126 * r + 0.7152 * g + 0.0722 * b;
%xgray = uint8(xgray);

figure;
imagesc(color)
title('Original')

%figure;
%imagesc(xgray)

p = 10;
block_size = 8;
check = 0;
%C = zeros(8);
for l = 1:8
  for m = 1:8
    C(l,m) = cos((l-1)*(2*m-1)*pi/(2*8));
  endfor
endfor
C=sqrt(2/8)*C;
C(1,:) = C(1,:)/sqrt(2);
Q = p*8./hilb(8);
%%%%%
for i = 1:3 %color
  for j = 1:8:rows
    for k = 1:8:cols
      b = color(j:j+7,k:k+7,i);
      xd = double(b);
      xc = xd-128;
      y = C*xc*C';
      yq = round(y./Q);
      compressed(j:j+7, k:k+7, i) = yq;
    endfor
  endfor
  for l = 1:8:rows
    for m = 1:8:cols
      bc = compressed(l:l+7, m:m+7, i);
      ydq = bc.*Q;
      xdq = C'*ydq*C;
      xe = xdq + 128;
      final(l:l+7, m:m+7, i) = xe;
    endfor
    endfor
endfor
figure;
imagesc(compressed)
title('Compressed')
imagesc(uint8(final))
title('Final P = 10')
  
