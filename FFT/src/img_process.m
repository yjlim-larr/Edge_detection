clear all 
close all
clc

im = imread("data1.png")

pre_im = rgb2gray(im) %gray img
F_im = fft2(pre_im)
arr = size(pre_im)

h = arr(1)
w = arr(2)


%plot3방법
X = 0:1:w-1
Y = 0:1:h-1
h1 = surf(X * 2 *pi / w, Y * 2 * pi/ h, abs(F_im / (h*w)), 'edgecolor', 'none')
xlim([-1, 10])
ylim([-1,10])
set(h1,'LineStyle','none')

%img_recover without any processed
inverse_im = uint8(abs(ifft2(F_im)))
f = figure
imshow(inverse_im)

%plot spectrum
mag = abs(F_im)
phase = angle(F_im)
spectrum = log(fftshift(mag))
surf(X - w/2, Y - h/2, spectrum, 'edgecolor', 'none')

% 2 dimensional fourier transform
shift_F_im = fftshift(F_im)
F_im3 = zeros(size(F_im))

% insert 0 to high frequency's magnitude.
i = h/2-10:1:h/2+10
j = w/2-20:1:w/2+20
F_im3(i, j) = shift_F_im(i, j)

%image_recover with magnitude 0 on high frequency's magnitude.
inverse_im2 = uint8(abs(ifft2(F_im3)))
f = figure
imshow(inverse_im2)

% insert 0 to high frequency's magnitude.
shift_F_im = shift_F_im - F_im3

%image_recover with magnitude 0 on high frequency's magnitude.
inverse_im3 = uint8(abs(ifft2(shift_F_im)))
f = figure
imshow(inverse_im3)

% differentiator
d_im = diff(pre_im)
f1 = figure
imshow(d_im)

%Differentiated image's spectrum
F_d_im = fft2(d_im)

X = 0:1:w-1
Y = 0:1:h-2

mag = abs(F_d_im)
phase = angle(F_d_im)
spectrum = log(fftshift(mag))
surf(X - w/2, Y - h/2, spectrum, 'edgecolor', 'none')
