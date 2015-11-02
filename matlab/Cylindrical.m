function [ output_img ] = Cylindrical( input_img, f )
%CYLINDRICAL Summary of this function goes here
%   Detailed explanation goes here
%
%   x' = s*arctan(x/f)
%   y' = s*y/sqrt(x^2+f^2)
%
%

s = f;
h_input = size(input_img,1);
w_input = size(input_img,2);

w_output = ceil( 2*s*atan((w_input/2)/f) );
min_w_output = ceil(ceil( s*atan((1-w_input/2)/f) ) + w_output/2);
max_w_output = ceil(ceil( s*atan((w_input-w_input/2)/f) )+w_output/2);
w_o = max_w_output - min_w_output +1;
h_output = ceil ( 2*s*(h_input/2)/sqrt(f^2) );
x_offset = min_w_output - 1;

output_img = zeros(h_output,w_o,3);%,'uint8');

for y = 1:h_input
    for x = 1:w_input
        x_output = ceil( s*atan((x-w_input/2)/f) );
        y_output = ceil( s*(y-h_input/2)/sqrt((x-w_input/2)^2+f^2) );
        output_img(ceil(y_output+h_output/2),ceil(x_output+w_output/2)-x_offset,:) = input_img(y,x,:);
    end
end

end