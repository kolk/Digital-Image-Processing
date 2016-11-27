function hist = get_hist(I)

for i = 1 : 256
    hist(i) = numel(find(I==(i-1)));
end

hist = hist/sum(hist);