clear;
image = imread('RISDance.jpg');

row = 1;
col = 1;
ret = double(zeros(7, 32));

for i1 = 3:2:15 %row
    col = 1;
    for i2 = 0.25:0.25:8.0 %col
        filter = zeros(i1, i1);
        ratio = (i2 * 1000000) / numel(image);
        image2 = imresize(image, ratio);
        tic;
        result = imfilter(image2, filter);
        elapsed = toc;
        ret(row, col) = elapsed;
        col = col + 1;
    end
    row = row + 1;
end
surf(ret)
