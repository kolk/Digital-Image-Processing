function map = get_lut_map(in_hist,out_hist)

%get input and output cdf's
in_cdf = cumsum(double(in_hist));
out_cdf = cumsum(double(out_hist));

%allocate lut
map = zeros(1,256);

%for each intensity value in input cdf
%find the nearest value in the output cdf
%is the value to be mapped
for i = 1:256
    [~,id] = min(abs(out_cdf-in_cdf(i)));
    map(i) = id;
end

end